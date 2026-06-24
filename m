Return-Path: <netdev+bounces-301656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4HUVMPPXO2pLeAgAu9opvQ
	(envelope-from <netdev+bounces-301656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:13:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1358C6BE7A8
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:13:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301656-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301656-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 350C83038A5A
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAEB3B19B1;
	Wed, 24 Jun 2026 13:10:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16513285C8B;
	Wed, 24 Jun 2026 13:10:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306640; cv=none; b=DqVqByAHzCeYE5ZZC387zUZZ0pOpNN+17SOa27Do4PNWTRiYD/VaA1neEWViOj0vzASl8GuFRhYo2fqQ5DNXIgj2xlcLemjOZ90TS9Za3FgGUou1muueHJ/JKyvSMFB2RiK+oWyNJXpjfKEq42GYE/wZ3HmbOltuobLon1uMvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306640; c=relaxed/simple;
	bh=Dtqkm98qhW+borrxFVxoJCwjgCy+xhriedBY9aDty/M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qiBIhNJmJfr4MgiEMtYK9kem50zoEvJelfyZ+u2Tx5EepYfMzD49Yu85AGfjL8hjDMSv9BFbpW4gHeSCKxyDdR9i+ng9LZmqSVlS3sAoqibn6EPUXd0LcMnBYVPOBYrGkFaSWa1y9mGINlctcQRD31zxHyBoi3rHisdVbUjNh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9937492009D; Wed, 24 Jun 2026 15:10:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 95E2892009C;
	Wed, 24 Jun 2026 14:10:36 +0100 (BST)
Date: Wed, 24 Jun 2026 14:10:36 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] ethernet: 3c509: Improve style of pnp_device_id
 array terminator
In-Reply-To: <a0cd057e6a24b9d355b5e4bdfcdb812cdd1e4652.1781082923.git.u.kleine-koenig@baylibre.com>
Message-ID: <alpine.DEB.2.21.2606241407580.58268@angie.orcam.me.uk>
References: <a0cd057e6a24b9d355b5e4bdfcdb812cdd1e4652.1781082923.git.u.kleine-koenig@baylibre.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301656-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[orcam.me.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,orcam.me.uk:from_mime,orcam.me.uk:email,angie.orcam.me.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1358C6BE7A8

On Wed, 10 Jun 2026, Uwe Kleine-König (The Capable Hub) wrote:

> To match how device-id array terminators look like for other device
> types drop `.id = ""` from it and let the compiler care for zeroing the
> entry.
> 
> There are no changes in the compiled drivers, only the source looks
> nicer.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> I'm currently working on changing various *_device_id definitions.
> This patch is irrelevant for this quest and a pure style update for
> consistency reasons without further dependencies on it. I just stumbled
> over this while working on that quest.
> 
> So if you don't like this patch, I won't insist.

 Absolutely fine with me, though I can see it's been taken already in my 
absence.  So for the record only:

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

 Thanks,

  Maciej

