Return-Path: <netdev+bounces-254259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB8zI0EPemmS2AEAu9opvQ
	(envelope-from <netdev+bounces-254259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:29:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F3A225D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B9630474F8
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D04352FB1;
	Wed, 28 Jan 2026 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ny2IcdL+"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513C0352FB8
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606892; cv=none; b=u/URtYSw7kEz9mncRItNH1a786fm34/W1CWNzYMkAw9cSDxcw4Txc/o40ZuF0p1uzdvBg1ZNF7BDw9VdhmSYiziO+rMkF9lsT78HHIHv6CU1Vfiv4a3Dt+CTu8W5Z/PaSY6Hz8zaX9N4dNe0q4TyDmB3n1hTPHOu4g+ZL+R02rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606892; c=relaxed/simple;
	bh=GeiS8UkWJiVd9fcioJVCZ0UB8h54nJE80Cpi6fdt9UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIX1IEZLnXmYvanCaFQnNV8kDT45JhmAMK2SEvKZY1tghlieddFJWh+W4hFyMNeaVZw8631Mk85Dp6c1Fg+gWhiQI9vuEWyTCyOurUSqUGkyT3TuCePfut4vB6O+oEWY3SJ6TB8dGWkbG79pGuQO3CIxLs/JSy+SzbKrabJ4B84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ny2IcdL+; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C7596C211E6;
	Wed, 28 Jan 2026 13:28:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3FD826071F;
	Wed, 28 Jan 2026 13:28:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8C84119A880E;
	Wed, 28 Jan 2026 14:27:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769606886; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=B5JCMMNEQztUBwudeMkHWDAcD2USZ9OKX/sG/bOWf9o=;
	b=Ny2IcdL+0uvG2HzvmhoJYWRsybshnbCU63i6zoWkLe7lAy/SxM+3RQH3HuMhzcsKDzthvm
	Ncv2bCC9ZuxwqZmSxakO1IxqCwaqG8nj9SyNQpC8rYdLiUHdnu9hfRub5Vp45wO3YD3F+P
	+Lr5IXCVwi6ca6GQtkt2yTTywD/XoJXrSE4Adf1x/LYAylM0xnu1qKKN+sSk1LK7BT4NCF
	J8N2tya1yRQYXmPCOCX7/zT9Id6idCLqeycnBAIvrq6hCKDBjUMqSKd9WNsBw3xU2W/zn6
	y0EQm4XwXf4KECtIKvBgdUdcbPezhsRrgBgrYlfDGhgvDexOEjQkmSIbQ/zrWA==
Message-ID: <0822e32a-3914-4678-af1b-f811a11ee2c8@bootlin.com>
Date: Wed, 28 Jan 2026 14:27:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: rk: add GMAC_CLK_xx constants,
 simplify RGMII definitions
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>
References: <aXnrzIbZN-gaZTia@shell.armlinux.org.uk>
 <E1vl3G0-00000006v3R-2ZBc@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vl3G0-00000006v3R-2ZBc@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254259-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: C77F3A225D
X-Rspamd-Action: no action

Hi,

On 28/01/2026 11:58, Russell King (Oracle) wrote:
> All the definitions of the RGMII related xxx_GMAC_CLK_xxx definitions
> use the same field values to select the clock rate. Provide common
> definitions for these field values, passing them in to a single macro
> for each variant that generates the appropriate values for the speed
> register.
> 
> No change to produced code on aarch64.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


