Return-Path: <netdev+bounces-273607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAp8IDS+y2kiLgYAu9opvQ
	(envelope-from <netdev+bounces-273607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:29:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178FE3697A0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C545B308C952
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8593E1CE6;
	Tue, 31 Mar 2026 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bLomtK/b"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61393E1D03;
	Tue, 31 Mar 2026 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959837; cv=none; b=GaLCmKeCys2W1SFNKIr/p6GDuR2fQ2F1HWxEIQ4YXDQ8TUEwwc/j5VNsgKVliqAH93jNyADt0TECk9mXpGom0vjHvucG6XnzLwYuTi+II19Btc7JR/9ohm1/JnifBBskWGPJCoJgCraqz3cfLPUjbjKUUrDttBt743XHDbiaksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959837; c=relaxed/simple;
	bh=6EHU6i3Kxk1PsCup6AbdyOQktdihYokChOMhMY1WDMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGNmofD5NmHQjgIq5TPNww/x/NpW9MMAnNi5KNbXCOVCyxRIm9kUxtRdZGr6DWvPNXFyy/0ywJbaQdgpQkMaX8C5XvWoMd8IivM/IV0xUsQRURmBJdBpI7Sqt7rJbnznpArBDsj9xZCTQYhG8odZdE9lgAYerRZccmrFDR360mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bLomtK/b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dksMoYQmNn4rvPd11eAqblukoSAKuwPHp8JrhoOdYjk=; b=bLomtK/b0H07CzFlV5YH8R3djV
	pdef76doN/DTo8CfsgGdBR6wIQik44SLikp9HhSGATx5w5ldmp48wltGiioRfdSj8t0ZFSAmX86Gc
	OIXQIvoKgk7Cr1e+4HjapmJZL3AJA3RbjLvKxhUUmH033agnB+vgS0yCgGwGV1GG1pvs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7Y8J-00EC3H-SQ; Tue, 31 Mar 2026 14:23:47 +0200
Date: Tue, 31 Mar 2026 14:23:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v2 3/4] net: dsa: initial MT7628 tagging driver
Message-ID: <60abbf88-e97a-4c2d-acc3-ecf3dd338a80@lunn.ch>
References: <20260330184017.766200-1-joey@tinyisr.com>
 <20260330184017.766200-4-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330184017.766200-4-joey@tinyisr.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273607-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tinyisr.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid]
X-Rspamd-Queue-Id: 178FE3697A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 09:40:16PM +0300, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch's tag.
> 
> The MT7628 tag is merged with the VLAN TPID field when a VLAN is
> appended by the switch hardware. It is not installed if the VLAN tag is
> already there on ingress. Due to this hardware quirk the tag cannot be
> trusted for port 0 if we don't know that the VLAN was added by the
> hardware. As a workaround for this the switch is configured to always
> append the port PVID tag even if the incoming packet is already tagged.
> The tagging driver can then trust that the tag is always accurate and
> the whole VLAN tag can be removed on ingress as it's only metadata for
> the tagger.
> 
> On egress the MT7628 tag allows precise TX, but the correct VLAN tag
> from tag_8021q is still appended or the switch will not forward the
> packet.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

