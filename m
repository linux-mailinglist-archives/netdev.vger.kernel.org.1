Return-Path: <netdev+bounces-306992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vf/wIMIxVGrtjAMAu9opvQ
	(envelope-from <netdev+bounces-306992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 02:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A074653D
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 02:30:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=M8LEdPTb;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306992-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306992-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57CAE3001F85
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3E1A6806;
	Mon, 13 Jul 2026 00:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294A7126C03
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 00:30:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783902650; cv=pass; b=pzi8KEmgWnyiOQPDUNRo003UROupI3gQKpi6Pcl/wlb/Pt9midUqgeZ/ZQr4L5xz1xNKJJe5ZpkpoG9kiDODTQCb3mzD0/zw9xiTIzYpbDPLnlcPaM8793uCFpBGkVYe6gUUpdEMsjbTRoeT2wRROBMMqPbik3ny+5phSFDdIzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783902650; c=relaxed/simple;
	bh=YclTtfQFm4H1iD4uxqndR27sxUZLguekuKgacTyMg9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5fSsEGwTd2j7fffp+qn8nSia0E4nXnyQarmHC1iVnjbPnl7BtYzumqpvwaNlw8h2qAiFkxTNnY0O/lmSw9f5NCUKrK2p9qFMnzR/fiTgoN2ZOR0sPzJ42xUddOhnLTU/DhKRUDek8QVLmw6EkEq58KdIwXYLOyEIoXA32dXfnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8LEdPTb; arc=pass smtp.client-ip=209.85.218.53
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15ea93028dso279721066b.3
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 17:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783902647; cv=none;
        d=google.com; s=arc-20260327;
        b=dYLkejajvRUyDDy7dw6xLkXcV6sXsLpiHJMr+hEW/eAgxIlwVAewVBfZRC9c+mKLyA
         YvLiIWkedxW5LmbZ71ohc0sjgWoFZHDQgLb3GPqCpbYGvUHlpeTd201iVxEwp2TJpS/C
         c5pbQLXaC9q9dA3rC+JCRAI6nTQ9birCTJqe7dTgzb1EmVVNLd2Nbz8aF3FRV85io5r7
         wtdHOeznKLxRk6EfJIX/iaiGz3CRB7jXuRVHVMJwmqlQJ7Qh8Q7EqQsNL1w+pDLqlrc+
         a+ERBX9vkFx7t1q50+v5ClLhwEMgLL342sDt0mOWHjx8QurKdHpi/NSh9ZU8ShQ6O/QX
         QuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H1mj9b4CfdzykEisbey5ZMpUh/K36ETmETj2T8bst0g=;
        fh=QxluX67lhTHPICH2rTjXOTdxzn2VtPkFKfrqvXlzUOE=;
        b=D1dCNhOesWbso4p5+CP3y2OZjF8MacK8XpwmWAos8d9wJd+hnqkPwgwkI+JcPHtbnd
         3hY2MMdZ83rY9hFj8e/USPdmM/x+88WJhmy+Cr7h+SsDJcsy6asb7ybRu1fwMaj0qUk9
         4AFji2Z6/RfaSbggyCsZqkI/gSgH5lppMJVfS/ILGc2Zs7OmKHcE1GrtlOOeVQfzmLHA
         +CoZ7RSUWBPJr8Z1VmXVB7RQYa3kkPl1T8UPgg9661OhQzd9uUArCm0xYD+6JJkaabol
         hDschUf7byrkkv2aW3zCmI4k26QzMpxeGt6SEm06Ts4bdwrp+uV3eMmwsDHP7iseDCe/
         J2SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783902647; x=1784507447; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1mj9b4CfdzykEisbey5ZMpUh/K36ETmETj2T8bst0g=;
        b=M8LEdPTbRS/OXPBvZOggTr+J5+1aRxJZiay8Cuj8amZrzodqm79TudUmvnRD4SC3Eu
         pQ+Frv59YE7BDPcKoQ4hC+/FsPq0j2sYS/J27Jnq5K3ZcDX/zwgQGn4iVHMZnlgeCVDX
         Saw0y823/SjyiLufMBZ1MefJwwZMFDJQRL05taZzeBAyl40r1zVwno0sk02c2u/oQvOU
         1nQT8Z3+7etMWkfIhnohZE/4KaiTmo+yXQCsouGFeb6v+EBbD2/Uv6uS5S4r3AclEyPw
         F66/jy+qh30Pe/Vrpnk7f9cJ+44HIG1Najf3ehRRLd9t04kVydfb1Jy7+wfYD3fuVu2z
         eILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783902647; x=1784507447;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H1mj9b4CfdzykEisbey5ZMpUh/K36ETmETj2T8bst0g=;
        b=NFKr48Ine7vYIoeoSkhbRW6vxrjFnEzVJcwkxjN/9c7Nq7f8oz5awAwR4EX+MY4eIT
         8wrEPxi7o6+qRg7IzW7caNvq2pVlFkFaA9qMQpJgV/VDX3lsccm/gZ6fqcUPltQ+bJuF
         jGprRXZ7DppE5DDVDc1ogm3VAGaLAgWHid4rkDYHSnE6sR5+rM124QsTtrpG0s0xzvOv
         fUjNH8JptRjA3mvwdx+8Il3lM7+7kn+XrrAXb4A80+LE5CVSLezwql3tzp0/1tS/WsW0
         7pL0pz6J17IOIdbN56cgDN9JCPUurNx1NM7anv+EcVSwUty3wZpv4kjOwGSfj2qDVLAQ
         MpKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9CBQwMr+uc1l6AUdi05uhhlSj5VLGdJ2HH27jn7j4xB23T0QwHIsRbKrznqm615BaylV3VXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0RTwxrohLyR7GiH3YmI0pXrwdcb2WK/D9NVnvn7wW0YIHHov
	NeHVd9q8wurHmMpCDpPjSHcCR/sP7huf5LN7EPh6k9rOaAfoJeLW2zzpIH3/NMrVGYNgZWQTv+5
	TD0CvnMw043NIr5vTJO+sEQmvjp5vJJI=
X-Gm-Gg: AfdE7cke2V8Y/TFr/A/3gnloVL5BvcfGPhMK7URwpnYpj964P+ZXWGh3fY593tWuX0k
	4F+R9J/kAWCe3NTOc9CiifaR9OiC22oYX8A75nAyaLQEjE9pT4LL86TuzZQAI3COErNldae5B3H
	9DIYJ3sxmxZ2Ut0286St8btpEjIZLS+lhiGOFtzf7SMwQ6nhzRIokF0xPXcITEc3k4yAb40n58+
	tDL+GViepegZt/KP8IDBDJNxf4tDdq7c0e642VYKCztqOMxzsBvFs+fy4md/JOgNFkgbqo09CMb
	pG7uAJPyfBd2aZpAaWa841+BdrX5yW9KY7Sx
X-Received: by 2002:a17:906:9fcd:b0:c16:1ba4:f29 with SMTP id
 a640c23a62f3a-c161f36dfbfmr309609866b.44.1783902647332; Sun, 12 Jul 2026
 17:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709095006.3683940-1-prashanthkumar.k.r@amd.com> <CAEg67Gk9zaFd1KZaffy04VgrRb86TnpDfBtH4Z_jkqQG9bOPcQ@mail.gmail.com>
In-Reply-To: <CAEg67Gk9zaFd1KZaffy04VgrRb86TnpDfBtH4Z_jkqQG9bOPcQ@mail.gmail.com>
From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Date: Mon, 13 Jul 2026 10:30:34 +1000
X-Gm-Features: AUfX_mxHECNWwBLID2eoScv-gzgYAWynjbBG9LVZ9SmcPopMhhk_wrYgKF60Be8
Message-ID: <CAEg67GmDHqtDvV_E_=WkJdZsn+Q=afyf76j726m1iP=Y1qG-aQ@mail.gmail.com>
Subject: Re: [PATCH net] amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN
To: Prashanth Kumar KR <prashanthkumar.k.r@amd.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306992-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:prashanthkumar.k.r@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:Shyam-sundar.S-k@amd.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patrickoppenlander@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patrickoppenlander@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 646A074653D

On Fri, 10 Jul 2026 at 09:16, Patrick Oppenlander
<patrick.oppenlander@gmail.com> wrote:
>
> Hi Prashanth,
>
> thank you for addressing the bug. I will test your patch on our
> hardware next week.

Tested working on 7.0.1 with your patch applied. Thank you.

Patrick

> On Thu, 9 Jul 2026 at 19:50, Prashanth Kumar KR
> <prashanthkumar.k.r@amd.com> wrote:
> >
> > From: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>
> >
> > MAC_AUTO_SW (VR_MII_DIG_CTRL1 bit 9) enables automatic XPCS speed
> > mode switching after CL37 auto-negotiation and is only meaningful in
> > SGMII MAC mode. The original code unconditionally set this bit on
> > every call to xgbe_an37_set(), including when called from
> > xgbe_an37_disable() with enable=false. This left MAC_AUTO_SW=1 after
> > AN was disabled, causing the XPCS to autonomously switch speed from
> > stale AN state during subsequent mode changes, breaking SGMII speed
> > negotiation on 1G copper SFP modules.
>
> In my testing this was breaking negotiation for all 1G SFP modules,
> not just copper modules.
>
> Patrick
>
> > Fixes: 42fd432fe6d3 ("amd-xgbe: align CL37 AN sequence as per databook")
> > Reported-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
> > Link: https://lore.kernel.org/netdev/CAEg67GmFS0Q4oSZkz8zWdOzckSth9_vBPiOy6a7-d697C2w2Xg@mail.gmail.com
> > Signed-off-by: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>

Tested-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>

> > ---
> >  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> > index fa0df6181207..12770af031eb 100644
> > --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> > +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> > @@ -267,9 +267,14 @@ static void xgbe_an37_set(struct xgbe_prv_data *pdata, bool enable,
> >
> >         XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_CTRL1, reg);
> >
> > -       reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
> > -       reg |= XGBE_VEND2_MAC_AUTO_SW;
> > -       XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
> > +       if (pdata->an_mode == XGBE_AN_MODE_CL37_SGMII) {
> > +               reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
> > +               if (enable)
> > +                       reg |= XGBE_VEND2_MAC_AUTO_SW;
> > +               else
> > +                       reg &= ~XGBE_VEND2_MAC_AUTO_SW;
> > +               XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
> > +       }
> >  }
> >
> >  static void xgbe_an37_restart(struct xgbe_prv_data *pdata)
> > --
> > 2.34.1
> >

