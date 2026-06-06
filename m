Return-Path: <netdev+bounces-296159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YXtRB0CLJGqa8gEAu9opvQ
	(envelope-from <netdev+bounces-296159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 23:04:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 986EF64E5FE
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 23:03:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gyC2BOm7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296159-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296159-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E287301B93D
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD203C1411;
	Sat,  6 Jun 2026 21:03:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA831716D
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 21:03:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780779830; cv=none; b=jN2GDnk5hGM5q4HVQbQ1Xv2HwEIsN3xT4/yAEkdQ8vxQpz3IeJ9R0gMRSVhr8uEL6d4hHtpgFzY3CyCofpPscjmm4Sxp4rmd4sldDzfnFphOr3xN5lxkyUiO6KRqoOaj3t2s0wSPCwCu8B/4LanIbONrHBcMsJCoOepRxfnOHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780779830; c=relaxed/simple;
	bh=8aQsvQV92fCNEJtI42BLGSyXug3KVyb8/WsuBLmztq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMeIGxLGgTI1+o5pWNOygPZkJfsLglfqZO7CMf7ofsnLv2eFkMbW6F829aLpi7KYfUTiBHxPH+uH8Z7MH0qW5Ok/Qs0ntD53e1+dG3ZsR0dGp2Jn1z8wfUuAPjtIBgT735hra4/PD0wo5JOmOaWf0V2A/sliLejb+2Cb8rJUIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyC2BOm7; arc=none smtp.client-ip=74.125.82.178
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso5301317eec.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780779828; x=1781384628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpsbdQ4HEXAu1DofK9GVpNtvbeL5V7mTYGQq3LB/EZo=;
        b=gyC2BOm7S5VP72mgnsTuhnN9AFqyGpSdrXsm683Sebk4NIWJ7aOvSj1RrBs8RPIALg
         ZlNdaZ6jaPPQp6+QNBHKWny3CXkarbqoUaGSz5nZFfgV0ETia4Zz6BiXd1JOg4UmlgeH
         IuJxGxAfRFywUbRFS1iclf3mrzxm5/YMbwIWZh/Zvc2KUwvcPfGzQ1jPQS3SxbG4rzpd
         I1JOn7YF+iLVtAt46bifoeGncS+O5KRdu/D51wKDROjvP6s93+ODmZRsr7ztmDXC/aAq
         6gEML85fg84YhetACuEBdxXki7T3+TQ9/FzXnXlw0NSKYOaRFV/LYo5zSa/cyeDPxFUS
         HWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780779828; x=1781384628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpsbdQ4HEXAu1DofK9GVpNtvbeL5V7mTYGQq3LB/EZo=;
        b=bkG+/UpiFs4Ag25DAg3qaje6wmpY+iFoh4CdNTajRu90ILNoONzVEagqdPhuEJfKDk
         gZNy211R9WFOaqNWtfOyK9I4iOw6cHxgNdYTL6dFp4u1wN+VjLQclD0MOSCewsAlMRHK
         TEwS1kM1q10RbgfGPhzdWXbeXTy4VR2XsoZRIAc8FW1rlPdh6QDaruxlVqynt5CtUKnn
         89eztIIm1o/dtv/ea7V4u+Fi+Q6FWjutPSOII6753qinPO7mTotmLKyclm13aLTEnkUl
         fjxiCmw1qRem+n47Ihz1uSmdNs65PExY0iF9a7YmhXvzLHau8DgdPWIHp114YSL+ued/
         L0eA==
X-Forwarded-Encrypted: i=1; AFNElJ/odGbsfYVUPoPcd3EY7N8ixRjxNDEYZzTjRPDX7nqp7of6Bl/jhH0dl4nnp6W9BoMIi7iWLTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtpijDuM+b64JkVBnDKrEKpxNWufkQ4dK8PRMMERUgFq3VPBHf
	F+IfKLIHKNOzCO1uX5Eg7cPBQUvO7osvFqOPP8m5CxzVGfguKtpO5Clr
X-Gm-Gg: Acq92OGNt1TPIyHA/BJVQi6Ez5cuoe+38MWkNnxd5B0mwjJs4zy+4qFo16BXFJY9ibU
	YlTqgZclrF/fNUAa6hQmt6nZHTFwGMEv8P3XfQrmJD9mnowos1KZ9f4ZVCD6M9/b6l7IMQDASul
	5YpqZGOVKe44ardm3lZ2KUzD+DAKOfZXjicX1bgfgkoJHBVZfvNHsNSFa8CCMZyNav3Kfi2B8L4
	wQuDio3wTB8fLXVs7Qvh/yoiS+47PWLrCeP5mHfEX8NJ4sl/4qXhK/DD1p65jW6VRXH1DGJk5YY
	s/x3r5yDhe5XhGOzzf3kVUDM3vgpDY+FvJHLTemi5hDWNCihWBnqoNS1248+rBwsESLFyIS+lt5
	bqR/XSUENrQW8BHIYbTEu6NeQpVXADk+rFG8zqCfa4ScB6WvvtJjCsWILV//qwFgTq/QLodcCqG
	/532Rxm/XMGTuTFdBcWj9TY7An11jwY2IRs0ODonWZ6zrBdTPeQczq+f237B19BUddGb6fgwUAx
	sfXfCcEuxiY4g==
X-Received: by 2002:a05:7301:5f0f:b0:2e6:e504:5431 with SMTP id 5a478bee46e88-3077b1de34bmr4945899eec.22.1780779827609;
        Sat, 06 Jun 2026 14:03:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bb2f:1c0b:386d:8909])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea9226sm11772015eec.19.2026.06.06.14.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:03:46 -0700 (PDT)
