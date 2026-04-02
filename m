Return-Path: <netdev+bounces-274516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB6sIcdfzmnvnAYAu9opvQ
	(envelope-from <netdev+bounces-274516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:23:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EAD388FF9
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB15A303352B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804AA3CD8AB;
	Thu,  2 Apr 2026 12:22:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F3221FBD
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775132577; cv=none; b=HFOBgGbQd/aqFW2m8RCXnqH81u6vdyea87RcwkqrxBNDtQy0DX50ot/SQexMWdlaVsKcSBtu0vrZssX01eK5a8F5gv7ICH8514ZObebe2WL469LRRL22EfIj51QY+7puaVJ8uatlzlqxg+JvH071jEDriOg8HVu5Y/StivYRHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775132577; c=relaxed/simple;
	bh=5Pc0OenZ3fZcs93Pg80x5PzRg92S/L7v3o65TCyhgfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SCqFxS/0zoQP0e/HKp1T+yUugZQdBfJ/5O9uMp4qO1PKMGahgSNReU0s4wZr9Bu1Wvp3WgPNFZlUypqaBwuzbxyVnF59CK6V8hzdnur4DJHLTv6K7C4iuEMz4F65hTLWWTdFLxch0v2otxkRxV9HKnas7CFOuWFI05wDw2RNjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w8H4B-0002P0-Bs; Thu, 02 Apr 2026 14:22:31 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w8H49-003N51-1P;
	Thu, 02 Apr 2026 14:22:29 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w8H49-000000009AC-1Nzj;
	Thu, 02 Apr 2026 14:22:29 +0200
Message-ID: <2d3ef7359f63fb364cb7bc13b721132894428874.camel@pengutronix.de>
Subject: Re: [PATCH v1 05/22] dt-bindings: clock: Add StarFive JHB100
 System-0 clock and reset generator
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Michael Turquette	
 <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Stephen Boyd	 <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt	 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti	 <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, Kees Cook	
 <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org, Sia Jee Heng
	 <jeeheng.sia@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>, Ley
 Foon Tan <leyfoon.tan@starfivetech.com>
Date: Thu, 02 Apr 2026 14:22:29 +0200
In-Reply-To: <20260402105523.447523-6-changhuang.liang@starfivetech.com>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
	 <20260402105523.447523-6-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274516-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FREEMAIL_TO(0.00)[starfivetech.com,baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,esmil.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p.zabel@pengutronix.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.663];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid,starfivetech.com:email]
X-Rspamd-Queue-Id: 26EAD388FF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Do, 2026-04-02 at 03:55 -0700, Changhuang Liang wrote:
> Add bindings for the System-0 clocks and reset generator (SYS0CRG) on
> JHB100 SoC.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../clock/starfive,jhb100-sys0crg.yaml        | 63 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jhb100-crg.h   | 56 +++++++++++++++++
>  .../dt-bindings/reset/starfive,jhb100-crg.h   | 30 +++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb1=
00-sys0crg.yaml
>  create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
>  create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h
>
[...]
> diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt=
-bindings/reset/starfive,jhb100-crg.h
> new file mode 100644
> index 000000000000..71affdcdf733
> --- /dev/null
> +++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__
> +#define __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__
> +
> +/* SYS0CRG resets */
> +#define JHB100_SYS0RST_RESOURCE_ARB					0

Where are resets 1 and 2, ...

> +#define JHB100_SYS0RST_SYS0_IOMUX_PRESETN				3
> +#define JHB100_SYS0RST_SYS0H_IOMUX_PRESETN				4
> +#define JHB100_SYS0RST_RST_ADAPTOR_TIMEOUT_RSTN				5

... where are 6-13?

> +
> +#define JHB100_SYS0RST_BMCPCIERP_RSTN_BUS				14
[...]

If there are non-reset bits in these registers, please enumerate reset
controls in a contiguous range for this binding and add a mapping table
in the driver.

regards
Philipp

