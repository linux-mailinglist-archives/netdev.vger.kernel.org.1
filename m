Return-Path: <netdev+bounces-262959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEHNK6Unpmk+LQAAu9opvQ
	(envelope-from <netdev+bounces-262959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:13:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE9D1E7014
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3AA23046E97
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 00:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B1A1632E7;
	Tue,  3 Mar 2026 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0GUhzQv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374B15665C;
	Tue,  3 Mar 2026 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496802; cv=none; b=XZlpjkEJEmq3Em0WNZQ8l4PAyQlSoI9UbIxHIok0smQAY+K3qRiAbgKeGKq7o+xCdL94r2PxDWxN4bqy1v7G9jtzp3xHsiNQRIZiCiznZSP0eURJTxIlQ9fT4jRHSxwLyZwRza0fUtADm2lNcD8/LrtY3MrIjO8DMTMIaJtpJ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496802; c=relaxed/simple;
	bh=39iFTj9Q7n1Hej3CRmaDkiEU5JMWbwzHLmZmckeKQNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uf56UXZY6JpzbthX3t3Mlx7N+9AVxBgQY2WeUTyLK9j5H8YAXSJjpIVZSbX4c/O76ju/+nab4+dYE0DpH+0rfFbzHUuQnm1zFVwZLGyuMv39bKe1P9NMv934Xh7nH0v6Jh2hxVUq2vkOY1KBRR3/frgITk1mDJsvpgAMzIV2ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0GUhzQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC77EC19423;
	Tue,  3 Mar 2026 00:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772496802;
	bh=39iFTj9Q7n1Hej3CRmaDkiEU5JMWbwzHLmZmckeKQNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r0GUhzQverJKK8WidfHYwF1AkFtQYDci4f1rZnQxAFVlH6hRX3BhpgUInaIiIS70+
	 vuH6o1Mt+ltWJBW8ekEsEvvlbBud3pU0xDpPA4hzC5ufak3nccmcqavp9R2kF27xgU
	 QArKLZ/YJbmsjUOGmPLOFgVgQ2nIX5eiTXdwOikhcKC0+lm7UrVt76OLh6kGMnUbWs
	 4F+rgqpOrbqY4eqsMVBT7fFgErmIWrrx682Ths88yrvuW/xHfUHwgX4oJib4617oUj
	 M9s3uMFgwvRumKaiTLWL57PLZRNAU6NMxk06CMeGDAQfQRD78NphB2hdUWmK1x5UQb
	 3bGRp2xO/8eAQ==
Date: Mon, 2 Mar 2026 16:13:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cedric Jehasse <cedric.jehasse@luminex.be>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
 "edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v4] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Message-ID: <20260302161321.03789236@kernel.org>
In-Reply-To: <PR3P194MB1505B5C902049D53057A41E8EA7EA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260225-net-next-mv88e6xxx-tcam-v4-1-117f600e41d7@luminex.be>
	<20260227035537.2630823-1-kuba@kernel.org>
	<PR3P194MB15055DDD60A57C6D9023A277EA73A@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
	<20260227172831.5ac5d09c@kernel.org>
	<PR3P194MB1505B5C902049D53057A41E8EA7EA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3BE9D1E7014
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262959-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,google.com,davemloft.net,redhat.com,armlinux.org.uk];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 13:36:59 +0000 Cedric Jehasse wrote:
>> I see. But that sounds like a bug / silliness in the core that should
>> be fixed. AFAICT it's due to the fact that the fields are a union and
>> FL_KEY_SET_IF_MASKED() ends up interpreting either being set as both :/  
> 
> Changes to the core would have to be done in a different patch submission? What
> should be done with this patch, wait untill the core has been patched?

Both can we posted in the same patch series.

> There could be drivers unknowingly depend on the current implementation of
> having both bits always set.

Do your best to spot them, otherwise we'll fix them when someone
complains.

