Return-Path: <netdev+bounces-231804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7F9BFD95B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7C004F29FD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A36E2BEC31;
	Wed, 22 Oct 2025 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmzqFxRU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED32BE7CB
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154162; cv=none; b=mDaG46Y0+4EBTDA20d+OzEmXrMGJmDXI4a5QjUq+hOshLUA9R1Lp0zBDnvf9xkvSmtHkKpXZHrib26jNVfqacNLaXIO6W85q2DPt+wu77kFPxlnnDYwUmkeHyR39rYT/D2Z5ahXHNlOFznUpe+ltPuMKmomBgr138awvnPuMQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154162; c=relaxed/simple;
	bh=jBDtWDj7roFe0nuAnEzB3HNU53XACSD9WqBhRDE4y2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9Q+530kgPcy+FS5j5UYpAiyCQuMkVAGLpUMIXjqId7Obf20RRnxxgfCS5IKYu4FHWESCiShlO1r50Q6ahqlgeSJZ5m9UMat0not1Id4yZD35jEemX6yHp1xuTSZQPsn+PQ++gbfkx55LyyLSlQ/UcNtJfmpMPHCeLLaBw8GWTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmzqFxRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAD7C4CEE7;
	Wed, 22 Oct 2025 17:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761154161;
	bh=jBDtWDj7roFe0nuAnEzB3HNU53XACSD9WqBhRDE4y2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CmzqFxRUO576gcilEDDPapeyJRXftX09hgg7kErexGSGSlt/+/bm6tE4tKGr1hH2W
	 m0dLFS55QjGyHuZCuD6xMXD/0d9PGGtXdRYERfgTjegjUayWGE0k9g+QmTJg59W/+G
	 YoGFP1FbnZstUUcoqX2c3UKsdcLiZrLSUODvIY5RAQycgwH75XZTi5SAaDAWpcBy+u
	 jkjXGtqJ8I7/FiAjTORm2W61TGlWYTTbmuP9BUHGkfOlmkZPZPnLSoPyoPlUi1Y3Sz
	 Ah8loW8PR2y8SBsO8Xuwgo2fYz64EmWJ6yIAPj+WumXxve2wwcSPCOKJpnPoW88kcr
	 xeVYx4KsMSS/Q==
Message-ID: <410cd787-0085-4409-97c1-2019a7baab8b@kernel.org>
Date: Wed, 22 Oct 2025 11:29:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, petrm@nvidia.com, willemb@google.com,
 daniel@iogearbox.net, fw@strlen.de, ishaangandhi@gmail.com,
 rbonica@juniper.net, tom@herbertland.com
References: <20251022065349.434123-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251022065349.434123-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 12:53 AM, Ido Schimmel wrote:
> Testing
> =======
> 
> The existing traceroute selftest is extended to test that ICMP
> extensions are reported correctly when enabled. Both address families
> are tested and with different packet sizes in order to make sure that
> trimming / padding works correctly.
> 

For the set:
Reviewed-by: David Ahern <dsahern@kernel.org>

Did you try testing this with an older kernel versions on the receiving
side of the icmp packet? ie., making sure older code does not have a bad
reaction to the extra data in the icmp.

