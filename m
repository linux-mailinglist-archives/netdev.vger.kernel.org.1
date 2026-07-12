Return-Path: <netdev+bounces-306954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mA74OKqnU2rLcwMAu9opvQ
	(envelope-from <netdev+bounces-306954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:41:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E914C74503F
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:41:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pigmoral.tech header.s=zmail header.b=pzyy9pAT;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306954-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306954-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAE8B3013D75
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B7A261B8A;
	Sun, 12 Jul 2026 14:41:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E392236F0;
	Sun, 12 Jul 2026 14:41:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783867304; cv=pass; b=hnRRLpmmvZ0+dVmCoYzE0NoNTeGY4EBHhxEE1YGFx7doW25/tJ1p1PXZJcCPXKrAFYCpg7pmQOajTw9eXP1UQtY7C2RmFzXpX3Myn/bW452TFwNuMZKKZuHcxGex2lB4ak46wlDFRoE60AHvYQbNHV7yRHBgs4h5EiptSPPZ1nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783867304; c=relaxed/simple;
	bh=2QI14BvAQb8oCfoBa/frHwYgMG9GD4XppKxhMN+gQWM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ajIQPeNqUdJObraciQUBxFUVutNk5kBRJkKqy1/jLHgFsOClfuf08YwZ1XpRm8rtG+9Fuo/0v9c8xqkgL7Zk9nW5XyY3M9ggdsvfNFfRlptBVYFXtwHc0zSweZfDjwnvgby/bZ0Iko2klptzez80o4jJhXcbA1hbHqaCes19l+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=pzyy9pAT; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal: i=1; a=rsa-sha256; t=1783867266; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ua0hV+q9YwWdierF0d3tTHArRa58XYI355ifeJIbWW4LZtaawtl20H96TbVmRQjqbSO56vOFPYpJkcOKAnwZLk41DUgWI6NBLxOKHS150cqIcbguHE/i2Dzfl7xsESTR2Xl8qHs1jZdr2oxv9KJGh3bWnllNWCTo8cThhDSAgrA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783867266; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SLS/kMhYXvqtbxCJZsqYcevLj6Cy5NnjgCrCPkzJMk8=; 
	b=aoh2WX9UcchPAoc6jZ2+7rUQ8S2O8lFa6QhYvdJ5DUkNr3W4qYNoX4JyGeP0uu6v9ZLglioPjgdNlVGRuy4VhhpqbgTU2hdFFv6MeypNTb7xTlgIQs5KDxKeFIUdmMH9uRKh6Vn6vNplJt9nOVb8yn+nBh+d0PJyEFPEXDJNDxI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783867266;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:References:In-Reply-To:Reply-To;
	bh=SLS/kMhYXvqtbxCJZsqYcevLj6Cy5NnjgCrCPkzJMk8=;
	b=pzyy9pATPvLJ5OdbAKgQIexqjPkcTp36x4ezLL3ngOF7JnVnEZGnT1j/CZzlbiP2
	WSEhCCeBy8H27PBqBkn7L4Eby5OjedwYGAs9h65RhVrIkJzg5gpa1jjN3r5EtAYLrbt
	6LGBXRYBXx1IwS0pbyTPypDBB5SSeHGDPQNuQAuQ=
Received: by mx.zohomail.com with SMTPS id 1783866353179481.00549749606785;
	Sun, 12 Jul 2026 07:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 22:25:39 +0800
Message-Id: <DJWNUAW00DTS.1L26UVJEYHZ0L@pigmoral.tech>
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <netdev@vger.kernel.org>, "Jerome Brunet" <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 6/8] clk: sunxi-ng: a733: Add mod clocks support
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
X-Mailer: aerc 0.21.0
References: <20260711-a733-clk-v2-0-974d188cbe0c@pigmoral.tech>
 <20260711-a733-clk-v2-6-974d188cbe0c@pigmoral.tech>
In-Reply-To: <20260711-a733-clk-v2-6-974d188cbe0c@pigmoral.tech>
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[pigmoral.tech:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:netdev@vger.kernel.org,m:jbrunet@baylibre.com,m:junhui.liu@pigmoral.tech,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
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
	TAGGED_FROM(0.00)[bounces-306954-lists,netdev=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pigmoral.tech:from_mime,pigmoral.tech:dkim,pigmoral.tech:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E914C74503F

On Sat Jul 11, 2026 at 4:10 PM CST, Junhui Liu wrote:

[...]

> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(timer0_clk, "timer0", timer_paren=
ts, 0x800,

I will update these to SUNXI_CCU_P_DATA_WITH_MUX_GATE in next version.

> +				       0, 0,		/* no M */
> +				       0, 3,		/* P */
> +				       24, 3,		/* mux */
> +				       BIT(31),		/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(timer1_clk, "timer1", timer_paren=
ts, 0x804,
> +				       0, 0,		/* no M */
> +				       0, 3,		/* P */
> +				       24, 3,		/* mux */
> +				       BIT(31),		/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(timer2_clk, "timer2", timer_paren=
ts, 0x808,
> +				       0, 0,		/* no M */
> +				       0, 3,		/* P */
> +				       24, 3,		/* mux */
> +				       BIT(31),		/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(timer3_clk, "timer3", timer_paren=
ts, 0x80c,
> +				       0, 0,		/* no M */
> +				       0, 3,		/* P */
> +				       24, 3,		/* mux */
> +				       BIT(31),		/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(timer4_clk, "timer4", timer_paren=
ts, 0x810,
> +				       0, 0,		/* no M */
> +				       0, 3,		/* P */
> +				       24, 3,		/* mux */
> +				       BIT(31),		/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(timer5_clk, "timer5", timer_paren=
ts, 0x814,
> +				       0, 0,		/* no M */
> +				       0, 3,		/* P */
> +				       24, 3,		/* mux */
> +				       BIT(31),		/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(timer6_clk, "timer6", timer_paren=
ts, 0x818,
> +				       0, 0,		/* no M */
> +				       0, 3,		/* P */
> +				       24, 3,		/* mux */
> +				       BIT(31),		/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(timer7_clk, "timer7", timer_paren=
ts, 0x81c,
> +				       0, 0,		/* no M */
> +				       0, 3,		/* P */
> +				       24, 3,		/* mux */
> +				       BIT(31),		/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(timer8_clk, "timer8", timer_paren=
ts, 0x820,
> +				       0, 0,		/* no M */
> +				       0, 3,		/* P */
> +				       24, 3,		/* mux */
> +				       BIT(31),		/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(timer9_clk, "timer9", timer_paren=
ts, 0x824,
> +				       0, 0,		/* no M */
> +				       0, 3,		/* P */
> +				       24, 3,		/* mux */
> +				       BIT(31),		/* gate */
> +				       0);

[...]

--=20
Best regards,
Junhui Liu


