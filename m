Return-Path: <netdev+bounces-267662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOI8MqvCtGnIsgAAu9opvQ
	(envelope-from <netdev+bounces-267662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 03:06:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2644C28B577
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 03:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB96308011E
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 02:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3B1299948;
	Sat, 14 Mar 2026 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwVhcdiR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789D86347;
	Sat, 14 Mar 2026 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773453992; cv=none; b=a8mNITs7LIxF4W+K8WA4azMTT0XS3OncJgZJVWivRb4rlSQAJZEfX5it+8MAf5utKrrbxdxbhkEFx5Urcre0Qo8Bzu3K/A8kylru/2P9i0wurWc5t34y+KJg0Qyg+ep2MeG8q1xLZGc9+LZw1v77F5cLOl22Pu89bwL8LVd1WbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773453992; c=relaxed/simple;
	bh=TaoqLmhFTp+2G8IAUKVxS5UJq6b/wRlGCy8vRApHfvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwe+Fxaql9iZDqAUVc15WklYj59eKI0DruTUNjWxXG3cy6K5TTQ6yioRGhP6HH+Q/xFJo8toSXLGGH5zFKO38fmvBCb9nW7BZ9zOPTY2rW1fiE9gjo5sDS57k8586HUlbshl4IC0klJvxW0OIn56t5FyZRupUuF24Sd3fx36Vhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwVhcdiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB7BC19421;
	Sat, 14 Mar 2026 02:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773453992;
	bh=TaoqLmhFTp+2G8IAUKVxS5UJq6b/wRlGCy8vRApHfvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NwVhcdiR0YcTa1uCutV3d7SrpDZyQAs9iEqr1S15zTQgffOvtASk57C3FIdxSir2H
	 spkL0CpIPa55Shz83PcMwqXJDHDMZAGH2n3khFMVFkQ0y3+YZ88Of35jaJqeZGyZ0l
	 Kr88gWhOFw61z3wMRHAZ8F/79Tf7pgyXqmwlbmdL2b7WnLyVfa+AkWBNGaDbwwTs7F
	 EdKuOKkhsQvAVxbzMqNY3TBU5s0+iow6iJT2WNEpT6/d9YUmff5edZUXtH+jEjk1b+
	 w2BXQ7+FR95xIzOThdNxlukTgk0WTC9CpwAUJvz65RP25L9ajX6u/s/VlpHSHlW2y+
	 c2Y13CPIRht8A==
Date: Fri, 13 Mar 2026 19:06:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: <netdev@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: macb: set default_an_inband to true
 for SGMII
Message-ID: <20260313190631.382df727@kernel.org>
In-Reply-To: <20260313142140.4040647-1-charles.perry@microchip.com>
References: <20260313142140.4040647-1-charles.perry@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267662-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2644C28B577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 07:21:39 -0700 Charles Perry wrote:
> Most platforms using GEM in SGMII mode use in-band autonegotiation
> because it is on by default in GEM's 1G PCS and is always on since
> commit e276e5e40e92 ("net: macb: Disable PCS auto-negotiation for SGMII
> fixed-link mode"). Leave it on if possible using the "default_an_inband"
> flag of "struct phylink_config" so that platforms that lack in-band
> autonegotiation configurability at the PHY do not break with commit
> 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled") which
> will turn off in-band autoneg for non hot pluggable PHYs.
> 
> Once the majority of the PHY drivers that support SGMII have the
> ->config_inband() callback, this commit could be reverted so that non  
> hot pluggable PHY use outband negotiation with macb, like its the case
> for other MACs.

I'm assuming this needs a respin now to account for the erronously
merged patch?
-- 
pw-bot: cr

