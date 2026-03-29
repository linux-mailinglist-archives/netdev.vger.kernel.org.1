Return-Path: <netdev+bounces-272964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFb7Ik9ryWnqxwUAu9opvQ
	(envelope-from <netdev+bounces-272964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:11:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CADE353909
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 837E43002B3D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3402E27281D;
	Sun, 29 Mar 2026 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQbJ0d7m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112541F7916
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807885; cv=none; b=ZhCBKP5nsiNNEC5vuGY6dIH5t8ERS0fJVwURQBEcEVVpBwcuXKkHGVq1AgLWVtXw2yz9DoF1RqZFdneAYBFQkoAVnYyW4P7/FRG1g7OIVOuFXDsGXaq2Ht2grabvbYhbwae34q7ZEgHmEHbosQP5lkR4tgFKSeA8DOnApxHXBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807885; c=relaxed/simple;
	bh=LafMpKW3NSnJa5FfLZmmzqltgjxT9kZoM/+zl6NnOfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5cqCC1xroCCBUDS2TDB7KKemFTTSem6KrhVyti7HjXUvAJlaJc84YNUC7LFg9fm4YFHoyYEGCKpu2A4uHbWVgag+Ang2pnp0TsrLZu5ScHG//naUSjJ/GKvhhVENAR7dTBUKsc6WaYovX/op3thtHb1LaqsE43LpFI4lk60Rfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQbJ0d7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C467C116C6;
	Sun, 29 Mar 2026 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774807884;
	bh=LafMpKW3NSnJa5FfLZmmzqltgjxT9kZoM/+zl6NnOfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LQbJ0d7m1/4MbRj5Gfe3XxX/23mxGIieJS6s4DaYHm+Hy+HdfBeqs77lESjTdVKM1
	 kLcU88DlmdETb6SoRTQ4+OyHSjoapDFHBEge2uuxUKb1o3xXGf6p1GuFmMOaKQtLO9
	 xXOXSvM6pn71TueIDWkAkVDJpL2US9YS3eRalTUuzwedoDvXsz75Le3501eDcZXjzK
	 RWe0z6zORWeLKVgYFCiWkSZLsOIkdj3A5ZtgTZAmTb7y2dMRisBDtNZSJDJ5IVrwrh
	 jKT0plrGbQ3ctfzbGza+89J2IVfsQdVX5AUR+x+XjZMtw9ZMLDajWVUTrIyWTZTYjk
	 wqVk4LEnc1eJg==
Date: Sun, 29 Mar 2026 11:11:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Ong Boon
 Leong <boon.leong.ong@intel.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 00/10] net: stmmac: TSO fixes/cleanups
Message-ID: <20260329111123.740bada9@kernel.org>
In-Reply-To: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272964-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CADE353909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 21:36:21 +0000 Russell King (Oracle) wrote:
> Hot off the press from reading various sources of dwmac information,
> this series attempts to fix the buggy hacks that were previously
> merged, and clean up the code handling this.

We have a limit of 15 outstanding patches per tree.
Please follow the community guidelines.

While I have you - you have a significantly negative "reviewer score".
You post much more than you review. Which should earn you extra 24h
of delay in our system. I've been trying to ignore that and prioritize
applying your patches but it'd be great if you could review a bit more.

