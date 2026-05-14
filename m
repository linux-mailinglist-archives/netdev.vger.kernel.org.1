Return-Path: <netdev+bounces-287861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8POFHaiMBWo5YQIAu9opvQ
	(envelope-from <netdev+bounces-287861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:49:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EF253F79F
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23EDC301053B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45FB3DC4C2;
	Thu, 14 May 2026 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FR9LKUOp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3022D3BED59
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748581; cv=pass; b=sTxmzl5lshQj5OI9dD8LudWIbHjlx9HOsnXTgq1EawMPm54tKXHWXwB0l2s5WPFdHJEiEW2o4JeoKrokpdQ2e6zsRoi3lTU3oDTd0kF/M8lhdrJxJlELFAJwB4QiUMXAmAbLdFkEBPz0MjZK6coh5xOn66R7BAlhktQ259F8o2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748581; c=relaxed/simple;
	bh=AIqS7H+FS8q96fvmjYC8KiK7LbGPQ029LrmPmz7DGsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoLdQtH5KHy2Y/9LC1Lq6SxNEt0P9uTitW3czuMVzOPAPN5ypCEVhBeqRlY6zAThggBrNe6vJwJqV3Km/Oi3sQXJvKHWx5yittSonsEbshJXPnwQpvUjNV8W/A786u2JlNkFsMr34HgR8pnqidufyAaLgv0TOI5BA8HJ37Y3qyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FR9LKUOp; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50fb4a7d704so57889971cf.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778748579; cv=none;
        d=google.com; s=arc-20240605;
        b=Lg1f5fCUwTusa7NNNVyrAIjXKA9gBEfLSY8rFlHL8Lhd5unCbu+G1RmapMcWbPimr/
         //Y/8Xk9uS4s4LbfkFmfIRB+IzbjFuF+oUrzvbiYbFhWF4Zf9CgT1+/1i+0yRiVaHfpr
         S7m2uowBdN9NjP6b2xMKnDC9dGNtiSa51QAIdgfNeOyhfhLBZoHfXzSWf9WE31Fx4J/U
         GTSVZkYw8grKrf+rrL8doeSKPI2ISYBABGzbwZMWXrdeTqvBVmW/rsb0ybAaWriHd+00
         sfF/v4spL+PhO+b+NNyrqN+4JxqHC07zTTR97QXdCf/00OMMS4vEQQRBjepSDxENpkqF
         3+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BCW639vg9pfHfP/ZPIo286GsIfi4t3AHJVhQGVz/9EM=;
        fh=aWlSSpZ6DWI1iUlJeGegFIo4uNBBKprqU8Wkii+kCaU=;
        b=XfYIcV28Ki8ngLJ/dv0Uf3w9p6PEIbCh7JYtU4TBu7RzzaEx3GeOY6RdZXpB160Pm8
         EtHF2u729mv3Zd+b3uL9QJKVtxnB00/snslWc3vJYhquB1oZ0DUHjIamjFL5iHeP1+Z1
         pkAwO6gPRbW6r91I5ncU4juqQ2ytdK7ZbjfC5fK7eeEFQ+SSO4dkz8smfGHly1x/AlfY
         DwxIYLV+bFr5KamyLaW5QZSKyvPRinJzFBT7r+DIHJf18oNHTEektEegkUIJuVqRSjC9
         E1Wx3iS+0SV4eJc3xRMtOX5G8tt94eQla2bNbtC8qd/ZVEkyeVjJgPbR+y+dwdfIgEl8
         z8uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778748579; x=1779353379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCW639vg9pfHfP/ZPIo286GsIfi4t3AHJVhQGVz/9EM=;
        b=FR9LKUOpKYlYxTCk0jcmo5NbkPm2QmQ005lKHcDTNJNsSwcUawdwXTAa/I5STwQtGC
         sqm9u6sj94CT3M8Etfv6q1fGUIf/LeO1i4rAHLJRT45Q5cMrxPpbULKyOhyHJkUps8TT
         esLff/ia8xBMAIQ+h3pZ6bCkYCoJXywbmEvwPxzRXzbXn/gSnmtVOZPHrmiXmp6sLgmM
         if2jAZTLYKwYJRpCl5KmUDEL4a9bhE1wjOUgwnJkNQSfjB+oQ+oqffQZtjCeKekM5oTj
         xvj0Nc3hOl61HyNo1FiT3naiB8ExXfb/h6eUOMbXIi+zlVbx2iCOiYltBW1Bpv6qGrmN
         LNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778748579; x=1779353379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BCW639vg9pfHfP/ZPIo286GsIfi4t3AHJVhQGVz/9EM=;
        b=hFIeYYp04+WghMK5DNmSrgnRgSk05FagS5zIE9D4KJ7BHnuw/qJsvGeNEGo7tQyHST
         llBear3rNMp3JiTzLBI3oKx2mWRkptWIptOhHICy7So5eiMOceX7v9prcI4fBxJD3UXp
         LaU1Qrv8IPtEQmoPTquj8jJPA7HOAFm/EsNQPYg8fC8BJo5wahL6q3Dks3Brcr8J9vAz
         XXoOd9hKJYIARllTS66TVCQQbzs65qjRDY6nrDRVef0OC+XX6uxJ7lHaRc4aaQgNs/yh
         cmjivkUEAahIqqA7f4sMI3ipTihj5y0VD6UW4DXdWlVbBAt5iyGdLe+9QOf7fA/8uwv4
         e7BQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GM/aznBD0tsK/HtVOI08BL7ZKNjiDPJAfHDj1XT96hzzVOlSte3Qkq92K6oiCXFBdEC8iuVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZus0IstqPZO+7+z5dt84dYfTUcWzmDKHcHEs0dT0N3VmSSFZ/
	xM822+nc98Yy7mnzB6bxaqJRbH9D0G0dKhhVs5WWLOhYprOls7zYksvqlUKkw9vH+xo61VuRwdp
	z/MuwwYljue+lNAlmm8FoJbqwu+xnsRxgD9eRItK1YsEFGpXUiWqHWjbT7Bk=
X-Gm-Gg: Acq92OHN6M8tc5GKWKDFoQ//HWh9pq552PbRXlcg2nc4WKvStuJMiT/a4VE7ZJmKNth
	ZiYQRCXqbX2fVfZ99oREb4nUGlbYHRbeCLB2QJfXr/f/bdekH3io8WeR8k1TYeYVJRgfU8IHiNp
	HHvaJT//wK9xuolIGS1hCWI028vjPTqPVU2Ie2wkHTeZ5TmjBsZ6dpUxizIzEMGib951Eay1HBM
	eX7EZWcLJSvB/Dh4qOEpJAaQrxB3zm/VyJROS5k1P/1mBlG90O4JSHkfYhCgkBqh6mvZzrn9/+X
	QpmG7xdGLFTyv74vFWtZ/vOJ/NRZuxs5SHOgHyPYcbbVMQI/apsusJzfAIfpp8povuOwx/oN66+
	IMXKRfwruI2krRRJ+WSFz70zSJIpgNbifVW6p+r8=
X-Received: by 2002:a05:622a:1906:b0:50e:5acc:e792 with SMTP id
 d75a77b69052e-5162f4c06d6mr93191221cf.14.1778748578592; Thu, 14 May 2026
 01:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512094859.3673997-1-edumazet@google.com> <20260512094859.3673997-3-edumazet@google.com>
 <ff0a041e-16c9-4e9c-b717-ff8a2bb85d84@redhat.com>
In-Reply-To: <ff0a041e-16c9-4e9c-b717-ff8a2bb85d84@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 May 2026 01:49:27 -0700
X-Gm-Features: AVHnY4Jao4-cAQpMCZPvvSFBzJan0qFbY9XAFHaBOBQBXzcxHs4-mLmCfPCa87g
Message-ID: <CANn89iJ=t=DPd5cw0YTdcj9dNv9BthW+=3jcHDXgtQYmp1nX1w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/sched: fq_codel: local packets no longer
 count against memory limit
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D6EF253F79F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-287861-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 1:24=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/12/26 11:48 AM, Eric Dumazet wrote:
> > Commit 95b58430abe7 ("fq_codel: add memory limitation per queue")
> > claimed that the 32Mb default was "reasonable even for heavy duty usage=
s."
> >
> > In practice, this is not the case.
> >
> > Packets that are associated with local sockets sk_wmem_alloc
> > do not really need additional memory control.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/sched/sch_fq_codel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> > index 1b1de693d4c64a1f5f4e9e788371829dea91740e..71107dc52be799a14f370f2=
ad74d2eadd93992c1 100644
> > --- a/net/sched/sch_fq_codel.c
> > +++ b/net/sched/sch_fq_codel.c
> > @@ -212,7 +212,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >               q->new_flow_count++;
> >               WRITE_ONCE(flow->deficit, q->quantum);
> >       }
> > -     get_codel_cb(skb)->mem_usage =3D skb->truesize;
> > +     get_codel_cb(skb)->mem_usage =3D is_skb_wmem(skb) ? 0 : skb->true=
size;
> >       q->memory_usage +=3D get_codel_cb(skb)->mem_usage;
> >       memory_limited =3D q->memory_usage > q->memory_limit;
> >       qdisc_qlen_inc(sch);
>
> I *think* this patch is causing TDC self-tests failures:
>
> # not ok 704 a4bb - Test FQ_CODEL with HTB parent - force packet drop wit=
h empty queue
> # Could not match regex pattern. Verify command output:
> # qdisc fq_codel 10: parent 1:10 limit 10240p flows 1 quantum 1514 target=
 99us interval 999us memory_limit 1b ecn drop_batch 64
