Return-Path: <netdev+bounces-224851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57521B8AEAE
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 781607BF33B
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4B025D1F5;
	Fri, 19 Sep 2025 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLyzQqK9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A31925CC64
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306588; cv=none; b=io+9uKVgFBEN+21Tk7P/002j490c8kn7yz3geWnvamTHTkK7i1Z/hL7GjNL8krvm//GtU1lzHfQB/Jf13lT9vB3KRJMtys3A9PC3dLf85OfkpQvu3OCuosIgFdIYi3Y3bAkWdALPUvoJar5mUB8NepsD5h0z84yWpDKL9+E83Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306588; c=relaxed/simple;
	bh=HvqSDF5RITSLhXpbQoFQ0lWoduVAaPO1uTaEFaQ8MgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2TqQbd3tRgyEGZx8DpYTPvA9EXwcdWllx7PBNLSk7M4IRkeraUzUautgNo3asfTdVo/l5B+iT/o9XZmpq28xc0LNFuT8GjZJnNvhnArebrZFbY8dVKKGt9+Ifzf2Vh04c1EsTBL4qYpC/8FQJM7uiFphZ1g98FHq0IEYEeeENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLyzQqK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC5AC4CEF0;
	Fri, 19 Sep 2025 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758306588;
	bh=HvqSDF5RITSLhXpbQoFQ0lWoduVAaPO1uTaEFaQ8MgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLyzQqK96WI9OFlHBArGDDYnZ7eHI1p97maAoDwEcG2OJIuQ7andGna6Y+AQkHw2Z
	 NWfH+BqPrzMR47LHiyrrnqNwARXHGYx5lOZSltM/ELKKTLRt9NXWI7n5cuacq9dNTq
	 CGYcx8T2paXucCw1kCxtvL81Jgrg0JW6SihP3Bx2kYkAn8MSE8u7l5dDWP6wThrO+b
	 fJLfG01ZTXcgBmEkZucasV6wrBXrfuEPrRLcsE/Y6W5EY007gOrtiim0HtFqu8HGuE
	 1Fj3d4B6B8P2BUqn600iNUrqAML+/Gn7laWLHwMSVXYe63T4tPjWG/QDU7AkjWebmO
	 gWijuNWshxr0g==
Date: Fri, 19 Sep 2025 19:29:44 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] psp: Fix typo in kdoc for struct
 psp_dev_caps.assoc_drv_spc.
Message-ID: <20250919182944.GE589507@horms.kernel.org>
References: <20250918192539.1587586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918192539.1587586-1-kuniyu@google.com>

On Thu, Sep 18, 2025 at 07:25:35PM +0000, Kuniyuki Iwashima wrote:
> assoc_drv_spc is the size of psp_assoc.drv_data[].
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

