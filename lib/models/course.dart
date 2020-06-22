// To parse this JSON data, do
//
//     final courseModel = courseModelFromMap(jsonString);

import 'dart:convert';

CourseModel courseModelFromMap(String str) => CourseModel.fromMap(json.decode(str));

String courseModelToMap(CourseModel data) => json.encode(data.toMap());

class CourseModel {
    CourseModel({
        this.id,
        this.date,
        this.dateGmt,
        this.guid,
        this.modified,
        this.modifiedGmt,
        this.slug,
        this.status,
        this.type,
        this.link,
        this.title,
        this.content,
        this.excerpt,
        this.author,
        this.featuredMedia,
        this.commentStatus,
        this.pingStatus,
        this.sticky,
        this.template,
        this.format,
        this.meta,
        this.categories,
        this.tags,
        this.links,
    });

    final int id;
    final String date;
    final String dateGmt;
    final Guid guid;
    final String modified;
    final String modifiedGmt;
    final String slug;
    final String status;
    final String type;
    final String link;
    final Title title;
    final Content content;
    final Content excerpt;
    final int author;
    final int featuredMedia;
    final String commentStatus;
    final String pingStatus;
    final bool sticky;
    final String template;
    final String format;
    final Meta meta;
    final List<int> categories;
    final List<dynamic> tags;
    final Links links;

    CourseModel copyWith({
        int id,
        String date,
        String dateGmt,
        Guid guid,
        String modified,
        String modifiedGmt,
        String slug,
        String status,
        String type,
        String link,
        Title title,
        Content content,
        Content excerpt,
        int author,
        int featuredMedia,
        String commentStatus,
        String pingStatus,
        bool sticky,
        String template,
        String format,
        Meta meta,
        List<int> categories,
        List<dynamic> tags,
        Links links,
    }) => 
        CourseModel(
            id: id ?? this.id,
            date: date ?? this.date,
            dateGmt: dateGmt ?? this.dateGmt,
            guid: guid ?? this.guid,
            modified: modified ?? this.modified,
            modifiedGmt: modifiedGmt ?? this.modifiedGmt,
            slug: slug ?? this.slug,
            status: status ?? this.status,
            type: type ?? this.type,
            link: link ?? this.link,
            title: title ?? this.title,
            content: content ?? this.content,
            excerpt: excerpt ?? this.excerpt,
            author: author ?? this.author,
            featuredMedia: featuredMedia ?? this.featuredMedia,
            commentStatus: commentStatus ?? this.commentStatus,
            pingStatus: pingStatus ?? this.pingStatus,
            sticky: sticky ?? this.sticky,
            template: template ?? this.template,
            format: format ?? this.format,
            meta: meta ?? this.meta,
            categories: categories ?? this.categories,
            tags: tags ?? this.tags,
            links: links ?? this.links,
        );

