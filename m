Return-Path: <netdev+bounces-175732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A3BA67486
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E17161F2C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415920A5D8;
	Tue, 18 Mar 2025 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3g0mpQI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628923CE;
	Tue, 18 Mar 2025 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303296; cv=none; b=BMPDjbUTv7kp7Effe98lBYwbKw8Ee02sjob+3SN7bcMqEZqBlitp6ZsOgW8VNiLAk1Bx06zSpdp6UDn+54CVc/of+ohRWTkxW/NhnyRPbqXMxxPM0Cw6hoXOc7mi5NUT7rKaLiuPZfeL/qRSth8+jYCBhFuFGj8rJiFYFPOdIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303296; c=relaxed/simple;
	bh=Pon6ZKwwrC+U6MxMbq1amRb8ogvhn/n9bJp7XnTSRew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbrhKor634GAcAr4wKqMWMMlpw1qjgfKL2FSRj/2z3+NtFOfxtzvf95ygq2E4LF+C19vbSNdIsgHNoFBmIlVYYTRBMOJi36vALEJVxPNdonYypEqfowo5fUhSCjVAx+P4kSc2Mn+uFLdA+xesuDOnE5tGGXV5ZI7btkLRHrhn0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3g0mpQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56A1C4CEDD;
	Tue, 18 Mar 2025 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742303295;
	bh=Pon6ZKwwrC+U6MxMbq1amRb8ogvhn/n9bJp7XnTSRew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3g0mpQIO+GfEHfjfuW60k5RCi7NmPyKkR1vQQFgkCHGf96/FNsqoH3jum4s5XR06
	 g4Z3oeQHlmL8d1kkxpVcWMPF0kXRwtMkieyOEMgJZavYwICnoErTSyWoOavxQI1Zb0
	 dW+o96/Y9sQt/a6RCYuUFQ0Mh0V/iFaKOIK9giberoo0l6RnhoJ3JCl2UrGySLnCqo
	 2MBb+7W63qX/BHORwc7znWcImDpazO1zE/PZB1zxlpv3CVOhsX4V2tT0frKnsXb7Iw
	 xUnV8yVnZzcnsR/xaGwFuRhPDaiycmg+qnJ2mklaSc291CXv1y4KYeDPZywn51sznH
	 WkyBPHT8ECwXw==
Date: Tue, 18 Mar 2025 13:08:11 +0000
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wireguard: Add __nonstring annotations for
 unterminated strings
Message-ID: <20250318130811.GQ688833@kernel.org>
References: <20250312201447.it.157-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312201447.it.157-kees@kernel.org>

On Wed, Mar 12, 2025 at 01:14:51PM -0700, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to correctly identify the char array as "not a C string"
> and thereby eliminate the warning:
> 
> ../drivers/net/wireguard/cookie.c:29:56: warning: initializer-string for array of 'unsigned char' truncates NUL terminator but destination lacks 'nonstring' attribute (9 chars into 8 available) [-Wunterminated-string-initialization]
>    29 | static const u8 mac1_key_label[COOKIE_KEY_LABEL_LEN] = "mac1----";
>       |                                                        ^~~~~~~~~~
> ../drivers/net/wireguard/cookie.c:30:58: warning: initializer-string for array of 'unsigned char' truncates NUL terminator but destination lacks 'nonstring' attribute (9 chars into 8 available) [-Wunterminated-string-initialization]
>    30 | static const u8 cookie_key_label[COOKIE_KEY_LABEL_LEN] = "cookie--";
>       |                                                          ^~~~~~~~~~
> ../drivers/net/wireguard/noise.c:28:38: warning: initializer-string for array of 'unsigned char' truncates NUL terminator but destination lacks 'nonstring' attribute (38 chars into 37 available) [-Wunterminated-string-initialization]
>    28 | static const u8 handshake_name[37] = "Noise_IKpsk2_25519_ChaChaPoly_BLAKE2s";
>       |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/wireguard/noise.c:29:39: warning: initializer-string for array of 'unsigned char' truncates NUL terminator but destination lacks 'nonstring' attribute (35 chars into 34 available) [-Wunterminated-string-initialization]
>    29 | static const u8 identifier_name[34] = "WireGuard v1 zx2c4 Jason@zx2c4.com";
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The arrays are always used with their fixed size, so use __nonstring.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v2: Improve commit log, add cookie nonstrings too
>  v1: https://lore.kernel.org/lkml/20250310222249.work.154-kees@kernel.org/

Reviewed-by: Simon Horman <horms@kernel.org>


