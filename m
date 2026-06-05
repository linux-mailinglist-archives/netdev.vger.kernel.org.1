Return-Path: <netdev+bounces-295852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c/oqCwnoImo/fAEAu9opvQ
	(envelope-from <netdev+bounces-295852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:15:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7664E64931A
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:15:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=IHtGl3Hn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295852-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295852-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3972231314E4
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8333FFF9B;
	Fri,  5 Jun 2026 15:03:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB1409111;
	Fri,  5 Jun 2026 15:03:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671793; cv=none; b=HlcGYcA1aHE47LyxMUeL2XyuOT/u3SN8uAUzyCw240ggPZKEQkVV6WcVsPEov8TAVLWYaFKeFZJOYIvfx/Hv9tBLyxDX0lRFII77uHKsqeeOHfBUzwA1Qc+FBUKWGhZmUH6KLdyU/nsBkQOYlrr4CQLy4B/gr67NPXsJP3Ssw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671793; c=relaxed/simple;
	bh=FpzjZ/JSAXGMKk7XpZUBxyB5+LgEwuCGGDjWYuaATp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUSMLKDiq/keWDeOBZ33pCp25FQSHK2TROY96DxmtQ9xpIYIrFgBpiBiOVIlP3cXqRvSsLEBii3JYyqlEpF+AFclEUYH51QwCRbXJ/+rIAlW8+Y89cG04PDYjApqtLkH8NoBn0o0arPZ1/r/j3vtHrOXLJZXxJUHj18G55Zdjvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IHtGl3Hn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225851F00893;
	Fri,  5 Jun 2026 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780671792;
	bh=Bj5BhhAsB2Vpx8LFsHBDy8pzea78VCGynJnUti3FUkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IHtGl3Hns82MjhHy6hwFwlGATBlzgSrKL9zSvlAZxrg2o72whSNASzZdJZVDitH94
	 DkHFb6j91ON6rG3jDAndXAianhm8FzEY9AdCwxy07A1Qx6ZsvADzh70A/xb1GnavSK
	 92I+ta+XTk4BA5D8KyLzT+CVkFH2t2PeHwHdv1Co=
Date: Fri, 5 Jun 2026 08:08:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Tim Bird <tim.bird@sony.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>,
	"linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH] tipc: Add SPDX id lines to source files
Message-ID: <2026060546-unwitting-unvented-f6d4@gregkh>
References: <20260604183805.747630-1-tim.bird@sony.com>
 <GV1P189MB1988FB0E53EA8D3FCC2533BDC6112@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV1P189MB1988FB0E53EA8D3FCC2533BDC6112@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:tim.bird@sony.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-spdx@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-295852-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7664E64931A

On Fri, Jun 05, 2026 at 01:37:57AM +0000, Tung Quang Nguyen wrote:
> >Subject: [PATCH] tipc: Add SPDX id lines to source files
> >
> >Most of the tipc source files are missing SPDX-License-Identifier
> >lines.  Add appropriate IDs to these files, and remove the
> >previous license lines from the headers.  In this case,
> >every file received the 'GPL-2.0 OR BSD-3-Clause' ID expression.
> 
> The original license of TIPC is GPL-2.0. Why do you think it should be dual licensing now ?

Because that is what the license text in these files say, or are you
stating that it is somehow incorrect and should not have been there at
all?

confused,

greg k-h

