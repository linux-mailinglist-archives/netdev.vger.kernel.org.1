Return-Path: <netdev+bounces-300230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8CFMMgjrMmp27gUAu9opvQ
	(envelope-from <netdev+bounces-300230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:44:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C5569BFC6
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:44:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=U46+FNNi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300230-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300230-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A88A43032070
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF100379ECD;
	Wed, 17 Jun 2026 18:44:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697DE305674;
	Wed, 17 Jun 2026 18:44:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721861; cv=none; b=FN5Olf27/actM07DCGapOB3b2jwUwGiRz0tPOHNbafPAkn9ATajT+1TgUDJwVsoa0P8YVVjY7qmhJV942IBT/zuPy7dvhieRxA7ewU8Oh5Z5p06CYWLx9Eh2fad3yLAzUvbDsUrscIfJrCS5GVZg2D5W/M/VJ1iLJD3NF3e2hZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721861; c=relaxed/simple;
	bh=jeEFhiaD+qtdPHfB/VtSDvvNcB8+JmaR4wmRQgLZ5EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfbIbt2zePrxrhK/5JUZ6bKYlrKou0eNgzSfkATDcPyeldPtZCBm9Nr7RLKhI6cgncHFSk61Vf9+jQi9e17/x+6RX1plEAsX+NaBMPE51pUneRvCZeUZR5qhXWER2fKoOS0YmEE6QOP+RVc4sY1n+BVwOV3M9vUhYzBneYt440E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U46+FNNi; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P3Axoo/5lYepLoIOpwANOv6fl+ucrultxip2EdrkoFY=; b=U46+FNNi+zlI4+FxqXjHAfdyZe
	9M4LnvZuw9JDN+WlG1TNeFsrcYABMfMRFi7P+ySH7Gvit8IhvaGdECBZJVH6fBE2FVuE6bPzhlVQ0
	PP0luYGKuOgEf4+SafJrx4VNDmDijvEsi04cDTI6ptDgEsp91XM4XPb1kIZFs3R6UEvI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZvFA-008Dld-ND; Wed, 17 Jun 2026 20:44:08 +0200
Date: Wed, 17 Jun 2026 20:44:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: prestera: initialize err in prestera_port_sfp_bind
Message-ID: <31f6bb61-3040-4a68-84e3-ce6a57022978@lunn.ch>
References: <20260617182214.963694-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617182214.963694-1-ruoyuw560@gmail.com>
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-300230-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:taras.chornyi@plvision.eu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09C5569BFC6

On Thu, Jun 18, 2026 at 02:22:14AM +0800, Ruoyu Wang wrote:
> prestera_port_sfp_bind() returns err after walking the ports node. If no
> child node matches the port's front-panel id, err is never assigned.
> Initialize it to 0 so the no-match path does not return stack data.

Why 0, and not -ENODEV? Please include an explanation of your choice
in the commit message.

Please also take a read of

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You need to indicate the tree this patch is for in the Subject:

    Andrew

---
pw-bot: cr

