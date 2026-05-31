Return-Path: <netdev+bounces-293480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFGIIoifHGpkQgkAu9opvQ
	(envelope-from <netdev+bounces-293480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 22:52:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0370617ED4
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 22:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E23C130191A6
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 20:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43D5368D65;
	Sun, 31 May 2026 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5d6uDvi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E57B3438A8
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780260739; cv=pass; b=nOAl+2/RfwK89wyrsD7FUYMSCuKxyNYe6gItWJ6NSYRQmVOeGe1uJSobTa6uoVSGJyPDxCT2Lfm/eSdthvY+GpPWeMTdoJeQtb45F5v9q8YvRTYIxCTvTMTAVYfV6z8GiO+quHcHfL1l1/ai1cJOFIZ3oQx1M7IRc2XvC1Hua4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780260739; c=relaxed/simple;
	bh=mJX9EOQZ7aTvNxi1scNtNeclUWfcK/Bzd0Kv5uyrxGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/hJWUUJkciIKMghlUXBEoJVHMrYKePoyvvKq2gvve3WffQhd7k6USli5L26w5L0lGy3CAMM1YWMgS4QtWqDmD2CGJaFjjZMIxnhiBn+YS6SJrkMoZ44YusUZ+f057P9hPQwyiEIjd9F1ew/e6VC7B50+xbsMlXYLTQ6lOU1+kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5d6uDvi; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68be16c61d1so4546462a12.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 13:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780260737; cv=none;
        d=google.com; s=arc-20240605;
        b=fzefhr5kzfBlh+mokJ0MkcrGWibfxRGDscr3mjCMTa1T3/h/AjVseLWbHhQbq+tX7+
         hYEEy/wxceRwJf/1vPG6h6hKRTcgQrJ+D9UesfvyvDstSNxpDdN2zKA4lCAYr3S9fP2D
         qCZ4gPVuAyAuqO012d64ICqMZCAAF1HmIHseu5IfdXXPPiKMiz/A3jMze0tzIb4s/GRh
         l1mPveS57bcDxcsRQJr/dF0TDOeYOlie5UFovLEmxWz+L6yc4wZ06rLE9VaQM7RGib+w
         wCMKVGfTzBXWQYrGeiNurp2M0eNRGTcZvuJezD/7Y5dbY1lDNendymnvmhARuIiGNKS1
         rP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t1YRY1wr+GwXS5LoxoRwMwv1aW/SGGfw/iMtVJ21LVc=;
        fh=9qs7J2ij9l1jwcrECCkxzrXUjTRTgACkgSN7OSp4xq4=;
        b=YN8e/wrK1uMj1jA8iWKd3/QXg+gKp4RBdfvdj4ePSx+jLSb0AKRno/3AX7afK3+o7a
         0xoaT9ZMT4Jy7BHF/9NUNuoSpCi4cCmfZ73ZeKp0Ws8IuEHEcmZVnGX4akNn1ymGrn1w
         dv3Dz9zhYHCMs4JSub5eA27ACdtP9ClZLjUAeeVf5DPAuWXk558YQsvixvFZogJE7T39
         1Bdv9c6aQIr7aC7L6+gPaR4kY5W6envji+7Wt7KFMD2zU54V/pkeDQT3WwdUUR7g8wno
         eovjZusNirPkuyvdmLc5QF4vgHQdycCenOKY3dWDH1QonkPtdjTXaHjfpsER3lJ698EK
         0Zrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780260737; x=1780865537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1YRY1wr+GwXS5LoxoRwMwv1aW/SGGfw/iMtVJ21LVc=;
        b=m5d6uDviFJKRnMCHyeUubEGgWv3q4OVRY/1ddBHwwwhUKwTWnFSEZK6IDmNOgmt8Xz
         PTfxsN9JTYHd2v9UVpWwKn8UMbAj5u80FkHbcFhuMZLS9QaNjnhtHOIpi1ObLxFd/apg
         fvSMEMKLtV4zmkHsyJ+hHtkgsRopigz1GWBMt2zjb08zuxBygzsViJnwAMhYGMidwsQW
         9SoYq0RXleLLgV2gM6fQhAFrD+e4nHwaP4AJ6O+HUIk5XBdtCodOM3QE7PGh9LK6sfJt
         ts+p5F+LEg5wO209l4VIDKpr7RfFuDcU9p/W0yebK2gaCWzDgNjbV38nR32URJN+c3NW
         k7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780260737; x=1780865537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t1YRY1wr+GwXS5LoxoRwMwv1aW/SGGfw/iMtVJ21LVc=;
        b=DQTAV02Ylp8iZerX2iFOBrRxeuH+qQv1lZM7zNfZZeTeGAwHtzTuvl2He/pg/ysCgM
         5qtrs5SmknMrnPK6cIUwHOf9F426fOyV+ENTRa5YNBPDPoMPzb4vIfxOoDglJEB0o+1h
         TG0HTJOXCRqZAyc1ign7Eih6URb44N5oL5SridmoUM39nL5TB4au2p0lWIahmAmP7dRq
         cT5iIhmke4zUP1bG2yULADcNA6jPteCxGlzbOsfKSH7/NQ6UIjuBGOXCtZUQHa82vUkx
         UUgqgBe9e2h1btvf8DUV4sjTzN3YMeq49PjtlQN2tgR0XPWD0juccUFTV5kpIvF3UozS
         pjlw==
X-Gm-Message-State: AOJu0Yy9WFGJqiEbfGrvv3o+54i2ij/gAbmDaPloL3WJ9HpK5gm954kq
	iKyLL6fbzYpJq7TRD5Avj9pPsDYrixgtJSh96IWLRBTcE1MW+BH8L3yuhPiYzXY6X54KLAd4Efx
	bRBQdDtFZiOIDhKBSyJyhahatk+CBNc8=
X-Gm-Gg: Acq92OGujTBj6p6Kh3jCRZ/lsjIm8ucrHebrzdrsiKFXMC5lzk72yQCx/oPe8eLzSZb
	8Fi/1CwstPloyE8M3uyr4CRTM8UIuutTulKdINjjVi58mSMDbsq9W3eOsJ3+thU0QHlbcIdn7aW
	MFzADp4mvEHym6KQRCKJHqTzG25SRsxmKBb2+dCO6cI3lpsV2oxw5XfQVYJX5pjT9qb1IhWkN04
	xPUs1qdkBLyf4tc33fiVqFFWyXlTEyW+k9711RE5XcA10fcu8Hele563tT+XWTmCiS+CGjh4fyd
	eHX1D5QtN/qjFUrISqNx0XRGwm3zOyUAEfe4C2PpaGLJQhCx2LNlfxntoRgxxHA8HQkhR1IO4BP
	iFsd6klpk44RPPLy42knAytt0LVAAVS6AEiK93PJgfuvCsyp4viLWAT7XBpkCYvu4QQ+0
X-Received: by 2002:a05:6402:42d5:b0:678:f8f4:a7f3 with SMTP id
 4fb4d7f45d1cf-68c86235dcbmr4542608a12.0.1780260736608; Sun, 31 May 2026
 13:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531022219.607001-1-rosenp@gmail.com> <9f01c5c2-873e-46ff-821d-3f36ab023555@lunn.ch>
In-Reply-To: <9f01c5c2-873e-46ff-821d-3f36ab023555@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 31 May 2026 13:52:04 -0700
X-Gm-Features: AVHnY4Lcapdk9qwTW6jYuIUVMDtbE0RhKkTnO0DMb28KOH5TfhQ0EK-2aSaQCkk
Message-ID: <CAKxU2N9U-OZd-1PYnRurXrC8e+VP3Ow=XCdQ9hMUG0CwN+NNLw@mail.gmail.com>
Subject: Re: [PATCH net] net: ibm: emac: Fix NULL pointer dereference in emac_probe
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293480-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D0370617ED4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 7:39=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, May 30, 2026 at 07:22:19PM -0700, Rosen Penev wrote:
> > Move devm_request_irq() after devm_platform_ioremap_resource() so that
> > dev->emacp is mapped before the interrupt handler can fire.  An early
> > interrupt hitting emac_irq() would dereference the NULL dev->emacp and
> > crash.
>
> Please add an explanation how this can happen, given that iser is
> written in open() not probe().
https://sashiko.dev/#/patchset/20260517033621.1839397-1-rosenp%40gmail.com

Also, does requesting the hardware interrupt before mapping the device I/O
registers create a NULL pointer dereference regression in emac_probe()?
The hardware interrupt is requested and enabled via devm_request_irq()
before the device I/O registers are mapped via
devm_platform_ioremap_resource().
If an interrupt is asserted early, emac_irq() will execute immediately and
attempt to read the ISR register by dereferencing dev->emacp. Since
dev->emacp is still NULL at this point, this would cause a kernel panic.
>
> > Fixes: dcc34ef7c834 ("net: ibm: emac: manage emac_irq with devm")
This is mine btw.
>
> Is this actually bothering people?
It's bothering the bot. The problem here is any other commit will also
trigger this nonsense. Having devm_platform_ioremap_resource earlier
like this is more consistent with other drivers as well.
>
>         Andrew

