Return-Path: <netdev+bounces-284028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJLaLVL0+Gke3gIAu9opvQ
	(envelope-from <netdev+bounces-284028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:32:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B2B4C345E
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 280B6305B00C
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284FF3E7179;
	Mon,  4 May 2026 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z6QcYcDV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381F3E3D89;
	Mon,  4 May 2026 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922638; cv=none; b=QrTo22bB85CCTl/2dSmZnZICS/I80ZHNI4WQ2wWF+YUyDPv1F5biaID7fqbSTOkrgQl0HWcOFxI84gg+j0KCN30ha6wLAXqzwAXoBhKIaiYQObgGdPAjFqVOUFZOggTab4rds/CpWxmT86XdkVxedFjR2vjcmJEFLM8gDMBct+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922638; c=relaxed/simple;
	bh=hDArOx3/taDF2l97kYK/gJTu/8TmxK77YYAWq53qBcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cupn8kfR2OTWLc60naS9iRv8ARQG4yycZ/62DABQWCAXBi6hXvfsrE6Owkpfhp5usVs4IHbg52nbMQxAeXd7ICidoSotxQLdD2SupS06jXxYrACFYHUh2o87dI7sjED648x9dretSwHBlLQhI5DiPDSmMOqa4TQzBUS/F6rk3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z6QcYcDV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fdPSU1AHOSFbJ/xqdLoWmqBgebTWyGJab8jZxdyfuO4=; b=Z6QcYcDVocfhIiuBCCBOtRO/4w
	abqzktR54ioRblxJsZYZJmMqQHXgkRTOszR0WsAjz17KQLBDE+qv3jEZvJ3DLJtT3gpEtjJjuDafr
	LBOJGvMvRVLZCYK/NZkR6oMUMTdTLSVmRAZciVCiXpA3tMWIsKcZFF9GuK5HEzR+siZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJytO-001Kh9-TU; Mon, 04 May 2026 21:23:46 +0200
Date: Mon, 4 May 2026 21:23:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] onsemi: ncn260xx: Add driver support for
 NCN26010 and TS2500 MAC-PHY
Message-ID: <e2f03fc4-2948-4046-83a6-7d587e09ef62@lunn.ch>
References: <CY8PR02MB92494A5A16B7AF4EA3A69F2483322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <12245592-fb85-46d9-9f26-5ed37efacbfc@lunn.ch>
 <CY8PR02MB92499BF412C31A04BADE609183312@CY8PR02MB9249.namprd02.prod.outlook.com>
 <5f07822d-6ea9-4beb-a222-58a94e4801d6@lunn.ch>
 <CY8PR02MB9249082A82E8E2C503D6773683312@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249082A82E8E2C503D6773683312@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: 55B2B4C345E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284028-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> > You failed to answer my question about this. What happens with your
> > device if you access C45 registers which don't exist?
> 
> Sorry. Waiting for an answer from hardware designer.

It should not be too difficult to program up something like:

	for (int mmd = 0 ; mmd < 32; mmd++)
		for (int reg = 0; reg < 65535; reg++) {
	    		val = phy_read_mmd(phydev, mmd, reg);
			printf("%2x %4x: %4x\m", mmd, reg, val);
		}

	Andrew

