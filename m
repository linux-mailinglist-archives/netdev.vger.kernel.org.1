Return-Path: <netdev+bounces-252922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHW9MWm7c2kmyQAAu9opvQ
	(envelope-from <netdev+bounces-252922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:18:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF03979788
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D40C3005145
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CBE238C3A;
	Fri, 23 Jan 2026 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzYJ0KFi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F1224B0D;
	Fri, 23 Jan 2026 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192289; cv=none; b=QgcpMJBlZiLgkxQmw3EB1uryxYfaXqyC0/3YSx+LVyn/mD/VBd0KzSS/xZ32xu1ijVpYfFTodHedg6fGn2YxGChcu95gzriDTn6D+VB3uqPZ3II+dFpVSjwDWOSGxbEkTRB/tvBGBV9qLnuhn2rk7m/PXgDUfGIxo+93GmKVDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192289; c=relaxed/simple;
	bh=UEuHx87ZZEm8hexpXkkqEvJojoLXTwN3WFioWloockw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6hD9zIApxEXAcbqloj83/lj+h7f1DC5Vsc2Pj+jAQoV/E/BLlZFzgMUBvLPAeq/L16nVxRao3bqB3ZmIYqcgXQqPW2x9ZgMwcSp88/H4C6RHB5pPRZNFEeKGmd2yS8B7cL9bX2D+I7VpbADlv0iyQOSGSM81zOZfYTf3J4gufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzYJ0KFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C228C4CEF1;
	Fri, 23 Jan 2026 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769192289;
	bh=UEuHx87ZZEm8hexpXkkqEvJojoLXTwN3WFioWloockw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PzYJ0KFi0sEqqdSIukQrUe0FLsC32uI2BkRc3zNX5zvm39IdjQEcIrgHUosm5aU4i
	 Mgv5we8FxnTzleMdeEbSssxjqyNJEbXnXJ8vxqcaXoAkobZNVouYEo/9SHY6bBVlRH
	 u3/TboJmTuPpfyEQWFxG+zMICg3usGFCsbM6Rh6WwsvzWlHOS98Zb0ss0WboljgqyF
	 4Bi1Y/CIbzPjYxcu/URDa4/9f/Sd5szV/8T3VVDRDuqr1fJiYDjWk4F2BfFteJNcGM
	 gKJX0/Liqq0l5HiQSn40AoWA4xmVZp23BGEymDjZgFpHwSE1HcTN9SnFyplKaAfQwc
	 8oDk4or1iRhpA==
Date: Fri, 23 Jan 2026 10:18:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>, Ethan Nelson-Moore
 <enelsonmoore@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: remove obsolete file entry in NETWORKING
 DRIVERS
Message-ID: <20260123101807.27beafe7@kernel.org>
In-Reply-To: <aXOsp3T2BC5Gxzaj@horms.kernel.org>
References: <20260122074609.151058-1-lukas.bulwahn@redhat.com>
	<aXOsp3T2BC5Gxzaj@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,lunn.ch,davemloft.net,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252922-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF03979788
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 17:15:19 +0000 Simon Horman wrote:
> On Thu, Jan 22, 2026 at 08:46:09AM +0100, Lukas Bulwahn wrote:
> > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > 
> > Commit d8f87aa5fa0a ("net: remove HIPPI support and RoadRunner HIPPI
> > driver") removes the hippidevice header file, but misses that there is
> > still a file entry in MAINTAINERS referring to it.
> > 
> > Remove the obsolete file entry in NETWORKING DRIVERS.
> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>  
> 
> Thanks Lukas,
> 
> I agree this is the case.
> 
> But unfortunately our CI seems to be confused about which
> tree to test it against. So could you resubmit targeting net-next
> like this?

It's alright, we don't really have any tests for MAINTAINERS in the CI,
anyway.

