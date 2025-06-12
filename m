Return-Path: <netdev+bounces-196756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589A0AD645F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D707ADFEB
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D95258;
	Thu, 12 Jun 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRBYFz4d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAB2905
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749687342; cv=none; b=ry8oz1owqnz4YnQMpQYu0Imzt42Mql3ez6ywyTDbYuzGn1Nu2ZvunOIareTX75Y8YiKmaEOsTdbLjuRfPY4kSvSzAEqTdLn/cv3DeNmslvtOf1lC0NHHOM+4boP7ie/vdWQhrQ3UWf11CdH3/yBa0Ao+G3A3tJjLq5sm47fpDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749687342; c=relaxed/simple;
	bh=NxE9w9QgX6Kb/IZTsH0RyK3SM7IfEBG3xP9vxtzbqes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rP7vbIlc3c9pwcxVj9s3DSwG1+RyLePQBAQU1ZllTnPxSlLP4Uqb++g5WmlG3SrlB2VsSbw0LqKrjNqyK7+phUpok1c9O4ZG8HmVrzQzrnISXdE//tahkZPP2SHXkmR9iTGc5M5CaOTk/vIZ3dz0DOcRE1mDfmHwhJzlBOWGZ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRBYFz4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F1BC4CEE3;
	Thu, 12 Jun 2025 00:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749687341;
	bh=NxE9w9QgX6Kb/IZTsH0RyK3SM7IfEBG3xP9vxtzbqes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gRBYFz4dDxLPqsAay8WOnVyfVFKYMAENqd3ZZWWJDJJlOQ1J9Ac3IfmIDqRjxoGBx
	 z9L+iC4BASnf8efHf6MPQtmnV+XO1em5YN/K8v0DLnjvli4Zed9Jmo/GVCWC7WDw7O
	 b9xVjuv7XX5P0xavC1jRNBUF87fcmBIDBEAPOUfsHZxUmWMWfPlvVhHQ1R0btpxWvZ
	 FYMbwfZ5EYBwF5hyG7+P77X4BLZBqeORTTWHX4r1+Huxd9tuPd+sHJDU+iR0OF0E6B
	 Q98XS/bkH3V3wcktpU3RDwAehlb+b4NT2KTExk2RANEHCJeZCNH0rptX39JRtl5iV1
	 EHp70zOXttsdQ==
Date: Wed, 11 Jun 2025 17:15:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Alex Lazar
 <alazar@nvidia.com>, "Dragos Tatulea" <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 1/2] net: vlan: Replace BUG() with
 WARN_ON_ONCE() in vlan_dev_* stubs
Message-ID: <20250611171540.27715f36@kernel.org>
In-Reply-To: <20250610072611.1647593-2-gal@nvidia.com>
References: <20250610072611.1647593-1-gal@nvidia.com>
	<20250610072611.1647593-2-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 10:26:10 +0300 Gal Pressman wrote:
> This code should not be reached, as callers of these functions should
> always check for is_vlan_dev() first, but the usage of BUG() is not
> recommended, replace it with WARN_ON() instead.

Did you try something along the lines of:

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 38456b42cdb5..f24af2988fd9 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -81,7 +81,8 @@ extern void vlan_ioctl_set(int (*hook)(struct net *, void __user *));
 
 static inline bool is_vlan_dev(const struct net_device *dev)
 {
-        return dev->priv_flags & IFF_802_1Q_VLAN;
+        return IS_ENABLED(CONFIG_VLAN_8021Q) &&
+               dev->priv_flags & IFF_802_1Q_VLAN;
 }
 
 #define skb_vlan_tag_present(__skb)    (!!(__skb)->vlan_all)


This should let the compiler eliminate the dead code completely,
assuming it truly dead. We can still replace the BUG()s as 
a of cleanup but I think the above is strictly preferable as 
a solution to your problem?

