Return-Path: <netdev+bounces-253434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMykH59Td2mdeAEAu9opvQ
	(envelope-from <netdev+bounces-253434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:44:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D42EA87BCD
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EAB73010D95
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2834331A70;
	Mon, 26 Jan 2026 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y8lwjlEd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D779329C6A
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427868; cv=none; b=pROzCgLp8B8NLrV51ve1KFIeZsKTadAQqtOu55CKfwxxbKrkhcorAFQOe5nnFg1nVpQQ0W9inuIwIl/DmNVCgDXbPuwkOHMp8X+NsJvP+x4Y3rbhxBvupgC90eNTpJuoNYeHsWzoBbM9E9HzlYU3NPNFTrVqMbPPH7sZjyh1638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427868; c=relaxed/simple;
	bh=sOmQHT/KB8XTMWgnQ5jz7GSXRwvF+dxEnN6zZ0y9Q4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OlWZ5l1f4aJAmZOH9DzSmxarWL9PIE6ANw4pukUDrzl9mDlP5cIbKVcOarS9nuewiAKB1GWKCgKCTwRADgEhvnVV1/e45O+rbBVOCxPGV3RpRMXQD4Rmz2IcKvsElGMb3UYEw8C2/k86SPgmwfAh0fnksWqGdfAin0StNZZBlzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Y8lwjlEd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yBZgVQPE5pyIHc9AqGzEXNSbNLwIwnbp7Ek3gt6UiS0=; b=Y8lwjlEdMnBjJgPevGq9soTwBU
	BO0PRHynTRQjso22RDyJLEtu8GL4on7kPvOqYgrb1FcLsxveUyHwIABeCBrvb1K95kQlbHJiWy/Zz
	VNT7U1GToRrpnBcczM+N0v9ZrS5D8zwnfSUARTyfTgWkGv3+Ni0aGuEd7d9k6l4iXyFfREqGv3VEP
	sBPs7f7SxUmM+6ptdeonH/owGEzhrhwpw2fEmXutCg9xUq1SsQGgJHk4N5AGLt0LQlEcwkkd1xvkR
	7TQ/SrdcRybIfBYpRCzVAJdUW9Oa/p6Jc/YAGOkNOo2rkzoDgAEgzwZ0OZzs7u7QR6gqreJp3WJ/a
	E8DvvxHA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35628)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vkL0x-000000004dB-0NVz;
	Mon, 26 Jan 2026 11:44:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vkL0t-000000004vB-2rTY;
	Mon, 26 Jan 2026 11:44:11 +0000
Date: Mon, 26 Jan 2026 11:44:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 00/22] net: stmmac: rk: simplify per-SoC
 configuration
Message-ID: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253434-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D42EA87BCD
X-Rspamd-Action: no action

[Please note: due to google's spam filtering, I can no longer send
patch series to @gmail.com addresses, and thus, to save being spammed
with failed deliveries, I'm dropping such addresses from my patch
series. Stop giving google so much power, use other email services.]

dwmac-rk has an excessive variability between each individual SoCs
which makes this file extremely large.

This series reworks the per-SoC handling, moving the majority of it
out of code and into data in a way that greatly reduces the lines of
code necessary for each SoC, moving the code into the higher level
functions in this file.

In order to do this, we need a version of FIELD_PREP_WM16() that works
with non-constant masks, so we introduce rk_encode_wm16().

We change the definitions to reveal the fact that in all of this
variability, there is a lot of commonality in terms of the values of
the bitfields, even though these bitfields appear to be randomly
placed within registers.

Both of these allow us to progressively move to a situation where
the SoC independent code can, in the mojority of cases, program these
RGMII clocks, RMII clocks and RMII speed without calling any SoC
specific code.

Further cleanup may be possible with the (actually incorrect) handling
of RGMII delays, but this is not addressed in this already large
series.

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 1237 ++++++++++--------------
 1 file changed, 508 insertions(+), 729 deletions(-)

v2: fix AI review comments

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

