Return-Path: <netdev+bounces-274356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJxsHATmzWl9iwYAu9opvQ
	(envelope-from <netdev+bounces-274356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:44:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC023833B5
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD88306EC92
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 03:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2E235BDAA;
	Thu,  2 Apr 2026 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmuuyP38"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E8359A7C;
	Thu,  2 Apr 2026 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775101033; cv=none; b=kZ8LG/t4UJ6CXVcbTH4x0NhgEiiu6n9NNpdn+Jwenx7F8x3YOG28V8QVtOMJfYdHLLQZ1CpJHYoRXsFiC5tcbaS/4TwtIo6pba+rAekaQYcgEZ/JlcEE0Et7Rw1YPNIbhIQJzdWdt06udx5wXsrMgN6nBm3u8IQJ/aKElLUAdD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775101033; c=relaxed/simple;
	bh=pIZT0zYN10uOGu4ZRS7BYZ7bm50eH3mtEzBr08ZwCag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlFkJCd1FAUsJ/CpLUieSRwUKcygL2fT4fFGyy2PZ/A+2MfeBXmmBDWOURE35tPvOL5nIsp7wa2xuZR7zoZY1LmGnVC8jx7DjflEAd+ybmYVlAUOSceHiF93EI6B7gJ0vACOkYQriWWoM+c6Onq53wDN/LY5przC+c9HSpFBPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmuuyP38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995CFC19423;
	Thu,  2 Apr 2026 03:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775101033;
	bh=pIZT0zYN10uOGu4ZRS7BYZ7bm50eH3mtEzBr08ZwCag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jmuuyP38kP/QhgISMVbY+zBuaEzO3CNj2pvcPwsoMoaBdtgMP3YVpPkhShlEO+9Ad
	 o1QkdLheimAADvVqspTipWqx33MLwU9Gflv0SNIe/1wHmSsK66rSRqtHwobcV3qIB3
	 jYLFNf3mq0Yoz3SxtgM5Tmce74uCASNibZVy5twuL8T4Yk+AMGCQegeck/l6i1mzkC
	 AVq4vh+onaVNouLuoghj7SXbWQ270sIMn2rvDaDXUlT7Tt3xJC/YBAUB4WnbbyybEs
	 7bdlhSQec+a6N9UNnDuR+g1CkKN4ELBMDP4uTrqsxlpxY1KgqVnwV/8TL32yI3bQvr
	 4ZIVgYQR1Ac9g==
Date: Wed, 1 Apr 2026 20:37:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/2] r8152: Add support for the RTL8157
 5Gbit USB Ethernet chip
Message-ID: <20260401203711.7e56ff95@kernel.org>
In-Reply-To: <20260331-rtl8157_next-v5-0-deb3095f8380@birger-koblitz.de>
References: <20260331-rtl8157_next-v5-0-deb3095f8380@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274356-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEC023833B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 17:55:52 +0200 Birger Koblitz wrote:
> Add support for the RTL8157, which is a 5GBit USB-Ethernet adapter
> chip in the RTL815x family of chips.
> 
> The RTL8157 uses a different frame descriptor format, and different
> SRAM/ADV access methods, plus offers 5GBit/s Ethernet, so support for these
> features is added in addition to chip initialization and configuration.

This version does not seem to apply to net-next.
Please make sure you base it on net-next not linux-next.

