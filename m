Return-Path: <netdev+bounces-273239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPJpH6ePymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:58:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1015235D4FB
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 921C030166DB
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2718A32571D;
	Mon, 30 Mar 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbOTibFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB319CCF5
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882269; cv=pass; b=AB0l7cWGct3IFJUr9iY+nKVlpROKlYgxbLy6COpDopkNkWiL6EQyZTOCMh1ps/Th0onM38HlrkXVamBsBYIT2WhMVSE2z/bDVIocuJm5FZthGPDAF6HGoYnMm/PV1ZbS1EKhAqoWHcMRfgLd6pFQpefAZHG8gKgskq72RQy0aFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882269; c=relaxed/simple;
	bh=NjGIippjLS5ZXI0KUGqyzEpNOpbu7+icz/0Lca/Ryno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLdZe47B/FcBHJUFeD4Wfn3YAB7PPYyZUYbfO9OVoXUKrBIQs19y8hV3PSbdkSpG0RflcktjQB7d5LE2UqhBN0rLKmipHB4Jo2JM2FfzLFaRuIBb/RX0vIAZK/qsY3fQyQg/C9wpGz7tlTUxfuiLvLWyM73QB+bW2p6/NpsQi18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbOTibFM; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so8557218a12.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 07:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774882266; cv=none;
        d=google.com; s=arc-20240605;
        b=NxkthRTM0dJ8CbMWrR89FyVOiKlvg3P1wdRODvc/Bz3TzNUCqEUloAQQXfWQWERsdR
         uarg8jCUQfmCGjJFKwnaAFIeP9DjLvRJf/b7hLDcBSBkb1Y/dmafOdn5T26PgMJIZZmr
         XbRewR0AZfKGpNccNFEqa3r/WBoK9zNjpVe4RXyGutABRHjBOudYsDF1PV1cU4vA6qAw
         dTn4WtYf5/eyj8cN3+L78i63hsXrMYeluJOP9iBday6H+Eeup8Op1rYpcdOskrYcDPeN
         7V+j/WRRkaIPqFCiNoK2+arh7hTceZuCC7878sxcIWYbdxw1oZReTcbTbSpLn8HZg4Uz
         5nPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/29l4ASRAtCKpi5hEDTGjzG665e4UiSdXvjWcpaD3Y8=;
        fh=C179Hr4gCnuBNXJAV1r1LcRDKvqci9ZSBcownxuQJzg=;
        b=RSa/pzZyOIhr07kDOoUwu/bGPuRudEKMqu9l3cvaO4KPSgw0L/WYj5fnPoenothJ94
         t2CKkbTFoHkZBCZiaN/pJDWPzTVRUs82JtTG/S5DAKpwc9qvHxaK30RAN0r2QmMV7+Xe
         Opl1jHkM9reO49/1PIaIEmAHWdzczkvOVVyz6Rbf+nX2V9eFQdUEirygbzT51SO4Mhyd
         pEMiLZ6LlmaJ3CP29OedOTdCnkNOmqmS5mXZlc1HjdoB/jMIFiSrIAy1UKvN6zko4V0t
         GURkT//KKzUhd0yduW6tWlWEpVcbMrLpm7qOeTBsqCcH52PE76ymZdkl3drNfJs5Ff58
         haBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774882266; x=1775487066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/29l4ASRAtCKpi5hEDTGjzG665e4UiSdXvjWcpaD3Y8=;
        b=MbOTibFMZOMt+kySZidRdHQaGXDCouZIVWZegqU1wyepZTHd613oc4D2B9Q6Y67GPC
         RRtGAcp3bk4mlGJ/NHZ5ebXMlRkKrO0BrPEQEAdIM341chx9RLK0wNvCdrQePSklVXbP
         aA+jgsz+BJo1alJmTW+F29++/x22qUOPUVF0HjjmJXsAg86brR90VCdrm6zJhVAu/nnu
         HKuacoNTIK4xqIc4u7oFLeSHT48wX9DMmgQCHyTISp5E2DrXoppgoRul0xq9iZXQg3Hp
         xh127Wr3YSncHMyMGrgQh/VCjV1CDpwgaeqfnRrem1xi3zRV589u94ZqIkeqNj55r2hU
         Y4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882266; x=1775487066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/29l4ASRAtCKpi5hEDTGjzG665e4UiSdXvjWcpaD3Y8=;
        b=dPJtjCISelQKPTvGWsLiK8X/8WizMdSomfh4UvTsTzObIC0L/E6YmKG1mpYaw+SkBm
         7Kfmuc9GBBayH63X8veu9S+7weuGgIFVrpD16b0PAtKx6ybYclW5IOuv82VW8yODlmQK
         VxyYHj1gCkOEdyCdHhhG1JjqJoSkVZFfjRi+7A1p7H4ut7sc4Z+2kiAcbz/0IQVV7hB0
         TI+vZQrzN/YYyoVI/bB4gKUJWlW7jft6J4dKHuLxH3sTGWpbRuoRc7jKYne9X0zhevi7
         3TwI2MHhhPgBLUvnUJuMZZYkwLS5y5pAwQ2UkARbiYqvSL0LZXK70IilF71iqznUn9l+
         a3QA==
