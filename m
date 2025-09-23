Return-Path: <netdev+bounces-225560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F2FB956A9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE18D7A73D0
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB3E30DD1C;
	Tue, 23 Sep 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzB4q8HK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835612B94;
	Tue, 23 Sep 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623029; cv=none; b=R6gWVxXhg9/IYOCJmgHPxBdb9+0LgUmWhsItkEEhmMplS8EOcSzXCvMNuutY8Kqrt8huyp56VkRwLP13ypNfQWUlJstTHB9sElZrJzazDexl7CUgTcoafXV2SHOV6TeX9lMNKjI7Hiqchf2Hj/2gdfABwOT932Ar5v7BQIaaRkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623029; c=relaxed/simple;
	bh=DdW4jh47rl33caplaUr+pH+GJQuEjokLuII6za8pXOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1yfvL/jXqIubNsCgV2Gtlv8oR1Fg5nzRZiuK14UbpuTI7Xf3L8yNzV2S57kh4pbSBvGRxUKho84a4mim5dfHa99GrCaKZrLHTfla4xnsQNWDpWNjaVc5EM5wR0XZYqLQQYpc/GH/16eFANLydqIasQvChHvGUS07D0ll6LvD5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzB4q8HK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FD9C4CEF5;
	Tue, 23 Sep 2025 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758623029;
	bh=DdW4jh47rl33caplaUr+pH+GJQuEjokLuII6za8pXOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzB4q8HK3GhKjvyNWHec6/F1yruIy/aktGv6RFZnT+ghP+1/6H6gN5rpdyl0LH1u9
	 7fegFLy4RIXI07YRPtML6NFBSrWDidLcQO7IWToool5ZprkvNx6splpTZeADq0wye9
	 mGgLiq4iyoTgUAOsSAZcQgPFVehjcCZkWVvOtWGXpAmg9z9V8uLJ33KqZ0TR7d64yu
	 mjQ8zRFsrzVWk54Xt0zMldWCYWUqVpB3eiaKLjsiKSEfiMKeZwDbXWyBNSQbCQwOhy
	 Bm/TNNztSmGxxoCbAjDGw+tlla3LjGbSyU90I8lvWkPEUvacBnQF0C39UjTeEVyxPN
	 1G8MY3+NODe1w==
Date: Tue, 23 Sep 2025 11:23:45 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next 3/3] net: dns_resolver: Fix request-key
 cross-reference
Message-ID: <20250923102345.GJ836419@horms.kernel.org>
References: <20250922095647.38390-2-bagasdotme@gmail.com>
 <20250922095647.38390-5-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922095647.38390-5-bagasdotme@gmail.com>

On Mon, Sep 22, 2025 at 04:56:48PM +0700, Bagas Sanjaya wrote:
> Link to "Key Request Service" docs uses file:// scheme instead due to
> angled brackets markup. Fix it to proper cross-reference.
> 
> Fixes: 3db38ed76890 ("doc: ReSTify keys-request-key.txt")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks,

I visually inspected the html output in a browser and confirmed
the both the name and link for cross-reference is now correct.

Reviewed-by: Simon Horman <horms@kernel.org>

