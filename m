Return-Path: <netdev+bounces-281934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NwMALbN8GnCYwEAu9opvQ
	(envelope-from <netdev+bounces-281934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 662EA487964
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 890C2310116D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD8C429813;
	Tue, 28 Apr 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LbRg61Jr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A03E1230;
	Tue, 28 Apr 2026 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387180; cv=none; b=N7iSKD+CqlhVofEKmkXf9WvJtOOwVc0B1I2sBiMLIjc3dCz9if4NwMnKXf55rVGkt7/TgJKj3wWJku3Z3svnRjePVZ6g00bE/Ac2QIQk5LiQNXpvakMzp8ff6TZgmiRsX2Hu86/9isAP0G+GIWZy5tbiZ7w7q1uWsydCID7GHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387180; c=relaxed/simple;
	bh=ndkYltk4TrLKbkDE2D7T8XnXR1jyK3Ql7fiYgPBtnG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNyezvUG5SyRb/XcYYrFRKdKpsuAFIo1tR6ROGsi4En9qlDzn7mxif00uZdVXdBwQv/Hmu1RzWH36VDslhSyAPF5y0h8AZEb1f3m8y0mMdKkOrVzYpi/TzJXHqBMVs6qsWcOPVgnskD1uCgFZXAIt9+loonPRdZ1GpywRKeR3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LbRg61Jr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UNK6Fl0ayUn6bkL7QNJCB3dd44T2ZvOmBCycUQo2hN8=; b=LbRg61Jr4BQeXALqT6iAAslTrw
	84lcTLxSueuJ24hY5JwrpeSWCt9mdcXbCVTsv4oY7kv3pnnQCY9Jbem5Z9ZsuHAZiSGUjHOzpAOSm
	lUnK0Jqlf/bdbnGhq5rHY9SkJI1QJy32oaTnPeJSQO8NKx5ipGLuRKgSJkMJzbGKCEwU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHjav-000Lo2-3p; Tue, 28 Apr 2026 16:39:25 +0200
Date: Tue, 28 Apr 2026 16:39:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Benjamin Berman <benjamin.s.berman@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: thunderbolt: enlarge RX/TX ring and set NAPI
 weight for sustained load
Message-ID: <0dce1878-f54a-44f4-b755-2ea6899c8c9f@lunn.ch>
References: <20260428015521.3454006-1-benjamin.s.berman@gmail.com>
 <20260428015521.3454006-3-benjamin.s.berman@gmail.com>
 <20260428074253.GP557136@black.igk.intel.com>
 <e6a249d5-8b11-43cf-89ee-14d436c70cf8@lunn.ch>
 <20260428141954.GT557136@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428141954.GT557136@black.igk.intel.com>
X-Rspamd-Queue-Id: 662EA487964
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281934-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

> > Is there interrupt coalesce going on, and the coalesce time set too
> > high, so that by the time the interrupt fires the ring is full? Can
> > you play with ethtool -C?
> 
> Thanks!
> 
> I'll leave these to Benjamin and Claude AI to answer.
> 
> One thing that could affect is the interrupt throttling that the hardware
> is doing. We have quite big value there by default. Lowering that may have
> affect as well. I just posted a patch series where one of the patches makes
> this configurable in the tbnet driver so you could apply that and play with
> the throttling value:
> 
> https://lore.kernel.org/linux-usb/20260428072209.3084930-6-mika.westerberg@linux.intel.com/

So i guess this is interrupt coalesce by another name.

In netdev, the module parameter would get NACKed.

[Looks more closely at the code].

So, you are adding the module parameter in
drivers/net/thunderbolt/main.c. That clearly is netdev code. So sorry,
please don't do that.

But ethtool provides an API for configuring these things:

       ethtool -C|--coalesce devname [adaptive-rx on|off] [adaptive-tx on|off]
              [rx-usecs N] [rx-frames N] [rx-usecs-irq N] [rx-frames-irq N]
              [tx-usecs N] [tx-frames N] [tx-usecs-irq N] [tx-frames-irq N]
              [stats-block-usecs N] [pkt-rate-low N] [rx-usecs-low N]
              [rx-frames-low N] [tx-usecs-low N] [tx-frames-low N]
              [pkt-rate-high N] [rx-usecs-high N] [rx-frames-high N]
              [tx-usecs-high N] [tx-frames-high N] [sample-interval N]

So i hope you can map these parameters to your tb_ring_throttling()
call.

   Andrew

