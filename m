Return-Path: <netdev+bounces-260962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAamOaf+nmlAYgQAu9opvQ
	(envelope-from <netdev+bounces-260962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:52:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4119862C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C37A3009F1B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0E53B5306;
	Wed, 25 Feb 2026 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="U029ypQj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB7C3B52E8
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027265; cv=pass; b=nhEdGzyg8beIlB2xyPjVfdb1sHqxuoN/Hve7myhtq7PTMTjq/eXx0CdzDCQZTixFFJ0MsgRvhMQzGJQlPzp9JNNIMv01Vh5RtEvoUcGIN/N2LhOuymxJSVWcPs3GOYTEeBHrZxa5nqFP1DQJXBu2YkRwiv72aswDy1XgQ3omgZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027265; c=relaxed/simple;
	bh=ovELUbnz9MhlUEU54Oo2ZU9Jpyx6+5dPAdAfKI8KdGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QShOKGkjRyinXvAFUfSfMkc/8p7RsBwXRb4YSi7BaNRXJSogJFLL7HEOtqexnvTpyCSX+PvObScSBl54NBYPGij1zDH2JoIvCKGJO7KKFpWtA/HCz8xioinTMloHAQz6c7WQ6klEgE6n613ugEPxOP+cg2JaKt8rNBKeuZIQCv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=U029ypQj; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2adae92249eso15811575ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:47:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772027261; cv=none;
        d=google.com; s=arc-20240605;
        b=bAx4g8LEq5ICQ7vCsqxUd+8b8qzb5zLlrRLrKKlHuidnLJ0jutNR6HHajPdhGjQ69E
         W61DcGiAkzx3x1t/NgVdX/pks9lIgHMEyCG0D7kvW/DK7nRZ5gAcNr013QW4yItRz+sf
         t8iBNxmBYtZfEonO4SaPWw8unlUIWJna59cBlUUWhFbVLsqzFIBNZisTx3llB3NJFwbG
         yW47cMAWesxByuyRa1NkNkt5CLx7xATmFw1yIosnj2lhnGCkCdBkf7v5ZC9juNkAiKDD
         L2UxsTRiE3SXinPbAZflsNfGQ+Q6ipaSqfd7y8/psFdtuzT68mSemKxR81UU4/zo6Apn
         eIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b7iIZNaBQSYUVo9grkEyao3Lov7n84k8BEyjOwlqS6c=;
        fh=XOy88+bcbZYAOqfP+zJa8Qn7ZLv/EdcEyKVEAkU1/Gg=;
        b=iy5vPGFyonPrZwh7qTmz8H7fFFypnXHXndFCGWYlvmxYbtJybEDXpRdriFioFsZcvX
         4jwNdQiVJpkNpqUhvQqmWdBS8J/wN5MKnKU+HnHP05V7UmHAg4OOhKe1bD37mjvG2h4C
         63tnFNl/9E8/JOmuanekKNzx5f8PrYoYk1yPlPB/VW8NXdqNZK2/JkkJy527RhAnE0BW
         4cyVkoWB3eJritAZ01vYCV1o7cF+WsOEdiOKY2wr3tQXkL2bP8qZut+zKglJ4Fpro/Yi
         wyB4lea2wVJTM0dN/h/Xm9TKT1SoKPGrINqAqN7DoeLJj1F1QAVs1nEJf1ojyLauNAMT
         3ntg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772027261; x=1772632061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7iIZNaBQSYUVo9grkEyao3Lov7n84k8BEyjOwlqS6c=;
        b=U029ypQjSr/10HZPeRK/I/q5iOyJDVVhoHXUfeBvwwMRMoThyr8pPipvPayMhB/Suq
         v7/ei7CwnbltmLhS+xZwCskvmI8fyK2TYhbFRx67hta/JTUWUkU2oCJxL0OwSwmx8rmW
         VKvLzrXrdjelOYfEPuwIx9heOYS5sKgCwfqdwY6nqKFtGd/u0oTf/OEkrDoihbmA5l0I
         ajQDO6rSEy8+fPnZy2kDur8P89ShIctDg9Hwr2MNzRmHdWDmxG+MQFvLt4oeZ4xohJqz
         /E+3eH5ICha630Ay5X6lX+mNWeDPt2vE8uUitcSXAEH1p+EdoUbuto3K2+BT/D8iAVZw
         KX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772027261; x=1772632061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b7iIZNaBQSYUVo9grkEyao3Lov7n84k8BEyjOwlqS6c=;
        b=hECShJv5qabx7sulO7XUbPYgR7YGMjJEBiwFdz27BnXpJ4F2OHAMHa5flgqj5rbbvA
         qjx82R9iivLbQCXqhW0QUoX+QI7SRsRmAYhsH1MMLH491eKttUHqggPBS/C7xfEkO1ew
         ls2F0BunlyUDRAGVye3Le82Hsg8F73SOuKdbG1vNnxcZBJ5tWiJmbw5g4hRGPHrUqo3/
         /mnLS8Vp7Ri4otxJ/Xyxxz+VFl4zGlx7cx1W/zDpQe7JCmVmTWF88cS1JpEBsXrJXv3A
         Uab71R4l+4Ztb+Z+SDw4KZqr4KiGUagXkpdyW7KMZtRd7jnoTq78ju/kG5y2VVkQEpQB
         +dZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3u38R3qfLpMjtd5oiZT8eqaRM1gR5cVMXRhsm+sz2W5Tiik2zQYoYHODLJROfpTNwm3VkqVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpwEQlyeEBVaRBtfWrGM+U3yLIsjVCMHFFVM9NB2Mw2F6jzm5
	3bA2b0ZpRL5PkrMNkWpDvS8N3j5Vsep0RG3fJn12fhF362gkeSmOJHlV8EL3nF1wT98amzzRQPm
	vL+GHpRbUYK18KcySYthSvHG+VoGVuKFalHI+wzL/
X-Gm-Gg: ATEYQzzMWPmmGSuNEocnZ8n44lsarcrs9L2XHmPTZZjD2Xby59AeA9REMoFotOCJOzd
	CoaMQ/HfiRHKHQ+X/64/KmoDHBFA9l6mueMHzHsx8C22BY4EO6K+IT2HB+4xhzCptTejdhbo8Jb
	xZU/PU1vqZW/sEGpn8IvKqh3JSPobOpUKA+qh9iXYscnGu0Xj3hncGr7sdwjRFGXz+clPxc+sl5
	r++EPaL9qxj1CKPZsfv3a/efCmb19h3BklLsACd4F/7aZEPJztjNyz5sYVYrNC3JyySUGn/Rl66
	w3TsKrstcYogMDU=
X-Received: by 2002:a17:902:f60f:b0:2ab:3cba:42fa with SMTP id
 d9443c01a7336-2ad7453257bmr163619475ad.46.1772027261300; Wed, 25 Feb 2026
 05:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225134349.1287037-1-victor@mojatatu.com>
In-Reply-To: <20260225134349.1287037-1-victor@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Feb 2026 08:47:29 -0500
X-Gm-Features: AaiRm53px7rqGdRW5gfANKpKc4H6K9kJBUzWMN2Ho4EClKUlj0-gvbVFsYYS_dw
Message-ID: <CAM0EoM=8odYZJ7ccvVB3YqAwssRD9CcB=D1UcKcMifT9dEcTqA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: Only allow act_ct to bind to
 clsact/ingress qdiscs and shared blocks
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org, taoliu828@163.com, 
	netdev@vger.kernel.org, pctammela@mojatatu.com, km.kim1503@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260962-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,163.com,vger.kernel.org,mojatatu.com,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: 5CF4119862C
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 8:44=E2=80=AFAM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> As Paolo said earlier [1]:
>
> "Since the blamed commit below, classify can return TC_ACT_CONSUMED while
> the current skb being held by the defragmentation engine. As reported by
> GangMin Kim, if such packet is that may cause a UaF when the defrag engin=
e
> later on tries to tuch again such packet."
>
> act_ct was never meant to be used in the egress path, however some users
> are attaching it to egress today [2]. Attempting to reach a middle
> ground, we noticed that, while most qdiscs are not handling
> TC_ACT_CONSUMED, clsact/ingress qdiscs are. With that in mind, we
> address the issue by only allowing act_ct to bind to clsact/ingress
> qdiscs and shared blocks. That way it's still possible to attach act_ct t=
o
> egress (albeit only with clsact).
>
> [1] https://lore.kernel.org/netdev/674b8cbfc385c6f37fb29a1de08d8fe5c2b0fb=
ee.1771321118.git.pabeni@redhat.com/
> [2] https://lore.kernel.org/netdev/cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@o=
vn.org/
>
> Reported-by: GangMin Kim <km.kim1503@gmail.com>
> Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo fr=
ags")
> CC: stable@vger.kernel.org
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  include/net/act_api.h | 1 +
>  net/sched/act_ct.c    | 6 ++++++
>  net/sched/cls_api.c   | 7 +++++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index 91a24b5e0b93..2ba40eb45aad 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -70,6 +70,7 @@ struct tc_action {
>  #define TCA_ACT_FLAGS_REPLACE  (1U << (TCA_ACT_FLAGS_USER_BITS + 2))
>  #define TCA_ACT_FLAGS_NO_RTNL  (1U << (TCA_ACT_FLAGS_USER_BITS + 3))
>  #define TCA_ACT_FLAGS_AT_INGRESS       (1U << (TCA_ACT_FLAGS_USER_BITS +=
 4))
