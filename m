Return-Path: <netdev+bounces-307768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oizKJSCXV2pMXgAAu9opvQ
	(envelope-from <netdev+bounces-307768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 16:20:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8E75F4B4
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 16:20:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fO9iLDf8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307768-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307768-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 305C5320BDDB
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A64379EE6;
	Wed, 15 Jul 2026 14:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846836F917;
	Wed, 15 Jul 2026 14:10:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124644; cv=none; b=uymLt9RjhhIb7njHcrsFPumUxFP7/SNuQ/jjIVCvCVxvJjYpl40pPGUB9JJwI4YKSuSPZVj8wQBMQ+QrzKxzTMbbfNponBqzDg2RPsJmT2MrQcLK0Aj+Ix2RTPHdS19ijSEnnHccBiRuEa+0hSabO9n4xOLg2kegHjGF6Y/Q3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124644; c=relaxed/simple;
	bh=+aJz7PZcVA4Xrnsogo+iBtFx9mlHz5aSD9xeYsDbo1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrBMbIiZaaOz3e2hKFylBR/+nOQspAZpByGkRcULiimFNWvZ8jmn9gCKOdSA5pCSp5xtxwGeQiw10LyMk0fg6uRVK0kNGbLHgTNoM8fP07DyI/MPYLJ3y3k8WKYPaDgLFKP57xDDR9t/KnklMUmPZc54RrzxeA7XhNGv38M/5Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO9iLDf8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E151F00ADB;
	Wed, 15 Jul 2026 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784124642;
	bh=6LfNdYaHzdWk/R4/yI03R3JZ5No2In+2bilqSUP9Fjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fO9iLDf8X4IUWTd3ekthRDpUak7xVmX6WQ+x842pMmtYXBVNXpNa27OXU450ZMG1a
	 PILck6Llt5jPwQeBSJXkCEnFoQSSlX9m2q/36oXbPv9dWcRZLnjyI7n1JevUPPk0cO
	 fmaFNr4q35ywfHsrBOO9K29q79SudQSf7vBB8+tifsOPTUYlMId4+yqg+DlisDy0zb
	 0flhYYjSVEu4WeAdSvcJJgpmuCw6FtBeakrpnjkzWqE721hpWNVdUm/XQ8kTm4UOjq
	 KRt/k787GciS1vvkm58Nh9LhVAYR3r5ETyPOSGtnyIRztpySvMxSkO9Wpi5BEVi3Gy
	 1yOtLmgqVlqdA==
Date: Wed, 15 Jul 2026 15:10:37 +0100
From: Simon Horman <horms@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa2-switch: put MAC endpoint device on disconnect
Message-ID: <20260715141037.GP1364329@horms.kernel.org>
References: <20260708111025.749311-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708111025.749311-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307768-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:ioana.ciornei@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDA8E75F4B4
X-Rspamd-Action: no action

On Wed, Jul 08, 2026 at 07:10:25PM +0800, Guangshuo Li wrote:
> fsl_mc_get_endpoint() returns the MAC endpoint device with a reference
> taken through device_find_child(). The switch port connect path stores
> that device in mac->mc_dev and keeps it for the lifetime of the connected
> MAC object.
> 
> However, the disconnect path only closes the MAC and frees the dpaa2_mac
> object. It does not drop the endpoint device reference stored in
> mac->mc_dev, so every successful connect leaks that device reference when
> the MAC is later disconnected.
> 
> Drop the endpoint device reference before freeing the dpaa2_mac object.
> 
> Fixes: 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