> #  Sent 490 bytes 5 pkt (dropped 0, overlimits 0 requeues 0)
> #  backlog 0b 0p requeues 0
> #   maxpacket 98 drop_overlimit 0 new_flow_count 1 ecn_mark 0
> #   new_flows_len 1 old_flows_len 0
>
> whole log at:
>
> https://github.com/p4tc-dev/tc-executor/tree/storage/artifacts/645644/1-t=
dc-sh
>
> Looking at the test code, I think the patch broke it, but the failures
> started a little afterward the patch merge, so I'm possibly
> misunderstanding something here.
>
> Thanks,
>
> Paolo
>

It seems this test uses a memory limit of 1 byte.

$TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit
1 flows 1 target 0.1ms interval 1ms

This might be a typo, I think they expected a limit of 0 packet.

commit cbe9588b12d058cbb16735fd468c82ec4b3d1256
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Apr 3 14:16:32 2025 -0700

    selftests/tc-testing: Add a test case for FQ_CODEL with HTB parent

    Add a test case for FQ_CODEL with HTB parent to verify packet drop
    behavior when the queue becomes empty. This helps ensure proper
    notification mechanisms between qdiscs.

    Note this is best-effort, it is hard to play with those parameters
    perfectly to always trigger ->qlen_notify().

    Cc: Pedro Tammela <pctammela@mojatatu.com>
    Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
    Reviewed-by: Victor Nogueira <victor@mojatatu.com>
    Link: https://patch.msgid.link/20250403211636.166257-2-xiyou.wangcong@g=
mail.com
    Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>

