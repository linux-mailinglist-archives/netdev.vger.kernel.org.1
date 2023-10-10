Return-Path: <netdev+bounces-39572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AA17BFDAD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A647281BFF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E8D1DFC0;
	Tue, 10 Oct 2023 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjEt62rw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4D47376
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 13:38:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F20B6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696945094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fo7gZ2wkT0/Tux+fl6ygHG2JpeubUr19nTjdB1HlVcQ=;
	b=LjEt62rw0/lHrwTxxF9KZKTtjdjXXnAKuYTexd+yA42rOaLTxdWnhXrV09TuxBil/ETlP4
	I24dwIQKRuLHoccK1zdGgrYGgzE4ABMbsp1pdmbJm+YG8Jw1AOeHO+6dn7ch110dNlHKVH
	qibCYrB4eO9ZAbQNLHK5u17umt1x7II=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-UcPDZwveNX2NUzYweHjEiw-1; Tue, 10 Oct 2023 09:38:13 -0400
X-MC-Unique: UcPDZwveNX2NUzYweHjEiw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51bee352ffcso4387575a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 06:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945092; x=1697549892;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fo7gZ2wkT0/Tux+fl6ygHG2JpeubUr19nTjdB1HlVcQ=;
        b=EyTNj7G93g75T2GySw8O8n7SrKdMC7swNz1CEQpMo89vo2LEKSPBcdAsi6E6Qus+iI
         BdBJTbrYLOHdK1rk4ujO/BJ1UhynxznuVik78T0WWkkk6NmyNEwuLf5+s1eMsFaC0UUm
         lLnlvf1mFPFcSbkYzjubBF3dsYBAq1oyDuEEg3M0o9IKBqsIguwsple63E2AleY9rf63
         OBl7FQkCIi/4vHvsbEYMyYcrX9q+c1lkm7qOXYUdjoQiREtlXYT8awdePWk3Hw2W+KKH
         XEbBHn26vGm9X4gk1rrhkzCapj2touPYheF4uoQfgHLVSlL6eutfW0pJqu8vy8+Amw5W
         shTg==
X-Gm-Message-State: AOJu0YzuED5xPsDK1C5eL0QNbLSjEzefoSE4rOhA0ycSfJ22OZsfEwiU
	KQ72o0OADz9c+Uw3lbHF6fwMT4u2/BEHx6GvhzOf7+TTgqpRdFGmhprfDQw+UMhKv9Zjb5bMSst
	MorX99oKfT8MREVL9
X-Received: by 2002:aa7:d791:0:b0:530:9e59:5795 with SMTP id s17-20020aa7d791000000b005309e595795mr16390515edq.4.1696945092209;
        Tue, 10 Oct 2023 06:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvFVaL/SMf6lY9c+LaqSLu+YZAj2DjxoN5EHkGzcUGZhxDJzz84oHZnLp2JYVHgOfQANmZOw==
X-Received: by 2002:aa7:d791:0:b0:530:9e59:5795 with SMTP id s17-20020aa7d791000000b005309e595795mr16390497edq.4.1696945091842;
        Tue, 10 Oct 2023 06:38:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cm7-20020a0564020c8700b0053d9f427a6bsm723176edb.71.2023.10.10.06.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:38:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D6F86E58431; Tue, 10 Oct 2023 15:38:10 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Ahern <dsahern@gmail.com>, Stephen Hemminger
 <stephen@networkplumber.org>, netdev@vger.kernel.org, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>, Christian Brauner <brauner@kernel.org>, David
 Laight <David.Laight@ACULAB.COM>
Subject: Re: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
In-Reply-To: <87ttqznxjm.fsf@email.froward.int.ebiederm.org>
References: <20231009182753.851551-1-toke@redhat.com>
 <877cnvtu37.fsf@email.froward.int.ebiederm.org> <87jzrvzc5v.fsf@toke.dk>
 <87ttqznxjm.fsf@email.froward.int.ebiederm.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Oct 2023 15:38:10 +0200
Message-ID: <878r8azjgd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>
>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>>
>>>> The 'ip netns' command is used for setting up network namespaces with =
persistent
>>>> named references, and is integrated into various other commands of ipr=
oute2 via
>>>> the -n switch.
>>>>
>>>> This is useful both for testing setups and for simple script-based nam=
espacing
>>>> but has one drawback: the lack of persistent mounts inside the spawned
>>>> namespace. This is particularly apparent when working with BPF program=
s that use
>>>> pinning to bpffs: by default no bpffs is available inside a namespace,=
 and
