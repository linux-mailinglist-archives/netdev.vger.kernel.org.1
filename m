Return-Path: <netdev+bounces-262770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPzEBsDNpWm1GwAAu9opvQ
	(envelope-from <netdev+bounces-262770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:49:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE41DE0C4
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28DFF303F7D5
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4962B3FB053;
	Mon,  2 Mar 2026 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yc+H6Zji"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4730E0EF;
	Mon,  2 Mar 2026 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473686; cv=none; b=eZhablcRyTP7dEuJwcnsc9RNCsw5LcV1GAnckk7FuRvDEp6neOIKJxZx/3l41zogulwWleptAjJ0Sn4/SPx5xc4TIWu1hR/XzfkpbpAHUHk7v9P8JlDgKTQaXQ9T/OvnBDdbwokBgy4q96Hs8PW7/vgwncQV34vwm4xiP7WmZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473686; c=relaxed/simple;
	bh=3l9yLaJVWbADlnZq1bBYerZDIk1jYuf11aA0o3ZYZO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iad53IfxdeaifumlkJXcgIdFOWwfdXrnYyCMu5sEriaJfu69a0DROaLItIVtpLZ4PECes9TYCjr8ezmE/my+s1lRAX3VTZhocU/9Z1negvQQyRYPNZ94a9fQSM2da9lPv0EonYfsJVM+87qEVigQ3pRhsshZiHyoKdOPbHrtA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yc+H6Zji; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l44psQATQO9zmL6QLOShbiPUK8IKCYLpPwQa89pfI/8=; b=yc+H6ZjidpQuKwoJselYBw1eQj
	ylaqMBiAyE71KBJkJqF6MvYpO3hQA2tP383M4LqfOcyaD582Qga6l9oEm7CEHFAPh1eA+QcTs7Ry6
	itiYuOXZj+bC3PgvYWWZy9YrXqdcyUFxchExa/yvvvC1MWFDuxEt4Xk3AUJTO5W8lmAo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vx7Mn-009iUa-7v; Mon, 02 Mar 2026 18:47:37 +0100
Date: Mon, 2 Mar 2026 18:47:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v6 3/5] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <ae88d56a-04c9-4a50-af22-5e439acd59c7@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-3-68319a4c4110@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-rgmii_delay_2600-v6-3-68319a4c4110@aspeedtech.com>
X-Rspamd-Queue-Id: 6FEE41DE0C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262770-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:24:30PM +0800, Jacky Chou wrote:
> On the AST2600 platform, the RGMII delay is controlled via the
> SCU registers. The delay chain configuration differs between MAC0/1
> and MAC2/3, even though all four MACs use a 32-stage delay chain.
> +------+----------+-----------+-------------+-------------+
> |      |Delay Unit|Delay Stage|TX Edge Stage|RX Edge Stage|
> +------+----------+-----------+-------------+-------------+
> |MAC0/1|     45 ps|        32 |           0 |           0 |
> +------+----------+-----------+-------------+-------------+
> |MAC2/3|    250 ps|        32 |           0 |          26 |
> +------+----------+-----------+-------------+-------------+
> For MAC2/3, the "no delay" condition starts from stage 26.
> Setting the RX delay stage to 26 means that no additional RX
> delay is applied.
> Here lists the RX delay setting of MAC2/3 below.
> 26 -> 0   ns, 27 -> 0.25 ns, ... , 31 -> 1.25 ns,
> 0  -> 1.5 ns, 1  -> 1.75 ns, ... , 25 -> 7.75 ns
> 
> Therefore, we calculate the delay stage from the
> rx-internal-delay-ps of MAC2/3 to add 26. If the stage is equel
> to or bigger than 32, the delay stage will be mask 0x1f to get
> the correct setting.

Please return -EINVAL. Asking for more than 7.75ns is clearly broken.

    Andrew

---
pw-bot: cr

