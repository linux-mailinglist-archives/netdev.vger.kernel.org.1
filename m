Return-Path: <netdev+bounces-40032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A097C57B0
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB36281CE3
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E20D1F17E;
	Wed, 11 Oct 2023 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+WhTS00"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433AF208A4
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:04:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8828EB0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697036638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLlcGcEREybwlAZhQP0OQ8Q56KZ9GGqNl8HWjsC+Glk=;
	b=d+WhTS00Ay/2ocEqo/DaqurLgAEJzYc8jZPnOJisv+IiXjI+gohFyi432LY8u5a9l05Xov
	b3XE5Rp2gglcklQqrXKK8Qbc6yiopYXLvysFfISWBjmcA70BO2iDVyPTgGQ+jQNMVt4AeJ
	CU7k7AnvOE+7y3WM8hV/mQJ++a9llS4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-LTTHzLeaMhK8mqOR2uzx8Q-1; Wed, 11 Oct 2023 11:03:57 -0400
X-MC-Unique: LTTHzLeaMhK8mqOR2uzx8Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae70250ef5so116968666b.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 08:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697036636; x=1697641436;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLlcGcEREybwlAZhQP0OQ8Q56KZ9GGqNl8HWjsC+Glk=;
        b=vpMMEkLfmXp31Zqzn0wB2PuM2IKElNUhfMbxCzzYGqL6N7B9lNrJJMWntNWyuYCLJO
         d9FYqve0F/cNKZ3qCoDEYCxKC41KWvPKD5AUchBKzhKm/r0CnC+vN4NSe1E6sutwPRAi
         a5EPblBgfMKNNocRZ3wCgjSa/FWI6592VOrPvDDyKbDhS04IflAIeNLbodo/CGfgqEtt
         faz7p3O0ae2PPxPjvZjD9R+S2jdizXVvgaR5L9WhkdoL3YU+VnP/vaQoGVCIhUA9xC95
         8jP4IgFGy2GlciU1XVy287YKkfEmB4k98gtF+3Ml8mqkhbKj4160XbMYNCu6wNkKBMKH
         iJjQ==
X-Gm-Message-State: AOJu0YzqwQFOHDfw9nKnS9jw1v2l5w0AxxqSgHgD6/Nn6siBIdvau7Ws
	F+nmWMBXnfIIWNvLOdHsBhLQ62BhOJhwlPDvdHk3RHjVh9TD8CqcLSU+fA0gYVWA/KdJhpkPpy6
	BfJfXAPR/Z/zQTUch
X-Received: by 2002:a17:907:3e1a:b0:9ae:699d:8a31 with SMTP id hp26-20020a1709073e1a00b009ae699d8a31mr21370617ejc.33.1697036635979;
        Wed, 11 Oct 2023 08:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh3Mp2uhE76MvsGweJH7uBEvR6Zre4SVGI0mQr6xkF94BynIC5ctLwgyGMHi0exdEIcl5OoQ==
X-Received: by 2002:a17:907:3e1a:b0:9ae:699d:8a31 with SMTP id hp26-20020a1709073e1a00b009ae699d8a31mr21370592ejc.33.1697036635657;
        Wed, 11 Oct 2023 08:03:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k26-20020a17090627da00b0099b7276235esm10030855ejc.93.2023.10.11.08.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:03:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EA045E5868A; Wed, 11 Oct 2023 17:03:54 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Ahern <dsahern@gmail.com>, Stephen Hemminger
 <stephen@networkplumber.org>, netdev@vger.kernel.org, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>, Christian Brauner <brauner@kernel.org>, David
 Laight <David.Laight@ACULAB.COM>
Subject: Re: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
In-Reply-To: <871qe1i4z7.fsf@email.froward.int.ebiederm.org>
References: <20231009182753.851551-1-toke@redhat.com>
 <877cnvtu37.fsf@email.froward.int.ebiederm.org> <87jzrvzc5v.fsf@toke.dk>
 <87ttqznxjm.fsf@email.froward.int.ebiederm.org> <878r8azjgd.fsf@toke.dk>
 <87y1gajne4.fsf@email.froward.int.ebiederm.org> <87r0m1xo97.fsf@toke.dk>
 <871qe1i4z7.fsf@email.froward.int.ebiederm.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 11 Oct 2023 17:03:54 +0200
