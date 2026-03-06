Return-Path: <netdev+bounces-264889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBN+OqwQq2kRZwEAu9opvQ
	(envelope-from <netdev+bounces-264889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 18:36:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 731172264E4
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 18:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE807305328B
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C03539890F;
	Fri,  6 Mar 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jf2+ryql"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0937475B;
	Fri,  6 Mar 2026 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772818529; cv=none; b=Athi2eXJ3NOsJev+KIGHPwDHcfe4eHecUQMmOYIJCdPsqhOxUguYtQFkjR3rHN8ROv79XgX97KrI03KHoX67MiOe7rC2CioDTBEOoqVZsMigSf2zVNvZvES/+irKPCGHJzN44M30rZzl88q1DSafWJ0i7nPwefykXZrPp49FKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772818529; c=relaxed/simple;
	bh=b0nz60gqa0A2bobFRuBO7QvFUiyPIQywBVkhY3IqHFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg4y0wlsK+tt/xNcCpz1HzameEzjiuOQbeUCJUCBziZW/I5FiXWANIMg9uJO5AvQBoYc9B9mXg2Vx433CRciefAm4hOpk+0SdYBpO54uPzazWNC7rmjW13a+hZy30n0HP7ovQQHfU5YzWGx9TSeUVuu60BGyj5BT4ZLYB+Kwqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jf2+ryql; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nSav4Taj7FeSAbA4PAMmEMckkxxksEcAn0hDjSYjp6E=; b=Jf2+ryqlMTWeK20RlmAy6tGwLQ
	vW2j2Z8GlmgJlHGlz9vqr3K2Bt8oBeZDzQ/cQVruxftpI4NYZDl5XReVDvjt2ZvsdpoLJsiyrRTyU
	CCAXtwKkaePDQI9qcKx4erO+LGDDO7VHeiwQNUz7LkYBDjfWpN3ZC3ykD/Qw+3XUHzJQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vyZ55-00AW6k-3S; Fri, 06 Mar 2026 18:35:19 +0100
Date: Fri, 6 Mar 2026 18:35:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mvneta: fix NVMEM mac address
Message-ID: <b0f7d9ed-2df6-48f3-904f-d256f1ec881d@lunn.ch>
References: <20260305224643.14524-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305224643.14524-1-rosenp@gmail.com>
X-Rspamd-Queue-Id: 731172264E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-264889-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 02:46:43PM -0800, Rosen Penev wrote:
> If nvmem loads after the ethernet driver, mac address assignments will
> not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> case so we need to handle that to avoid eth_hw_addr_random.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

