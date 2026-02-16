Return-Path: <netdev+bounces-258832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO8eNoKlkmnSwAEAu9opvQ
	(envelope-from <netdev+bounces-258832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 06:05:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48387140EC4
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 06:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 492B4300C5B0
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 05:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2A5298CB2;
	Mon, 16 Feb 2026 05:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=poleshift.se header.i=@poleshift.se header.b="c1u2LF8T";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="EZLmlQhW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=poleshift.se header.i=@poleshift.se header.b="R6n7AY0x"
X-Original-To: netdev@vger.kernel.org
Received: from e240-2.smtp-out.eu-north-1.amazonses.com (e240-2.smtp-out.eu-north-1.amazonses.com [23.251.240.2])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560742765FF;
	Mon, 16 Feb 2026 05:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771218300; cv=none; b=MaV/OEgC/s8m/fCHHZWWbCTSJvRNRyvtHEZ5sfJjrsYfY4108tqHSyreUZoBYYI03TTrPvyQyrZugtqQebAxdXTEFX1+jBUoFnVbemrNHPawGdxovt9RCxUCg2DRimFGS4uMDuHc2D0jUrkeIBa0Cp/eJEYOdENkCdv218j8Uso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771218300; c=relaxed/simple;
	bh=vykWrZ6pC3R6DCA8YVVhJCmQ9aqRf8RTLTtVVUlRK6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBmUVzqQ/gyClB/CgYiX0uUMiqvk/cx/+JdMHcGBwRP1sLleZxF4+RNlp+2CeMjuMIrv9dsuVREi9vqW864c/8IdPdmdodYfcQG2MdeSn4lNf0Z6XK3XCb3SIG9NMXO/c0yW5Pa0rmMT3/ynNXO05iy9FCpJ0X2nnc+JU6Y11ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=poleshift.se; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=poleshift.se header.i=@poleshift.se header.b=c1u2LF8T; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=EZLmlQhW; dkim=fail (0-bit key) header.d=poleshift.se header.i=@poleshift.se header.b=R6n7AY0x reason="key not found in DNS"; arc=none smtp.client-ip=23.251.240.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=poleshift.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=n6aiayff3zq3manwyovyvpolm4pou2ef; d=poleshift.se; t=1771218295;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vykWrZ6pC3R6DCA8YVVhJCmQ9aqRf8RTLTtVVUlRK6Q=;
	b=c1u2LF8To4sddjhXKrn3ZdIkcxqDtU/pJGz104kHU1RfBUm0gs2yV2oco1VhS2c4
	7LKo37uDuPfLVDb0Q//UId8Gql1HUuP+APuUPxQ8in3g2WSM6weoabz/FtkcVEsmcQ7
	nI7P+8Twow3qulTsZ7zdNoKoqN/dWqzuzvL3OVh+nN0SE8YcUmHXJLDI3kNT1FpAGvc
	WP6MBfhrTEfHNFeX80mas17Ou7TB+dWom2lHUuQSN8UT/rsBkJ8BSj2aT+oF3mKKWcC
	dvUkSeb1KbB8sCPq9flzUXwAnY0VkLnMy8oc6nM+64LHHnPnBsnu+qenilI4H+rSVgF
	Dc88bkOMOw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=icdr7g7fbtu2nwxgaimytihkt42k3kiy; d=amazonses.com; t=1771218295;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=vykWrZ6pC3R6DCA8YVVhJCmQ9aqRf8RTLTtVVUlRK6Q=;
	b=EZLmlQhWNbq+1sOdSJClNi0iepT20UruxIpq9w+tOdpfvrRVJrO68pWgF17Zrlvx
	abH0/urclU8cLmR7PNoQlSv9kjMvw6Ka88s590gKbDC2FEb+R9/ar7tJyKb5PN6LGJD
	YHNJ6cVq5EzGzd8c8R7vSGZasx1KJb3AAuDMjAPQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poleshift.se;
	s=20230429; t=1771218292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8I+MDTFKthMwICJO5pCCKZlR1NlGLo4krg+z6zbaYIs=;
	b=R6n7AY0x1JW5Lo6m2FQzm4QqXj2pc4IWcFAxrInZui2dU1bhd34aFZZKstifUF7HcJrTxq
	GGkTBbAhhPHXYypFme2s4yf/aoHoP25i98I1I6/anb0N0Ai9NguUvMsWlyVYR5bDoQIWnl
	U63p2p44E0ubL/wG5gdJpXyJNxlZuc0=
Message-ID: <0110019c64d659d2-815ad63f-3a90-4967-ac0e-850ec981ec27-000000@eu-north-1.amazonses.com>
Date: Mon, 16 Feb 2026 05:04:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] net: usb: lan78xx: scan all MDIO addresses on LAN7801
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>, 
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0110019c5c13b668-dd1f5db3-309a-442a-b483-262c4edbb360-000000@eu-north-1.amazonses.com>
 <d5e4a2e9-4ecd-4103-9537-74fbb58692ed@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Martin_P=C3=A5lsson?= <martin@poleshift.se>