Date: Sat, 6 Jun 2026 14:03:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Akash Sukhavasi <akash.sukhavasi@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew@lunn.ch>, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>, linux-media@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Vladimir Oltean <olteanv@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 4/4] dt-bindings: input: remove obsolete
 matrix-keymap.txt
Message-ID: <aiSK6_n4ZnB_KRd8@google.com>
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
 <20260603-b4-remove-redirect-stubs-v2-4-c8c19876ab64@gmail.com>
 <178052559618.2296868.8781332297681333925.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178052559618.2296868.8781332297681333925.robh@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:lee@kernel.org,m:akash.sukhavasi@gmail.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:andrew@lunn.ch,m:linux-tegra@vger.kernel.org,m:linux-input@vger.kernel.org,m:mchehab@kernel.org,m:hkallweit1@gmail.com,m:thierry.reding@kernel.org,m:linux-media@vger.kernel.org,m:krzk+dt@kernel.org,m:kuba@kernel.org,m:olteanv@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edumazet@google.com,m:jonathanh@nvidia.com,m:horms@kernel.org,m:devicetree@vger.kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:skhan@linuxfoundation.org,m:linux@armlinux.org.uk,m:corbet@lwn.net,m:akashsukhavasi@gmail.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,lunn.ch,vger.kernel.org,google.com,nvidia.com,redhat.com,linuxfoundation.org,armlinux.org.uk,lwn.net];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 986EF64E5FE

On Wed, Jun 03, 2026 at 05:26:38PM -0500, Rob Herring (Arm) wrote:
> 
> On Wed, 03 Jun 2026 15:42:21 -0500, Akash Sukhavasi wrote:
> > matrix-keymap.txt has been a single-line redirect to
> > matrix-keymap.yaml since commit 639d6eda3b80 ("dt-bindings: input:
> > Convert matrix-keymap to json-schema"), which introduced the .yaml
> > schema and reduced the .txt to a stub in the same change. The .yaml
> > has the same filename in the same directory, making this redirect
> > unnecessary for discoverability.
> > 
> > Eight instances across six files still reference matrix-keymap.txt,
> > forcing readers through an extra hop to reach the .yaml. The stub has
> > not been touched since June 2020. Update all references across input
> > and mfd binding documentation to point directly to matrix-keymap.yaml
> > and remove the stub.
> > 
> > Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> > ---
> > v2:
> > - Patch 4/4: corrected commit message (eight references in six files,
> >   not eight files), Sashiko review.
> >   https://sashiko.dev/#/patchset/20260529052246.4934-1-akash.sukhavasi@gmail.com?part=4
> > 
> > v1: https://lore.kernel.org/all/20260529052246.4934-5-akash.sukhavasi@gmail.com/
> > ---
> >  Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt    | 2 +-
> >  Documentation/devicetree/bindings/input/clps711x-keypad.txt    | 2 +-
> >  Documentation/devicetree/bindings/input/matrix-keymap.txt      | 1 -
> >  Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt | 2 +-
> >  Documentation/devicetree/bindings/input/pxa27x-keypad.txt      | 2 +-
> >  Documentation/devicetree/bindings/input/st-keyscan.txt         | 2 +-
> >  Documentation/devicetree/bindings/mfd/tc3589x.txt              | 6 +++---
> >  7 files changed, 8 insertions(+), 9 deletions(-)
> > 
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 

Lee, could you please ack for MFD piece and I can take it through input?

Thanks.

-- 
Dmitry

