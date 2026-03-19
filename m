Return-Path: <netdev+bounces-269276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C7OMe1ku2lVjgIAu9opvQ
	(envelope-from <netdev+bounces-269276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:52:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 293292C5291
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 762AF3152F6E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48900383C64;
	Thu, 19 Mar 2026 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqkFlHf9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521636BCC5;
	Thu, 19 Mar 2026 02:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773888504; cv=none; b=qAQUBJLynDKLZaUiBB2c64sUxV9rEugPGunBLjYfAjADWJA2a6PU89NNKwdLSoPiRZmv3K1gcwIwTrEd0PB+tAgdfhgNtwj/hrbCrL+23BbC7M1ow32wRPCqR/cd7s7ZTLC8XhCpu9jOXqGFSL8TJzZfFBReq9+UEkPoLBLW7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773888504; c=relaxed/simple;
	bh=gXRb3uW0LyPdgBbi0NfT/zpKPh+p2Te+mAtHa7RkgVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjvdCy1qBjdPOImT6NGiRtapDE+RUSyXk0HoZzcxVwEY5/yC8XSMbFP7zLlmnl15brwOz00DTpaUEpsoBY5+wefJ8Il7q4nE3K3uQug2JtqaqhdBCowMG3YZphTdYS9zc7iUxtGk0Fku3fS3vR+Lscpfv5Z6AeXmZIOiT8Jqaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqkFlHf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8D5C19421;
	Thu, 19 Mar 2026 02:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773888503;
	bh=gXRb3uW0LyPdgBbi0NfT/zpKPh+p2Te+mAtHa7RkgVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iqkFlHf9dyQoMihmcd7hRS1Patxl2G509XVdmnJLYm/yqy7032inX6PJp8q8ASzs9
	 6kkJktPo+dHJQk0as8Jp/J8diVvQ2k+Bqmw5yaVI2/GrAoeCWaS17yk+F2AwF+O+5H
	 cK/CaS3ge3MUvhMHWknNlM5kg0B1I7CnpMmeYYv6lz77t9jvSlTE8zK/KMFS3AkHzG
	 +xhJXuYZUjJdrohBLl8EQfmKd8jDoh3SewQlo1ZoBlK10xlARackZ9F+bmvS5QgxK0
	 0VsynnQGr+MwP3fxSPE7Y+zTnZDCUTr0w/zhnNtD0SwbchttLPH77/4ag/JEU10LAD
	 vR1Ywi6wZuRvA==
Date: Wed, 18 Mar 2026 19:48:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Ryabitsev <mricon@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, helpdesk@kernel.org,
 davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-03-12
Message-ID: <20260318194822.434c0485@kernel.org>
In-Reply-To: <20260315132013.75ab40c5@kernel.org>
References: <20260312200655.1215688-1-luiz.dentz@gmail.com>
	<20260314104436.31bcf68b@kernel.org>
	<20260315-majestic-beluga-of-fragrance-cf42c6@lemur>
	<20260315132013.75ab40c5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269276-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 293292C5291
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 13:20:13 -0700 Jakub Kicinski wrote:
> On Sun, 15 Mar 2026 11:04:47 -0400 Konstantin Ryabitsev wrote:
> > On Sat, Mar 14, 2026 at 10:44:36AM -0700, Jakub Kicinski wrote:  
> > > To be clear I have pulled already, if any of the AI reports looks
> > > urgent please send a follow up.
> > > 
> > > Hello helpdesk! The patchwork reply bot has not been replying to pull
> > > requests for us in the last few weeks. Is this an intentional change?    
> > 
> > It was an intentional change to make it work more reliably, but we clearly
> > failed because it stopped matching altogether. *sigh*
> > 
> > I think I found where the match was failing and added tests to check for it.
> > It won't work retroactively, but it should find future pull requests
> > (hopefully!)  
> 
> Thank you! I'll report back in a couple of days.

Since I promised - pw-bot replies to pulls seem to be working fine now

