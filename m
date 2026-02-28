Return-Path: <netdev+bounces-262225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJFEImRko2myBQUAu9opvQ
	(envelope-from <netdev+bounces-262225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:55:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E373C1C9558
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D01F30B2DDD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406FD2877C3;
	Sat, 28 Feb 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew5g5c8t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B013175A80;
	Sat, 28 Feb 2026 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772313528; cv=none; b=nBJx6CtdOhVkDu60gzAWSLvjeQ46h74j3p1MPKTxVNCZPrqT9y+sEGnDttY1q/jaeMMpa5IofHDeG05f6nmhpNDn2TVIR059gbNDOylkTOMnnFkyfQ3vcUd9HdeeCrjb8l/fa5WgjehdcFHZjp3qRzvxHT7ed6JQeOAnJupPnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772313528; c=relaxed/simple;
	bh=LrGT6mNI+jCfEdEtzYEm5ownAK+ham3iPLxI8Va3x6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EszHQ9RNLioqn2HgX5IUwQzUB5KwB8Jx9ZY37Cq+VfDsIG8YsuMKNtt01xNK0EyZQgmPalgG/XkEYwfGPz/h9VwxSjHUuuxMJVDABUGhC1UB9xiblRzl/8BAoeg+/gmDnb9qb3Af8zVoDU8Nv6pLmGjbP23xmf9RjyVvgDo1Iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew5g5c8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361BFC116D0;
	Sat, 28 Feb 2026 21:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772313527;
	bh=LrGT6mNI+jCfEdEtzYEm5ownAK+ham3iPLxI8Va3x6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ew5g5c8tzhBv5k8g1mFuy03Thy+F5AuRIn5yAWi6HNFtQv56oq1bs9bzo03rTCdns
	 5ztCwasRq6mudOLB9siqGZycUc16wcm5QZ1B1TxiWUg3IgDAyqw8+XehIMUtMeetPq
	 p2aG7roHkxbBwDGcjGL4QbUj86OrIKbMdR/YtvkVtI598ms6Ljd+UU1rRJBTZmF/QY
	 Bvd+8BZgAbsbjiEjS38dOameD66tzEhzeS28OOQzeSvOo2oZ+K+X0tfA+rTWId+g4+
	 IIGgvxEygphcugx6YHcfaUdz4ieS3mOu77DEXncjwKKns4Ra87Va0+phlJS0pZ47sW
	 f5fWCxoljvdEA==
Date: Sat, 28 Feb 2026 13:18:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan
 <dlan@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Richard Cochran
 <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Yao
 Zi <me@ziyao.cc>, Yanteng Si <siyanteng@cqsoftware.com.cn>, Choong Yong
 Liang <yong.liang.choong@linux.intel.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Shangjuan Wei
 <weishangjuan@eswincomputing.com>, Chen-Yu Tsai <wens@kernel.org>, Boon
 Khai Ng <boon.khai.ng@altera.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu
 <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin
 Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: Add glue layer for
 Spacemit K3 SoC
Message-ID: <20260228131845.70421792@kernel.org>
In-Reply-To: <20260227075718.2243818-4-inochiama@gmail.com>
References: <20260227075718.2243818-1-inochiama@gmail.com>
	<20260227075718.2243818-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262225-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,linux.intel.com,bp.renesas.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E373C1C9558
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 15:57:17 +0800 Inochi Amaoto wrote:
> The ethernet controller on Spacemit K3 SoC is Synopsys DesignWare
> MAC (version 5.40a), with the following special points:
> 1. The rate of the tx clock line is auto changed when the mac speed
>    rate is changed, and no need for changing the input tx clock.
> 2. This controller require a extra syscon device to configure the
>    interface type, enable wake up interrupt and delay configuration
>    if needed.

checkpatch says:

ERROR: "foo* bar" should be "foo *bar"
#110: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c:45:
+static int spacemit_dwmac_set_delay(struct spacmit_dwmac* dwmac,

ERROR: "foo* bar" should be "foo *bar"
#148: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c:83:
+static int spacemit_dwmac_fix_delay(struct spacmit_dwmac* dwmac,

WARNING: line length of 99 exceeds 80 columns
#243: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c:178:
+	apmu = syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node, "spacemit,apmu", 2, offset);
-- 
pw-bot: cr

