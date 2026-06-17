Return-Path: <netdev+bounces-300098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TkCYLY5sMmryzgUAu9opvQ
	(envelope-from <netdev+bounces-300098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:44:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C759698074
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:44:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=Fu3w2ist;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300098-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300098-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4638A321A276
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74313D890F;
	Wed, 17 Jun 2026 09:36:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E83D6689
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:36:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688999; cv=none; b=hjKIuVLwJ++sfY7r8x6t8kpjTz/ELapna89hwjXyEcFR9X986iUidfJ8oFsllVfEHqFNABDnzaPc6YMAb2wQtolceWCy44rrYXSNonJaiU/XsD2O/9mfC3KOJwLIZjs4OmAjGAeX+dj0UuD+P8vtoUF75OcqGRlwSrYLMeKcBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688999; c=relaxed/simple;
	bh=BbRNm8y1FBfHKpqoxnBw1aeXkgIorAY91Vn4evfRR3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2v2M1zDgWRbP7Z7PDwrVKyDpJYFC6z4/U4l+He8eurToT6uPHdeNWfgMrEr1O6OFTer3PDPV8JPT3/uhcQHDf0yzFlFoTbidji4ynbwU3xTPIywb1tTRl0x4G7boYoIvIf8XplwaZQlr7bDLNqcKV2B4RojnIL3AT8gD2sdr3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fu3w2ist; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P5Ye1io3XhSOO12mUAAOsL6uDGe3iMJtPtuI1oR8/Ls=; b=Fu3w2istTw6znCSJ0H0WXPzEIn
	0NeUUxAQYjJUcLBHl4sAj0WPrFSUbx4ObFu+OHIM70xgnn+II024+0a9mFgPjv4zX6RLmWsm/R8V5
	GB0mgInUVhcWu+OrIc7G7sOKBuYzHDsGeer+nMeKGZy22FOIjU4PI9L2mBOxTJFYcr/k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZmhD-0089qN-CL; Wed, 17 Jun 2026 11:36:31 +0200
Date: Wed, 17 Jun 2026 11:36:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH] e1000: Remove redundant else after return
Message-ID: <5350b174-13f0-41c1-9d8e-2996d6e21d75@lunn.ch>
References: <ead7bfc9-3978-4442-9cd1-23c2182b36b3@lunn.ch>
 <20260617075855.113719-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617075855.113719-1-lovekeshsolanki00@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-300098-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lovekeshsolanki00@gmail.com,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:przemyslaw.kitszel@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C759698074

On Wed, Jun 17, 2026 at 01:28:55PM +0530, Lovekesh Solanki wrote:
> Hi Andrew,
> 
> I read the documentation you linked and understand simple standalone
> cleanups are discouraged.

You also said in the commit message it reduced the indentation level,
but you did not actually reduce the indentation!

    Andrew