> +#define TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT     (1U << (TCA_ACT_FLAGS_USE=
R_BITS + 5))
>
>  /* Update lastuse only if needed, to avoid dirtying a cache line.
>   * We use a temp variable to avoid fetching jiffies twice.
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 81d488655793..7de6eb3ff53b 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1360,6 +1360,12 @@ static int tcf_ct_init(struct net *net, struct nla=
ttr *nla,
>                 return -EINVAL;
>         }
>
> +       if (bind && !(flags & TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT)) {
> +               NL_SET_ERR_MSG_MOD(extack,
> +                                  "Attaching ct to a non ingress/clsact =
qdisc is unsupported");
> +               return -EOPNOTSUPP;
> +       }
> +
>         err =3D nla_parse_nested(tb, TCA_CT_MAX, nla, ct_policy, extack);
>         if (err < 0)
>                 return err;
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index ebca4b926dcf..8c72faf3314d 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2228,6 +2228,11 @@ static bool is_qdisc_ingress(__u32 classid)
>         return (TC_H_MIN(classid) =3D=3D TC_H_MIN(TC_H_MIN_INGRESS));
>  }
>
> +static bool is_ingress_or_clsact(struct tcf_block *block, struct Qdisc *=
q)
> +{
> +       return tcf_block_shared(block) || (q && !!(q->flags & TCQ_F_INGRE=
SS));
> +}
> +
>  static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>                           struct netlink_ext_ack *extack)
>  {
> @@ -2420,6 +2425,8 @@ static int tc_new_tfilter(struct sk_buff *skb, stru=
ct nlmsghdr *n,
>                 flags |=3D TCA_ACT_FLAGS_NO_RTNL;
>         if (is_qdisc_ingress(parent))
>                 flags |=3D TCA_ACT_FLAGS_AT_INGRESS;
> +       if (is_ingress_or_clsact(block, q))
> +               flags |=3D TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT;
>         err =3D tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh=
,
>                               flags, extack);
>         if (err =3D=3D 0) {
> --
> 2.52.0
>

