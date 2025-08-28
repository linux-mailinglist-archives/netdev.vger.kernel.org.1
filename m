Return-Path: <netdev+bounces-217828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96964B39ED4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B61B685FEA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A8D311C1D;
	Thu, 28 Aug 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9O30dWO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72D311972;
	Thu, 28 Aug 2025 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387571; cv=none; b=opaVmolvhfTZ0ia/9+FHofZCUAJ81MFVw88ZRb0eYYBsxYCrvKnkI0ghb4uaR7QLQeyqi1dW0Pckg/6z0pJLfBYgIthusjOiGAJSRF0MqYTefQRreLmXEo2mj9d/ib5J+wPkY/JaIbRiuzO8SI1eUldPC5hXFYOZ274lC7WKR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387571; c=relaxed/simple;
	bh=i+5Oim/HXTglyokFAvo3qzr+eTdcCWXR7N4SxzM53Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf88lIl9CQCa39NuOR/XcyrDnvCsHx56Uodfpy9qHFLWQjcYHD2H2n+qHvTxQ3HcIB4Xd+MtZdYjPF7YFZWs5IIXI+Wf83lgaqYkgyAFzgSEUC1p5+VVF0Ur4+n9YE2S1nlsVr1Lsx9BEIStQr6o5lu19tYay0VzkjlBx/NmcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9O30dWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74829C4CEEB;
	Thu, 28 Aug 2025 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756387570;
	bh=i+5Oim/HXTglyokFAvo3qzr+eTdcCWXR7N4SxzM53Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9O30dWOUUevxK2fiLQpLX/weKtJM7lgQCSaSvqZKLvY4WCME85SyqPM8/RBScTi8
	 gCkvck458Ydx3B8xBv+prNU0JZHT6ZHiAO1cg6YrBrnN1+rqntGeqJFLYWpHW+kpGR
	 b7Pl/KVmJ/n3957C8+9KexfmdApoa01CdWyyBuNNZ9WLiTI71pTWiqzWNMZhHH/XCV
	 hk8KKTZIZeHD9EopC5B45VDA+XpDJ8pghmFzDdCOD/cRK6rOO+s24fK0nA1gYwNQR3
	 byRb8Yd9bbDjCfaRseFHnzzdIyxxEl/YMfLruTEsXH7DzeQsd/cRA3HHTTDnkxDyIy
	 zM1xYIzbPXAZg==
Date: Thu, 28 Aug 2025 14:26:06 +0100
From: Simon Horman <horms@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM BNX2X 10 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bnx2x: Remove redundant ternary operators
Message-ID: <20250828132606.GK10519@horms.kernel.org>
References: <20250827101514.444273-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827101514.444273-1-liaoyuanhong@vivo.com>

On Wed, Aug 27, 2025 at 06:15:14PM +0800, Liao Yuanhong wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:

  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.

  Conversely, spelling and grammar fixes are not discouraged.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
--
pw-bot: cr


