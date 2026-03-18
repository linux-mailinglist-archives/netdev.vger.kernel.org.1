Return-Path: <netdev+bounces-269200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFr3MAkju2lofgIAu9opvQ
	(envelope-from <netdev+bounces-269200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:11:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 224A02C3461
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE080304409E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04EC351C18;
	Wed, 18 Mar 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4duqbzZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC02DF12E;
	Wed, 18 Mar 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871878; cv=none; b=PaGX73E+zhEeM8KBI7qsJS0btbN8RGHG/EzwjgphQzTHprcIgoT1d8FLNgA1Rg65jjOGdZWCBADvCh6CZPSakhBCUQ1LMG22fqO1ODCDH4vEQI4u+9/Z3IHI5AuX8E0004x7RNiT4E6BZvwCeyBVFC05jSE4kEAfBsKRRLWcBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871878; c=relaxed/simple;
	bh=OVSmFm1cxnMXBULW+h02G6KqeZnD/e7FBfBURnvLEiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttuH/ctVaCZIg2/F8HcIn8R0Bnr1E9dhzM0xIoTt5MizAz5PHmkEP0Ui4QEiF2qFbeny2sSU3HOiN63rEIBJrhu7eIJMmxWJlsjv424IOm4BCZlWTAvD4LYn/hQdCgWXJUNmXbkX+QtuVgRusJO4YhPE5FJxTMxpnOxF1UgdIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4duqbzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A33C19421;
	Wed, 18 Mar 2026 22:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773871878;
	bh=OVSmFm1cxnMXBULW+h02G6KqeZnD/e7FBfBURnvLEiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b4duqbzZ6dPyvqlo96pGqHMcKTr8KBAq0gc8VHiZQrSmaV5QlSyvVe1W3icpB12Ll
	 wkEOH0te/x7TGwFhJo62xaw2nNqRWV1l3rjzq7KIvnMSNpEB3lsA8xT8WAgAo7nCkB
	 wzgilKy/kmD+EITG2iwlynV6p1spl3SEpb/sT4/u+PNk0EGhjNaKpVb1X6RvqOFHp5
	 mU7GKduQrpI6PPsMvT5SW7y9uWFyJgfKeKFs63K7qeAyXaTNKgi5juJEm2oJjwOjYo
	 2V6p7TsL1NkawDAmNpPzhBjcZRV67X2Bettj6X+eM0TnIVup/bnWGNjFgrRmZLh9rS
	 jo9JmwcKhD1yg==
Date: Wed, 18 Mar 2026 15:11:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <rmk+kernel@armlinux.org.uk>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] stmmac crash/stall fixes when under memory pressure
Message-ID: <20260318151116.665400cb@kernel.org>
In-Reply-To: <CAH5Ym4iaBkFsAH6e9UgHbxOEs8D6-Tcq9so0HJ24GFfmnQiUiA@mail.gmail.com>
References: <20260316021009.262358-1-CFSworks@gmail.com>
	<20260317202718.3a5433c4@kernel.org>
	<CAH5Ym4iaBkFsAH6e9UgHbxOEs8D6-Tcq9so0HJ24GFfmnQiUiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269200-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.911];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 224A02C3461
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 20:46:00 -0700 Sam Edwards wrote:
> > Please have a critical look at the commit messages.
> > They are very bloviated and not slop looking.  
> 
> Thank you for saying my messages aren't slop. :)

Typo, of course. Are you saying you haven't use an LLM at all to write
these patches or commit messages?

> I'll try to dial back the verbosity, though. What kind of bloviation
> do I have? Should I be leaving off more context, or should I focus
> more on preserving the same detail but using fewer words?

IDK, writing is hard. I read the commit message for patch 1 and I felt
like I understood less than when I started :S Try to imagine you don't
know the code very well and think what information is crucial to
understanding the change.

