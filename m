Return-Path: <netdev+bounces-125888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA55296F1CC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832A828339E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C61C9EC1;
	Fri,  6 Sep 2024 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y01C17wS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC883A18;
	Fri,  6 Sep 2024 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619432; cv=none; b=b7EEl6dDUSjZ5c5P/oSDb9Gb9GnSKpxFmt81h2w6GZUfmLXrjnYGJMsBhcuviL/CavWLoHXpvI+6Z554FO6F6aKsHgK012CN46UFok1531dYtYG/redbJ6Geyhl/Bt6GiDHjgyA5QkxJE1NDIB7Qa37PSfGdcrmq4szX00QJTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619432; c=relaxed/simple;
	bh=OQw+WTM6xsGefmWjW1mTw+a1YVJ8KpEFzr1onkeQHfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKlJQv9v9jqz1ppIXOPquvBpVgdJqn5r8Kcpp13/T2/DmRFXs49TD7pyof0W4AJwi7E4ezcDLipxAUghmymnmbWd0sFqY65GGhSJSvB0Crdar9QrfPppm1YTq9yZDJfV2m8fUTPfTafif8nF6/uEwtyFM+5aDdUfAaWKg3t1WgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y01C17wS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B41C4CEC4;
	Fri,  6 Sep 2024 10:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725619432;
	bh=OQw+WTM6xsGefmWjW1mTw+a1YVJ8KpEFzr1onkeQHfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y01C17wSTBw1rVClSHb3nFmJdC/89zR/QvQj45GQS/exY+yR9plhOwjewH5VWg6Ju
	 zcQx82rYD6adoLrgaxnQqKc9NBaxE/nNswvGSsogEt3LQpKU6/xoBwoeFZrXF4bHnK
	 g6vkuO1yeeSM9YzWimL0pJrcNlQC+3jgc8GfoMWmkuFs91P84e8TwB8PoYvXNZ57EL
	 HFQ37vMM430JlCcDsHHa/E3tbh/9NTv9of+ctocRyzQUBF3El730lMstCBjw280bgN
	 2qoe3sv+pmRLmGbAIHFsirJH7U3tDdzYD5hD1UtOorxcZ8TLSJ2dF+i2YLkdKYLGI7
	 XFOHWnWTlaG3g==
Date: Fri, 6 Sep 2024 11:43:48 +0100
From: Simon Horman <horms@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: irusskikh@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v1] net: atlantic: convert comma to semicolon
Message-ID: <20240906104348.GF2097826@kernel.org>
References: <20240905100619.1199590-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905100619.1199590-1-yanzhen@vivo.com>

On Thu, Sep 05, 2024 at 06:06:19PM +0800, Yan Zhen wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Thanks,

This looks correct to me, although a bit more text in the patch description
would be nice.

That said, this duplicates a slightly earlier patch.

https://lore.kernel.org/all/20240904080845.1353144-1-nichen@iscas.ac.cn/

-- 
pw-bot: not-applicable

