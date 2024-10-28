Return-Path: <netdev+bounces-139727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A1C9B3E8C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6B71F21F40
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B94B1F9AB8;
	Mon, 28 Oct 2024 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLZqu6YZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3271E0B62;
	Mon, 28 Oct 2024 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158637; cv=none; b=OFhFSa5sUaLTbJKii3ms2puFnDNu6KHWk1iUrD82LnbaglHNW3V0us+nGCo/YjImIbUuXq3pA41hfTGdILlkthR4kDeYeTatZ0btnjAMVv9kDZJsOV7OZ3M5jP3R8TjtKIz5wsdvPgbComaba+Wjt/WQlBpbo7F6OC5G58IsFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158637; c=relaxed/simple;
	bh=S47lYuLvJr2byEk7lZ68+wZXEnpqqU3QlilyzPP2pTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtbY041V7S5HIB2xh448GbZph7AOpAh/HA3rwP/oeH8U90g3GVRaP5f34jICxgzKRJ6ZfoGmjsnvzq2E1w8SQFox+W7B275lSabGyjsrccNrXTTF1G5rOnPpAHw/30rYsQ0VPIPQ3F9Yw57e+a+D2J4sBFGQPhtg6uB4hiHOIp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLZqu6YZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1313C4CEC3;
	Mon, 28 Oct 2024 23:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158637;
	bh=S47lYuLvJr2byEk7lZ68+wZXEnpqqU3QlilyzPP2pTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLZqu6YZKO6pIOVA84u2CXTBq/CHtCq7is5wPbCe6aEDMmS5kdRP6uXbjz0u9+Fwo
	 P3ofV5oNNwlSvahrN2hCm+M7mWgv0NwNu112S5CWcRp2osulnb33UVoFVO/mvIqa+9
	 Sc9/vfMJCLfS29o7yCvvPlU+eaSNQvGmOgkjJVPHIOdIJhQWX/nI4LLp8NXpH9Cq2z
	 4vliL78nJRLeRV3A9MgXLpPhF8VojI3vbelczSz2RXq/rtSedS2WLNvf+Ko1T3n1BX
	 MA9bHIBBARLbzpOnLFNcCUjmzuMpbbhoNKmUJahb2f6qVJ6fpQK6hr1lVqD+kNcpcK
	 ZDeD1Hfb9Z4yQ==
Date: Mon, 28 Oct 2024 16:37:14 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 4/4][next] uapi: net: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <202410281637.68A4BCF7@keescook>
References: <cover.1729802213.git.gustavoars@kernel.org>
 <cc80c778ce791f3f0a873b01aecb90934d6fd17a.1729802213.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc80c778ce791f3f0a873b01aecb90934d6fd17a.1729802213.git.gustavoars@kernel.org>

On Thu, Oct 24, 2024 at 03:14:31PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Address the following warnings by changing the type of the middle struct
> members in a couple of composite structs, which are currently causing
> trouble, from `struct sockaddr` to `struct __kernel_sockaddr_legacy` in 
> UAPI, and `struct sockaddr_legacy` for the rest of the kernel code.
> 
> include/uapi/linux/route.h:33:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/route.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/route.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end
> include/net/compat.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/net/compat.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Also, update some related code, accordingly.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right, including the helper prototype update.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

