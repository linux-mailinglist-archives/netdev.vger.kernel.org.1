Return-Path: <netdev+bounces-306951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tDffAf6kU2oPcwMAu9opvQ
	(envelope-from <netdev+bounces-306951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:30:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03E744FE5
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:30:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pigmoral.tech header.s=zmail header.b="lW/5oxaO";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306951-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306951-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D33F2300D621
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841D62580F2;
	Sun, 12 Jul 2026 14:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0CF23A562;
	Sun, 12 Jul 2026 14:30:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783866616; cv=pass; b=dYZPi4ABu4sBV/tjLXWapJjiqre/KNdQUk1g7QPOBvbiqkvvgddBjakYrJLAiX40eHTYwRrqFekN+b1/vuR94LFXSU2tvQq9kpDRMduAF/XCs6ZgCQejHwO3HIrnDaIlHCFaDkab9E0tFbW0Lnbnv3eaCaVmZ5tv5+KP8Y+oiYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783866616; c=relaxed/simple;
	bh=kW0o9UPJNg9AiaH8DSDghz5FDDxObOe1q9wX485ILPE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Rueej/iBMB/hou+4MYJtgwY2tY3dNMee/GYPtAWdlMVHmOXpQ27q/vfgj0vmyzo8QXIpN1SjWklulkk6c7Amcl1hKCtBAmNqypu6BHGFMExLKaledZC5Ucj6Z5xrd+cSOSISVqMM593hQNyYjKiLl6RnkkeUzDGg7qYp+oQj+ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=lW/5oxaO; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal: i=1; a=rsa-sha256; t=1783866572; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CbSThQwVFKuvcUyMJAZMQMjEGfBe+S0u3AYavMf4uAL9cH8dhDMtYxTmTxcHMlX2Zpq846FJ1vHxLqz5czyzGw7u1B+xwqxZZppc8ZGqvOVWt+up/kboYR+82ZLmF4vPKlYsubWm7g82iNhicIQEfeQX67Srl7Wyh3rX+3OtoRQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783866572; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kW0o9UPJNg9AiaH8DSDghz5FDDxObOe1q9wX485ILPE=; 
	b=b8lO66kWioDHgWFO9xDePdqvN4v+z/TTkf+KW6oLnVL3/7etC+D8wubfhR1qWqEADAPUAKJnnupOsQ+giMD8zR2BavWin+vb8if2doUVwYpgTQK7W6VktHlaG5hWx4ECUuHuM2zCjebWQpJOhnCkS57rM3FO/6ksD9FQLVLQgYg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783866572;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:From:From:To:To:Cc:Cc:Subject:Subject:References:In-Reply-To:Reply-To;
	bh=kW0o9UPJNg9AiaH8DSDghz5FDDxObOe1q9wX485ILPE=;
	b=lW/5oxaO/c02GuF4ZI5GwC/QM/JtLE8JZtR1q+1ScpoHN22vN/zPs8UsKpyF7oq9
	HycEte8i9DKiSCV4Kc1Q6gwkXBWuEiqPMXS7D3Te3oS8KLrJ+YzjFyC0aVGOxsZ0BoP
	33xO5kdx++JJ6JUekSpkIePLuwYTO5enKOGfbOGA=
Received: by mx.zohomail.com with SMTPS id 1783866570656662.824676365365;
	Sun, 12 Jul 2026 07:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 22:29:16 +0800
Message-Id: <DJWNX2QDTLFF.17I9ING28DUWM@pigmoral.tech>
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Junhui Liu" <junhui.liu@pigmoral.tech>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Brian
 Masney" <bmasney@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Chen-Yu Tsai" <wens@kernel.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Richard Cochran"
 <richardcochran@gmail.com>
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <netdev@vger.kernel.org>, "Jerome Brunet" <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 7/8] clk: sunxi-ng: a733: Add bus clock gates
X-Mailer: aerc 0.21.0
References: <20260711-a733-clk-v2-0-974d188cbe0c@pigmoral.tech>
 <20260711-a733-clk-v2-7-974d188cbe0c@pigmoral.tech>
In-Reply-To: <20260711-a733-clk-v2-7-974d188cbe0c@pigmoral.tech>
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[pigmoral.tech:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:junhui.liu@pigmoral.tech,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:netdev@vger.kernel.org,m:jbrunet@baylibre.com,m:krzk@kernel.org,m:conor@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[pigmoral.tech];
	FORGED_SENDER(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[pigmoral.tech,baylibre.com,kernel.org,redhat.com,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[pigmoral.tech:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306951-lists,netdev=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF03E744FE5

On Sat Jul 11, 2026 at 4:10 PM CST, Junhui Liu wrote:

[...]

> +
> +static SUNXI_CCU_GATE_HWS(mbus_iommu1_sys_clk, "mbus-iommu1-sys", mbus_h=
ws, 0x5b4, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(apb_iommu1_sys_clk, "apb_iommu1-sys", apb0_hws=
, 0x5b4, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_iommu1_sys_clk, "ahb_iommu1-sys", ahb_hws,=
 0x5b4, BIT(2), 0);

The clock names here should be "apb-iommu1-sys" and "ahb-iommu1-sys". I
will update them in next version.

--=20
Best regards,
Junhui Liu