>>>> even if mounting one, that fs disappears as soon as the calling
>>>> command exits.
>>>
>>> It would be entirely reasonable to copy mounts like /sys/fs/bpf from the
>>> original mount namespace into the temporary mount namespace used by
>>> "ip netns".
>>>
>>> I would call it a bug that "ip netns" doesn't do that already.
>>>
>>> I suspect that "ip netns" does copy the mounts from the old sysfs onto
>>> the new sysfs is your entire problem.
>>
>> How would it do that? Walk mtab and remount everything identically after
>> remounting /sys? Or is there a smarter way to go about this?
>
> There are not many places to look so something like this is probably suff=
icient:
>
> # stat all of the possible/probable mount points and see if there is
> # something mounted there.  If so recursive bind whatever is there onto
> # the new /sys
>
> for dir in /old/sys/fs/* /old/sys/kernel/*; do
> 	if [ $(stat --format '%d' "$dir") =3D $(stat --format '%d' "$dir/") ; th=
en

What is this comparison supposed to do? I couldn't find any directories
in /sys/fs/* where this was *not* true, regardless of whether there's a
mount there or not.

> 		newdir =3D $(echo $dir | sed -e s/old/new/)
> 		mount --rbind $dir/ $newdir/
> 	fi=20=20
> done
>
> If the concern is being robust for the future the mount points can also
> be enumerated by looking in one of /proc/self/mounts,
> /proc/self/mountinfo, or /proc/self/mountstats.
>
> I am not certain which is less work parsing a file with lots of fields,
> or reading a directory and stating the returned files from readdir.

Right, fair point.

>>> Or is their a reason that bpffs should be per network namespace?
>>
>> Well, I first ran into this issue because of a bug report to
>> xdp-tools/libxdp about things not working correctly in network
>> namespaces:
>>
>> https://github.com/xdp-project/xdp-tools/issues/364
>>
>> And libxdp does assume that there's a separate bpffs per network
>> namespace: it persists things into the bpffs that is tied to the network
>> devices in the current namespace. So if the bpffs is shared, an
>> application running inside the network namespace could access XDP
>> programs loaded in the root namespace. I don't know, but suspect, that
>> such assumptions would be relatively common in networking BPF programs
>> that use pinning (the pinning support in libbpf and iproute2 itself at
>> least have the same leaking problem if the bpffs is shared).
>
> Are the names of the values truly network namespace specific?
>
> I did not see any mention of the things that are persisted in the ticket
> you pointed me at, and unfortunately I am not familiar with xdp.
>
> Last I looked until all of the cpu side channels are closed it is
> unfortunately unsafe to load ebpf programs with anything less than
> CAP_SYS_ADMIN (aka with permission to see and administer the entire
> system).  So from a system point of view I really don't see a
> fundamental danger from having a global /sys/fs/bpf.
>
> If there are name conflicts in /sys/fs/bpf because of duplicate names in
> different network namespaces I can see that being a problem.

Yeah, you're right that someone loading a BPF program generally has
permissions enough that they can break out of any containment if they
want, but applications do make assumptions about the contents of the
pinning directory that can lead to conflicts.

A couple of examples:

- libxdp will persist files in /sys/fs/bpf/dispatch-$ifindex-$prog_id

- If someone sets the 'pinning' attribute on a map definition in a BPF
  file, libbpf will pin those files in /sys/fs/bpf/$map_name

The first one leads to obvious conflicts if shared across network
namespaces because of ifindex collisions. The second one leads to
potential false sharing of state across what are supposed to be
independent networking domains (e.g., if the bpffs is shared, loading
xdp-filter inside a namespace will share the state with another instance
loaded in another namespace, which would no doubt be surprising).

> At that point the name conflicts either need to be fixed or we
> fundamentally need to have multiple mount points for bpffs.
> Probably under something like /run/netns-mounts/NAME/.
>
> With ip netns updated to mount the appropriate filesystem.

I don't think it's feasible to fix the conflicts; they've been around
for a while and are part of application API in some cases. Plus, we
don't know of all BPF-using applications.

We could have 'ip' manage separate bpffs mounts per namespace and
bind-mount them into each netns (I think that's what you're suggesting),
but that would basically achieve the same thing as the mountns
persisting I am proposing in this series, but only as a special case for
bpffs. So why not do the more flexible thing and persist the whole
mountns (so applications inside the namespace can actually mount
additional things and have them stick around)? The current behaviour
seems very surprising...

>>>> The underlying cause for this is that iproute2 will create a new mount=
 namespace
>>>> every time it switches into a network namespace. This is needed to be =
able to
>>>> mount a /sys filesystem that shows the correct network device informat=
ion, but
>>>> has the unfortunate side effect of making mounts entirely transient fo=
r any 'ip
>>>> netns' invocation.
>>>
>>> Mount propagation can be made to work if necessary, that would solve the
>>> transient problem.
>>
>> Is mount propagation different from the remount thing you mentioned
>> above, or is this something different?
>>
>> (Sorry for being hopelessly naive about this, as you probably guessed
>> from my previous email asking about this, I'm only now learning about
>> all the intricacies fs mounts).
>
> Mount propagation is a way to configure a mount namespace (before
> creating a new one) that will cause mounts created in the first mount
> namespace to be created in it's children, and cause mounts created in
> the children to be created in the parent (depending on how things are
> configured).
>
> It is not my favorite feature (it makes locking of mount namespaces
> terrible) and it is probably too clever by half, unfortunately systemd
> started enabling mount propagation by default, so we are stuck with it.

Right. AFAICT the current iproute2 code explicitly tries to avoid that
when creating a mountns (it does a 'mount --make-rslave /'); so you're
saying we should change that?

>>>> This series is an attempt to fix this situation, by persisting a mount=
 namespace
>>>> alongside the persistent network namespace (in a separate directory,
>>>> /run/netns-mnt). Doing this allows us to still have a consistent /sys =
inside
>>>> the namespace, but with persistence so any mounts survive.
>>>
>>> I really don't like that direction.
>>>
>>> "ip netns" was designed and really should continue to be a command that
>>> makes the world look like it has a single network namespace, for
>>> compatibility with old code.  Part of that old code "ip netns" supports
>>> is "ip" itself.
>>
>> Well my idea with this change was to keep the functionality as close to
>> what 'ip' currently does, but just have mounts persist across
>> invocations.
>>
>>> I think you are making bpffs unnecessarily per network namespace.
>>
>> See above.=20
>>
>>>> This mode does come with some caveats. I'm sending this as RFC to get =
feedback
>>>> on whether this is the right thing to do, especially considering backw=
ards
>>>> compatibility. On balance, I think that the approach taken here of
>>>> unconditionally persisting the mount namespace, and using that persist=
ent
>>>> reference whenever it exists, is better than the current behaviour, an=
d that
>>>> while it does represent a change in behaviour it is backwards compatib=
le in a
>>>> way that won't cause issues. But please do comment on this; see the pa=
tch
>>>> description of patch 4 for details.
>>>
>>> As I understand it this will cause a problem for any application that
>>> is network namespace aware and does not use "ip netns" to wrap itself.
>>>
>>> I am fairly certain that pinning the mount namespace will result in
>>> never seeing an update of /etc/resolve.conf.  At least if you
>>> are on a system that has /etc/netns/NAME/resolve.conf
>>
>> I was actually wondering about that /etc bind mounting support while I
>> was looking at this code. Could you please elaborate a bit on what that
>> is used for, exactly? :)
>
> The idea is that you can have separate static configuration depending
> upon your network namespace.
>
> A real world case is vpning into several company internal networks.
> Each company network uses overlapping portions of the 192.168.x.x
> network.
> Each company network will want it's own dns servers and possibly other
> network configuration as well.
>
> For it to make sense you really only need one company network and a home
> network.  One of which you could stash in a network namespace to prevent
> conflicts.
>
> I don't know if supporting that ever caught on very strongly, but
> I tried to build a template that would work for that and similar cases.

Hmm, I actually use a network namespace for something like that myself,
but I'm not using that functionality because I had no idea it existed
until now... :)

>> Also, if staleness of the /etc bind mounts is an issue, those could be
>> redone on every entry, couldn't they?
>
> They already are ;)

Right, by the transient mount namespaces, what I meant was that this
could be preserved even with a persistent mount namespace.

-Toke


