Return-Path: <netdev+bounces-39338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A07BEE01
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8774B28184E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE30436AB;
	Mon,  9 Oct 2023 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a39h54To"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681641239
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 22:03:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85319AF
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696889008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQSPOWytWzaZ0yxzrN9XtvCTSX8Vzm9Wb094ewEPIQ0=;
	b=a39h54To2Inz+2DZOGoVnQ4q+WDXRDiQXHGSHRik1nxUAwHYTn2BQ1X6W+xqTJutQrw0b0
	n+5kFJ0IHiJxjwPe9dQ4Yh6vBWfywH0jcpjd9tVQEOReVqNECt4Asejz/xbc5VKTAva4a2
	VPBvo8XZqhYyvRzrF42tqla8L4FJ0Jg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-LU-RmPEJMXq-9KVyh30JCw-1; Mon, 09 Oct 2023 18:03:27 -0400
X-MC-Unique: LU-RmPEJMXq-9KVyh30JCw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bcb13d8ddso150079466b.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 15:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696889006; x=1697493806;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQSPOWytWzaZ0yxzrN9XtvCTSX8Vzm9Wb094ewEPIQ0=;
        b=Hms8alCxYOkGkQfcH7zRpgdOO+O3c8Tmqwk8x0YYwq/VnRUi5TOcIF7Tw+qqnDiA4J
         7qgK9I8VMrVLJmB8BChVw8HyBBGGh7Ds5wUko2mcFtkc5fseJ3H+oyZYtmCKGc0g/rPu
         4a/NqkFZ8NJLzYuuuQyuIifbGiR8wf9RNK4X/8d5GD57a5tvtXhLmaCpK2iFwM5QcV9g
         r7bSc4JPe1gWqkuccuODVjvL4AtrgIanWRz3zBFPMrt8bCq9X2HdE1+qdZwDz3tYuvde
         0Z9tlKqT8KS0bRRmpJW5AHvlYBhP6ScML7YFWT0g0dC0/O/XijO53r2juyzELnK8ZqZi
         mWXA==
X-Gm-Message-State: AOJu0Yx78+ykSR6ZIFcZ+tNGbMNrqTrfGuX3d2EpLzkLiS2hhNsZRu8w
	0eaGra7jhrAzSzog7N5kY5Jd1CIfWbXnsl+5uQIHBM1OiInX7mz11CH88ERmIGOF41V2HLqok4c
	da2PU/8PcZ8YCe8bt
X-Received: by 2002:a17:906:257:b0:9b8:8bcf:8739 with SMTP id 23-20020a170906025700b009b88bcf8739mr13775523ejl.75.1696889005941;
        Mon, 09 Oct 2023 15:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM9lf63OcYrf+p1wBvTzfubLiMs5nXwSy8CHRw+Ioar/IZWEaISwLnypKaJjmgavwYyrA5yg==
X-Received: by 2002:a17:906:257:b0:9b8:8bcf:8739 with SMTP id 23-20020a170906025700b009b88bcf8739mr13775511ejl.75.1696889005515;
        Mon, 09 Oct 2023 15:03:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709063b5800b009b285351817sm7294312ejf.116.2023.10.09.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 15:03:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3CD18E582B4; Tue, 10 Oct 2023 00:03:24 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Ahern <dsahern@gmail.com>, Stephen Hemminger
 <stephen@networkplumber.org>, netdev@vger.kernel.org, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>, Christian Brauner <brauner@kernel.org>, David
 Laight <David.Laight@ACULAB.COM>
Subject: Re: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
In-Reply-To: <877cnvtu37.fsf@email.froward.int.ebiederm.org>
References: <20231009182753.851551-1-toke@redhat.com>
 <877cnvtu37.fsf@email.froward.int.ebiederm.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Oct 2023 00:03:24 +0200
