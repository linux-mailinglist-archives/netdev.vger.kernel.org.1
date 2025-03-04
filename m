Return-Path: <netdev+bounces-171468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53142A4D0A9
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 02:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8693716F64E
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E691524B0;
	Tue,  4 Mar 2025 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBgC7kz0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3A4D8C8;
	Tue,  4 Mar 2025 01:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051276; cv=none; b=CIzSe+YVOuAjPOQLyoicoYyjT27f41STAG8c4twzMr6jPqlQJ6WoaJB60MJ9bufVC+Myqd5ojJH2v0I17YVasTL4NPMzKDP2ti0D8jHiqR9L2qh2mxSKQoIhFkbVQAaGn+FK6fxMYcPa18wKXfKlcwN4AcqzBcYX71XTNy9w/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051276; c=relaxed/simple;
	bh=3+aL9NhkJtBOT0hzihSpD5t8XrsL4CpvnSqTzQXi1ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9HSFnDvA02xQ3sCB1L1aZFgg2jWoHJdIpcdUY48hw43fncIRYATciIb1mWb4wrA8OpkTItO2onWftf8RbHGRcdJf9iFgzvtC5ic/sKjJGs8+KHaAyqLfXHPsvomF0tN8GTfhmaURStNiGDvQLcU9xku8qyrUcb/dCg/VOaW1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBgC7kz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C9BC4CEE4;
	Tue,  4 Mar 2025 01:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741051275;
	bh=3+aL9NhkJtBOT0hzihSpD5t8XrsL4CpvnSqTzQXi1ik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rBgC7kz0EHnHNT1qLFDNNsL6k1z11ZE6KF03jhlZWz/Q0qai31/jvPq8JVLPFrDw1
	 KbbhysGUeuwclozniY4r0/7s88sT65mhSnZCmgwOrWjLnaFFSnzmHggbAOphkd76tj
	 JZtxPjCzBcjkl4HEwbZSSzulnCMXO9mJvzd8ID751Ym5sK9CPR1NraCoXG8zY6S9Fh
	 iEcm3pZEXtOQGfvAKANaL7wyPMH3f9VoRJgN6KxXquqcBkl5fWKNKj+k3MrHR+VhIa
	 VdaGenf7ZaH0DeCF5J6Eq0xWADp7QIYJ81Vs5Qzu0R5jTyR3MYQ7BoqK9uDWB5EjPV
	 9MbgYx/frIJng==
Date: Mon, 3 Mar 2025 17:21:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Rasesh Mody
 <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
Message-ID: <20250303172114.6004ef32@kernel.org>
In-Reply-To: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
References: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 12:05:37 +0200 Andy Shevchenko wrote:
> In some configuration, compilation raises warnings related to unused
> data. Indeed, depending on configuration, those data can be unused.
> 
> Mark those data as __maybe_unused to avoid compilation warnings.

Will making dma_unmap_addr access the first argument instead of
pre-processing down to nothing not work?

