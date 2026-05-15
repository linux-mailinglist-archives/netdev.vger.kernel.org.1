Return-Path: <netdev+bounces-288449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AtyG/CBB2qQ5gIAu9opvQ
	(envelope-from <netdev+bounces-288449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:28:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C38625576D2
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CF78302F0F5
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15173DFC90;
	Fri, 15 May 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="Q4+dBboh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E9D3DFC86
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876834; cv=pass; b=EA7uxOBr9XNPXjI8pCAiNVZTF2qRzHVbKdrjKYwwE6bnq4NHOLDyof6EyERS6oRC0/1+i8C93bumsKpTZsjswnJuK0c7MitiwWNBV8rIok9v4TX4wfRwp5E6dY5bQ096HnQskHFILtd3rsXRbm0lYZOd9M7iAxP2FvIXG9mlo0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876834; c=relaxed/simple;
	bh=bvFO2tQoA6KfOhrIqdfOm6A+Td+qOJ6Y/NTiHn7vb0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfbWEdSnbtWnMioDNtPWntEJSFdXgxD0/oys7maPHZy7PPlghHAnd+aKgYRD9KlS9RbtDNRKBmGWSJwvo61q/KEx4HQux17GUufrhx4CrxgueNFD1ISQ2alFtaL4p4Cbu+CZ83fROAgzNEgFeBtSLGr56Dw0SAwcrOp85rMAXTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=Q4+dBboh; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c801b30188dso94408a12.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778876830; cv=none;
        d=google.com; s=arc-20240605;
        b=TzBjvmpRTbZWGISuxtllGpKclE7QIs0yqGm6/1GrNdCKyWt4i/2yLSK/T/p+BMoYBx
         NKIlAlnBawTaXJWDQjdyj1eIxImMhRWJBkS2PVJ77hIU4bteyRa6y0oWz0gIxsWN52si
         jCaaPFqOVgTtHH4RZ/qGn/2tzaQxcZh3HLdHhcFt2PsNSFWr1gerP/XXnm3++n3mRkiS
         H5X4HXVHfantiS8gubCHU/Af/T1GX870yWmI2EXUmuJZI4nCGzkD+FMhI7RyatrET8hm
         hOGzWoL/Ufh29ySjkZDnH66lVNgpMgmmIxQX8duGkPc8x6FiJuoMNzI6VUz+0HJ6OZoj
         TpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ntDAD6lxKTdP76ePiJuyglP8geBWARN0T9OKfL9vXTo=;
        fh=gBHrq23NHJ3cUg7x9NRyRPrjm16bGA8Dcl3v6j7Y6MA=;
        b=g2TidsGV+RgqkVpIrPVm8OojCrVbUZlStEpu6GhgNXBjcenzGu4tsLJd29iVobfHAw
         glWXFtk0lvMhLxFxmWjkHn3Q+veWthYscGf+NmKXpwBQ+Qed4EojVE3idIYOsJkML4Ca
         94U8TWTxyL3JcYg4Ni+A69Yt9I0h8BIE0Cj6cuqPO34LeEhdZLo29oxV0AIa/vQ/9NWq
         Vpenx+Mfyiq0nK7TUMF7XQ+0TjGXEYBBNV8BaDhZL45e8+dnt6pl8KtKOSGxSLJU6pxA
         NagS4P0lwDBR7Buhf9o6MBL5k70CalvVP9L3DgO0thsI3sQreA5MLYjFI7E18tNq2aes
         5bOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778876830; x=1779481630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntDAD6lxKTdP76ePiJuyglP8geBWARN0T9OKfL9vXTo=;
        b=Q4+dBboh5rKsN8vUY/WRKloIPP3uOV9lxbd2Z8TPTiZscpwGuy4rfU/4VIsRYPszu1
         wVSASHYCBvt6P6r9AvvodbHIgHBkPH1MFikRHyWBhS2+RWMBvCBBi+pmaTMWWxkug95S
         TggZUU2D6nGL+84LFwMbaDHERnPhyYPER1SFQB9g9b7yCZ++TQfyABjyOoGSNKliQc5h
         eexsHADeh/TaFLFO91ckUBKmyECugCWKL/ZfZxILfG6Vj1oDjVgZ+tgCwjXRl7MV1ibL
         czYDjHQOD5nHqaMPVu/tj/NNBfDWBJEyEkhPZXAYGX1yCHUPtbP+zeZ1oQ1xtju2c32A
         pwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876830; x=1779481630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ntDAD6lxKTdP76ePiJuyglP8geBWARN0T9OKfL9vXTo=;
        b=XBwwq0mmaINeNQCz57fEAwxgQztTd4rmDG0MwUfCL7M8y3iiRVxkShZeOY2AGwB0O+
         wVQ16Y7oN/BX2XZiYPfLDjwa4Ai1jBAR3Z8sxz3E8Vz2I0+81vb6/YToj3ecq6pv+sve
         al71FtNnbq3oCSZJDRvlEdeno5AeTrYpaaf8XTqZdwWuoI8/zRmnPp8E1isRQ3teorZd
         +PZQcpHeZHJZUhu6/VTk5Vowp1ZrK5PTAhCouTPYZwIhZXB3LEgP7lbvTHwCOpzsg9rm
         uBQ5l7iIfvCVewwDPp1i4i0osgwPaCRi3EAnUKTbEXg2GPsA9ABEIX1HVl+wR8v20IC8
         aLoQ==
X-Gm-Message-State: AOJu0YyKBDPEGVQnlFVkXN75s5vhCGkcDHURdcNkUuqqQ22M9fNx/LBc
	zv7Yr5E7dQvZvcHUUcGymUWJSvogG8EoAUGYNSPxK/Cn4gc0sBi5MHzuusFS/guABCUAqWa6wXj
	FkaBDh3XApXD5gLUkrvPeDc0NxO7FD7ubPPizWORXTjX0HZyxPj6U5g==
X-Gm-Gg: Acq92OEdercJkUV2snvGzzcB/k3MQ9lxxC6oa24W0iycFGIAPGLS/7z63AupRpGZWow
	G+we83+Str/Q9MOKPCISvqQnFmznAy4x2tJ3NhuXXMr/Nbq7StbuyC/+3qZuQt+hOvG0yJMaAqI
	fHyZ3USqBU8m7Z2+inyNZxrnUpHgQB+prCZuJLXe5dyuhoH9vV6xVUedvGAm2kFcq4Pcyxd/J2K
	8FWJ8atpZemGcxNthpkJFMAPUv6L4yDYhwdIGvOfyTUO76ghkCqPxaToW8L6g8H9vQwBY94kqBp
	4aMXpZ9K0DWnUOSh5Ng=
X-Received: by 2002:a05:6a21:e097:b0:398:7d4a:c2c4 with SMTP id
 adf61e73a8af0-3b22ecf50bamr6391664637.48.1778876829789; Fri, 15 May 2026
 13:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514144747.527175-1-jhs@mojatatu.com>
In-Reply-To: <20260514144747.527175-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 15 May 2026 16:26:58 -0400
X-Gm-Features: AVHnY4Kwh5zFugK50GrFbxIyB_0CtNMYxCcxhbnIDn2QvYYqjcSfPKX7W4uSoS0
Message-ID: <CAM0EoMkthnGFtsmJgj5ibwuFjKg5s8dGOAkJSXUtH4FytG=qtg@mail.gmail.com>
Subject: Re: [PATCH net v5 0/9] net/sched: Fix packet loops in mirred and netem
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	stephen@networkplumber.org, victor@mojatatu.com, savy@syst3mfailure.io, 
	will@willsroot.io, xmei5@asu.edu, pctammela@mojatatu.com, kuniyu@google.com, 
	toke@toke.dk, willemdebruijnkernel@gmail.com, hxzene@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C38625576D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288449-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,sashiko.dev:url,mojatatu.com:email]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 10:48=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> This patchset adds a 2-bit per-skb tc_depth counter that travels with