    factory CourseModel.fromMap(Map<String, dynamic> json) => CourseModel(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : json["date"],
        dateGmt: json["date_gmt"] == null ? null : json["date_gmt"],
        guid: json["guid"] == null ? null : Guid.fromMap(json["guid"]),
        modified: json["modified"] == null ? null : json["modified"],
        modifiedGmt: json["modified_gmt"] == null ? null : json["modified_gmt"],
        slug: json["slug"] == null ? null : json["slug"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        link: json["link"] == null ? null : json["link"],
        title: json["title"] == null ? null : Title.fromMap(json["title"]),
        content: json["content"] == null ? null : Content.fromMap(json["content"]),
        excerpt: json["excerpt"] == null ? null : Content.fromMap(json["excerpt"]),
        author: json["author"] == null ? null : json["author"],
        featuredMedia: json["featured_media"] == null ? null : json["featured_media"],
        commentStatus: json["comment_status"] == null ? null : json["comment_status"],
        pingStatus: json["ping_status"] == null ? null : json["ping_status"],
        sticky: json["sticky"] == null ? null : json["sticky"],
        template: json["template"] == null ? null : json["template"],
        format: json["format"] == null ? null : json["format"],
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
        categories: json["categories"] == null ? null : List<int>.from(json["categories"].map((x) => x)),
        tags: json["tags"] == null ? null : List<dynamic>.from(json["tags"].map((x) => x)),
        links: json["_links"] == null ? null : Links.fromMap(json["_links"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date,
        "date_gmt": dateGmt == null ? null : dateGmt,
        "guid": guid == null ? null : guid.toMap(),
        "modified": modified == null ? null : modified,
        "modified_gmt": modifiedGmt == null ? null : modifiedGmt,
        "slug": slug == null ? null : slug,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "link": link == null ? null : link,
        "title": title == null ? null : title.toMap(),
        "content": content == null ? null : content.toMap(),
        "excerpt": excerpt == null ? null : excerpt.toMap(),
        "author": author == null ? null : author,
        "featured_media": featuredMedia == null ? null : featuredMedia,
        "comment_status": commentStatus == null ? null : commentStatus,
        "ping_status": pingStatus == null ? null : pingStatus,
        "sticky": sticky == null ? null : sticky,
        "template": template == null ? null : template,
        "format": format == null ? null : format,
        "meta": meta == null ? null : meta.toMap(),
        "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x)),
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "_links": links == null ? null : links.toMap(),
    };
}

class Content {
    Content({
        this.rendered,
        this.protected,
    });

    final String rendered;
    final bool protected;

    Content copyWith({
        String rendered,
        bool protected,
    }) => 
        Content(
            rendered: rendered ?? this.rendered,
            protected: protected ?? this.protected,
        );

    factory Content.fromMap(Map<String, dynamic> json) => Content(
        rendered: json["rendered"] == null ? null : json["rendered"],
        protected: json["protected"] == null ? null : json["protected"],
    );

    Map<String, dynamic> toMap() => {
        "rendered": rendered == null ? null : rendered,
        "protected": protected == null ? null : protected,
    };
}

class Guid {
    Guid({
        this.rendered,
    });

    final String rendered;

    Guid copyWith({
        String rendered,
    }) => 
        Guid(
            rendered: rendered ?? this.rendered,
        );

    factory Guid.fromMap(Map<String, dynamic> json) => Guid(
        rendered: json["rendered"] == null ? null : json["rendered"],
    );

    Map<String, dynamic> toMap() => {
        "rendered": rendered == null ? null : rendered,
    };
}

class Links {
    Links({
        this.self,
        this.collection,
        this.about,
        this.author,
        this.replies,
        this.versionHistory,
        this.predecessorVersion,
        this.wpAttachment,
        this.wpTerm,
        this.curies,
    });

    final List<About> self;
    final List<About> collection;
    final List<About> about;
    final List<Author> author;
    final List<Author> replies;
    final List<VersionHistory> versionHistory;
    final List<PredecessorVersion> predecessorVersion;
    final List<About> wpAttachment;
    final List<WpTerm> wpTerm;
    final List<Cury> curies;

    Links copyWith({
        List<About> self,
        List<About> collection,
        List<About> about,
        List<Author> author,
        List<Author> replies,
        List<VersionHistory> versionHistory,
        List<PredecessorVersion> predecessorVersion,
        List<About> wpAttachment,
        List<WpTerm> wpTerm,
        List<Cury> curies,
    }) => 
        Links(
            self: self ?? this.self,
            collection: collection ?? this.collection,
            about: about ?? this.about,
            author: author ?? this.author,
            replies: replies ?? this.replies,
            versionHistory: versionHistory ?? this.versionHistory,
            predecessorVersion: predecessorVersion ?? this.predecessorVersion,
            wpAttachment: wpAttachment ?? this.wpAttachment,
            wpTerm: wpTerm ?? this.wpTerm,
            curies: curies ?? this.curies,
        );

    factory Links.fromMap(Map<String, dynamic> json) => Links(
        self: json["self"] == null ? null : List<About>.from(json["self"].map((x) => About.fromMap(x))),
        collection: json["collection"] == null ? null : List<About>.from(json["collection"].map((x) => About.fromMap(x))),
        about: json["about"] == null ? null : List<About>.from(json["about"].map((x) => About.fromMap(x))),
        author: json["author"] == null ? null : List<Author>.from(json["author"].map((x) => Author.fromMap(x))),
        replies: json["replies"] == null ? null : List<Author>.from(json["replies"].map((x) => Author.fromMap(x))),
        versionHistory: json["version-history"] == null ? null : List<VersionHistory>.from(json["version-history"].map((x) => VersionHistory.fromMap(x))),
        predecessorVersion: json["predecessor-version"] == null ? null : List<PredecessorVersion>.from(json["predecessor-version"].map((x) => PredecessorVersion.fromMap(x))),
        wpAttachment: json["wp:attachment"] == null ? null : List<About>.from(json["wp:attachment"].map((x) => About.fromMap(x))),
        wpTerm: json["wp:term"] == null ? null : List<WpTerm>.from(json["wp:term"].map((x) => WpTerm.fromMap(x))),
        curies: json["curies"] == null ? null : List<Cury>.from(json["curies"].map((x) => Cury.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "self": self == null ? null : List<dynamic>.from(self.map((x) => x.toMap())),
        "collection": collection == null ? null : List<dynamic>.from(collection.map((x) => x.toMap())),
        "about": about == null ? null : List<dynamic>.from(about.map((x) => x.toMap())),
        "author": author == null ? null : List<dynamic>.from(author.map((x) => x.toMap())),
        "replies": replies == null ? null : List<dynamic>.from(replies.map((x) => x.toMap())),
        "version-history": versionHistory == null ? null : List<dynamic>.from(versionHistory.map((x) => x.toMap())),
        "predecessor-version": predecessorVersion == null ? null : List<dynamic>.from(predecessorVersion.map((x) => x.toMap())),
        "wp:attachment": wpAttachment == null ? null : List<dynamic>.from(wpAttachment.map((x) => x.toMap())),
        "wp:term": wpTerm == null ? null : List<dynamic>.from(wpTerm.map((x) => x.toMap())),
        "curies": curies == null ? null : List<dynamic>.from(curies.map((x) => x.toMap())),
    };
}

class About {
    About({
        this.href,
    });

    final String href;

    About copyWith({
        String href,
    }) => 
        About(
            href: href ?? this.href,
        );

    factory About.fromMap(Map<String, dynamic> json) => About(
        href: json["href"] == null ? null : json["href"],
    );

    Map<String, dynamic> toMap() => {
        "href": href == null ? null : href,
    };
}

class Author {
    Author({
        this.embeddable,
        this.href,
    });

    final bool embeddable;
    final String href;

    Author copyWith({
        bool embeddable,
        String href,
    }) => 
        Author(
            embeddable: embeddable ?? this.embeddable,
            href: href ?? this.href,
        );

    factory Author.fromMap(Map<String, dynamic> json) => Author(
        embeddable: json["embeddable"] == null ? null : json["embeddable"],
        href: json["href"] == null ? null : json["href"],
    );

    Map<String, dynamic> toMap() => {
        "embeddable": embeddable == null ? null : embeddable,
        "href": href == null ? null : href,
    };
}

class Cury {
    Cury({
        this.name,
        this.href,
        this.templated,
    });

    final String name;
    final String href;
    final bool templated;

    Cury copyWith({
        String name,
        String href,
        bool templated,
    }) => 
        Cury(
            name: name ?? this.name,
            href: href ?? this.href,
            templated: templated ?? this.templated,
        );

    factory Cury.fromMap(Map<String, dynamic> json) => Cury(
        name: json["name"] == null ? null : json["name"],
        href: json["href"] == null ? null : json["href"],
        templated: json["templated"] == null ? null : json["templated"],
    );

    Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "href": href == null ? null : href,
        "templated": templated == null ? null : templated,
    };
}

class PredecessorVersion {
    PredecessorVersion({
        this.id,
        this.href,
    });

    final int id;
    final String href;

    PredecessorVersion copyWith({
        int id,
        String href,
    }) => 
        PredecessorVersion(
            id: id ?? this.id,
            href: href ?? this.href,
        );

    factory PredecessorVersion.fromMap(Map<String, dynamic> json) => PredecessorVersion(
        id: json["id"] == null ? null : json["id"],
        href: json["href"] == null ? null : json["href"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "href": href == null ? null : href,
    };
}

class VersionHistory {
    VersionHistory({
        this.count,
        this.href,
    });

    final int count;
    final String href;

    VersionHistory copyWith({
        int count,
        String href,
    }) => 
        VersionHistory(
            count: count ?? this.count,
            href: href ?? this.href,
        );

    factory VersionHistory.fromMap(Map<String, dynamic> json) => VersionHistory(
        count: json["count"] == null ? null : json["count"],
        href: json["href"] == null ? null : json["href"],
    );

    Map<String, dynamic> toMap() => {
        "count": count == null ? null : count,
        "href": href == null ? null : href,
    };
}

class WpTerm {
    WpTerm({
        this.taxonomy,
        this.embeddable,
        this.href,
    });

    final String taxonomy;
    final bool embeddable;
    final String href;

    WpTerm copyWith({
        String taxonomy,
        bool embeddable,
        String href,
    }) => 
        WpTerm(
            taxonomy: taxonomy ?? this.taxonomy,
            embeddable: embeddable ?? this.embeddable,
            href: href ?? this.href,
        );

    factory WpTerm.fromMap(Map<String, dynamic> json) => WpTerm(
        taxonomy: json["taxonomy"] == null ? null : json["taxonomy"],
        embeddable: json["embeddable"] == null ? null : json["embeddable"],
        href: json["href"] == null ? null : json["href"],
    );

    Map<String, dynamic> toMap() => {
        "taxonomy": taxonomy == null ? null : taxonomy,
        "embeddable": embeddable == null ? null : embeddable,
        "href": href == null ? null : href,
    };
}

class Meta {
    Meta({
        this.linksTo,
        this.linksToTarget,
    });

    final String linksTo;
    final String linksToTarget;

    Meta copyWith({
        String linksTo,
        String linksToTarget,
    }) => 
        Meta(
            linksTo: linksTo ?? this.linksTo,
            linksToTarget: linksToTarget ?? this.linksToTarget,
        );

    factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        linksTo: json["_links_to"] == null ? null : json["_links_to"],
        linksToTarget: json["_links_to_target"] == null ? null : json["_links_to_target"],
    );

    Map<String, dynamic> toMap() => {
        "_links_to": linksTo == null ? null : linksTo,
        "_links_to_target": linksToTarget == null ? null : linksToTarget,
    };
}

class Title {
    Title({
        this.rendered,
    });

    final String rendered;

    Title copyWith({
        String rendered,
    }) => 
        Title(
            rendered: rendered ?? this.rendered,
        );

    factory Title.fromMap(Map<String, dynamic> json) => Title(
        rendered: json["rendered"] == null ? null : json["rendered"],
    );

    Map<String, dynamic> toMap() => {
        "rendered": rendered == null ? null : rendered,
    };
}
