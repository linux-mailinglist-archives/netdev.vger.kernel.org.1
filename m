Return-Path: <netdev+bounces-285517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPYnBeQF/WnkWgAAu9opvQ
	(envelope-from <netdev+bounces-285517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:36:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9FB4EF5FA
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF6F3031036
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8E63451AA;
	Thu,  7 May 2026 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ax2WpD9O"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BCC2475E3;
	Thu,  7 May 2026 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189792; cv=none; b=PqzCsdPPL160VaE3K63rp6Ivfv2hb2fa8RRmIt/EjrMhdNKp66S8zueh+06p5X/+r4pevmJHL9Zfkydqm+4HnZGYsmBspg8TgiW1kbwgz+NIvBW9mNEtlBm/Fgg7MpDv2cQeVwx9kSGLZh6quWQAuEm7uVoYnMoMYq7WdPJJDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189792; c=relaxed/simple;
	bh=p3wVzz5VNqgwveHdVU9d5bK9qwu/4koa6H+tJj2UyaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijC1OWfqc68UbWTwH/vVnP3zs3fTeCQEH4dvvq17fTcdzgZmV19ZL78WaNc5CpDwfrrXJpgGf6nmKVuKvdnOo0vO/u0A1+IOacD0srljfuO5DW8h/0ri5hgObRgA+bF3grvdrRE9sDL3RU5kiDBRxpk/178tdF+AdklL2s6z4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ax2WpD9O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=EGD8JspjmSP80eMiWCiz+GZtznF5vZ7uaGhPmePdXwA=; b=ax
	2WpD9Ob8DtriFO3GDwHPYC3Ncwa+gpynnAQ+4hmtkSIpOyUzG5g0UVfxxXCg9p6MguhSVilkZCaTj
	aW/gry1sjeMoGSCmIinzbRZPPgvV6wv9Iw7VyXF1xpz8v3y72HK7LaKta313siWMhGgP9d3EKuySO
	IwLHdeLowl0KnWo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wL6O5-001s1n-AV; Thu, 07 May 2026 23:36:05 +0200
Date: Thu, 7 May 2026 23:36:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: phy: air_phy_lib: Factorize
 BuckPBus register accessors
Message-ID: <d7580b92-f165-4135-85b9-ec89a2568949@lunn.ch>
References: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
 <20260326-add-airoha-an8801-support-v2-3-1a42d6b6050f@collabora.com>
 <3bd7803d-4c4a-4f61-9434-a6bf25627b58@lunn.ch>
 <9f569ba00b959b701a7a51bcd7347c1a108a15ee.camel@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f569ba00b959b701a7a51bcd7347c1a108a15ee.camel@collabora.com>
X-Rspamd-Queue-Id: 0E9FB4EF5FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285517-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 02:11:54PM +0200, Louis-Alexis Eyraud wrote:
> Hi Andrew,
> 
> On Thu, 2026-03-26 at 13:30 +0100, Andrew Lunn wrote:
> > > @@ -480,8 +287,8 @@ static int en8811h_wait_mcu_ready(struct
> > > phy_device *phydev)
> > >  {
> > >  	int ret, reg_value;
> > >  
> > > -	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> > > -				     EN8811H_FW_CTRL_1_FINISH);
> > > +	ret = air_phy_buckpbus_reg_write(phydev,
> > > EN8811H_FW_CTRL_1,
> > > +					
> > > EN8811H_FW_CTRL_1_FINISH);
> > 
> > Is a rename required? Is the namespace air_buckpbus_ used somewhere
> > else?
> > 
> > 	Andrew
> Sorry for the delay.
> 
> The air_buckpbus_ namespace is only used in the air_en8811h driver.
> It seemed better to me that in the new air_phy_lib, all functions (the
> buckpbus accessors and air_phy_read/write_page functions) started with
> the same prefix. That is the reason I renamed them, even if not
> required.
> 
> As an alternative, to avoid renaming those buckpbus function calls on
> air_en8811h driver and reduce this patch changes, I can add macros at
> the beginning of the file such as:
> ```
> #define air_buckpbus_reg_write(_phydev, _pbus_address, _pbus_data) \
> 	air_phy_buckpbus_reg_write(_phydev, _pbus_address, _pbus_data)

No don't do this.

If you want to rename them, rename them. But do it in a patch which
only contains a rename. That is easier to review, and more obviously
correct.

	Andrew

