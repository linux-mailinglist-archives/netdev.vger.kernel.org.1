Return-Path: <netdev+bounces-275359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLwLLmP30GmjCwcAu9opvQ
	(envelope-from <netdev+bounces-275359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:34:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E77339AF27
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1FC5300F9D1
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA5314D34;
	Sat,  4 Apr 2026 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmZ68RU3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591152BEC34;
	Sat,  4 Apr 2026 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775302491; cv=none; b=OZDXHoHRJjTzR/THkVBO0x/NvYfAf8yIdkyOq0NhsZ1yCgppB5O+MVt5cKI7VNQciwQPA8VVeeWae1vNh8mKR/L5JquqCHyt+EZtV6ZtOvi/3Ym2cEFrujpdlN6BmVGZaupg7PtxDN0gs8BR4r8QzpzjguoYsACgr/8iKMBghtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775302491; c=relaxed/simple;
	bh=Ow9QhO9wfoF7Vmg/G2JX4vIid+D5TO7M8+RE/T6ptQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjRPGpkfaDHPQDaGMuCjusXCm9bJHWJDYQ+Ln9OcPVkMnEAgnvb2kl3PIXf6/U1ThPBdZOi17e4cu/NmA7zz0UVwhf8nq/q5cq95Cui0VK1t5/p/6CGGim/V8V1FBo+WoIf4KNll7Ukbkj+c54StDVvcwxPoGGVOW+y3M63dEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmZ68RU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4093FC19421;
	Sat,  4 Apr 2026 11:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775302490;
	bh=Ow9QhO9wfoF7Vmg/G2JX4vIid+D5TO7M8+RE/T6ptQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmZ68RU39l6GEIZun8e6WzYdbO86be3EcpU17/EAfhJZv347v/TM+QxiPaMbFpeHc
	 K4bMxLwFJBq8bSrHeAVv63/rAX7/V7gFMMrtBnIlHT8gwOMNuAu5ju0PhDxH1JOkhq
	 BE1T2BXRI+aqfuAxSUg53sxoPCgXYtlSSogEHojPe4us+ppePsvedzZsAqsQaZvOfW
	 vDYeAQo33yt4zz+qbu0bfCvEuKd/pZkQlAEDiD+bgI1QtXRUBqIfESa50DAJcehylR
	 mPuikA8MEO8zbOed65evwcniqk6g07jgYhNr1Gd2xm7T9zyZ/Uj9ST/tkOnjHCvMG6
	 QuZsP5sMcUIqQ==
Date: Sat, 4 Apr 2026 13:34:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Emil Renner Berthing <kernel@esmil.dk>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, netdev@vger.kernel.org, 
	Sia Jee Heng <jeeheng.sia@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>, 
	Ley Foon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v1 17/22] dt-bindings: clock: Add StarFive JHB100
 Peripheral-2 clock and reset generator
Message-ID: <20260404-valiant-auburn-raven-c24be6@quoll>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
 <20260402105523.447523-18-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402105523.447523-18-changhuang.liang@starfivetech.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275359-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com,vger.kernel.org,lists.infradead.org,starfivetech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E77339AF27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 03:55:18AM -0700, Changhuang Liang wrote:
> +  clocks:
> +    items:
> +      - description: Peripheral-2 600MHz
> +      - description: Peripheral-2 400MHz
> +      - description: Peripheral-2 125MHz
> +      - description: Peripheral-2 GMAC2 RGMII RX
> +      - description: Peripheral-2 GMAC2 RMII Reference
> +      - description: Peripheral-2 GMAC3 SGMII TX
> +      - description: Peripheral-2 GMAC3 SGMII RX
> +      - description: Main Oscillator (25 MHz)
> +
> +  clock-names:
> +    items:
> +      - const: per2_600

Does not have any meaningful name in datasheet / clock hierarchy?

> +      - const: per2_400
> +      - const: per2_125
> +      - const: per2_gmac2_rgmii_rx
> +      - const: per2_gmac2_rmii_ref
> +      - const: per2_gmac3_sgmii_tx
> +      - const: per2_gmac3_sgmii_rx

per2 is redundant. Name these according to clock input names.

Same for your patch for per3.

> +      - const: osc
> +
> +

Just one blank line

Best regards,
Krzysztof


