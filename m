Return-Path: <netdev+bounces-255303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIC8GUZdfWnKRgIAu9opvQ
	(envelope-from <netdev+bounces-255303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:39:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B43C00AA
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F41513019BA0
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEBF3009C7;
	Sat, 31 Jan 2026 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8DBcGHa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997921EB9E1;
	Sat, 31 Jan 2026 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823554; cv=none; b=Zq8V2Acd9X4U2Ouvil+0DUTIV8lLgEpw/nRa1Zz0AGOlOPGZdIsJcIyWkojGOowyEyMhrxjr/wd+ZvAbzrPo5FCqY8gfW/o1BgQ++lX8vV8G9cOGv/la4TutOxBWpzs5ugkQK+9tyZdZyqEGwz7iylcWIRPfb7aqBkRuu16l4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823554; c=relaxed/simple;
	bh=6SlNB8cgPyUu9hhPZS1lDhOjHWkFpWa/jyYqlHaVXQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLUQ0AoAOu2COYrrXtfuEo/xbXZiPn5uUIKrxlKgTnJ5jscHd+8epBjvmnwm3oFcWnqoA/H4VFJBVEXtYfj0JyyFPL9ek6Q8XV8BCJ6wGxON25o3SP2QV+2dAbriR44RpR1BZocu7iXIIztTOvD8zsjCWp+1FKZJHXRb0XBWB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8DBcGHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3846C4CEF7;
	Sat, 31 Jan 2026 01:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769823554;
	bh=6SlNB8cgPyUu9hhPZS1lDhOjHWkFpWa/jyYqlHaVXQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P8DBcGHaEfoV7OtSDetv3BGCD4RwTQcj5oz5YFdg83bH31p7gD3mrXjP2XoeKrMPv
	 VYmzvMbbf8+JJHlfL0pxIVZt++OHQxBfFk0nNQkzRqTdW6p2TKOvAAKg+AltsDfYD2
	 AiDVdiB8vOPe7KPxjLhivaZ8WPtpcbLGBNXKkjFG791tY9t8vE+aN+bUqrLErcBpLv
	 uvywsoQtfdouGuWeTs4cgNg+1idY2E5M0NXo1jPRnV/LVm3No1Yvc6VXZvUupkRXPn
	 Uxt7CS2vQZUV0B7nglPVGGvvV1TdcgIUvnmzCRIalnMKh8WD6NbBovdRjEd/bzuXRt
	 Z7kB/1CW6BC4Q==
Date: Fri, 30 Jan 2026 17:39:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mscc: ocelot: add missing lock protection in
 ocelot_port_xmit()
Message-ID: <20260130173912.33ac6c54@kernel.org>
In-Reply-To: <20260130021258.95045-1-n7l8m4@u.northwestern.edu>
References: <20260130021258.95045-1-n7l8m4@u.northwestern.edu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255303-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1B43C00AA
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 02:12:58 +0000 Ziyi Guo wrote:
> ocelot_port_xmit() calls ocelot_can_inject() and ocelot_port_inject_frame()
> without holding ocelot->inj_lock. However, both functions have
> lockdep_assert_held(&ocelot->inj_lock) indicating that callers must hold
> this lock.
> 
> The correct caller felix_port_deferred_xmit() properly acquires the lock
> using ocelot_lock_inj_grp() before calling these functions.
> 
> Add ocelot_lock_inj_grp()/ocelot_unlock_inj_grp() around the injection
> code path in ocelot_port_xmit() to fix the missing lock protection.

Please add an appropriate Fixes tag and repost.
-- 
pw-bot: cr