Message-ID: <87jzrvzc5v.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
>> The 'ip netns' command is used for setting up network namespaces with pe=
rsistent
>> named references, and is integrated into various other commands of iprou=
te2 via
>> the -n switch.
>>
>> This is useful both for testing setups and for simple script-based names=
pacing
>> but has one drawback: the lack of persistent mounts inside the spawned
>> namespace. This is particularly apparent when working with BPF programs =
that use
>> pinning to bpffs: by default no bpffs is available inside a namespace, a=
nd
>> even if mounting one, that fs disappears as soon as the calling
>> command exits.
>
> It would be entirely reasonable to copy mounts like /sys/fs/bpf from the
> original mount namespace into the temporary mount namespace used by
> "ip netns".
>
> I would call it a bug that "ip netns" doesn't do that already.
>
> I suspect that "ip netns" does copy the mounts from the old sysfs onto
> the new sysfs is your entire problem.

How would it do that? Walk mtab and remount everything identically after
remounting /sys? Or is there a smarter way to go about this?

> Or is their a reason that bpffs should be per network namespace?

Well, I first ran into this issue because of a bug report to
xdp-tools/libxdp about things not working correctly in network
namespaces:

https://github.com/xdp-project/xdp-tools/issues/364

And libxdp does assume that there's a separate bpffs per network
namespace: it persists things into the bpffs that is tied to the network
devices in the current namespace. So if the bpffs is shared, an
application running inside the network namespace could access XDP
programs loaded in the root namespace. I don't know, but suspect, that
such assumptions would be relatively common in networking BPF programs
that use pinning (the pinning support in libbpf and iproute2 itself at
least have the same leaking problem if the bpffs is shared).

>> The underlying cause for this is that iproute2 will create a new mount n=
amespace
>> every time it switches into a network namespace. This is needed to be ab=
le to
>> mount a /sys filesystem that shows the correct network device informatio=
n, but
>> has the unfortunate side effect of making mounts entirely transient for =
any 'ip
>> netns' invocation.
>
> Mount propagation can be made to work if necessary, that would solve the
> transient problem.

Is mount propagation different from the remount thing you mentioned
above, or is this something different?

(Sorry for being hopelessly naive about this, as you probably guessed
from my previous email asking about this, I'm only now learning about
all the intricacies fs mounts).

>> This series is an attempt to fix this situation, by persisting a mount n=
amespace
>> alongside the persistent network namespace (in a separate directory,
>> /run/netns-mnt). Doing this allows us to still have a consistent /sys in=
side
>> the namespace, but with persistence so any mounts survive.
>
> I really don't like that direction.
>
> "ip netns" was designed and really should continue to be a command that
> makes the world look like it has a single network namespace, for
> compatibility with old code.  Part of that old code "ip netns" supports
> is "ip" itself.

Well my idea with this change was to keep the functionality as close to
what 'ip' currently does, but just have mounts persist across
invocations.

> I think you are making bpffs unnecessarily per network namespace.

See above.=20

>> This mode does come with some caveats. I'm sending this as RFC to get fe=
edback
>> on whether this is the right thing to do, especially considering backwar=
ds
>> compatibility. On balance, I think that the approach taken here of
>> unconditionally persisting the mount namespace, and using that persistent
>> reference whenever it exists, is better than the current behaviour, and =
that
>> while it does represent a change in behaviour it is backwards compatible=
 in a
>> way that won't cause issues. But please do comment on this; see the patch
>> description of patch 4 for details.
>
> As I understand it this will cause a problem for any application that
> is network namespace aware and does not use "ip netns" to wrap itself.
>
> I am fairly certain that pinning the mount namespace will result in
> never seeing an update of /etc/resolve.conf.  At least if you
> are on a system that has /etc/netns/NAME/resolve.conf

I was actually wondering about that /etc bind mounting support while I
was looking at this code. Could you please elaborate a bit on what that
is used for, exactly? :)

Also, if staleness of the /etc bind mounts is an issue, those could be
redone on every entry, couldn't they?

-Toke


