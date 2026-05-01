Return-Path: <netdev+bounces-283198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCaVD1e39GmvDwIAu9opvQ
	(envelope-from <netdev+bounces-283198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 16:23:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A03664AD326
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 16:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54C9B301C91F
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361B53CA4A3;
	Fri,  1 May 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9LKDR2d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198426299;
	Fri,  1 May 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645394; cv=none; b=VOWOteHCzrbJLYzem4G2bPQxQQul4ZLdXQcr7Z9m6golzP1ZvSimY2cK62QQAdt46HiunfE8mTKhmWDOYjSH98Hj6lrcXH6AP4nDTCoNcYI4xQ4wXnCHGRc1xrFHauQ/2+SEbIyB09RTrfyFzSFQskQ5eW53+RdEmndPa3g8fVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645394; c=relaxed/simple;
	bh=Smd/rDia6/nukcgc5tyDQ3wBy/rH5UJM3WMmLWBD+mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGzHA4gJM5dcyEIWq296Ubf6ttV40I2k0Io5eYMH6W4sYb8ARo2YLv41aX3SK2yXfOSMXVXB3kKWlEscIvgGQpdQQbeiaS3FFvy1aCsKhdIO9SB7jL1oOfo4vpStsi0YManGzohTAp7qAVEtIhTISn80RmDs8aBv2qDrjd4u5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9LKDR2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD87C2BCB4;
	Fri,  1 May 2026 14:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777645393;
	bh=Smd/rDia6/nukcgc5tyDQ3wBy/rH5UJM3WMmLWBD+mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9LKDR2d6gsBX6QqOOccZD17ZJx03+uWeiHgdbRhJkcC61conJFeWYqpV94GoYdCt
	 JioZFWaK8TOoT9wt6WLi+ZsZzjDStVHYoOGEszwpdIqrEja5Nr+f/eY9PeRuEJbE0t
	 fLMfCyw4E2dRTqI3M3MBqbBqiuy6ZJmYknjs1MKSz8lKbTGbt4qMz3VxzJV8H8189t
	 +mW5tZEwBXsTUeTToIroir9gSzL45W4c/PXQcko0KJ0C5HPOQOoozOQolxskudlxZ+
	 ogtb5777WJFme6hMzB0v+SM1txVGhEOWMs8bfw58pQDX/uCuEgoFvuFFaQqv3uAb4+
	 bUSgdhpxvO+/w==
Date: Fri, 1 May 2026 15:23:09 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] ne2k: fold drivers/net/Space.c into ne.c
Message-ID: <20260501142309.GG15617@horms.kernel.org>
References: <20260429145624.2948432-1-arnd@kernel.org>
 <20260429145624.2948432-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429145624.2948432-2-arnd@kernel.org>
X-Rspamd-Queue-Id: A03664AD326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283198-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,arndb.de:email,sashkio.dev:url]

On Wed, Apr 29, 2026 at 04:55:46PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> drivers/net/Space.c is the last remnant of the linux-2.4.x driver model
> that required each subsystem and device driver init function to be called
> from init/main.c explicitly, before the introduction of initcall levels.
> 
> In linux-7.0, this was only used for a handful of ISA network drivers,
> with the ne2000 driver being the last one.
> 
> Fold the code into ne.c directly, with minimal changes to preserve
> the existing command line parsing.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd,

FTR, that there is an AI generated review of this patch available on
sashkio.dev. I believe that covers only pre-existing issues. And I do not
believe that review should block progress of this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

...

