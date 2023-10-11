Return-Path: <netdev+bounces-40001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529067C55E3
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750451C20BAB
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE48200B1;
	Wed, 11 Oct 2023 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ai0CuMO8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE5200A3
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 13:49:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9F4B0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697032186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INw5XogOJcd4veMjumqnQXf6RoJ3YrteHvnOFI2NkLQ=;
	b=Ai0CuMO8YnkaUgewDSRFiaMrNLxUJX4x3kvx2+GJaMEZ7gr81Al5nSBA9Aw1ItqJjTTReQ
	VdSqL38RWjlJw1b/Coh1TmoHN8KRruoNoFoN90VavS3fwLLDZJDL8nihKGcINbVXO5bZQK
	DtG1uvz4DowBJgsb95EoaAovduh+DUA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-78Runx58NGiggBGlQM3v7Q-1; Wed, 11 Oct 2023 09:49:43 -0400
X-MC-Unique: 78Runx58NGiggBGlQM3v7Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b98d8f6bafso548997866b.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697032182; x=1697636982;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INw5XogOJcd4veMjumqnQXf6RoJ3YrteHvnOFI2NkLQ=;
        b=N/mpwCeRyuSzxdSiIXGgMN3E41rdmVk8fcrpX01sOAx+uU2GhTDaOugeIJBRePGG/9
         vUDg+4IlvXMaT++yJHNoVuYhheBpA3gVCxE9sOxvhmgS+Tu7QGe67QI5BASbm41imAPN
         qQLYZgS48JNkOe43ymB49dQfx3WV1CZnx0SvSfEbduksOikC2k14ZXXMaREWvVJMknZt
         YucGBRsZQIFSvdkpmeIFpmoQNwjuu/DXqCkpSU8IQqhqkl+lF9HZh1brZiIxqghrfuBg
         CPMroV4FG7PDCo7UIOywP3rPLiONIvHhz2ocr+ypj33YkgcQfi/sUHWEc9DUqato+Vr7
         ObqA==
X-Gm-Message-State: AOJu0YyUEZPt3sRksqJizdJC2X4Qn1XadVpbGYuRoMD4GzNIVh4DGD+9
	Pm9Qn0dOk8E4ZU9bdclZgSLA4cvenY6Vhyojp8uVHR/DNk55S/4ZuSYxv1SbuQQKRRLTjJXaqH9
	gbkwnG/SuMYKNIKr/
X-Received: by 2002:a17:906:cc2:b0:9ae:82b4:e306 with SMTP id l2-20020a1709060cc200b009ae82b4e306mr18748956ejh.62.1697032182010;
        Wed, 11 Oct 2023 06:49:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBu4En6qZsKj/MxfyUJzvr0GzkkgkYKgW/mhkduSGCGGyHf11PpO65hI2r7MK3H73325Tc5g==
X-Received: by 2002:a17:906:cc2:b0:9ae:82b4:e306 with SMTP id l2-20020a1709060cc200b009ae82b4e306mr18748931ejh.62.1697032181539;
        Wed, 11 Oct 2023 06:49:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id gh18-20020a170906e09200b009786c8249d6sm9953435ejb.175.2023.10.11.06.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:49:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7B6B3E5866F; Wed, 11 Oct 2023 15:49:40 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Ahern <dsahern@gmail.com>, Stephen Hemminger
 <stephen@networkplumber.org>, netdev@vger.kernel.org, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>, Christian Brauner <brauner@kernel.org>, David
 Laight <David.Laight@ACULAB.COM>
Subject: Re: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
In-Reply-To: <87y1gajne4.fsf@email.froward.int.ebiederm.org>
References: <20231009182753.851551-1-toke@redhat.com>
 <877cnvtu37.fsf@email.froward.int.ebiederm.org> <87jzrvzc5v.fsf@toke.dk>
 <87ttqznxjm.fsf@email.froward.int.ebiederm.org> <878r8azjgd.fsf@toke.dk>
 <87y1gajne4.fsf@email.froward.int.ebiederm.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 11 Oct 2023 15:49:40 +0200
