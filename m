Return-Path: <netdev+bounces-269565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOETAdgvvGnquAIAu9opvQ
	(envelope-from <netdev+bounces-269565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:18:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1D42CFC88
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFE643217794
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84D5348898;
	Thu, 19 Mar 2026 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UUiq0APE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A92DFA5B;
	Thu, 19 Mar 2026 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940163; cv=none; b=oorRjW+MVgOi/rbxWJnoWPAeOOlNZBz3lCI9GEb0R3Pa3XnzqGX9fSpHPdPmSHZtrw8tPxMRe1gyRoph1aKnlPk5uK7njvzkhT9rBPSrxjTiZXPfE8ldyQRAxQYVFH4GMSNCHmzEqAQunvZ3XVVITQmHChcNcg/xpsQbtWKPKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940163; c=relaxed/simple;
	bh=NLU2KE2etLo5EK+U2mNgOEY6OjEiVXvqaLsYF9//3m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEy5cB+ONhx2ZuQpPeEKplvi7YSxhgp91c+Tb1O28hHvblwfja+BiVuykbUJ/ci+ThzR53RbvsP/IdJWHAKN+UnI/zOB6sQKoqsJWpEFA7u+3BpKLGfRi96r6HtcC9J1niYMAWshNWfzUQPprIwgXFpN/rGgBieQMQ6wX15nP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UUiq0APE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OEvDt1nf2P9S5k7t0TFUpeBge/qIDMGoRTMtpmnde7c=; b=UUiq0APEcUiXss49RvjaDvMApQ
	mOH2W1AjpWyCBUm6pusrba0OR8jULejtUlg7lqwSjEhsSERlDhk84zxw4LR2gVifQTHIPB4dVjKnc
	WYKlVe11vqd13tHWHMyUTqt16q3vGBd277ZCa9S1tpJ55UYod4vmfyKrPaKvPPc6BcS4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3Gru-00CQCz-Rb; Thu, 19 Mar 2026 18:09:10 +0100
Date: Thu, 19 Mar 2026 18:09:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Javen <javen_xu@realsil.com.cn>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1 2/4] r8169: add sfp mode for RTL8116af
Message-ID: <da0b02b6-31c3-4815-9ba2-605012946257@lunn.ch>
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
 <20260302063215.1790-3-javen_xu@realsil.com.cn>
 <d2b97f5b-6032-49fd-b80a-6fb47f3fad4c@gmail.com>
 <98d632aecbbb4dd8ad79c24e672765b1@realsil.com.cn>
 <fcb72518-24f7-4e16-8208-fb38441408d2@gmail.com>
 <761cc11222bc4f4cb206629a76292c97@realsil.com.cn>
 <cd96bc5c-1087-4d13-b556-e1fd94e6322e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd96bc5c-1087-4d13-b556-e1fd94e6322e@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269565-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: 8D1D42CFC88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > We checked our chip documentation and confirmed that the SerDes register file maps
> > all clause 22 registers(e.g. WR 0xeb10<reg_addr>, RD 0xeb14. reg_addr 0x40 is for BMCR,
> > 0x41 for BMSR, 0x42 for PHYSID1, 0x43 for PHYSID2, etc.)
> > As you suggested, I wonder whether the proper approach is to implement a virtual mii_bus
> > and map the standard serdes reg in the new map.
> > 
> We'd need to know how the internal PHY and the SerDes play together.
> Whether the usual internal PHY plays any role in communication between MAC and SerDes.
> How interface modes are controlled on MAC and SerDes side, etc.
> If Realtek doesn't implement proper layering in hw, and doesn't have enough knowledge
> about mainline network driver structures, and on the other hand doesn't want to provide
> chip documentation, then the situation somewhat deadlocks.

The PHYSID1 and PHYSID2 might give us some clues. Is it a PCS licensed
from Synopsys?

https://elixir.bootlin.com/linux/v6.19.8/source/include/linux/pcs/pcs-xpcs.h#L24

	Andrew

