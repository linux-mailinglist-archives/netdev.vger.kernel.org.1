Return-Path: <netdev+bounces-295834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ck0bJgfYImpXeQEAu9opvQ
	(envelope-from <netdev+bounces-295834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 16:07:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBA8648B75
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 16:07:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="Bo 3VVqm";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295834-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295834-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07D92303C652
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD11235E1AF;
	Fri,  5 Jun 2026 14:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956B2BEFE5;
	Fri,  5 Jun 2026 14:04:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668272; cv=none; b=umcpSm29ftSF1OGNkIYRabk2bUQUpsAbFvdrzupZm9BWDP/gdOu1rcmOZXVqj6BGv3/sdRSZyMj2nKv1P9Z5tW70dBmH3THtOAP2nJ9v6zQYdBNeot5FkxTQNR7Z9BLhFUp7lXFla/ZsjYgM+vx1nhYn/DTLZzXGS6fr0Bvh9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668272; c=relaxed/simple;
	bh=bMuE4x/xwnv1J6lcCVfe0OVweZh+mrF+Yms8gNS54eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxdU7hTFisgJPgjWL+oIZWYzbb10NWkdkEGrKU3oH129HFsbkjjuvC7W7kcrzVRbwsPmnUnnSIXhsgZpAwYypLN0fgrXCJIsnF+FlB9CoTxtPdJiboT5Q0oWjD9fn2eRt3A2vGQzOD3YX754PlcGwBO4KbGG86TEOD96eoWNhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bo3VVqmr; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=lRTi43Pb6AImbXcZqNNb2NBaT6asbEas00SHcRQI/Jk=; b=Bo
	3VVqmr3FpceEM4tORBT6wO8rikO8j3wHa7c9gADrtbV4FxlrL8L9PoUEeXkLTITLrmt0oq1ccrvIy
	4nlmmPG4GBj2P7yyoithnBxwtq1yUQ29ZSHb84f931utJUCAO2FNrcCfsgcwcRK9fKZ3B+gpmwsrN
	jBAoJUfr/G+S6qQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVV9h-006Ezu-9y; Fri, 05 Jun 2026 16:04:13 +0200
Date: Fri, 5 Jun 2026 16:04:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Nazle Asmade, Muhammad Nazim Amirul" <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: xgmac: report L3/L4 filter match count in
 ethtool stats
Message-ID: <334ba778-e004-4e63-891a-c8cc8ea352b2@lunn.ch>
References: <20260604083037.24407-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <5e912b43-7c06-4d04-9ba0-8f929150429c@lunn.ch>
 <ed1ead6c-0505-4e56-97e3-b8e32e3e8e2b@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed1ead6c-0505-4e56-97e3-b8e32e3e8e2b@altera.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295834-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CBA8648B75

> To reply on Andrew question - As per what I'm seeing, the XGMAC2 RDES2 
> only defines L3FM (bit 27) and L4FM (bit 28) — there is no FILT_NB_MATCH 
> equivalent in the XGMAC2 descriptor layout, unlike dwmac4 which exposes 
> it via RDES2 bits [27:26]. This patch covers all filter match bits 
> available in XGMAC2 RDES2.

Thanks for the information.

       Andrew