Message-ID: <87r0m1xo97.fsf@toke.dk>
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
>>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>>>
>>>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>>
>>> There are not many places to look so something like this is probably su=
fficient:
>>>
>>> # stat all of the possible/probable mount points and see if there is
>>> # something mounted there.  If so recursive bind whatever is there onto
>>> # the new /sys
>>>
>>> for dir in /old/sys/fs/* /old/sys/kernel/*; do
>>> 	if [ $(stat --format '%d' "$dir") =3D $(stat --format '%d' "$dir/") ; =
then
>>
>> What is this comparison supposed to do? I couldn't find any directories
>> in /sys/fs/* where this was *not* true, regardless of whether there's a
>> mount there or not.
>
> Bah.  I think I got my logic scrambled.  I can only get it to work
> by comparing the filesystems device on /sys/fs to the device on
> /sys/fs/cgroup etc.
>
> The idea is that st_dev changes between filesystems.  So you can detect
> a filesystem change based on st_dev.
>
> I thought the $dir vs $dir/ would have allowed stating the underlying
> directory verses the mount, but apparently my memory go that one wrong.
>
> Which makes my command actually something like:
>
> 	sys_dev=3D$(stat --format=3D'%d' /sys)
>
> 	for dir in /old/sys/fs/* /old/sys/kernel/*; do
> 		if [ $(stat --format '%d' "$dir") -ne $sys_dev ] ; then
>                 	echo $dir is a mount point
>                 fi
> 	done

Ah, right that makes sense! I thought I was missing something when I
couldn't get your other example to work...

>>>>> Or is their a reason that bpffs should be per network namespace?
>>>>
>>>> Well, I first ran into this issue because of a bug report to
>>>> xdp-tools/libxdp about things not working correctly in network
>>>> namespaces:
>>>>
>>>> https://github.com/xdp-project/xdp-tools/issues/364
>>>>
>>>> And libxdp does assume that there's a separate bpffs per network
>>>> namespace: it persists things into the bpffs that is tied to the netwo=
rk
>>>> devices in the current namespace. So if the bpffs is shared, an
>>>> application running inside the network namespace could access XDP
>>>> programs loaded in the root namespace. I don't know, but suspect, that
>>>> such assumptions would be relatively common in networking BPF programs
>>>> that use pinning (the pinning support in libbpf and iproute2 itself at
>>>> least have the same leaking problem if the bpffs is shared).
>>>
>>> Are the names of the values truly network namespace specific?
>>>
>>> I did not see any mention of the things that are persisted in the ticket
>>> you pointed me at, and unfortunately I am not familiar with xdp.
>>>
>>> Last I looked until all of the cpu side channels are closed it is
>>> unfortunately unsafe to load ebpf programs with anything less than
>>> CAP_SYS_ADMIN (aka with permission to see and administer the entire
>>> system).  So from a system point of view I really don't see a
>>> fundamental danger from having a global /sys/fs/bpf.
>>>
>>> If there are name conflicts in /sys/fs/bpf because of duplicate names in
>>> different network namespaces I can see that being a problem.
>>
>> Yeah, you're right that someone loading a BPF program generally has
>> permissions enough that they can break out of any containment if they
>> want, but applications do make assumptions about the contents of the
>> pinning directory that can lead to conflicts.
>>
>> A couple of examples:
>>
>> - libxdp will persist files in /sys/fs/bpf/dispatch-$ifindex-$prog_id
>>
>> - If someone sets the 'pinning' attribute on a map definition in a BPF
>>   file, libbpf will pin those files in /sys/fs/bpf/$map_name
>>
>> The first one leads to obvious conflicts if shared across network
>> namespaces because of ifindex collisions. The second one leads to
>> potential false sharing of state across what are supposed to be
>> independent networking domains (e.g., if the bpffs is shared, loading
>> xdp-filter inside a namespace will share the state with another instance
>> loaded in another namespace, which would no doubt be surprising).
>
> Sigh.  So non-default network namespaces can't use /sys/fs/bpf,
> because of silly userspace assumptions.  So the entries need to be
> namespaced to prevent conflicts.

Yup, basically.

>>> At that point the name conflicts either need to be fixed or we
>>> fundamentally need to have multiple mount points for bpffs.
>>> Probably under something like /run/netns-mounts/NAME/.
>>>
>>> With ip netns updated to mount the appropriate filesystem.
>>
>> I don't think it's feasible to fix the conflicts; they've been around
>> for a while and are part of application API in some cases. Plus, we
>> don't know of all BPF-using applications.
>>
>> We could have 'ip' manage separate bpffs mounts per namespace and
>> bind-mount them into each netns (I think that's what you're suggesting),
>> but that would basically achieve the same thing as the mountns
>> persisting I am proposing in this series, but only as a special case for
>> bpffs. So why not do the more flexible thing and persist the whole
>> mountns (so applications inside the namespace can actually mount
>> additional things and have them stick around)? The current behaviour
>> seems very surprising...
>
> I don't like persisting the entire mount namespace because it is hard
> for a system administrator to see, it is difficult for something outside
> of that mount namespace to access, and it is as easy to persist a
> mistake as it is to persist something deliberate.
>
> My proposal:
>
> On "ip netns add NAME"
> - create the network namespace and mount it at /run/netns/NAME
> - mount the appropriate sysfs at /run/netns-mounts/NAME/sys
> - mount the appropriate bpffs at /run/netns-mounts/NAME/sys/fs/bpf
>
> On "ip netns delete NAME"
> - umount --recursive /run/netns-mounts/NAME
> - unlink /run/netns-mounts/NAME
> - cleanup /run/netns/NAME as we do today.
>
> On "ip netns exec NAME"
> - Walk through /run/netns-mounts/NAME like we do /etc/netns/NAME/
>   and perform bind mounts.

If we setup the full /sys hierarchy in /run/netns-mounts/NAME this
basically becomes a single recursive bind mount, doesn't it?

What about if we also include bind mounts from the host namespace into
that separate /sys instance? Will those be included into a recursive
bind into /sys inside the mount-ns, or will we have to walk the tree and
do separate bind mounts for each directory?

Anyway, this scheme sounds like it'll solve the issue I was trying to
address so I don't mind doing it this way. I'll try it out and respin
the patch series.

>>> Mount propagation is a way to configure a mount namespace (before
>>> creating a new one) that will cause mounts created in the first mount
>>> namespace to be created in it's children, and cause mounts created in
>>> the children to be created in the parent (depending on how things are
>>> configured).
>>>
>>> It is not my favorite feature (it makes locking of mount namespaces
>>> terrible) and it is probably too clever by half, unfortunately systemd
>>> started enabling mount propagation by default, so we are stuck with it.
>>
>> Right. AFAICT the current iproute2 code explicitly tries to avoid that
>> when creating a mountns (it does a 'mount --make-rslave /'); so you're
>> saying we should change that?
>
> If it makes sense.
>
> I believe I added the 'mount --make-rslave /' because otherwise all
> mount activity was propagating back, and making a mess.  Especially when
> I was unmounting /sys.
>
> I am not a huge fan of mount propagation it has lots of surprising
> little details that need to be set just right, to not cause problems.

Ah, you were talking about propagation from inside the mountns to
outside? Didn't catch that at first...

> With my proposal above I think we could in some carefully chosen
> places enable mount propagation without problem.

One thing that comes to mind would be that if we create persistent /sys
instances in /run/netns-mounts per the above, it would make sense for
any modifications done inside the netns to be propagated back to the
mount in /run; is this possible with a bind mount? Not sure I quite
understand how propagation would work in this case (since it would be a
separate (bind) mount point inside the namespace).

> But I would really like to see an application that is performing
> mounts inside of "ip netns exec" to see how it matters.

Two examples come to mind:

- I believe there are some applications that will mount a private bpffs
  instance for their own use case. Not sure if those applications switch
  in and out of namespaces, though, and if they do whether they are
  namespace-aware themselves

- Interactive use ('ip netns exec $SHELL'), which I sometimes use for
  testing various things. I've mostly had issues with bpffs in this
  setting, though, so if we solve that as per the above, maybe that's
  not needed.

> Code without concrete real world test use cases tends to get things
> wrong.

Heh, amen to that :)

-Toke


