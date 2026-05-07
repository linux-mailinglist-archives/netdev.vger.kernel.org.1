Return-Path: <netdev+bounces-285109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECtYDXPy+2mMJAAAu9opvQ
	(envelope-from <netdev+bounces-285109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:01:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A876C4E2250
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD7BF30086FD
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71BD25F99F;
	Thu,  7 May 2026 02:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue19lhf3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B1213E9C;
	Thu,  7 May 2026 02:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119265; cv=none; b=MRelCPcaMiRmRaZMZa0+jxowffUJHDzHURmsT399N2r68PGXumCu2Mbf7SMzX9YZNS2MwpW+yAmGLCbEjvWJ4c9cGxQEoHZVzI3WzJ12bLZEd3Ot9S6DO05L3TAzdLId2r6W8YP359thckAT2l8et5s8dIVxorN1WO+oeOAYNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119265; c=relaxed/simple;
	bh=a40ZyRGxQXRd6QRk2rzSLaT+x+MGE5hs0j2SUEwlOH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a1LB5SPc3RXLBal/ABQRyNX3m9AD70pKD20mplf51FBBYDNsgH3NhjpelsAzVtLvVVzF7jx6TUkfLedaLvBed3eVdyLMwYc9gY2km/OnRA2WeMSfziKovKyHvGZk3l3ZD185biNjHB3ixh8yjbcyyD9fFLB+GiK3KWVKmbbZba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue19lhf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7CDC2BCB0;
	Thu,  7 May 2026 02:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778119265;
	bh=a40ZyRGxQXRd6QRk2rzSLaT+x+MGE5hs0j2SUEwlOH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ue19lhf3TYarCZyrQHjVx5fYcnhj8cMEih8yZB7EnrUcpSZ7Q4pkKMmaWKwDD3GUa
	 7aG7hXenRg7FXG+uuwihNzvJAtVehaNR3zZiFj0Qtyqy2oFFfrwrhZYofDoqoYAAgr
	 esMzM0XlvkB9SlvXQmw6iNFdt5CueqIImMxQlbjL/D3uSSe8d/p4Up09mMfqO3FYQT
	 +P+xZ9xqRn3IRmlCEABmqyJLSVFVmqjC+msJFa0NIHP9PGgA0H/OSjnXzOIb8LcDhT
	 /i/v/fAlEDIAwbQhhci7FHpy+Il1jEs8l7TnGzUQmtJySga9NFVMrEBdjSEzYtVciI
	 WHKOrGk4jK9LQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC2393089F;
	Thu,  7 May 2026 02:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] r8152: Add support for the RTL8159 10Gbit
 USB Ethernet chip
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811921453.3299821.167480571518572588.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 02:00:14 +0000
References: <20260505-rtl8159_net_next-v4-0-1a648a9c4d8d@birger-koblitz.de>
In-Reply-To: <20260505-rtl8159_net_next-v4-0-1a648a9c4d8d@birger-koblitz.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 hsu.chih.kai@realtek.com, andrew@lunn.ch, olek2@wp.pl
X-Rspamd-Queue-Id: A876C4E2250
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285109-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,realtek.com,wp.pl];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 05 May 2026 17:56:32 +0200 you wrote:
> Add support for the RTL8159, which is a 10GBit USB-Ethernet adapter
> chip in the RTL815x family of chips.
> 
> The RTL8159 re-uses the frame descriptor format and SRAM2 access introduced
> with the RTL8157 as well as most of the setup and PM logic of the RTL8157.
> 
> The module was tested with a Lekuo DR59R11 USB-C 10GbE Ethernet Adapter:
> [ 2502.906947] usb 2-1: new SuperSpeed USB device number 3 using xhci_hcd
> [ 2502.927859] usb 2-1: New USB device found, idVendor=0bda, idProduct=815a, bcdDevice=30.00
> [ 2502.927867] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=7
> [ 2502.927871] usb 2-1: Product: USB 10/100/1G/2.5G/5G/10G LAN
> [ 2502.927873] usb 2-1: Manufacturer: Realtek
> [ 2502.927875] usb 2-1: SerialNumber: 000388C9B3B5XXXX
> [ 2503.063745] r8152-cfgselector 2-1: reset SuperSpeed USB device number 3 using xhci_hcd
> [ 2503.123876] r8152 2-1:1.0: Requesting firmware: rtl_nic/rtl8159-1.fw
> [ 2503.126267] r8152 2-1:1.0: PHY firmware installed 0 to be loaded: 20
> [ 2503.156265] r8152 2-1:1.0: load rtl8159-1 v1 2026/01/01 successfully
> [ 2503.270729] r8152 2-1:1.0 eth0: v1.12.13
> [ 2503.289349] r8152 2-1:1.0 enx88c9b3b5xxxx: renamed from eth0
> [ 2507.777055] r8152 2-1:1.0 enx88c9b3b5xxxx: carrier on
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] r8152: Add support for 10Gbit Link Speeds and EEE
    https://git.kernel.org/netdev/net-next/c/9774acd5fa5d
  - [net-next,v4,2/3] r8152: Add support for the RTL8159 chip
    https://git.kernel.org/netdev/net-next/c/ad2a55b63b41
  - [net-next,v4,3/3] r8152: Add firmware upload capability for RTL8157/RTL8159
    https://git.kernel.org/netdev/net-next/c/a51e171e176c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



