Return-Path: <netdev+bounces-285302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEwdAO+C/GmOQwAAu9opvQ
	(envelope-from <netdev+bounces-285302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:17:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DC04E818D
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80E793028010
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BDE3DA5C0;
	Thu,  7 May 2026 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MvG1GfRf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73818BC3D;
	Thu,  7 May 2026 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156159; cv=none; b=pkyZd22sYDz8qrrKbGo6d1udblakjPvjpQ7O2p2ea1ApnYIKTqRxjKaFj0ezkOfI+RTsnqID4oyDb81wyqzU7i0ZYo0BGX7ML/tcWPwzdRtHpdR+AooKY0tUzz8CLcmSegGjpHhfLI6q5tNb/dq05mYhJJAGyEwa2XjgsxM90ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156159; c=relaxed/simple;
	bh=KQV/TfhDcsgk5QpZw0ExborelwnYGGyaF3SU76XO5eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSbajogFHmHOxhJ+/o4l33FFhRhWNwI0QnHpQy2SvwYChxitkQEeb2S7uvffSJoI1J74kAj82bld2Sj5g2LRKEav8Aq20+YKXltXHm3VOl8XU6btvlZK7LdaIhSCgOuXHziJbQh+4eAJKdq6LiCH/zs4/8otQlg6HuRXjqgaElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MvG1GfRf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k3DI5VHNsX2dtInGmX3aR5Hyj7MlF2pGpMlNqzUivf8=; b=MvG1GfRfk8yPoSwjN4if1WBYr7
	uAOS9Oxk/4pLC4AqlwuIGpKPaCLF4vPWHlY31q/mU4dnmdaeDsHwZaJ6t6dLT0wbD8bVA1haBle/3
	bvyc/NMBTWqn6TpqhJ8RUcmYxbUdNbdyYw93LjwJ7s7QfjOXTzAPr4pGtifjReRzwiH0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKxdh-001o9u-9v; Thu, 07 May 2026 14:15:37 +0200
Date: Thu, 7 May 2026 14:15:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	KhaiWenTan <khai.wen.tan@linux.intel.com>,
	anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com,
	khai.wen.tan@intel.com, hector.blanco.alcaine@intel.com
Subject: Re: [PATCH iwl-next v4 0/3] igc: add support for forcing link speed
 without autonegotiation
Message-ID: <a74089d5-1b27-4d05-bd8c-9ec2226667be@lunn.ch>
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
 <20260430154105.505739ac@pumpkin>
 <63b186e0-046d-496e-8ae4-d68cd5eb5817@linux.intel.com>
 <20260506104053.7a4f5bf5@pumpkin>
 <78e48cc4-759f-46e1-83c7-1c9442308ae3@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e48cc4-759f-46e1-83c7-1c9442308ae3@linux.intel.com>
X-Rspamd-Queue-Id: 59DC04E818D
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
	TAGGED_FROM(0.00)[bounces-285302-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim,profinet.com:url]
X-Rspamd-Action: no action

> I agree that for normal Ethernet use, auto-negotiation on both link
> partners is safer and avoids the issues you mentioned.
> 
> The reason for this patch is the more specific PROFINET Fast Start Up
> (FSU) use case. For FSU, the requirement is different from normal Ethernet
> use. It is intended for deterministic startup, for example in industrial
> robot/tool-change applications.
> 
> One of the startup optimizations is to use "fixed transmission parameters"
> instead of automatic detection in the profinet specification:
>   https://us.profinet.com/profinet_tech/fast-start-up/

Automotive also have similar requirements. For them, Autoneg is slow,
takes around 1 second, where as a fixed link is operative very
fast. There are even some automotive ethernet devices which don't even
support autoneg.

So this use case makes sense to me, for embedded systems. If the
hardware can do it, any most PHYs can, i see no reason not to support
it. And anything using phylib gets it for free.

	Andrew

