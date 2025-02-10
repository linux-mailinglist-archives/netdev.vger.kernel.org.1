Return-Path: <netdev+bounces-164907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB00A2F973
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA261883A6D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B982725C70A;
	Mon, 10 Feb 2025 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJJZbjKN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9DB25C6E8;
	Mon, 10 Feb 2025 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217024; cv=none; b=KTG+1Q8oGhk4/PjkIiNZgsG30wzJOuaV3uBYfiAOR2VXChmmJPs1CC5fRC8IhAsHXDCFSgsAbknAf51qiAvY+E+fr4lV1WSvDAnO+sNqIruKkrkbDNzsSL/oxTlYSjs0nWSuatRIvd5DNhfnJ8znCHCg0pylvaVu2BGvTOv0AvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217024; c=relaxed/simple;
	bh=8hPP00+5TyuBUw9HYwxObov7AmV1jQGJTCHjssiuKzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEqhadFM45QBKAxGbQoJDbeaz/EpXTY3FthzzbhHCFzGeE6tqlgfDpoe4/poOi83v3fE+xWXtS7xnYeIMT2ZsVFoFiwolNWhNb1pOqs7cXrTJdcT/pxXSuP6P3pzLifCyEh+dsNKC0OFm2mT/GqsyGONs74C5su+KQFv8f0Vhzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJJZbjKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F45AC4CED1;
	Mon, 10 Feb 2025 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217024;
	bh=8hPP00+5TyuBUw9HYwxObov7AmV1jQGJTCHjssiuKzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJJZbjKN0zPd185BeLXC5gja5N1iOG4qZ4b89oCu1R4cwmvR69rM/EiV+liuR5d0P
	 3SSzIMClTuHq50YGR/PXq8USIP007OB0fQtnPqjxde/ouPOvEIVV2vr+lkH/CaQGJ7
	 N8bHKe7kzJC/j+LKXA+bzGmj+3L4BLQR8bu5ImxxqVDfvSHgMvn8DaCEaZ360KOEyr
	 8GPLIbKN1lQWh60Ic/O4aDt1/JU/3Lcmt7SQe7o60AWxIwjCv5ZjMEdkIBYiWqlKy4
	 lkY73++6/COxxzDV/cT1/M5Qw6uBsdbWh0wGCJI0aws154l9o6qK0VPm4S+F1AiIXe
	 uPHPIQt6o2EtQ==
Date: Mon, 10 Feb 2025 19:50:19 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/15] mptcp: pm: improve error messages
Message-ID: <20250210195019.GR554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-4-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-4-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:22PM +0100, Matthieu Baerts (NGI0) wrote:
> Some error messages were:
> 
>  - too generic: "missing input", "invalid request"
> 
>  - not precise enough: "limit greater than maximum" but what's the max?
> 
>  - missing: subflow not found, or connect error.
> 
> This can be easily improved by being more precise, or adding new error
> messages.
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


