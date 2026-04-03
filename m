Return-Path: <netdev+bounces-275080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMpqBlPOz2m50gYAu9opvQ
	(envelope-from <netdev+bounces-275080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:27:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C38395380
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7F2C300574E
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0526D386C2A;
	Fri,  3 Apr 2026 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vNi6FMwf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29523B892D;
	Fri,  3 Apr 2026 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226001; cv=none; b=lg39bBFi+xgfPULBOKMntNTeFfa6MP4sF6hTu8I80EBb2VluSv99yJQYSMzeqvtSrJSRu0+3uDuTWDj57mwqSd6wsYXMA6vMrwr5sLwpGib5y8N4ukaRrEbiB4xiP0OF1ybYsdKI7syeVlqJq+cxaMnRhxwb6W7AHfK7KXgcciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226001; c=relaxed/simple;
	bh=tGTBweo9NFXmnODGZU94m8xzlmOFALtngsCyYmiJ728=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8h0j4FXpko3XZjDU0CPVzovqNbNuDYrLL15Ag1GzTEJsX1nyb9khcoQtBGBITvHYvvooXsbjsE6OvvuBn3T3yuqbDZxFRe0cE2UVzyq+3t9BqxjcdTiYqwYfCiaaKYBXAJnkNvuey3oHlCGuqXb/QyNsjS65TBk/g6bniB6/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vNi6FMwf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l1hC3uV69przVxSDp/HvbjLA55jCweeBC6cMLyqbk6Q=; b=vNi6FMwfvFlmufDx9S5tBA0HLU
	ru/MYvZmOx4jxpuGgdQJ2VVk3uxkpstSSlDdtoExXinNI/VSoEwF6nsRPyn7SlXn9DF+SgpQgQyHC
	zQoJlWF0h3OJBRmlOWPDu5gTqgsbp5niE+2trgBhuONQixqTat/6UU4zTIhLE5YhF4Fk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8fN9-00EfpT-7Z; Fri, 03 Apr 2026 16:19:43 +0200
Date: Fri, 3 Apr 2026 16:19:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: dsa: yt921x: Add port police support
Message-ID: <308c4474-3da3-41bf-af29-3a400232e029@lunn.ch>
References: <20260402223437.109097-1-mmyangfl@gmail.com>
 <20260402223437.109097-4-mmyangfl@gmail.com>
 <654b51cd-fc06-4dd2-9a6e-421d7333f905@lunn.ch>
 <CAAXyoMP=o7P0-o6HOKi8dho8iLLV4LJT=YHae5Gj13xJ2ph4og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMP=o7P0-o6HOKi8dho8iLLV4LJT=YHae5Gj13xJ2ph4og@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275080-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 17C38395380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Does it unnecessarily depend on __int128? Otherwise it's good.

Ah, it seems to be a 64 bit architecture only thing.

Shame, because it would make this code easier to understand.

For these u96 values, the masks i looked at would fit into a u64.  Are
there any fields which cross from bits < 64 to > 64? Could you
represent it as a u64+u32?

	  Andrew

