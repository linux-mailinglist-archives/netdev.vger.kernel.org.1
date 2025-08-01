Return-Path: <netdev+bounces-211317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38898B17F2F
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 602A37A328B
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E21C223328;
	Fri,  1 Aug 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5C47LUK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0EB222582
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040254; cv=none; b=q7pDbPlV8SqnfmRvgDF7pPJXu8BB3SlfE/ui94BdP+BcpOCVVJ9RqapfDoGvvWseL5uuF/kUzb6gjaw1HR9TPayRYYNobRdPQPxWLYm4S3F0hYpoVUKGloYXvjIPmwx2TYuYxb3yNhd/HfvbsOPNAUjeKDMlwSXLW68cLCQ8+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040254; c=relaxed/simple;
	bh=ZROP4PCFq2T7DW/ZWlKWmKghuDi4tEmByvOd8mH4brA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGdeIRRuTIoLrhfmW1r5Sq1gMBDffBNQmHnwowV+5Ry+gWviMsK0R5eN6gg9IkIXe6yqR510uzG6nU66YJkitj9C9Kl/cJYyTzrO4G/AIXFZw1/DVdmq0IkGfew+Cbo4p80rLIrleAD/Lq6FuRTGw43QbrKZMgip85h1MeEfkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5C47LUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CC1C4CEF4;
	Fri,  1 Aug 2025 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754040253;
	bh=ZROP4PCFq2T7DW/ZWlKWmKghuDi4tEmByvOd8mH4brA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5C47LUKujpSv8f+oTbYNiCQiRcIF5EO61YX0RV76mOQJRwY+G5ultxJAlmz6n0Gk
	 qOs3SUTpjpp7H6khGrtHX3u/Dt1Jr5s+JMPp/Nso7oN05tbmILs1kxNd3cX1gngty5
	 er+FHoDWzdFJ598zC1f/CaiCG3WX6mrCLQWPyw1GSOeEl2mAqt+4Sx1SEK14IJyXhe
	 dDWxRTl4wPj5GS8d0sPzB44LNsK+0cu8KePIIpeIV45sj6W+97voNuWy93k3JgVp2z
	 d7tsRa6U79xXZkCnTtdngNUMzOwa0ljB94oe8gdtqVcI6uBdNTf+U2rIYIYU2fOtyk
	 KYbb4REoeNTJw==
Date: Fri, 1 Aug 2025 10:24:10 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net v2] ixgbe: fix ixgbe_orom_civd_info struct layout
Message-ID: <20250801092410.GD14753@horms.kernel.org>
References: <20250731124533.1683307-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731124533.1683307-1-jedrzej.jagielski@intel.com>

On Thu, Jul 31, 2025 at 02:45:33PM +0200, Jedrzej Jagielski wrote:
> The current layout of struct ixgbe_orom_civd_info causes incorrect data
> storage due to compiler-inserted padding. This results in issues when
> writing OROM data into the structure.
> 
> Add the __packed attribute to ensure the structure layout matches the
> expected binary format without padding.
> 
> Fixes: 70db0788a262 ("ixgbe: read the OROM version information")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: use get_unaligned_le32() per Simon's suggestion

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


