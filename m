Return-Path: <netdev+bounces-295286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VCGANraPIWq0IwEAu9opvQ
	(envelope-from <netdev+bounces-295286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:46:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA54641037
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:46:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SZQjkGrF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295286-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295286-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 841EF317A882
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E7547DFB5;
	Thu,  4 Jun 2026 14:23:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89213B293
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:23:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583037; cv=pass; b=HiNKXtYCxlXFYdolhTr6KCxVWD26gUGq76Glhk7izfMe2nbaRWO4ybdBXxPKxbV5IitTYl2RRHsQU5QvLgqCgH717Psh49S+qmuFzZMhrrKcYYAFWGzYgTaGu/lYMjHW4JWmUckEiraVSK6BcxhDiQkKtio7h9pk4iN3cfkoJ44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583037; c=relaxed/simple;
	bh=vt8nhgrb2sThHxajsIkk+V+1ruMMVCNaX/ixzdwx16g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVNwc6sl4L/DLmyGG3yTqdcYBDYss/TXTGg4BBT3LyZmT5J78rpQdv/IjPOPPy+J0XQXjjAhlcXf2FXfgC5PUsj+onSVjHBLUksH0a69Q5+ucatNJt9XJ/bMjlMy2UXln0JaJ5iAiLh8pTNRTg8i5tv2zuzHKq+r+zg+/2YaVTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZQjkGrF; arc=pass smtp.client-ip=209.85.167.180
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4865b9e2719so439807b6e.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780583035; cv=none;
        d=google.com; s=arc-20240605;
        b=Ffotb2DGcWE6z9R/z4nVp461KwfvP4KNwvmgsXOPO4qbo0wJ0cO55KSjWBvTCcKgRn
         m+OgpAs9mActHs+pi0Ajuy/eQGeXak+tnrvGS9Vt7jFfE2sgHYflXCRHIVFITDFSlkX/
         g1WUt4+yjVNP2nrCO75Dw67Rs/h2S2WLVk+yjTJ7mrKJriH374CrwgQgvjJzrDMFj2HR
         SX5aDSb72x80gDjk16LsJl/TyPn0QZzGOoDATh8IPAMWGnFh1lnFGzOpzan2NKTWIt3N
         rw5q6x10jf2McfSX5wj5EgnCEE/X3Jp7EJ3eaDYZz3dDkwx3v9sAOAWfFDPajPMJzTHk
         3oTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Hi3HH5l+sobiTKuH6sd+W5IgXXHb4QlH+L6VHIGwyo=;
        fh=yN0ViMpODSFplKY/CnqWLYTpqpH68zAFy6qOmtK3Mp4=;
        b=JyWeibuOog4mj5teMpH0BAW54M/dqb3xp/lpVbt4f7mI4Fqh7wRZktaJXHyD98qBW+
         TbK8TlFgHHohmWxTvUbEnn1ioDQ6sKehDyWuNJ7xedxCHUvLTdpQIFrsudLa20A9YCh4
         aN2/ZpLOZqo4cOjDm8goEhXDc2qoKcVcI8YFNr1N23IMPaj+9i/tbsjw7FfzawSPXthK
         WyviikbNMA6VisVOAyETcvSFLV2aGNt2wdc5o2htba88VuLC/aJgYnEQd6yhvCFzeYgi
         cqzstcDiwirDA32PDmjWmFJzRPfA6cdCB6Cg6ujUAkhhhUwkvAsSuIC7y2Ypra7CBrZJ
         ofJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780583035; x=1781187835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Hi3HH5l+sobiTKuH6sd+W5IgXXHb4QlH+L6VHIGwyo=;
        b=SZQjkGrFom6cAynSpluvHCweyYLfyCt67x/HGpE4rB4GTcq5ZUZ4JjzqlvXN+R9920
         pWRwdLTB97NHkNEm57dYJMoIrBH7baWksldwHdhp7DgIUmW1MZwCjHP7iE4fF9kff3Yk
         FyqShmGgGUxPxoB4DzBsJwzzjXvumLBacYAlhuUKN1NbL93Nk6TRhr33iBK3UUOj/gV3
         e5uVHG42/lvVzJvO0j2odinkhdOpUJk/zgFo8XJ/JjOwhB5cfYp3mRmNPQB9D/F1iENk
         rhGSmYjG4Ql4yVEvriCzZgPf53rtzKAX78aurLCW8lnXsKNLqj+m7jM6khBU6cSzu2hN
         K4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583035; x=1781187835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Hi3HH5l+sobiTKuH6sd+W5IgXXHb4QlH+L6VHIGwyo=;
        b=HWj3JoydloVVAi3KBDWbMHGxolODXlqVlUoic65n2dFutB7FsJU9OvpPxN/YbOvTq/
         JVa8WW5P57lha0QgyxKCMXBam7oXjCMdHezAdAHGe3bSRo96CmyplJoSLrv0pcOgvW5/
         lRItOQPI4XXb95m1h5oguirUQ0h4uqF1kPSi3dnuvgXGnrYcYFpotmyhuTaYmrMqsoX6
         zF8jBpXvWQbFpU/wWFHI0Iv5IfUO27AWpq+EujLZZJwXC1MUKOy64M7s4aPJEUTdu3vo
         8Pa0eCW5CXVfL/etu5qGrHkOT86zr7fPzcgg9h1BKIAD/iTtbx+T59wrG8CQJZaDSceZ
         tprg==
X-Forwarded-Encrypted: i=1; AFNElJ9Z67a1Q6Ja02U+GhBa7YAunt8P70XjDXum2sQJFfD00e4TlBi2OlKtd0leFcJgXXKfVUG3B9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrSrpuNk6MDeNd3boIfU9hUbNZohXJ1TrdGGUsWWHnHKHDTGlU
	TnNG9STDi7oak0d4zEpNgbbzgs2Z9h9dtuyhDYcqC/9Qvh3UTAJAWspgcSqWwVAbQdKi6p7Uvjq
	ENNA7xPs0mOEp1m2hb5NKiQu9oK0IJvg=
X-Gm-Gg: Acq92OFnpvL9C1XcGR5FVI5CgWFazApFC3cG1n+hRzZONn0vnrij38ae0Vc98yeh2YS
	Uub8MNCWKGDJuQgpVWIlxIS+M1vhhZlRMlwUbX7aV8OQYn4iPzQi3PB3u0y8nO5e6qMJ0DCysPv
	v4an44mulewqHdlFJ10i135xIc6PI0lASIc0aCVYx/KmNHQrJzC5jIWQ1yoAxddSxTL0oPxpwxn
	twNu4xOqpu4VXJ8lUydH/00LyhblYzLmAVJN1MKSf9/d0hHA1QxgroiZVtrlGaxZkxBqnbECNtx
	Zfyf0+jnHiRoEOaLS6U=
X-Received: by 2002:a05:6808:d53:b0:486:3537:2199 with SMTP id
 5614622812f47-4865a993074mr4660190b6e.17.1780583034904; Thu, 04 Jun 2026
 07:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com>
 <8978c158-b005-4b53-99d7-b475d9c4c665@mojatatu.com>
In-Reply-To: <8978c158-b005-4b53-99d7-b475d9c4c665@mojatatu.com>
From: Anirudh Gupta <anirudhrudr@gmail.com>
Date: Thu, 4 Jun 2026 19:53:43 +0530
X-Gm-Features: AVVi8Cdr6vKVpyX9U5Qvly8BnpOqfgovOnk_eYUAZjI90dGq-RSPWpVP87MmJpE
Message-ID: <CAN2cbVenex+3wB0o+rvxcFrQOTjAL3W_WQ1sh7QZ_AKewgRVVQ@mail.gmail.com>
Subject: Re: [BUG] net/sched: HFSC + fq_codel stall on 6.6.116
 (qdisc_tree_reduce_backlog / qlen_notify)
To: Victor Nogueira <victor@mojatatu.com>
Cc: "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Anirudh Gupta <Anirudh.gupta@sophos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:victor@mojatatu.com,m:xiyou.wangcong@gmail.com,m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:Anirudh.gupta@sophos.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[anirudhrudr@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295286-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudhrudr@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,mojatatu.com,vger.kernel.org,sophos.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BA54641037

Hi Victor,

The provided patch did not fix the bug.

Observing the same issue, where sent bytes get stuck and backlog
continues to increase, while traffic gets stuck.

=3D=3D logs =3D=3D
# watch -n1 tc -s class show dev ifb0 | grep -A 4 'class hfsc 1:a'
class hfsc 1:a parent 1:1 leaf a: rt m1 0bit d 0us m2 320Kbit ls m1
0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 480Kbit
 Sent 449658 bytes 297 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 132430b 94p requeues 0
 period 2 work 449658 bytes rtwork 1514 bytes level 0

--
class hfsc 1:a parent 1:1 leaf a: rt m1 0bit d 0us m2 320Kbit ls m1
0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 480Kbit
 Sent 449658 bytes 297 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 132484b 95p requeues 0
 period 2 work 449658 bytes rtwork 1514 bytes level 0

--
class hfsc 1:a parent 1:1 leaf a: rt m1 0bit d 0us m2 320Kbit ls m1
0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 480Kbit
 Sent 449658 bytes 297 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 153680b 102p requeues 0
 period 2 work 449658 bytes rtwork 1514 bytes level 0

--
class hfsc 1:a parent 1:1 leaf a: rt m1 0bit d 0us m2 320Kbit ls m1
0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 480Kbit
 Sent 449658 bytes 297 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 155260b 104p requeues 0
 period 2 work 449658 bytes rtwork 1514 bytes level 0

--
class hfsc 1:a parent 1:1 leaf a: rt m1 0bit d 0us m2 320Kbit ls m1
0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 480Kbit
 Sent 449658 bytes 297 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 155260b 104p requeues 0
 period 2 work 449658 bytes rtwork 1514 bytes level 0

--
class hfsc 1:a parent 1:1 leaf a: rt m1 0bit d 0us m2 320Kbit ls m1
0bit d 0us m2 1Kbit ul m1 0bit d 0us m2 480Kbit
 Sent 449658 bytes 297 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 156774b 105p requeues 0
 period 2 work 449658 bytes rtwork 1514 bytes level 0
=3D=3D=3D

# watch -n1 tc -s qdisc show dev ifb0 | grep -A 4 'qdisc fq_codel a: parent=
 1:a'
qdisc fq_codel a: parent 1:a limit 10240p flows 1024 quantum 1514
target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 454200 bytes 300 pkt (dropped 6, overlimits 0 requeues 0)
 backlog 219496b 140p requeues 0
  maxpacket 10598 drop_overlimit 0 new_flow_count 93 ecn_mark 0
memory_used 306226
  new_flows_len 92 old_flows_len 1
--
qdisc fq_codel a: parent 1:a limit 10240p flows 1024 quantum 1514
target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 454200 bytes 300 pkt (dropped 6, overlimits 0 requeues 0)
 backlog 219550b 141p requeues 0
  maxpacket 10598 drop_overlimit 0 new_flow_count 93 ecn_mark 0
memory_used 306228
  new_flows_len 92 old_flows_len 1
--
qdisc fq_codel a: parent 1:a limit 10240p flows 1024 quantum 1514
target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 454200 bytes 300 pkt (dropped 6, overlimits 0 requeues 0)
 backlog 237916b 148p requeues 0
  maxpacket 10598 drop_overlimit 0 new_flow_count 97 ecn_mark 0
memory_used 327594
  new_flows_len 96 old_flows_len 1
--
qdisc fq_codel a: parent 1:a limit 10240p flows 1024 quantum 1514
target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 454200 bytes 300 pkt (dropped 6, overlimits 0 requeues 0)
 backlog 239496b 150p requeues 0
  maxpacket 10598 drop_overlimit 0 new_flow_count 99 ecn_mark 0
memory_used 330016
  new_flows_len 98 old_flows_len 1
--
qdisc fq_codel a: parent 1:a limit 10240p flows 1024 quantum 1514
target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 454200 bytes 300 pkt (dropped 6, overlimits 0 requeues 0)
 backlog 241010b 151p requeues 0
  maxpacket 10598 drop_overlimit 0 new_flow_count 100 ecn_mark 0
memory_used 332436
  new_flows_len 99 old_flows_len 1
--
qdisc fq_codel a: parent 1:a limit 10240p flows 1024 quantum 1514
target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
 Sent 454200 bytes 300 pkt (dropped 6, overlimits 0 requeues 0)
 backlog 242590b 153p requeues 0
  maxpacket 10598 drop_overlimit 0 new_flow_count 102 ecn_mark 0
memory_used 334858
  new_flows_len 101 old_flows_len 1

=3D=3D=3D logs end =3D=3D=3D

Regards,
Anirudh Gupta

On Thu, 4 Jun 2026 at 06:53, Victor Nogueira <victor@mojatatu.com> wrote:
>
> Hi
>
> On 02/06/2026 16:12, Anirudh Gupta wrote:
> > Linux 6.6.116 can permanently stall traffic under this qdisc tree on if=
b0:
> >           HTB =E2=86=92 prio =E2=86=92 HFSC (class 1:a, RT 320Kbit) =E2=
=86=92 fq_codel
> >
> > Symptom:
> >    tc -s shows hfsc/fq_codel backlog stucks while Sent byte/packet
> > counters do not increase for 30+ seconds. No kernel oops.
> >
> > Steps to reproduce:
> > 1) Use attached script =E2=80=98apply_tc_tree.sh=E2=80=99 to create the=
 required tc qdisc tree.
> > 2) Send bulk short lived tcp connections, on the interface whose
> > traffic is mirred to ifb0 interface for rate limiting.
> > 3) Observe that the sent bytes in class statistics get stuck, while
> > the backlog counter keeps on increasing -
> > [...]
>
> Can you check whether the attached patch fixes the bug?
>
> cheers,
> Victor



--=20
Regards

Anirudh Gupta

