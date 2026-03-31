Return-Path: <netdev+bounces-273610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFoeJGa/y2k9LgYAu9opvQ
	(envelope-from <netdev+bounces-273610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:34:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F02E536985A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 497B53036638
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE353E2765;
	Tue, 31 Mar 2026 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a2u0lPA6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FE3B0AD0;
	Tue, 31 Mar 2026 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960214; cv=none; b=Ac7HaKtHkWktCax6/FdPSNQ/xwowKCPAxNH+lS/rDDcb9zs+HMZ6a3wG8PNm1uZaO25UQmcr8Jl/yrTQVxKxdw/3SVMA0LVqwG/6pPMFtis8ZBIra4Gz0LVfI1givM+EmotD/RFoIZ6qffTFbkpp89lZgHTIkuUF2qO6fwUxL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960214; c=relaxed/simple;
	bh=OQJlvwNf/qiW+LpcSodHYUethJ5VunVzGgHagnXmiXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPWN+uEv0QDUjGP/ihhzEVhBm1ulh7hJqQ0H8SCyFf6sLk7p5jw0onaxyRrUZVGv6z0df7+t9Q2adbMmOIR1HpUpN2ij95HVQkr6Qg+xDLcAi0RQ1e1Gd3PiICIcE4EneUoyKw5iTwCAkCdPuqNXRKdx8CJjai+vr/KhfljFVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a2u0lPA6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F79QCtXzXa5tHU8nSoJsDLLtDJfEeAlFOGFuiWskg7s=; b=a2u0lPA6a1owXhY222XCmt5PRQ
	HyNtmWXoyPCyg0saKK1ARbzhPtBk6HS9rJI7aw82QyycL5iIkfJf/1f436p3si7Ove07SdyngQjsP
	PflxpIrG6Ms6QGWUx9rSATQIWgXDvJ24472/z6ZKZP5oF6WPcr2h6dZ3d+2kUTc/P/ZU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7YEK-00EC60-PP; Tue, 31 Mar 2026 14:30:00 +0200
Date: Tue, 31 Mar 2026 14:30:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v2 4/4] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <d4f7ac51-5c46-4104-b657-23e5c4a375f8@lunn.ch>
References: <20260330184017.766200-1-joey@tinyisr.com>
 <20260330184017.766200-5-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330184017.766200-5-joey@tinyisr.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273610-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,tinyisr.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F02E536985A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 09:40:17PM +0300, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch.
> 
> The switch has 5 built-in 100Mbps user ports (ports 0-4) and one 1Gbps
> port that is internally attached to the SoCs CPU MAC and serves as the
> CPU port.
> 
> The switch hardware has a very limited 16 entry VLAN table. Configuring
> VLANs is the only way to control switch forwarding. Currently 6 entries
> are used by tag_8021q to isolate the ports. Double tag feature is
> enabled to force the switch to append the VLAN tag even if the incoming
> packet is already tagged, this simulates VLAN-unaware functionality and
> simplifies the tagger implementation.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

