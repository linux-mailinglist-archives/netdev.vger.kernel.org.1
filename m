Return-Path: <netdev+bounces-176184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED57A69447
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199AB7A8E9B
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC781DB34B;
	Wed, 19 Mar 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jazZvQ5q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156131A841C;
	Wed, 19 Mar 2025 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400285; cv=none; b=KDkReoERVNcFVPA65re1uitbWS8fc5oId+IhE/g+HTFRtCKvnJQaskIMvRgAiw4oc+K8RJwb3bVwa/T7LVEUFA3ZoyIsL643+/JAvsgY3tEDpCa55HIWQjUAKohgOnXSLWgo1DOVr9P5VgsCdq3+PzmB+X/Ylp3AJvhYAcDJFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400285; c=relaxed/simple;
	bh=sgXflDBGJnAaJSuAaHBQeadUNQ0qTm/T1gyi9pWV0Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXO+2nnb3LT+2oRO0RpCoI5j1YhoVvruSyiDrhSmbXwxF43uD/LxYbGR4ByO6/HSH+JmO/xiAbiRgSeYkioirQlFNYJG+NWQJMCoBdc19XR0hSzNMa2qnHEr8H1vNR1Fwg+s5HLvPVFFAj/TmZVJCW3Z68J+Ce8GUH4k4VCcgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jazZvQ5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792D1C4CEE4;
	Wed, 19 Mar 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jazZvQ5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1742400278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INl+wOk3mYWty4PRlR7VWhbsVm/lVjeQqLlim8JHYhc=;
	b=jazZvQ5qjwyifsrGNAgUp6rMzT2gpMLC/N0+JaOnujaxUsbm1ZTwxBQS1/z5hnCsp3A7NS
	Xs7BjaZDQaUproMgWmLPzVNmxNF0oN1eiPchhfetXwXYj21BOooIlMvpNbE2Hm6/owKVqe
	v0VOf+geXgnLMoXPbxv2JsilTI+yIW8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7eeba5cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 16:04:36 +0000 (UTC)
Date: Wed, 19 Mar 2025 17:04:31 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wireguard: Add __nonstring annotations for
 unterminated strings
Message-ID: <Z9rrD0dyDDzTZRHj@zx2c4.com>
References: <20250312201447.it.157-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312201447.it.157-kees@kernel.org>

Hi Kees,

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

Applied. Thanks for the patch.

Jason

