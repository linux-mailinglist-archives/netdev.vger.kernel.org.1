Return-Path: <netdev+bounces-260877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO1XLAjWnmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:59:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7174419621A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBD053030516
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCA9393DC2;
	Wed, 25 Feb 2026 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="hguYhiFZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110593939D1
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017158; cv=none; b=PoDUgfG1bjcyHpXWQ1KduSIdfExJVxvL3F92uMMBn96i1x6hQUUKXGZcoom/bAobGCXaxezlH5SyRgjgxl8saF4c9v5AjytO7oV7wtxcA2zXjCaspzo1Mi1qVcesNhr7uVmZjbOPxgkzaePhiB9gduP4oywzkGM+t28rXFXfEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017158; c=relaxed/simple;
	bh=Db3xaViep4xadUj5hbJ5gSJqVKu5FIQCIs8XzQEZQ0A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=W5M7REgO9UPZT324s/nvUTCsoLKR9suBGVeMD0DlULMrDoR3HTUYMkg1iVgSs14Ffh+Mb05nYJmI8TKBcCebMgi4TykYMfgrIJ300/BGGlgiZWJxX4esJXXF1fQ2eseL5IhpraLmuoMR1OQyCClLAiDZy2WB6uJ87CVGB81agcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=hguYhiFZ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F34DA0364;
	Wed, 25 Feb 2026 11:56:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772016990; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cs+8QaoJrfxu3M8QiX2ghjZkw5IxXgF958u8DoGV4+w=;
	b=hguYhiFZ9RIn1u09sA0kFaubEHdLjzUTC1t4ac1QsxpTw9AFX4+Ckby7n3nlGY7JbQ236z
	dnJ0EHo37l3/14shv9zbqNkXX50E4hcSmy0RdxA/z+J8Lgyc24hGtB6kGjb6lbvR3tBSNc
	+SXRYQI116yYv+fx5Odzdy90Ihi8/SGW32+WZgK8GKTfE3bcGgq6K+QgPDf4fLguaj3Yhg
	JhC33OJr1Let2GyHPPSq9V6vulYuYINAXYMsrTVfI0sTFCDv/uGR6KQvYGkXwoFzT2ET/4
	egqaTRQe+2x+/qtuTh0v1PCgCwx2Frkn1UYsXzKpixdooHrIU+1EmA03QX7SzA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Feb 2026 11:56:28 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, nicolas.ferre@microchip.com,
 pabeni@redhat.com, linux@armlinux.org.uk, phil@raspberrypi.com
Subject: Re: [PATCH net-next v3 0/5] net: cadence: macb: add IEEE 802.3az EEE
 support
In-Reply-To: <20260225091558.51157-1-nb@tipi-net.de>
References: <20260225091558.51157-1-nb@tipi-net.de>
Message-ID: <6c78119ff230910805372d155ef57fe9@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TAGGED_FROM(0.00)[bounces-260877-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7174419621A
X-Rspamd-Action: no action

On 25.2.2026 10:15, Nicolai Buchwitz wrote:
> Add Energy Efficient Ethernet (IEEE 802.3az) support to the Cadence GEM
> (macb) driver using phylink's managed EEE framework. The GEM MAC has
> hardware LPI registers but no built-in idle timer, so the driver
> implements software-managed TX LPI using a delayed_work timer while
> delegating EEE negotiation and ethtool state to phylink.
> 
> Changes from v2:
>   - macb_tx_lpi_set() now returns bool indicating whether the register
>     value actually changed, avoiding redundant writes.
>   - Removed tx_lpi_enabled field from struct macb; LPI state is tracked
>     entirely within the spinlock-protected register read/modify/write.
>   - macb_tx_lpi_wake() uses the return value of macb_tx_lpi_set() to
>     skip the cancel/udelay when TXLPIEN was already clear.
>   All changes based on feedback from Russell King.
> 

Apologies for the missing subject prefix and version tags on this
series - should have been [PATCH net-next v3]. I'm still fairly new
to the kernel mailing list workflow and building up the muscle memory
around git-format-patch/send-email. I'll resend as v4 with the proper
tags. In the meantime, feedback on the code itself is very welcome.

> Changes from v1:
>   - Rewrote to use phylink managed EEE (mac_enable_tx_lpi /
>     mac_disable_tx_lpi callbacks) instead of the obsolete
>     phy_init_eee() approach, as recommended by Russell King.
>   - ethtool get_eee/set_eee are now pure phylink passthroughs.
>   - Removed all manual EEE state tracking from mac_link_up/down;
>     phylink handles the lifecycle.
> 
> The series is structured as follows:
> 
>   1. Register definitions: LPI counter offsets (0x270-0x27c), TXLPIEN
>      bitfield (NCR bit 19), and MACB_CAPS_EEE capability flag.
> 
>   2. LPI statistics: Expose the four hardware EEE counters (RX/TX LPI
>      transitions and time) through ethtool -S, accumulated in software
>      since they are clear-on-read.
> 
>   3. TX LPI engine: phylink mac_enable_tx_lpi / mac_disable_tx_lpi
>      callbacks with a delayed_work-based idle timer. LPI entry is
>      deferred 1 second after link-up per IEEE 802.3az. Wake before
>      transmit with a conservative 50us PHY wake delay.
> 
>   4. ethtool EEE ops: get_eee/set_eee delegating to phylink for PHY
>      negotiation and timer management.
> 
>   5. RP1 enablement: Set MACB_CAPS_EEE for the Raspberry Pi 5's RP1
>      southbridge (Cadence GEM_GXL rev 0x00070109 + BCM54213PE PHY).
> 
> Tested on Raspberry Pi 5 (1000BASE-T, BCM54213PE PHY, 250ms LPI timer):
> 
>   iperf3 throughput (no regression):
>     TCP TX: 937.8 Mbit/s (EEE on) vs 937.0 Mbit/s (EEE off)
>     TCP RX: 936.5 Mbit/s both
> 
>   Latency (ping RTT, small expected increase from LPI wake):
>     1s interval:  0.273 ms (EEE on) vs 0.181 ms (EEE off)
>     10ms interval: 0.206 ms (EEE on) vs 0.168 ms (EEE off)
>     flood ping:   0.200 ms (EEE on) vs 0.156 ms (EEE off)
> 
>   LPI counters (ethtool -S, 1s-interval ping, EEE on):
>     tx_lpi_transitions: 112
>     tx_lpi_time: 15574651
> 
>   Zero packet loss across all tests. Also verified with
>   ethtool --show-eee / --set-eee and cable unplug/replug cycling.
> 
> Nicolai Buchwitz (5):
>   net: cadence: macb: add EEE register definitions and capability flag
>   net: cadence: macb: add EEE LPI statistics counters
>   net: cadence: macb: implement EEE TX LPI support
>   net: cadence: macb: add ethtool EEE support
>   net: cadence: macb: enable EEE for Raspberry Pi RP1
> 
>  drivers/net/ethernet/cadence/macb.h      |  20 ++++
>  drivers/net/ethernet/cadence/macb_main.c | 136 ++++++++++++++++++++++-
>  2 files changed, 155 insertions(+), 1 deletion(-)

Nicolai