X-Forwarded-Encrypted: i=1; AJvYcCX292i+6n4nZRRrTRR3WOrV2CY2OF9UqeeeooGcZn8PG5WmVx/LTspEIiLpD+1nR1rfmCncq/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJ1iBY5ao1izMo3QUrkaZABo3XGbh3J8gsSJPQZTcULY1g3ho
	mwxGH8+ajtBbvT7mE2zxXNGa1SUVhumI1GLnZZsBu7oqUrqfA+K+9Za9TdYwqI0HmoHn4stR/9d
	O0DnvFMHrgt3nfQCrzi7wDedWX+b5ZEI=
X-Gm-Gg: ATEYQzxVsl0PVSvB6em+ey4PU2CrCEc4NrekhrGDjVY87o/SZOJVT3f4WRgiOZcETA8
	hFu6sRUYDxFH+QwmgstH442Htq3//B8fwdwFJJ61QK0ays+At5QuOCw9C3hME5+upvz8UiFQ2gB
	mvIqp4MrbGvl9s0Ndt5Gi6zqny+RcR98eHp3J2lTW7Ux/1l00bZl/9a8SdwFSURU11j3M0r4r9V
	ryMIjKGtW9OBtKekZzJxwFhojctnkUEbdHkjbTDYxgnmBaC2W1bF+AVGXBL9JTEqlfrFAEwUM2R
	3/i14XG8UT+l0fudkMr5CGiuqlav0O2CFhMkKRPZ+A==
X-Received: by 2002:a05:6402:5242:b0:66b:b6e2:66cc with SMTP id
 4fb4d7f45d1cf-66bb6e2685bmr3075752a12.12.1774882265822; Mon, 30 Mar 2026
 07:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326123639.94056-1-keenanat2000@gmail.com>
In-Reply-To: <20260326123639.94056-1-keenanat2000@gmail.com>
From: Keenan Dong <keenanat2000@gmail.com>
Date: Mon, 30 Mar 2026 22:50:53 +0800
X-Gm-Features: AQROBzAKWuTJvh3yODAaK8vNjUEAcZlPUPqIxkzkkSOl1VhgGHpTafygot6Xmek
Message-ID: <CAG0CALwyMFsJ9w8ZXvSNF638GamuyAFX9tAbwC+2nujGp+vwTQ@mail.gmail.com>
Subject: Re: [PATCH net] xfrm: account XFRMA_IF_ID in aevent size calculation
To: steffen.klassert@secunet.com, netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273239-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keenanat2000@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1015235D4FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Just a gentle ping on this patch:

I wanted to check if I might have missed any process or
if there=E2=80=99s anything I should revise.

Thanks for your time.

Best regards,
Xianrui Dong


On Thu, Mar 26, 2026 at 8:36=E2=80=AFPM Keenan Dong <keenanat2000@gmail.com=
> wrote:
>
> xfrm_get_ae() allocates the reply skb with xfrm_aevent_msgsize(), then
> build_aevent() appends attributes including XFRMA_IF_ID when x->if_id is
> set.
>
> xfrm_aevent_msgsize() does not include space for XFRMA_IF_ID. For states
> with if_id, build_aevent() can fail with -EMSGSIZE and hit BUG_ON(err < 0=
)
> in xfrm_get_ae(), turning a malformed netlink interaction into a kernel
> panic.
>
> Account XFRMA_IF_ID in the size calculation unconditionally and replace
> the BUG_ON with normal error unwinding.
>
> Fixes: 7e6526404ade ("xfrm: Add a new lookup key to match xfrm interfaces=
.")
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
> ---
>  net/xfrm/xfrm_user.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 1656b487f..d79240a1c 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -2677,7 +2677,8 @@ static inline unsigned int xfrm_aevent_msgsize(stru=
ct xfrm_state *x)
>                + nla_total_size(4) /* XFRM_AE_RTHR */
>                + nla_total_size(4) /* XFRM_AE_ETHR */
>                + nla_total_size(sizeof(x->dir)) /* XFRMA_SA_DIR */
> -              + nla_total_size(4); /* XFRMA_SA_PCPU */
> +              + nla_total_size(4) /* XFRMA_SA_PCPU */
> +              + nla_total_size(sizeof(x->if_id)); /* XFRMA_IF_ID */
>  }
>
>  static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const=
 struct km_event *c)
> @@ -2789,7 +2790,12 @@ static int xfrm_get_ae(struct sk_buff *skb, struct=
 nlmsghdr *nlh,
>         c.portid =3D nlh->nlmsg_pid;
>
>         err =3D build_aevent(r_skb, x, &c);
> -       BUG_ON(err < 0);
> +       if (err < 0) {
> +               spin_unlock_bh(&x->lock);
> +               xfrm_state_put(x);
> +               kfree_skb(r_skb);
> +               return err;
> +       }
>
>         err =3D nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, NETLINK_CB(=
skb).portid);
>         spin_unlock_bh(&x->lock);
> --
> 2.43.0
>

