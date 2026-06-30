Return-Path: <netdev+bounces-303275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JzRZLvrdQ2rIkgoAu9opvQ
	(envelope-from <netdev+bounces-303275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:17:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E26E5D79
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:17:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=y2GhF5Dv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303275-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303275-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60ED30166CF
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FA133F5AE;
	Tue, 30 Jun 2026 15:17:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD6213E89
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:17:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832632; cv=pass; b=sNHnIxIYP+7DWfjgyWszbhNUUgeIxT0C5Yz7E+Q0a0YfgnKFiGuIQx9l6/Ax7VIucxISayzgfCoXAccFQjQ+J9mKbiVAMclNIB2oa4xsfxKq9QZ9NtTK8QlDnA55SxId1HfLaY7v7TgR/JRsVm1rgYFJNH6sFdLpy58nUaOL60g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832632; c=relaxed/simple;
	bh=CFYZPeDBJHAqq/BvCG48SzQxIRQvOSl7bsIhUTer9L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBDXZf0U9Jmig5PTeHoBfc+Zd1P87Mnp4kzvp1SEim/XzQ6WEVVGOvPvyf1duhjpEV0Epm3yETCLCIsDs/dYXv4a5Um5hZTnAvCgJybwiuRdsI3hlsmkqGP16wi43d6D6B2LHaqAzP5WjPh+L9qJc48SCe58qtBMmkpE8iu4tTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=y2GhF5Dv; arc=pass smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84347ad88edso3942235b3a.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782832630; cv=none;
        d=google.com; s=arc-20260327;
        b=GtXyI2jhMxHF/i2ShVNvPk6MEIayX0TeInVOI2JQSqei6n96dfEi75Pd2lY8ybDmwu
         f+SCClTS/JcyqK/I09hsMP+sTFVcmMkukaSPdaEQKhkUJk7uhPAZuMFD4NmL/pwj8AjY
         VP+nAxOl8YLuvAPlLyrwEj45LfLoSU3wYNfiTtzTl/aH0mvpnjRqqMp3MGju9XglYmwL
         sB6ZX0nHI0KX5W95CSiYlovH5/irQKwaq68CS+89tXepX6/GKz9kSEgUIKuANhIT86Xz
         W5pev0UBbbegS1CANRjmQ7JVcCWcxIjw2mnqiac21p2TEHm4GzHJb2gUnWRsHB0KHO9+
         bhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7E2xvFe845VTulezC24Dlc1of03GvIzkNEoLSFQylEY=;
        fh=JtFSInpxfo80ZA6hsnEtkkx9DcEmw2wPBAXMFjOuk/s=;
        b=mi0ulsohy/pWtzN4ZJH4tmQAX79Y/mXWMYSaL7ssAlsvqRDMD0t4jo2sqCKpVP2iYP
         THfmI0iM5mCogiFcOaCJJYxHoJLHeQXY4j4FZ5ioipNg5oELZLWs1pd4g0I0+YD1dNrT
         5gNZHTpr8IQm+sw219r/m6IwNEOcm4+kyv+dLPuIijvZ6g1LlqLZn6Pkc0KLJ8fXrEiW
         mkPOclvsvrryucUjqmTHCpa+kKzbSXz26ET0Y1cEcGpg6Vf6JLtuLxayCckhUSX6+QjX
         1dpMq/pENOUyJoAm00iB6gnYiMITEzF5ADnvF4ezHlfw+OfQfbgjzBx+SoRW9qR62B2S
         illw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782832630; x=1783437430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7E2xvFe845VTulezC24Dlc1of03GvIzkNEoLSFQylEY=;
        b=y2GhF5DvXlLloT9tMV525w/oiZ+jP72s+r3JsGT0Mtl7v9x7tse9mM0CZrmlofMgCZ
         tr2eBaiPnPCSr7B3gDl8mpqlmUsJRUT0Ia1l24RTsq9+lmWuN1uvRhmAp8CUSVA39MYW
         zTpO3D22jqAMRY1RwzuulTpEwjdYNMt/EChgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782832630; x=1783437430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7E2xvFe845VTulezC24Dlc1of03GvIzkNEoLSFQylEY=;
        b=YiMefyMqBC6coQcNk94QjunYCnlhy8S3+7b5U2ASHKitmqECKDGTN4UYDxhi1jKknZ
         vEfS9kh9k5tGW1MUuVbfae7Fgc2TBi9MdpmaFE1Z7mJ0TkDmsVGbZuTCLlwD+GuH7oFK
         1Mn0ZoV4PV+Cq9HCj8zFRmZlHkZcGl42Uop5T+0jHpVD1tga9yzJm9SfTsALYIDoS3Fh
         WtNMPUcq5TWSq96dkWTxQmHdNy64ytXnkAET+IoPiH3khyN928DUJberbGZINbL6h0/a
         zBqzPtK5iqgvCRRg6XnLdJMQc0YIWNqDdVmkvOZnU78H+1TcUk1B0ojihrka/5pgIOQ1
         xl9g==
X-Forwarded-Encrypted: i=1; AFNElJ8L7nu4h3qK1GSW2q1YFpvo1zTMnWztSAsJ9adFJkLTwSAOhSF5UwKwtVAfXNTtKmQLYW2NEtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw03nt+PknjP35a5EiDlBGqsLw31XZDemIoUAr1IGqQCm8SZwO
	RivJi1fK5Eae3I0Z3AbTXyHv51z6YLZl5tCwKBVew2Szrz4IdBmxb2k+My84cleYCxlb092DP2/
	MNNvJyZzW5bTxQRox6GPPeHI/X32pJyZkRgXb6C6c
X-Gm-Gg: AfdE7cnKBlQ78QPuD3o7eadH6ZANRauFf4PTrqpoMT2hA30njXRty4+N7528+CnKzmi
	K+G/yT01DJgWTxem64VLp/SzVUQjfUBrpP4We/lDUR2UyN4jcVA29kMipxyOUOUPQVGPy3JxnUW
	l46keGb+u++PwSgwwXoFbaeO+TMelWR4hVQZSOKKkWLE83fdS7lbTnDjP6D0x0jRds7Xv2GtVGa
	k95q/zfLchMq6my9mFcu6ayGaSHSpfDLnKYQR2463VYox+/7uH9Xw2UOYVnKOFmotObdCPvJr+X
	Um85DSoa
X-Received: by 2002:a05:6a00:94c6:b0:845:d284:9e0a with SMTP id
 d2e1a72fcca58-8479f28fe89mr3639487b3a.49.1782832629741; Tue, 30 Jun 2026
 08:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630123331.186840-1-daniel@iogearbox.net> <20260630123331.186840-3-daniel@iogearbox.net>
In-Reply-To: <20260630123331.186840-3-daniel@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 30 Jun 2026 11:16:58 -0400
X-Gm-Features: AVVi8CfQO0Jn3fyFry3469fRN46AnxmoFVszUEORXyBOWlbgLB5M02XmMTdE_T0
Message-ID: <CAM0EoMn6H6cKCweHmt=8ve2i0JuK=E8W1Q89oqDD7vra_Uuk-w@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, pabeni@redhat.com, bigeasy@linutronix.de, 
	andrii@kernel.org, memxor@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:victor@mojatatu.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303275-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,linutronix.de,gmail.com,vger.kernel.org,mojatatu.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E0E26E5D79

On Tue, Jun 30, 2026 at 8:33=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> From: Jamal Hadi Salim <jhs@mojatatu.com>
>
> When a TC filter attached to a qdisc filter chain returns
> TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or an
> act_bpf action), the redirect was silently lost i.e no qdisc classify
> function handled TC_ACT_REDIRECT, so the packet fell through the
> switch and was enqueued normally instead of being redirected.
>
> This has been broken since bpf_redirect() was introduced for TC in
> commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
> for a long time because bpf_net_context was a per-CPU variable that
> was always available.
>
> commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct
> on PREEMPT_RT.") turned bpf_net_context into a task_struct member that
> is only set up by explicit callers. Without a caller setting it up,
> bpf_redirect() itself crashes with a NULL pointer dereference in
> bpf_net_ctx_get_ri(). However, even with bpf_net_context available,
> TC_ACT_REDIRECT from qdisc filter chains cannot be honored without
> adding skb_do_redirect() calls to every qdisc classify function, which
> would require changes across net/sched/. Isolate it to ebpf core where
> it belongs.
>
> Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
> wrapper around tcf_classify() for use by qdisc classify functions and
> tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
> the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
> than letting it continue silently. Dropping is preferred over
> letting the packet through because the user immediately sees packet
> loss. Silently passing the packet through would hide the problem and
> leave the user wondering why their redirect is not working.
>
> The clsact fast path, tc_run() continues to call tcf_classify() directly
> and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
> sch_handle_egress/ingress() calling skb_do_redirect() as before.
>
> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on=
 PREEMPT_RT.")
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/net/pkt_cls.h    | 14 +++++++++++++-
>  net/sched/cls_api.c      |  4 +---
>  net/sched/sch_cake.c     |  2 +-
>  net/sched/sch_drr.c      |  2 +-
>  net/sched/sch_dualpi2.c  |  2 +-
>  net/sched/sch_ets.c      |  2 +-
>  net/sched/sch_fq_codel.c |  2 +-
>  net/sched/sch_fq_pie.c   |  2 +-
>  net/sched/sch_hfsc.c     |  2 +-
>  net/sched/sch_htb.c      |  2 +-
>  net/sched/sch_multiq.c   |  2 +-
>  net/sched/sch_prio.c     |  2 +-
>  net/sched/sch_qfq.c      |  2 +-
>  net/sched/sch_sfb.c      |  2 +-
>  net/sched/sch_sfq.c      |  2 +-
>  15 files changed, 27 insertions(+), 17 deletions(-)
>
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index 3bd08d7f39c1..5f5cb36439fe 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -156,8 +156,20 @@ static inline int tcf_classify(struct sk_buff *skb,
>  {
>         return TC_ACT_UNSPEC;
>  }
> -
>  #endif
> +static inline int tcf_classify_qdisc(struct sk_buff *skb,
> +                                    const struct tcf_proto *tp,
> +                                    struct tcf_result *res, bool compat_=
mode)
> +{
> +       int ret =3D tcf_classify(skb, NULL, tp, res, compat_mode);
> +
> +       /* TC_ACT_REDIRECT from qdisc filter chains is not supported.
> +        * Use BPF via tcx or mirred redirect instead.
> +        */
> +       if (unlikely(ret =3D=3D TC_ACT_REDIRECT))
> +               ret =3D TC_ACT_SHOT;
> +       return ret;
> +}
>


Why did you remove the warning?
A lesser issue is that you introduced a space above #endif

cheers,
jamal
>  static inline unsigned long
>  __cls_set_class(unsigned long *clp, unsigned long cl)
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index ac49ca6d9a0c..3ca56d060e28 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -4033,9 +4033,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent=
 *qe, struct Qdisc *sch, stru
>
>         fl =3D rcu_dereference_bh(qe->filter_chain);
>
> -       switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
> -       case TC_ACT_REDIRECT:
> -               fallthrough;
> +       switch (tcf_classify_qdisc(skb, fl, &cl_res, false)) {
>         case TC_ACT_SHOT:
>                 qdisc_qstats_drop(sch);
>                 __qdisc_drop(skb, to_free);
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index a3c185505afc..94eb47ac54ee 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1730,7 +1730,7 @@ static u32 cake_classify(struct Qdisc *sch, struct =
cake_tin_data **t,
>                 goto hash;
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       result =3D tcf_classify(skb, NULL, filter, &res, false);
> +       result =3D tcf_classify_qdisc(skb, filter, &res, false);
>
>         if (result >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> index 020657f959b5..91b1ef824afa 100644
> --- a/net/sched/sch_drr.c
> +++ b/net/sched/sch_drr.c
> @@ -312,7 +312,7 @@ static struct drr_class *drr_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         fl =3D rcu_dereference_bh(q->filter_list);
> -       result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       result =3D tcf_classify_qdisc(skb, fl, &res, false);
>         if (result >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index 5434df6ca8ef..98364f74211e 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -364,7 +364,7 @@ static int dualpi2_skb_classify(struct dualpi2_sched_=
data *q,
>                 return NET_XMIT_SUCCESS;
>         }
>
> -       result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       result =3D tcf_classify_qdisc(skb, fl, &res, false);
>         if (result >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index cb8cf437ce87..25fcf4079fec 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -391,7 +391,7 @@ static struct ets_class *ets_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         if (TC_H_MAJ(skb->priority) !=3D sch->handle) {
>                 fl =3D rcu_dereference_bh(q->filter_list);
> -               err =3D tcf_classify(skb, NULL, fl, &res, false);
> +               err =3D tcf_classify_qdisc(skb, fl, &res, false);
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (err) {
>                 case TC_ACT_STOLEN:
> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index cafd1f943d99..6cce86ba383c 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -91,7 +91,7 @@ static unsigned int fq_codel_classify(struct sk_buff *s=
kb, struct Qdisc *sch,
>                 return fq_codel_hash(q, skb) + 1;
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       result =3D tcf_classify(skb, NULL, filter, &res, false);
> +       result =3D tcf_classify_qdisc(skb, filter, &res, false);
>         if (result >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
> index 72f48fa4010b..069e1facd413 100644
> --- a/net/sched/sch_fq_pie.c
> +++ b/net/sched/sch_fq_pie.c
> @@ -96,7 +96,7 @@ static unsigned int fq_pie_classify(struct sk_buff *skb=
, struct Qdisc *sch,
>                 return fq_pie_hash(q, skb) + 1;
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       result =3D tcf_classify(skb, NULL, filter, &res, false);
> +       result =3D tcf_classify_qdisc(skb, filter, &res, false);
>         if (result >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index 7e537295b8b6..e87f5021a199 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -1143,7 +1143,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sc=
h, int *qerr)
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         head =3D &q->root;
>         tcf =3D rcu_dereference_bh(q->root.filter_list);
> -       while (tcf && (result =3D tcf_classify(skb, NULL, tcf, &res, fals=
e)) >=3D 0) {
> +       while (tcf && (result =3D tcf_classify_qdisc(skb, tcf, &res, fals=
e)) >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
>                 case TC_ACT_QUEUED:
> diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> index 908b9ba9ba2e..fdac0dc8f35a 100644
> --- a/net/sched/sch_htb.c
> +++ b/net/sched/sch_htb.c
> @@ -243,7 +243,7 @@ static struct htb_class *htb_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>         }
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       while (tcf && (result =3D tcf_classify(skb, NULL, tcf, &res, fals=
e)) >=3D 0) {
> +       while (tcf && (result =3D tcf_classify_qdisc(skb, tcf, &res, fals=
e)) >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
>                 case TC_ACT_QUEUED:
> diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
> index 4e465d11e3d7..004f0d275caf 100644
> --- a/net/sched/sch_multiq.c
> +++ b/net/sched/sch_multiq.c
> @@ -36,7 +36,7 @@ multiq_classify(struct sk_buff *skb, struct Qdisc *sch,=
 int *qerr)
>         int err;
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       err =3D tcf_classify(skb, NULL, fl, &res, false);
> +       err =3D tcf_classify_qdisc(skb, fl, &res, false);
>  #ifdef CONFIG_NET_CLS_ACT
>         switch (err) {
>         case TC_ACT_STOLEN:
> diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
> index e4dd56a89072..79437c587e7e 100644
> --- a/net/sched/sch_prio.c
> +++ b/net/sched/sch_prio.c
> @@ -39,7 +39,7 @@ prio_classify(struct sk_buff *skb, struct Qdisc *sch, i=
nt *qerr)
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         if (TC_H_MAJ(skb->priority) !=3D sch->handle) {
>                 fl =3D rcu_dereference_bh(q->filter_list);
> -               err =3D tcf_classify(skb, NULL, fl, &res, false);
> +               err =3D tcf_classify_qdisc(skb, fl, &res, false);
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (err) {
>                 case TC_ACT_STOLEN:
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index cb56787e1d25..6f3b7273cb16 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -709,7 +709,7 @@ static struct qfq_class *qfq_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         fl =3D rcu_dereference_bh(q->filter_list);
> -       result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       result =3D tcf_classify_qdisc(skb, fl, &res, false);
>         if (result >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
> index b1d465094276..ed39869199c0 100644
> --- a/net/sched/sch_sfb.c
> +++ b/net/sched/sch_sfb.c
> @@ -260,7 +260,7 @@ static bool sfb_classify(struct sk_buff *skb, struct =
tcf_proto *fl,
>         struct tcf_result res;
>         int result;
>
> -       result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       result =3D tcf_classify_qdisc(skb, fl, &res, false);
>         if (result >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> index 758b88f21865..77675f9a4c46 100644
> --- a/net/sched/sch_sfq.c
> +++ b/net/sched/sch_sfq.c
> @@ -171,7 +171,7 @@ static unsigned int sfq_classify(struct sk_buff *skb,=
 struct Qdisc *sch,
>                 return sfq_hash(q, skb) + 1;
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       result =3D tcf_classify_qdisc(skb, fl, &res, false);
>         if (result >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> --
> 2.43.0
>

