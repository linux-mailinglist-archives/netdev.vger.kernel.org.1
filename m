Return-Path: <netdev+bounces-261473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OqoDRCFoGkakgQAu9opvQ
	(envelope-from <netdev+bounces-261473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:38:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 328641AC965
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8F2A31F0AB6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C25426ED6;
	Thu, 26 Feb 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1HDMIYe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1443E4AB
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122219; cv=pass; b=G3nAlA4/9WGZnfD+SeSx4sW0VEjyLLrw2Y/X4sGe/yHDVHR5QhqcPKt6yfieA6ijy41Tmowh3d9/J3E8XOB8lE8uIK2FfUqbbUix7Ik8y8+FGTzpBK4H6rWqNgmOmffsYyD9ocDvfLw4PkzZxdxPubv5DIbFBhfzQ2LWbhDjJbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122219; c=relaxed/simple;
	bh=dXUwA0TQXWiB5tGToQJfVmSDM/JIXXUFQoNEi5/JUnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRqryI2nfvg0ArmiwnDly/dFxHfEiyxugcesWlznCNR+q0A1fYpkaysvZmV2pOqTkHDS9BQT0OBqNFFNvkROIJFuzptfwTFyOtKn+SQHaQvStsdk49YlPFRSwPi3rojksIvqZkohMsbIG/1UOM9Wwr01iArnv/pmjZ62m6akd38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1HDMIYe; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ff1699312bso545968137.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:10:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772122212; cv=none;
        d=google.com; s=arc-20240605;
        b=HFCn/1cTs6qxs+8VOIMXSddm1Prrzwi8Bqt/2kgw4V9fjbyBtGcHq4NOq1mACkdeNM
         /Kbq2/xswt3a4Naz58/9z2iePyxUFNVJA99NtWAzpxBcOegU7M5Xu0etXnC94sih1gOe
         W6mpjYFMAWBeLEOz9HlRWTSmxcgD8jySu/N0Hj8ddzb3txo6HIInd53p3RwdTfOxgjqD
         MB0/aJa1JfOAVShVJmGjse1tGaLjO93qDJG2F+ad2PLgTdf7HrtyQtQz7ajrJ5ynxpEa
         jr2GcdT1ev5H734irHDNoxrPuPLAvoGKZ2LNpWMlIX2Tyc8Ye1K6mzDsEZp1yEhWaQDQ
         NR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dXUwA0TQXWiB5tGToQJfVmSDM/JIXXUFQoNEi5/JUnk=;
        fh=YpnUg7eXVwdCUy8q6oEN3uPdK5VZTdzpBc5LfX5ZuEM=;
        b=DtDnD1EaXIygSVlwHA7iAHQneF6vY5iyb8r2S70EGrMwjW+H3CWRxR/HoAOKK3c7iJ
         pAjAxRP1i8R5yZZuSzs1J+OznRF5bukS7EPQYOMsyEv+6aXH24oAj/wUMVe2eUHkXfbp
         gp5f1gxu8RCIwFIuui+vpKVrWjrtupnN45xZ6mqS7o44wpBPYuCA2xC/HBkicWDHSfZ2
         DwB9+b2Ln2uHyeuCYoQUZ2T9/BgeXB7V6e9jJjX076BW1cRVKpkTIVOAHGssXNFSTcxZ
         VRwc65QIpEZKnfvIDy4bKmGyijLpBRuauWY8VnCcGTbg5sdAGVMCt2jhImwkfYy0ef3R
         Ko9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772122212; x=1772727012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXUwA0TQXWiB5tGToQJfVmSDM/JIXXUFQoNEi5/JUnk=;
        b=Z1HDMIYeLTmoyOtaW8cBILpe5gGI14KwZGlLANTcUocbWgSAmjvyp5jVKu+AOoqgL+
         Z9dAzaG8CKG2rbAOSLt6zkjrrysBROefAy4yC7IBOTD3SpIBgMowc44O/c5IiYUjqUMw
         gkLn/+VRacf3ZfjTvMllljWUPsfi8uEu0cGyioWX/dx4ougPcaiBVt9y9+PAuxKbRW6G
         ZKNbnjNc0cA9Xnnnhmr3IoEl0+lsUMmMjaigSqApIinXo5HKVKbHSVg3DuQH6IWAFnGE
         HCZSMkSaW8uKHR0bjAINNqpUpoFfZQ/uRPolUuQ37v69bVnu/8Gd3amt9/FyIMC6qzJq
         rUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772122212; x=1772727012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dXUwA0TQXWiB5tGToQJfVmSDM/JIXXUFQoNEi5/JUnk=;
        b=Pj3wubYYhL8a2Fcqog8FLeT8eoTSMtwdSc0ciuy885Qwm2QL8q+xVOhdCcDTViR6Wj
         nF0guHkmHqtzN6+pdUjDLdTYtgXUGiRyTIDS3ME9NH5jH7Zz276zaMhSr4NAUuf04G4Y
         otRbauOcOjhWdgxZyLGmlsBnOdl0rDvGPfulH2su34DgOGl9EQJXOeL0fQLQJCL/5CXZ
         i7J2lP3Y9dipk4tkELA0m7ZYuX1rJSEge537+wLXO3cdIK5MTsVxyB3hz1mfeMY2Zb3G
         hqYAlzCqlqINk2+LnWMb2WGl/4ojFBQM/F1GYchF/DfMW4ee1NYV1Epz4W3cE6q+K7lr
         aPwg==
X-Forwarded-Encrypted: i=1; AJvYcCUO5RTilOQvh28OKtYu7OIUdp6KdZfuH25gxFk5THFDtvJjBQ+gCEGBRW2ZNV15hm7S9M/mPrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwertmMKk58QEKBSPtwWATuqZ2LWVs0QNuKHPqFi/1u+gPJHJod
	E5vWQx3fdTcxCGyPPghH9zSfgqNH6GmVa9mBy98yEl5P4NDOlEPcSp1gzJUQeS3JtgFcji87Qab
	vUNo7189mrZU3IFCr6AyQqJpxICCI6+o=
X-Gm-Gg: ATEYQzzRFI/KS2K/SGn4HuWCU3HnUdtllv7U0i1xlFvQXOt7x0D8gUFc7YS9LZYtxBw
	2j3up1DDRZSJdZLUwJMlrA73usyL6tv2toamuVDt2spOKvkOBdy/17RRBG2a1Psvorp8oL2vZif
	FzPDfyi3FDC4nhHoCUimnennmOLPhqVUk9Ns833cg19KM2OZSVNTsYe73jYj65x1Lw+Z495xrBP
	lmS4UqwnDIPPGMeRSX/ay9KKquRVd1NxIjia++a1/wmgYNRjrBGdod732tA8Wzq3nLrzgTH+q3T
	nUED1rKIH4N78myoK0grAiuhKnT+iqx653dGXbOPXC7Gc3jZ3Bx9aR9CRvkbGPmsQi0=
X-Received: by 2002:a05:6102:54a8:b0:5ff:2cea:c173 with SMTP id
 ada2fe7eead31-5ff2cead351mr567040137.23.1772122211894; Thu, 26 Feb 2026
 08:10:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+DkFDaW_wJ5p9_P7pMpz-8iE6xeKkdF-MQcd2m2GcyVUE3S4Q@mail.gmail.com>
 <5bbafc78-9dbb-448f-a86e-c5e94618f2f8@lunn.ch> <20260226123647.kvv7zbu5ijkbn6jb@skbuf>
In-Reply-To: <20260226123647.kvv7zbu5ijkbn6jb@skbuf>
From: Patryk <pbiel7@gmail.com>
Date: Thu, 26 Feb 2026 17:09:59 +0100
X-Gm-Features: AaiRm53ktauUgmdhmBo00yFpBVQLxDGlckCb9nK5-7NQjBdgQT7CvGi0_93Nht4
Message-ID: <CA+DkFDZfJ4kD0=6O6XB5=azeFukiGxou4T0mM30qVktQCB8-1w@mail.gmail.com>
Subject: Re: 10G-QXGMII phy no autonegotiation on LS1028A
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	Ioana Ciornei <ioana.ciornei@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261473-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbiel7@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 328641AC965
X-Rspamd-Action: no action

Hi,

czw., 26 lut 2026 o 13:36 Vladimir Oltean <vladimir.oltean@nxp.com> napisa=
=C5=82(a):
> The problem that Patryk has identified is correct. Both PCS and PHY
> in-band auto-negotiation used to rely on U-Boot pre-configuration to be
> in sync.
>
> To bring some context, the U-Boot driver for the Felix switch does
> enable in-band auto-negotiation here:
> https://github.com/u-boot/u-boot/blob/master/drivers/net/mscc_eswitch/fel=
ix_switch.c#L200-L201
> so the reason why Patryk is seeing this issue is probably because he is
> not using that driver.

Indeed, I don't use this driver in u-boot.

> Not depending on U-Boot pre-configuration is obviously a great goal, but
> the infrastructure just hasn't existed until very recently. Again, it's
> a combination of PHY and PCS settings, not exclusively a PHY or a PCS iss=
ue.
> This is not the only place where an implicit dependency upon U-Boot has
> existed.
>
> What we are looking at here are the loose ends for 10G-QXGMII, where the
> Linux driver was just assuming that U-Boot would pre-initialize in-band
> autoneg, and just validate that the device tree has
> managed =3D "in-band-status". This is obviously insufficient for the new
> world where we have API in place to ensure PHY and PCS settings are in
> sync.
>
> The good news, so to speak, is that I am not expecting regressions if we
> were to configure 10G-QXGMII in-band autoneg in phylink_pcs_config()
> according to the passed neg_mode, and remove the "%s only supports in-ban=
d AN for now\n"
> limitation.

Thanks for the detailed explanation, that makes sense now.

> Patryk, which PHY are you working with? Are you able to also patch its
> phylib driver so as to report both LINK_INBAND_DISABLE | LINK_INBAND_ENAB=
LE
> in its inband_caps() method? It would be great if the mode without
> managed =3D "in-band-status" would also work. My notes on this topic whil=
e
> I was working with the AQR412C didn't show a clear procedure on how to
> disabled 10G-QXGMII in-band auto-negotiation.

As for the phy... I'm aware that this isn't ideal for community
visibility, but the PHY I'm working with has not been upstreamed yet
and is currently under a strict NDA. Unfortunately, I cannot disclose
the specific model at this stage. This is a constraint I'm bound by,
as I'm working with vendor-supplied sources. I can however patch the
vendor supplied sources adding modification you suggested so I guess
the phy will be working as expected.

> How do you wish we proceed? Is the above context enough for you to
> submit patches, or do you need assistance?

Of course I=E2=80=99ll gladly prepare patches. Just to summarize what needs=
 to be done:
- in lynx_pcs_config_usxgmii the constraint about in-band only
supported mode should be removed
- if neg_mode =3D PHYLINK_PCS_NEG_INBAND_ENABLED then the vendor
specific registers to enable and restart autoneg (similarly like in
u-boot) should be configured
- additionally it should also work without in-band-status defined in
the device tree

Is this what you're suggesting? I'll proceed with this unless you have
any objections.

Best regards
Patry

