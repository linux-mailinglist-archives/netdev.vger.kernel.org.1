Return-Path: <netdev+bounces-254800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLb4Intge2kdEQIAu9opvQ
	(envelope-from <netdev+bounces-254800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:28:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1476DB062C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 264F93012E98
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80279286410;
	Thu, 29 Jan 2026 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xop3VeCL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFA2749E0
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769693140; cv=pass; b=K149tANx1P/RT8fFB5m67wInACR4Mk50oXrZ3h1gF+qSgHuKk5kxJtENn8B6fwz7PoUEJjGhfoJLdckvXhh/KoetMOV7JV3iUvx0j/6WV1o5+FGLSjEvVz+7Js8XUD4KaB6Bo2uoQz8O2S/zdgVMu724yCrVh5o1g7Ts7LDekpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769693140; c=relaxed/simple;
	bh=irTKlxvC0B/7k9p5rSJ+13AhJAONwpB0xxiLTA9InSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IB60f88pDesgjlYQQoRL8qn2gtbBK6+v//ITjz+6iFG1yGz2Mt7iQ0n9T6G5P3KGbF2vPJLw+v7O1ille08AnDJPy/y0UjfY+686JTxUoRevMRnmuTtq8O87lbOYtqC/jw1qAEfATRk0675i2Qw9MdRQJGsuvta2SoLUe5T8X7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xop3VeCL; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65814266b08so2067150a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:25:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769693137; cv=none;
        d=google.com; s=arc-20240605;
        b=O0eUAqRFcnjf4nZoNxzrjFAeD2qIGBtiYvfFTyAMJwarpYmfc333HPFvTQrMYa5eoL
         NhM6zeEvikYPxBpcVQg6ehVf8qj4HMeEwzH/HcT4TjlHddnpAelUDVf2XMDtFQ1Tn8bS
         yiI/ymORF3I367BaN8cX43K5hVPToA8GTZY4zt4SFyC9UYO+wNbujOy4of7Zquq2dU/V
         lbZVQ1XDfbZqypV9uh9qIy3Uh0eGm3oyIkY7lmGbUR9ZKDe92frCuS8a3YDLc/jTOwja
         r6GPizHya5jOlKXjakluFztzc4qT4yHdsrk0fGPPb5D5jcbUlKlWn3dTMd91bav3FjpJ
         EgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iJI6azVkXkgIfaMxff/M3tZ2LPX3nIaJgPt7XOt8j40=;
        fh=s3IveCHXFpcSL6WKTJJc0nVoUPbji1Yffo02mIVJaC8=;
        b=cdisyTr02SC+nsBirg0gUbssXO5Al1uAjUvuoh1SZxuOzE4LKInALFBgFK+GZGLu/f
         ZZ4a8XXM46tDNiz+nAyMpfqZTafEsIc2ebojaKSZ81ikP2cvI97KNam9KBHFzpFAnk03
         0EsF/JArRsaQrynAmCxRBqjXNIUp5tfM1pu+k4DdCl5ygQB3tyZk/83ar4ywGir+ZFpX
         1eWu4QySAYfgP5oB6Pqg4E8gKr7PIfm18OIgdvNttlNkIh0JFfWu9TlLVrmVkmBuwgFR
         STK2BNR/MeGuGNwaDGjBywMfcMjWcu7UE076tgzzauX0+gU55ywEPpY5pgG0QBGMbVyg
         4n1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769693137; x=1770297937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iJI6azVkXkgIfaMxff/M3tZ2LPX3nIaJgPt7XOt8j40=;
        b=Xop3VeCLd2o6DWj9pkBAcEQlDlnDEyP2QB6YknCNr8iPKDH3cGQF4VsI+S/k/BGSKT
         25FkiPUIkW4p3wXjQKcjIri65GgbIqMHlbAP0/jO0CZejuI6tqJheTPfEm8FXCcv7M6G
         oVap6TiFdLK+5QcwDy+tAWPtRARr96eVigcq7jxReZTD8aW+kZeWGCFHTTFhKfsrLSyD
         vQTttgG6mPuyWET3nFJ9ygukv3JZcroDqfXVRswptjp/BphsIS3MV760mr5dKU8piLSB
         7m8baPlba5i27fq19ukn+IFqJpP/B7M7zznwgnibRGQwoOnU8Z6ENpfkIxn3qSiGQV5P
         OEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769693137; x=1770297937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJI6azVkXkgIfaMxff/M3tZ2LPX3nIaJgPt7XOt8j40=;
        b=wDcgqT6Yj1fTQAfD9sGhLT85CgXkYAPAfRd7eJPpd9asyS3N7clxJk48CfRkURkyGQ
         KwZiFTthWxNaVmVQO/VAA7IUvF8VMocjdivmjkvd8+WTg0JXegIfsx0RBuQ0srnXclqa
         OfkbP+eFtK2W4msX1a2ynfiuIcnUzlr2itmcjKS6dDBimnHbtzVBWxlGMtYkQdS/+2hg
         81uppsqvznZFT6zIFlwqzjFvN1Vsxt3D22DpXJXfz4th00FWfo3WDrS4cbI3T24xVd6Z
         boS9gLpESPjeI8aKGf5TxAh0X1vpSIxHjs2ik0J6CotSSOztU07OXi7495QTH8vyuIra
         jrpw==
X-Forwarded-Encrypted: i=1; AJvYcCUHKZPmt+PRYTTL/KXyJJYW/5zg+yiYzE3+oTGYvBwPIZ6+vLQbBWbbn5Txx1ZtAQjtruJzkQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wkTzlDEsGklub2jojTtAqivRhZM1hiLEH8+RpJZ7lyVhORJw
	Xsbb6am5cxabyXDQHO73cFWRLcBkWnS9Xtab5ZOMsrssarZ4D9KXwme0GlWawAHoU2GtmXmcY2k
	7DsMYEtBZgOzKZPhm8piU/BezaH6rjtVZxYuv3rAfMw==
X-Gm-Gg: AZuq6aI18BU98Lsy2MmS15HtmeafwB1hpc7pw0Rzx76iDIqCOEaiXbU23qLLS4swRtm
	VDahnfo9HcRhdI4suO6usVc70vLEJOZJ8LtV4zAd2gAYiq9XgbsBhJtZkIE+QxSxisuqB/TGYX/
	2LQJSTn+fk/n8T2YjqLPwWJsdbZc9wsZ239VseHdpRFY36IbVJZJvmwgU/IlyQjJGcJ4082ltrQ
	E6GSBo+CZZ+86efh+Jz0fFAaHe45l79pBX501tUEJgjZlHvPrmptH/ZapcO2XPycc65MySkZynJ
	nJwzq4HkeBKY/1NBhehUoBrA
X-Received: by 2002:a05:6402:2792:b0:64d:3b22:a5b9 with SMTP id
 4fb4d7f45d1cf-658a6064db3mr4654871a12.9.1769693137209; Thu, 29 Jan 2026
 05:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-5-vincent.guittot@linaro.org> <20260129120757.GA358439@kernel.org>
In-Reply-To: <20260129120757.GA358439@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 29 Jan 2026 14:25:25 +0100
X-Gm-Features: AZwV_Qhzp9iT1f899kqFHSBaYxaRjfwJBMJyrZuFRXvntdrURTUvSVnGWlmRJag
Message-ID: <CAKfTPtArVxXnAw0F4s03QH3wTPvJ3RRBGf2JQ2burh3v=rS-Tg@mail.gmail.com>
Subject: Re: [PATCH 4/4] MAINTAINERS: Add MAINTAINER for NXP S32G Serdes driver
To: Simon Horman <horms@kernel.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com, 
	p.zabel@pengutronix.de, linux@armlinux.org.uk, ghennadi.procopciuc@nxp.com, 
	Ionut.Vicovan@nxp.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254800-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,linaro.org:email,linaro.org:dkim,mail.gmail.com:mid,nxp.com:email,digriz.org.uk:email]
X-Rspamd-Queue-Id: 1476DB062C
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 at 13:08, Simon Horman <horms@kernel.org> wrote:
>
> On Mon, Jan 26, 2026 at 10:21:59AM +0100, Vincent Guittot wrote:
> > Add a new entry for S32G Serdes driver.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 765ad2daa218..888674a308a5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3202,6 +3202,15 @@ S:     Maintained
> >  F:   Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> >  F:   drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> >
> > +ARM/NXP S32G SERDES DRIVER
> > +M:   Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > +R:   NXP S32 Linux Team <s32@nxp.com>
> > +L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/pci/nxp,s32g-serdes.yaml
>
> This patchset adds the following file, not the one above:
>
> Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml

yes, that's a typo.

>                                   ^^^
>
> > +F:   drivers/phy/freescale/phy-nxp-s32g-*
> > +F:   include/linux/pcs/pcs-nxp-xpcs.h
> > +
> >  ARM/Orion SoC/Technologic Systems TS-78xx platform support
> >  M:   Alexander Clouter <alex@digriz.org.uk>
> >  L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > --
> > 2.43.0
> >

