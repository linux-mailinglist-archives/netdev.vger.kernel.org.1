Return-Path: <netdev+bounces-255466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1Os+GWs4fmnwWQIAu9opvQ
	(envelope-from <netdev+bounces-255466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:14:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98274C323A
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC6E73010D97
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E64E342CBB;
	Sat, 31 Jan 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ac6AQ+HE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8643733F370
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879654; cv=pass; b=IjkfHZeiUcb27eFkhYSuWXa8h/9brvfmunArx+RzAKSWJOhqowHqSMiYwkM1EH/YYK5hztyroaxrJwZTL1P2gWffyZSDw2uR4HpmBIqNhggd4DGuWKS94gL3uHAmGT9z9duf1qd5mSHxijCYRlM/uVpJE02iP3FFDJ/p+/meiQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879654; c=relaxed/simple;
	bh=r+vwDs7BuZngUPxeijC/0bcS3Gi48Tqn+Nl4riVXyC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8Hkjv9BgpsWxrtbSkxcUVn8L5bXP4yG3GZZC60WXZMP/X+ZA6vuHFW6EjlkNCe0k7zF0CZ9HiH1WRrFaeDKvLI1UCQd3HjW0jE96aHHrGexoX7nLzDitMWi3KBQVCdQukO8kxTzXiCYzUZzAuers4UDLJPBl4v8dUrM3o/t30U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ac6AQ+HE; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-823081bb15fso1660269b3a.3
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:14:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769879653; cv=none;
        d=google.com; s=arc-20240605;
        b=Y9Ou/0UwHKYVbeYRaAAxxpMQ4cgX3UCltJ433fNzDefabBjwiHsA1pnRWIODc1wBF6
         EkDXt1qlZ/AKuICd9sl5Qjx1XhHmeZ5UUezHP9Jxh8jkAn2K5WClzREnOBC+r4O90NkQ
         b8NCysDIkICARRn5z0DyPUjtVM3Rv8TtxSIj0pYG3quBv3mCyPYFOntbcIotCz7eGzEy
         vJXMD1Pj84i2vzR2/P+GCgiNpN/zdIqlZfWYmnEiko3YkkmhIcLQUJ/smC1ALufKj9QP
         ltBqTK0KMJVK58O8/MtbLhy4QOcPLYjtQO7Cepu+XGCs35eN4YxMwMzbKkuDkQkSVayW
         E4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C+DEJkDZ8t1gSzphKTb6gNVdppljsyPu97cg1FwdVG0=;
        fh=x9QdEeNHueCIkNXX527hi19agiCELBBIpe2v3pSsflY=;
        b=fDLeD62quMlYi0YoOwphoA/VadgEiC1mCVnsdVcoi/3NbYqLVRwGjJVRx0W2NBXjyV
         YCoInYWcAzPcpQtrCY0EvkQfVNVJkK8QKGCAqtyE9GLMO/Q+LG0UIjsUdBs5XuPUWCWB
         A72DxcNA3wuvOUFfcanpVRJC8JUSnb+4pwvFs0lK3ysT1yP8C4oFog0xKJhECwiT9und
         a63yWM5huGjHIayeEk+IsaavW3tc3jWXbuoOFp3ub+t8q4q0tCBwdkRIIpYWa/QlKbty
         fGw38IoNC2XkTklsZDSuXL24FSLogT7w7Ac9sVvXW73n7C1Tl4vG18zSC6SQ+zau95Tl
         XjsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769879653; x=1770484453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+DEJkDZ8t1gSzphKTb6gNVdppljsyPu97cg1FwdVG0=;
        b=ac6AQ+HE0jew4ccZ88RekymdsiPy9dXnI44jQeu9ZwFnxtp+Rz0KfAepDoPHxfMcfD
         Z5J8Z3+fiC+MHbTB3SGktoSpk8T0di9Qzt2iEn3S2j9+zpif0yLPQIh47GWyiZBssch1
         P3SpG2KCKv5/32x5wTjlduggC3wxqTG0UNs3rIddwOLTa25i7nehxlTjIw/bfjBHirqx
         rrDKq2/hMchede6vcDXCO9xkGGVU2fo+8sNSwMbSBLpahv+mxmCYBA7XffnOosHkzZsV
         J9EPlk1h1teGnn4sI+5lwlyuU6LKrnedw74LTqMm4j9HWamu7jf5mAPH+GAP72kZr6Jb
         9HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769879653; x=1770484453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+DEJkDZ8t1gSzphKTb6gNVdppljsyPu97cg1FwdVG0=;
        b=r5+/RISweJ7K8ZHtEwc3cG79EMZgwHbMBITg/0F764F9c0Jp2jYs3dktNkX/x4RJag
         syXXtK60HhjNhfBlnZ19m+9NyoyUSSGXirYFoMcY3Hb6d8jChl22G/f64LY53oBMcOFl
         CMjO717Cnr8CjdO7xPB1l/TptyEDIeAKWwVp3aQqUraB0UuL/6dP/Z5gMWROJvZ7MYri
         PvRQ52UCInH5yFZD5u+uyRGek9wlhjSVLY9Lacd+3jyoQ39Hdc5oKgH5geJtOBvzeqbs
         SgCJbFPDQq4CBLqTJingZFvym8EdQ20foW8xFlErhgO+qNEz/DRnoQgynF5XP5E4EjW1
         CXww==
X-Gm-Message-State: AOJu0YzFUZyaUGoPmDDnxR/JW5e9L9e7wVoqGyqwptNPiV1yEp7NNiPr
	QoxLETDQwrOtr6d6SjWXiX6GtPf5nbzuY/YuyoYr6oj2LuLNbmyjmljRawgVu/0I7sOP6p4ZRtE
	TjGJicBvLlpvmfCBRrJbs8QNpZUbhyaep22Ki2HX0
X-Gm-Gg: AZuq6aKxi+Z99OLMQSW2hrpSAVuBP7qhchJzfkFTnj1PkerKe+Rxp6iXeBZotHQ045e
	AArk7+BM+yVTV3ShuPRPKXS3CAzVfSknCc/ERh4gFQ/r+DHWvlukZMukh3vkKDgva9ZjRDa+y4M
	jXFESUFzF6bAGSMk5Hu5XTgUFEfM7d7S0gC7VonsHcG8gK8lP9VZryesacZhphgIXpUjheTkrT7
	NEYqo5kOxiVP2aGKFii0MgHwLxepa3EF3ef3IhYJ8RdV3Cb8VUemOyhAZl20ccaP86gTqg3UtIv
	dOk=
X-Received: by 2002:a05:6a21:730e:b0:38d:e9e8:25e0 with SMTP id
 adf61e73a8af0-392e0051edemr6582546637.20.1769879652878; Sat, 31 Jan 2026
 09:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com>
 <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org>
 <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com>
 <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org>
 <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com>
In-Reply-To: <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Jan 2026 12:14:01 -0500
X-Gm-Features: AZwV_Qgs08CtqhIcbX8IL2co-VDwAiZD2ridaHVUhIq8MI3H4zkSvLzNniTVE_E
Message-ID: <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Po Liu <Po.Liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255466-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,nxp.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 98274C323A
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:51=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> .
>
> On Fri, Jan 30, 2026 at 3:48=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
> >
> > What version of act_gate.c are you currently testing?
>
> I am running plain ubuntu on this machine using their shipped kernel 6.8.=
0.
> But i did look at the latest kernel tree and the dumping code has not cha=
nged.
> +Cc Po Liu who i believe added that code.
>
> >Did you actually run the tests? =E2=80=9Clarge dump=E2=80=9D creates ONE=
 action at base_index, with num_entries=3D100, then immediately does GETACT=
ION. So =E2=80=9Ctc actions ls action gate | grep index | wc -l=E2=80=9D wo=
n=E2=80=99t exercise this, because it only counts actions. It doesn=E2=80=
=99t amplify the per action dump size (the entry list does). It uses libmnl=
 (mnl_socket_sendto / mnl_socket_recvfrom) with MNL_SOCKET_BUFFER_SIZE. The=
re is no custom netlink handling. The failure is returned by the kernel bef=
ore userspace parses anything. The dumps are transactional at the netlink l=
evel, but an individual action dump still has to fit in the skb backing tha=
t message.
>
> Sorry - I am not running your code (didnt want to compile anything on
> this machine), just plain tc and i have to admit I dont know much
> about the mechanics or spec for gate, so my example is based on
> something Po Liu posted, here's a script to add 100 entries:
> ---
> for i in {1..100}; do
>     echo "$i"
>     tc actions add action gate clockid CLOCK_TAI sched-entry open
> 200000000 -1 8000000 sched-entry close 100000000 -1 -1
> done
> ---
>
> Then dumping:
>
> $ sudo tc actions ls action gate | grep index
> index 1 ref 1 bind 0
> index 2 ref 1 bind 0
> index 3 ref 1 bind 0
> index 4 ref 1 bind 0
> index 5 ref 1 bind 0
> index 6 ref 1 bind 0
> ..
> ...
> ....
> index 95 ref 1 bind 0
> index 96 ref 1 bind 0
> index 97 ref 1 bind 0
> index 98 ref 1 bind 0
> index 99 ref 1 bind 0
> index 100 ref 1 bind 0
> $
>
>
> >
> > look at af_netlink.c
> >         /* NLMSG_GOODSIZE is small to avoid high order allocations bein=
g
> >          * required, but it makes sense to _attempt_ a 32KiB allocation
> >          * to reduce number of system calls on dump operations, if user
> >          * ever provided a big enough buffer.
> >          */
> >          ...
> >         /* Trim skb to allocated size. User is expected to provide buff=
er as
> >          * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped a=
t
> >          * netlink_recvmsg())). dump will pack as many smaller messages=
 as
> >          * could fit within the allocated skb. skb is typically allocat=
ed
> >          * with larger space than required (could be as much as near 2x=
 the
> >          * requested size with align to next power of 2 approach). Allo=
wing
> >          * dump to use the excess space makes it difficult for a user t=
o have a
> >          * reasonable static buffer based on the expected largest dump =
of a
> >          * single netdev. The outcome is MSG_TRUNC error.
> >          */
> >
> > This is where I am currently but I have seen these bugs appear througho=
ut all my iterations including what's in the tree currently, if you show me=
 better alternatives that solve my problems, I'll gladly accept.
> > https://github.com/torvalds/linux/compare/master...jopamo:linux:net-sta=
ble-upstream-v4
> >
>
> I dont see a problem with "dump" as you seem to be suggesting. I asked
> earlier if it is possible that you can create some single entry - not
> 100 as shown above that will consume more than NLMSG_GOODSIZE? My
> limited knowledge is not helping me see such a scenario.

Aha. I think there is a terminology mixup ;->
"dump" (a very unfortunate use of that word in the netlink world ;->)
is a very special word. So when you take a dump in this world you are
GETing a whole table. In this case all the gate actions.

If i am not mistaken in your case this is not a dump - rather, you are
CREATing a single entry which is bigger than NLMSG_GOODSIZE as i
suspected. I dont believe iproute2 will allow you to do that.
What's happening then is that the generated netlink event notification
for that single entry is too big to fit in NLMSG_GOODSIZE.
Let me try to craft something for that...

cheers,
jamal

