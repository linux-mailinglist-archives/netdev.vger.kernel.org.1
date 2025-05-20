Return-Path: <netdev+bounces-192056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F4BABE6A7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 00:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB1E4C5689
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 22:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931FF217F35;
	Tue, 20 May 2025 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="W/qhqyL0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCB25C817
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747778405; cv=none; b=WZelE9WL9h2sW//cwKw0Rjr6c2BbHzrD65Xu79gDLlST8J40f36Jjmt6flVf2JmHudoYVnu4zJvRpdO59mb/ifedrONPAjiPd0zUI7dBrmkA8S8Vs/bLAtM4+kFI4+leEvfnCtw3Af5O4tfiAmYSBFhKYTeUlmLhiAaaaSGo1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747778405; c=relaxed/simple;
	bh=pSy2fPX0smSmavL4n2WlB/VCRbL6QG+iDI4/OIPescM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNUHUY3DldreBQxTaMbt2MNt+/S2Xw4jFE4rt2+Si6qmko2QuayC2Z6UNYStnRTRk+3gQDhXjh56IborF+s7CGEU19qTHrAdx40aPHGXl/xjNZUlhVFG6NFft8KqeeTn7hJO5McfyagH9pqyMP8vJFeTGJkrC3/8rxQETVyWaLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=W/qhqyL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3135C4CEE9;
	Tue, 20 May 2025 22:00:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="W/qhqyL0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747778403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxbM0kES0op3KAnd4+qfiYzc3gghdR4qokMBOHpYeyA=;
	b=W/qhqyL0UW0b4zswpATwJRVWGgaW6Q+io8viV5DKG1KK8l3V6eikZRPqgB28ImghZUMc3Y
	l8+49Ty4Gsppj5dSN0kbsd65poVqizQkMe78WVXEJ8xIZH9u0p1xblc+qUbaZswS1dWHNr
	anCev7hF2hpm4iog/Wxlx4LFfI3tqdg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d9bd13f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 May 2025 22:00:02 +0000 (UTC)
Date: Wed, 21 May 2025 00:00:00 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jordan Rife <jordan@jrife.io>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RESEND PATCH v3 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
Message-ID: <aCz7YEp5-Viktx7W@zx2c4.com>
References: <20250517192955.594735-1-jordan@jrife.io>
 <20250517192955.594735-2-jordan@jrife.io>
 <aCz4jK9i-N6e5xk-@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCz4jK9i-N6e5xk-@zx2c4.com>

On Tue, May 20, 2025 at 11:47:56PM +0200, Jason A. Donenfeld wrote:
> Hi Jakub, Jordan,
> 
> On Sat, May 17, 2025 at 12:29:52PM -0700, Jordan Rife wrote:
> > * Use NLA_POLICY_MASK for WGALLOWEDIP_A_FLAGS validation (Jakub).
> [...]
> > +	[WGALLOWEDIP_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGALLOWEDIP_F_ALL),
> 
> I wonder... Can we update, in a separate patch, these to also use
> NLA_POLICY_MASK?
> 
>    ...
>         [WGDEVICE_A_FLAGS]              = { .type = NLA_U32 },
>    ...
>         [WGPEER_A_FLAGS]                = { .type = NLA_U32 },
>    ...
> 
> Some consistency would be nice.

Perhaps I'll commit something like this?

From 22b6d15ad2a2e38bc80ebf65694106ff554b572f Mon Sep 17 00:00:00 2001
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 20 May 2025 23:56:18 +0200
Subject: [PATCH] wireguard: netlink: use NLA_POLICY_MASK where possible

Rather than manually validating flags against the various __ALL_*
constants, put this in the netlink policy description and have the upper
layer machinery check it for us.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/netlink.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index f7055180ba4a..b82266da949a 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -24,7 +24,7 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 	[WGDEVICE_A_IFNAME]		= { .type = NLA_NUL_STRING, .len = IFNAMSIZ - 1 },
 	[WGDEVICE_A_PRIVATE_KEY]	= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
 	[WGDEVICE_A_PUBLIC_KEY]		= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
-	[WGDEVICE_A_FLAGS]		= { .type = NLA_U32 },
+	[WGDEVICE_A_FLAGS]		= { .type = NLA_POLICY_MASK(NLA_U32, __WGDEVICE_F_ALL) },
 	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
 	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
 	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED }
@@ -33,7 +33,7 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
 	[WGPEER_A_PUBLIC_KEY]				= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
 	[WGPEER_A_PRESHARED_KEY]			= NLA_POLICY_EXACT_LEN(NOISE_SYMMETRIC_KEY_LEN),
-	[WGPEER_A_FLAGS]				= { .type = NLA_U32 },
+	[WGPEER_A_FLAGS]				= { .type = NLA_POLICY_MASK(NLA_U32, __WGPEER_F_ALL) },
 	[WGPEER_A_ENDPOINT]				= NLA_POLICY_MIN_LEN(sizeof(struct sockaddr)),
 	[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL]	= { .type = NLA_U16 },
 	[WGPEER_A_LAST_HANDSHAKE_TIME]			= NLA_POLICY_EXACT_LEN(sizeof(struct __kernel_timespec)),
@@ -373,9 +373,6 @@ static int set_peer(struct wg_device *wg, struct nlattr **attrs)

 	if (attrs[WGPEER_A_FLAGS])
 		flags = nla_get_u32(attrs[WGPEER_A_FLAGS]);
-	ret = -EOPNOTSUPP;
-	if (flags & ~__WGPEER_F_ALL)
-		goto out;

 	ret = -EPFNOSUPPORT;
 	if (attrs[WGPEER_A_PROTOCOL_VERSION]) {
@@ -506,9 +503,6 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)

 	if (info->attrs[WGDEVICE_A_FLAGS])
 		flags = nla_get_u32(info->attrs[WGDEVICE_A_FLAGS]);
-	ret = -EOPNOTSUPP;
-	if (flags & ~__WGDEVICE_F_ALL)
-		goto out;

 	if (info->attrs[WGDEVICE_A_LISTEN_PORT] || info->attrs[WGDEVICE_A_FWMARK]) {
 		struct net *net;
--
2.48.1

