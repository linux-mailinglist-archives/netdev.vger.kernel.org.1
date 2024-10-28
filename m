Return-Path: <netdev+bounces-139724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E269B3E86
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A430B21D14
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED64D1F4260;
	Mon, 28 Oct 2024 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nftaVFrA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4C1DEFF3;
	Mon, 28 Oct 2024 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158537; cv=none; b=UK0LHpjb+lEqZa4wvCsd33nOaQZbpdTDUmQhaC+sYXEVgLnd+tWG+bPdQyjTxcp+6D8fFuUgKZSX2S+QTmQfUyVRU9ChEXzz0vmDkAOyv/dSMdzhgKoKoZPu2QK3gZmbtwZR3xWsrhzR4ySAwwBK0bs0NOeexeCdKpxNFuHIj50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158537; c=relaxed/simple;
	bh=TTyEL0rVkBxaazrm1m7siVYel9UK13LL2Auom0D0O/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioGA5u7mGJcmeMuQu1fdlueM6UZDmCFLpHN/7BBn/sy54QzOfyPZTFC1QAQUo455JpTUNksn/94vjVLJDABjyQ7Y3psD707SzD+45bw/aelS6HlldMQBs0PYPbuVS1uJ/3AV5SbAcQ2UJfRTdHEesoyLiv+M2vBLcAPV93K4naY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nftaVFrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B38C4CEC3;
	Mon, 28 Oct 2024 23:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158537;
	bh=TTyEL0rVkBxaazrm1m7siVYel9UK13LL2Auom0D0O/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nftaVFrApCLB7yMzzvdcXHUHfFjDWxOpdQMXEIIOTEMjcYVu8s3eya1Sn2TxhhdPh
	 K6j9Ve8//vg+5ti8++55YHLAI/UqUREROif4OBs7f5SRL7knaEUbQyiOWfp4nVEEIz
	 IFSmLLyA3KIuSDpXfi9ijZsQ31BPjiprdf4sID+knkKVAHqxfbljbbnbqnL/whh7gE
	 2TMh5ZdimExYpV/wFRIK42kdrDedYY4eFvm3qZW92tWdXENwIMTTfimi8nKmTItGUm
	 h4QtyzPijZLg/kf5IZQ/J1xsObAigZaiTC9KNg53cH0/zim+V6bm8P+lwaPz0mF+9y
	 v76lFpA+2wWRg==
Date: Mon, 28 Oct 2024 16:35:34 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 2/4][next] uapi: wireless: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <202410281635.8AC0075B4@keescook>
References: <cover.1729802213.git.gustavoars@kernel.org>
 <65f90d60460f831a374d9cd678ba38b31fdd4f93.1729802213.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f90d60460f831a374d9cd678ba38b31fdd4f93.1729802213.git.gustavoars@kernel.org>

On Thu, Oct 24, 2024 at 03:12:02PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Address the following warnings by changing the type of the middle struct
> members in various composite structs, which are currently causing trouble,
> from `struct sockaddr` to `struct __kernel_sockaddr_legacy`.
> 
> include/uapi/linux/wireless.h:751:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/wireless.h:776:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/wireless.h:833:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/wireless.h:857:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/wireless.h:864:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

It's a little weird to have to update all the whitespace, but yeah,
seems correct.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

