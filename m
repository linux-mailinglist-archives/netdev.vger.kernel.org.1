Return-Path: <netdev+bounces-278537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKxYGiZp3mnyDwAAu9opvQ
	(envelope-from <netdev+bounces-278537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:19:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D10323FC768
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43645308D9B3
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E233ED138;
	Tue, 14 Apr 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xUsdb/TY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364392EFDAF;
	Tue, 14 Apr 2026 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183377; cv=none; b=CQwbHG893EMpIpByTaXL2Y1DZf7T/Bm9HxFUh1qRBWzFm3WFCxMEsfO4NhQlAdQBHMU5V9StBpr004TYsVHrgdU+ldPd2Dg5Pa7kws+O+jnILBSNBEHO6DN9jF4EE3ESc+lgfPWgI2rlGxlX+wxMQN/RT4ErW+FLqOXpzSS/hbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183377; c=relaxed/simple;
	bh=kQpGdZTXwOQKPy4c+euZ4m8PWIggxDQzuGAYq0hHazA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BINLmARkTPgm6/rgg6FuUKhhVH2e1XjsAJ+PDTZe2+hedQghPi/M0aIgGYMdnCQ/RyKHctWcH/ewqdd3nrOdmK5JfBwitQBdG6XF6vONf85j0qJ3nU9c1TA8Tlz+r0N0MdhWVUhUwWczP87DOhzKUbxkxDf4oC+vQ2ShtsqZu/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xUsdb/TY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F0byk/LIGSU6zkTlqKFrVWY1hs0+5fdogZYvtcaExVU=; b=xUsdb/TYB3EBb5eBfOZ1tMFSpg
	YqFYLB2MAKUPc2jaST+3R04VHY8icRCzIf5XP75JRZsyuxs8vxZTDLr7skae4r4XRXSDghBELhdB3
	84CZG3rMONwZH2EI/6s+nfEjqjLxKgA8ArAjg8VTyacVVcWz+Q5PFcF6gbo+CzMRyFC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCgQq-00G4gx-Ae; Tue, 14 Apr 2026 18:16:08 +0200
Date: Tue, 14 Apr 2026 18:16:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio: octeon: use %p for bus id
Message-ID: <efc34ba8-730a-4c01-bc44-ee64569d2d4e@lunn.ch>
References: <20260414155652.7468-1-ku.loong@gapp.nthu.edu.tw>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414155652.7468-1-ku.loong@gapp.nthu.edu.tw>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278537-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D10323FC768
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:56:52PM +0800, Chen Jung Ku wrote:
> Replace %px with %p to avoid exposing raw kernel pointer values.

What exactly are we giving away here?

                        compatible = "cavium,octeon-3860-mdio";
                        #address-cells = <1>;
                        #size-cells = <0>;
                        reg = <0x11800 0x00001900 0x0 0x40>;

Isn't bus->register_base this well known value?

You also need to think about ABI.

    Andrew