Organization: Poleshift AB
In-Reply-To: <d5e4a2e9-4ecd-4103-9537-74fbb58692ed@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-north-1.nVsitYrO9p3qnPLcZXP017jV0c/PN62ZbS4lYSSQpnA=:AmazonSES
X-SES-Outgoing: 2026.02.16-23.251.240.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[poleshift.se,reject];
	R_DKIM_ALLOW(-0.20)[poleshift.se:s=n6aiayff3zq3manwyovyvpolm4pou2ef,amazonses.com:s=icdr7g7fbtu2nwxgaimytihkt42k3kiy];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-258832-lists,netdev=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[poleshift.se:s=20230429];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin@poleshift.se,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_MIXED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[poleshift.se:+,amazonses.com:+,poleshift.se:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazonses.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eu-north-1.amazonses.com:mid]
X-Rspamd-Queue-Id: 48387140EC4
X-Rspamd-Action: no action

Hi Andrew.

Thank you for reviewing.

As for the PHY interface mode: the RGMII configuration (including TX/RX 
clock internal delays) is set via the configuration EEPROM on the 
device, so PHY_INTERFACE_MODE_RGMII_ID as set by lan78xx_get_phy() is 
correct for this hardware. The DP83TC814 supports RGMII and the link 
works well as-is, so no change is needed there.

I will resend with the Fixes: tag added.


Best regards

Martin


On 2/16/26 3:54 AM, Andrew Lunn wrote:
> On Sat, Feb 14, 2026 at 12:15:21PM +0000, Martin Pålsson wrote:
>> The LAN7801 is designed exclusively for external PHYs (unlike the
>> LAN7800/LAN7850 which have internal PHYs), but lan78xx_mdio_init()
>> restricts PHY scanning to MDIO addresses 0-7 by setting phy_mask to
>> ~(0xFF). This prevents discovery of external PHYs wired to addresses
>> outside that range.
>>
>> One such case is the DP83TC814 100BASE-T1 PHY, which is typically
>> configured at MDIO address 10 via PHYAD bootstrap pins and goes
>> undetected with the current mask.
>>
>> Set phy_mask to 0 for the LAN7801 so that all 32 MDIO addresses are
>> scanned during bus registration, allowing any external PHY to be
>> discovered regardless of its address.
>>
>> Signed-off-by: Martin Pålsson <martin@poleshift.se>
> Since you are submitting this for net, it should have a Fixes: tag.
>
> Also, since this is a 100Base PHY, i assume dev->interface needs to be
> PHY_INTERFACE_MODE_MII? But it looks like lan78xx_get_phy() is hard
> coding it to PHY_INTERFACE_MODE_RGMII_ID for the 7801. How is this
> working out for you?
>
> 	Andrew

-- 
Best regards / Bästa hälsningar / Mit freundlichen Grüßen

Martin Pålsson
Poleshift AB - Local Automotive Ethernet Solutions
+46 706 26 49 90
martin@poleshift.se


