Return-Path: <netdev+bounces-265388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEaTL5l4rmmPFAIAu9opvQ
	(envelope-from <netdev+bounces-265388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 08:36:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B5234DBD
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 08:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D9563035D48
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1392B363C56;
	Mon,  9 Mar 2026 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KpInZ88z"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8761474CC;
	Mon,  9 Mar 2026 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041676; cv=none; b=ZwxH/BNzLAodJbJCBjWiY5sdic/nSV7OTqa+masY86G7RNHcLcTT+INHwr9eJ+SJPZvEPdSz7x/cPpWVwcJ8Pd/e+34Mu409+NGwVj/gYiZ0O2sPfn2HdBuSAukBszSazsJqGEKBl7mlTTmUehchIH4svwS2ERBUQDdRX04tt3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041676; c=relaxed/simple;
	bh=R2b3GT16yuRWLURpppoxZ2/BomPiRrUP05I1F+TgX5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrjgaPID4P/KMNccgMRHYcltl8MGf+Xu90vY6HWY+//JXqoRLkKNryCJfLj3wWBwuj5t7OfU+B1h8QF9+BYhsRkXPqzvvV+fyjDix1HzoAsV5GGmtCvSKXJGwys6+6o6bj1TwJTNdsRLt7ebAmoW/ftvD+0TNi+da9R5HcrQbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KpInZ88z; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B63A8C4286F;
	Mon,  9 Mar 2026 07:34:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 633F45FFB8;
	Mon,  9 Mar 2026 07:34:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BE0910369AA1;
	Mon,  9 Mar 2026 08:34:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773041664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=57MDzh0byafJX1r5KvR9O6Bb41FrwPESxzx8+oF42bg=;
	b=KpInZ88zT0C/m9wEsGqcZTgd/wme9ICKOw/x8mxOZfj3zD93K/y5rv9vdzov/zSPdhyTH/
	OdOLhho0dxYdFb56RFgxhN/dlWVlo9l9DaUuXk08i5juRzcD9SYLl45J3yMACAwYsXdj7X
	4o1KunCQIp7FFnWmSwCrxGvQnRWYYmVrOY73s/REAIrZvEeAEa42yQNjZFEBbfPo9buM4O
	eBnOZqroRgTptzHfeLfT/dRGU2m+heHKYN3xoYsGf4DYLkV46emYgi13Hbgv8jOvSBOfGy
	Go4upMe496Z/45jlE/JKI+r/4pi9Fa3f3br9a8llw+vDiDZtPFLDJOuOekLQzw==
Message-ID: <19aa42c1-4e3c-4722-84bd-a21b53ad3993@bootlin.com>
Date: Mon, 9 Mar 2026 08:34:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 2/6] ethtool: Add loopback GET/SET netlink
 implementation
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Russell King <linux@armlinux.org.uk>
References: <20260308124016.3134012-1-bjorn@kernel.org>
 <20260308124016.3134012-3-bjorn@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260308124016.3134012-3-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 239B5234DBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265388-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Action: no action

Hi Björn,

On 08/03/2026 13:40, Björn Töpel wrote:
> Add the kernel-side ETHTOOL_MSG_LOOPBACK_GET,
> ETHTOOL_MSG_LOOPBACK_SET, and ETHTOOL_MSG_LOOPBACK_NTF handlers using
> the standard ethnl_request_ops infrastructure.
> 
> GET collects loopback entries from per-component helpers via
> loopback_get_entries(). SET parses the nested entry attributes,
> dispatches each to loopback_set_one(), and only sends a notification
> when the state is changed.
> 
> No components are wired yet.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

At a first glance, what I see is that you're using the GET ->doit method
to retrieve an array of loopback entries. The pefered approach in that
case is to use the GET ->dumpit command instead, issueing a netlink DUMP
request to list all available loopback entities on a given netdev.

If you want some reference on that, take a look at the phy.c + the
'perphy' helpers in net/ethtool/netlink.c

The idea is that you can pass a netdev ifindex in the header of the DUMP
request, which you can use to dump all loopbacks the passed netdev.

You can also check the ethtool code itself, you'll see that when you use
the "ethtool --show-phys eth0" command for example, it issues a DUMP
request to the kernel.

I'll continue the review w.r.t the actual content of the messages :)

Maxime