> the packet. The existing per-CPU mirred nest tracking loses state
> when a packet is deferred through the backlog or moves between CPUs
> via XPS/RPS. A per-skb field covers both cases.
>
> Patch 1 adds the tc_depth field in a padding hole in sk_buff.
> Patches 2-3 revert the check_netem_in_tree() fix and its tests,
> which broke legitimate multi-netem configurations.
> Patch 4 uses tc_depth to stop netem duplicate recursion.
> Patch 5 uses tc_depth to catch mirred ingress redirect loops.
> Patch 6 fixes the infinite loop in the mirred egress blockcast case.
> Patch 7 fixes an skb leak in early return error scenarios in tcf_mirred_a=
ct
> for redirect (caught by Sashiko [1]).
> Patches 8-9 add mirred and netem test cases.
>
> Changes in v5:
> - Fix issues in patches 6 and 7 found by Sashiko
> - Set limit (1000) in root qdisc in test 8c17 to avoid flakiness (Paolo)
>

Sashiko has found some issues - we'll be sending a v6.

cheers,
jamal

> Changes in v4:
> - Fix the infinite loop for the mirred egress blockcast case
> - Fix skb leak in tcf_mirred_act caught by Sashiko
>
> Changes in v3:
> - Renamed skb->ttl to skb->tc_depth to avoid confusion with IP TTL
> - Expanded commit messages
> - Split mirred and netem test cases into separate patches
> - No code changes from v2
>
> Changes in v2:
> - Do not reuse skb->from_ingress (which was moved to skb->cb)
>
> [1] https://sashiko.dev/#/patchset/20260413082027.2244884-1-hxzene%40gmai=
l.com
>
> Jamal Hadi Salim (5):
>   net: Introduce skb tc depth field to track packet loops
>   net/sched: Revert "net/sched: Restrict conditions for adding
>     duplicating netems to qdisc tree"
>   Revert "selftests/tc-testing: Add tests for restrictions on netem
>     duplication"
>   net/sched: fix packet loop on netem when duplicate is on
>   net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
>
> Kito Xu (veritas501) (1):
>   net/sched: act_mirred: Fix blockcast recursion bypass leading to stack
>     overflow
>
> Victor Nogueira (3):
>   net/sched: act_mirred: Fix skb leak in early mirred redirect returns
>   selftests/tc-testing: Add mirred test cases exercising loops
>   selftests/tc-testing: Add netem test case exercising loops
>
>  include/linux/skbuff.h                        |   2 +
>  net/sched/act_mirred.c                        |  73 ++-
>  net/sched/sch_netem.c                         |  47 +-
>  .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
>  .../tc-testing/tc-tests/infra/qdiscs.json     |   5 +-
>  .../tc-testing/tc-tests/qdiscs/netem.json     |  96 +--
>  6 files changed, 696 insertions(+), 143 deletions(-)
>
> --
> 2.53.0
>

