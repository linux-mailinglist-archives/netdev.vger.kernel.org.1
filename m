Return-Path: <netdev+bounces-269574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ8zMs0xvGnxuQIAu9opvQ
	(envelope-from <netdev+bounces-269574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:26:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 320182CFF55
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64D503275F7D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355123E0C60;
	Thu, 19 Mar 2026 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rL3sa67/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274453242BD
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940788; cv=none; b=VvFMiVgRN5d/7KQb1ZP5f+Z9bGD2LdeIktJJ4HO/BRNp8SgyPxxQQvS1VZCxbDiwDQufbUg7p+rXfnqjQM4MfMhXv9QgJrCayaVph0IiTXP4NLCDgkjO4lCtlAznIZlgMH2gg7NoJ12DohUzMI65QPRYOwq8LmJvKECYP55mPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940788; c=relaxed/simple;
	bh=uKS9jFUjLtOqGZ7fa7JSWw7aBNecmXVRjgnOjaJ8vnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdF8LZ3FEmMORnxGmgc4c+O8P8jqbh/GuxKI/zk2ti0RmFUIqqPlwmJxVfVFNPqHMiEozcQ9Q05Mz8urOseHQfnCePECvv/myCoEg3Cvml8fJkcJLGX/QyLhgif/OieAVtXaTIts4DWD2BowKoQYe6gv2LBYZYdBN+mUKxS3L4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rL3sa67/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CMohD21ZVdc4EdTwB29TcG44o8kbx6ZodTcwxjCdXQM=; b=rL3sa67/+PvbRNxWbUVlQuI4Fb
	S9RgMofeGIZpzQiCV+B2p2XHd2EriyLsDFzbvX9CJyzFCS+14l4JAA95KefosP36AOP86pXXifJn4
	dsuRuMMcE/wYhFBUr08hzqYusfn4tVKStlAT5M6128VoDPhFEuOePmX6sm/dZDYPT0gs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3H20-00CQJq-Bh; Thu, 19 Mar 2026 18:19:36 +0100
Date: Thu, 19 Mar 2026 18:19:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: r8169: Discussion on implementing RSS support for r8169
Message-ID: <bb17044d-9dff-4c81-a001-d754c42e0040@lunn.ch>
References: <1ce3478d571f4d26a45e792c4c84c429@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ce3478d571f4d26a45e792c4c84c429@realsil.com.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269574-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 320182CFF55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 08:56:58AM +0000, Javen wrote:
> Hi, Heiner
> 
> We are now planning to implement RSS support on r8169 driver. This will require significant changes to the existing driver architecture, so we want to discuss it with you.
> 
> Based on our vendor driver which can be fetched from Realtek, the key modifications will include:
> 
> 	1. Enable msix and updating the irq allocation mechanism
> 	2. Support multiple rx/tx queues
> 	3. Register multiple napi and update new interrupt mapping(isr/imr) for multi-queue
> 	4. Implement rx msix poll and rx interrupt function
> 	5. Implement ethtool callbacks for rss configuration
> 
> Should we submit the changes above separately or submit them all at once? Or do you have any other suggestions?

You generally want lots of small patches, each with a good commit
message, which are obviously correct. Given the limit of 15 patches in
one series, you probably need to break it up into a number of series.

Also, having small patches makes git bisect more useful when you
break stuff.

      Andrew

