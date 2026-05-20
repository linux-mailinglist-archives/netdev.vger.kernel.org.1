Return-Path: <netdev+bounces-289991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM17LK/UDWrW3wUAu9opvQ
	(envelope-from <netdev+bounces-289991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:35:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA9C590FEF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7230A31912C0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18A3F23CC;
	Wed, 20 May 2026 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s/EC2p74"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0D3DCD8E;
	Wed, 20 May 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290293; cv=none; b=lBvJVusVTPvD61BLHTt3Vng8nur/SHBwlrZkqNn3c7qvI+SnXji9AK5NXFfV79xAvD/7TuVSJXkRWQxbX91jyMXad6DMpzxpS9S7L9BYIj3ro7ov2mOFKyNrsri4dd/B44zxx0nh1keT/1DfdVf2cAM4DYH8+IlY0QV5nXcSLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290293; c=relaxed/simple;
	bh=exyH23ychdHI0aA8Fjoy/ay3/EPrNpYDeE9GG9NT9To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIEGCpb1tdAJ0yvhLN0s/tRPBV9tiJXAdCB7TqFbNabiGUgP3gMjXbcKNm6rkZJcIbsox2Arzb2zEOUWbIeTeytCBoQb+kUZ/198UTgV76YKTk2wsGVQtHTbvsWk3kxPt+XJf/tgOsaOE9ftmrqjTD8/wqkInbvSKiCJWyfoeyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s/EC2p74; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=29b7Sa1wvAs7vY8D5BR2Sr5a8e+XA37Wl4dKtGFgEyA=; b=s/EC2p74cYTZYObAQEYB9Ixhgq
	/heTabw5W/7P2o8AMSXnpK3dkvXUjTRw6gO43DpNanljjXfw5MJgAJx+Ghl4OaTnTBt+frOEFDa8K
	KhjRoaGOj58c9YO/KCUKUiYMzJxLrUGb4PIiM0vY9LY3LbHeVYmMB0CYIcHHNcbBOxQ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPigI-003qyG-Ps; Wed, 20 May 2026 17:17:58 +0200
Date: Wed, 20 May 2026 17:17:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v4 3/3] net: phy: motorcomm: Add YT8522 100M RMII PHY
 support
Message-ID: <58ee1532-06f3-41f6-8bc2-96fefff28a61@lunn.ch>
References: <20260520101310.128969-1-minda.chen@starfivetech.com>
 <20260520101310.128969-4-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520101310.128969-4-minda.chen@starfivetech.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289991-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,starfivetech.com:email,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: ABA9C590FEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:13:10PM +0800, Minda Chen wrote:
> Add YT8522 100M RMII ethernet PHY base driver support, including
> PHY ID and base config init function.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

