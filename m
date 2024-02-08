Return-Path: <netdev+bounces-70203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEE784E008
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1641C2241F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F016F523;
	Thu,  8 Feb 2024 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqyMzcE/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296C86F512
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393156; cv=none; b=h4IlLC7mIWLySNMpQbG9NEITZRUzX4ZGAwxgKBxzAQo0WW9H5qxZsX+h/IAjMLYgTopC3A6/8o0eFPkNYCvb0VprfoTMwshB55ik/rlKiB6GE8o0DargF+BjTTNQjm/tGAmcVxMruYnA/s7DMubL+fLapOBk9NAjhQ09LhyM5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393156; c=relaxed/simple;
	bh=z7fT4fCWr/oF5T4KH1RNdsE5B7t/u2g8JbfEAXGuzag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1UFRV7daHgtPYBk7ewhzoNGidAddvQuJuhG5/2okLKWR89LnPCDmtWIhktDZkV2QbcMCmyphvY7YO6MEdC373qiaPScBrYNFB7ghVultU7jZ2XmolymrCseb96K4lhXgszM9+e/Ycr0L8upYa4AmE/oeClLMpQHNqbUTBNhMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqyMzcE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358F1C433F1;
	Thu,  8 Feb 2024 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707393155;
	bh=z7fT4fCWr/oF5T4KH1RNdsE5B7t/u2g8JbfEAXGuzag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mqyMzcE/iFCyo9g5V6SSycvj6r+pnoImt4oGzbx8i6LtVRE18uG/0vVPzHYb+ne48
	 jliH2FJnLem6uklgG1hrwzoNXX8abxcq4Wwneoza9GBrx7SlM5rfKvjVXSg+w4Osor
	 a5RCTi9CKsol8IzinOdeMCjByXucn3r3boGXr4r8K8oc7G0xwWkjDkT88IOVWoWYnY
	 PWr7+6V4Nm/ke9g0AQUn9VUCELQPd6Kw/rI6b5PVYhT8QLng+j8NjLwMMxCSM/Ypu2
	 +mKXTKjufwmqOHfA9xQ66xkV5/ZjGH94thFMqab2BCip8K+CqLBe8JW6d4yITREf6l
	 SWBV6PM2oQLPQ==
Message-ID: <a6187f1a-41f7-45df-a700-5e840d0d5d9f@kernel.org>
Date: Thu, 8 Feb 2024 13:52:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Remove duplicate cleanup calls
 in emac_ndo_stop()
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, vigneshr@ti.com, jan.kiszka@siemens.com,
 dan.carpenter@linaro.org, robh@kernel.org, grygorii.strashko@ti.com,
 horms@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
References: <20240206152052.98217-1-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240206152052.98217-1-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/02/2024 17:20, Diogo Ivo wrote:
> Remove the duplicate calls to prueth_emac_stop() and
> prueth_cleanup_tx_chns() in emac_ndo_stop().
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

