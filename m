Return-Path: <netdev+bounces-258091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAsIBA03i2neRgAAu9opvQ
	(envelope-from <netdev+bounces-258091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:47:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BD211B65E
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16D7D3041782
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8582C27F19F;
	Tue, 10 Feb 2026 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pBBXQjiD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057D2749C7;
	Tue, 10 Feb 2026 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731267; cv=none; b=LUDfspWdbBcfC7q/ZAXu2PyWG30e8TJKNrNAuTJ70ao6g9mK6tVqCtK2CG3ISHFZB16y3qXEM8UK41i7PMpxkYRYsQQVogr2X5S/1YxoYqlRTeDPI/WUjg/EU8yx/uB6NyL0ECH7CQ0KhH0YOf0vKL9EXp3i4/YM4tb32mTzrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731267; c=relaxed/simple;
	bh=ZbxnQix/W5OgpnZ6DijlN3ozaBZtLkcEINRjuhnnhaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZtBJJswYE18+dPRJGflk3kGAKkVbimd0WK7aCkMh9cDDm46p/RzMUspfqLnGAu8z+71oWC3EgyBhDWQ/la9SyrdUDaTZgLkheDCDjsrlRsFCTIeDfYwjEY6qjuAOvfeYT2Wdz2wYWI6d/M4PsdbKSGC6VyUnLdZatFpGBBrZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pBBXQjiD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3aMXt61cCmGa2ehLRDVodFqvqerK2mFVEC+9Y0ENreU=; b=pBBXQjiDSp8XUkmUWsXrzVNhO4
	YyGjl0VeHqFsu5YSUS7RaPglzRfhYYv8J9IYlCHrtRKDp4NSQjZT8GyBzw0H17e3sfkOvAeA5JhRQ
	b86UZvBBGKR4twpIGKNzl2D+X/ka/oC2UzafhENG2Pt5uVt8KJfIxYgYUm444nT4cO+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vpo5T-006q0x-On; Tue, 10 Feb 2026 14:47:31 +0100
Date: Tue, 10 Feb 2026 14:47:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] r8169: add support for RTL8125cp
Message-ID: <1a36b013-ae9b-4d51-8259-92728644ceab@lunn.ch>
References: <20260210071134.1530-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210071134.1530-1-javen_xu@realsil.com.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-258091-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim,realsil.com.cn:email]
X-Rspamd-Queue-Id: 71BD211B65E
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 03:11:34PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply
> different and firmware for RTL8125cp.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
> ---
> v2: This patch fix one mistake on phy_modify_paged(phydev, 0xa43, 0x10,
> 0x0000, 0x1001) which is phy_modify_paged(phydev, 0xa43, 0x00, 0x0000, 0x1001) on patch v1.
> 
> v3: Set phy_modify_paged(phydev, 0xa43, 0x10, 0x0000, 0x0003), bit 0
> means 'link speed 10m PLL OFF', bit 1 means 'ALDPS PLL OFF', bit 2 means
> 'ENABLE ALDPS', bit 12 means 'ALDPS XTAL OFF'.

If you know what these bits mean, why not add

#define RTL8125CP_LINK_SPEED_10M_PLL_OFF 	BIT(0)
#define RTL8125CP_ALDPS_PLL_OFF 		BIT(1)
etc.

    Andrew

---
pw-bot: cr