Message-ID: <87lec9xkth.fsf@toke.dk>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
>>>>>
>>>>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>>>>>
>>>>>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
>>> My proposal:
>>>
>>> On "ip netns add NAME"
>>> - create the network namespace and mount it at /run/netns/NAME
>>> - mount the appropriate sysfs at /run/netns-mounts/NAME/sys
>>> - mount the appropriate bpffs at /run/netns-mounts/NAME/sys/fs/bpf
>>>
>>> On "ip netns delete NAME"
>>> - umount --recursive /run/netns-mounts/NAME
>>> - unlink /run/netns-mounts/NAME
>>> - cleanup /run/netns/NAME as we do today.
>>>
>>> On "ip netns exec NAME"
>>> - Walk through /run/netns-mounts/NAME like we do /etc/netns/NAME/
>>>   and perform bind mounts.
>>
>> If we setup the full /sys hierarchy in /run/netns-mounts/NAME this
>> basically becomes a single recursive bind mount, doesn't it?
>
> Yes.
>
>> What about if we also include bind mounts from the host namespace into
>> that separate /sys instance? Will those be included into a recursive
>> bind into /sys inside the mount-ns, or will we have to walk the tree and
>> do separate bind mounts for each directory?
>
> if /run/netns-mounts/NAME/sys has everything you want.
>
> mount --rbind /run/netns-mounts/NAME/sys /sys
>
> Will result in a /sys that has everything you want.
>
>> Anyway, this scheme sounds like it'll solve the issue I was trying to
>> address so I don't mind doing it this way. I'll try it out and respin
>> the patch series.
>
> Thanks that sounds like a way forward.
>
>
>>>>> Mount propagation is a way to configure a mount namespace (before
>>>>> creating a new one) that will cause mounts created in the first mount
>>>>> namespace to be created in it's children, and cause mounts created in
>>>>> the children to be created in the parent (depending on how things are
>>>>> configured).
>>>>>
>>>>> It is not my favorite feature (it makes locking of mount namespaces
>>>>> terrible) and it is probably too clever by half, unfortunately systemd
>>>>> started enabling mount propagation by default, so we are stuck with i=
t.
>>>>
>>>> Right. AFAICT the current iproute2 code explicitly tries to avoid that
>>>> when creating a mountns (it does a 'mount --make-rslave /'); so you're
>>>> saying we should change that?
>>>
>>> If it makes sense.
>>>
>>> I believe I added the 'mount --make-rslave /' because otherwise all
>>> mount activity was propagating back, and making a mess.  Especially when
>>> I was unmounting /sys.
>>>
>>> I am not a huge fan of mount propagation it has lots of surprising
>>> little details that need to be set just right, to not cause problems.
>>
>> Ah, you were talking about propagation from inside the mountns to
>> outside? Didn't catch that at first...
>>
>>> With my proposal above I think we could in some carefully chosen
>>> places enable mount propagation without problem.
>>
>> One thing that comes to mind would be that if we create persistent /sys
>> instances in /run/netns-mounts per the above, it would make sense for
>> any modifications done inside the netns to be propagated back to the
>> mount in /run; is this possible with a bind mount? Not sure I quite
>> understand how propagation would work in this case (since it would be a
>> separate (bind) mount point inside the namespace).
>
> Basically yes, but the challenge is in the details.
>
> If the initial propagation is setup properly it will work.  The
> weirdness is how propagation works.  There is a weird detail that
> it needs to be setup on the parent and not on the mount point.
>
> I think the formula is something like:
>
> mount --bind /run/netns-mounts/NAME/sys/ /run/netns-mounts/NAME/sys/
> mount --make-rshared /run/netns-mounts/NAME/sys/
> mount -t sysfs /run/netns-mounts/NAME/sys
>
> My memory is that systemd by default does
>
> mount --make-rshared /
>
> So the challenge may be to simply limit what is propagated to a
> controlled subset.

Alright, I'll play around with it and bug you some more if I can't get
it to work properly; thanks for the pointers! :)

-Toke


