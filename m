Return-Path: <netdev+bounces-250572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE8DD337C4
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1FBF300184C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B362765F8;
	Fri, 16 Jan 2026 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRZai1hi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7B23EAAB
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580808; cv=none; b=f6IDu9Fa6KRhSyY6WVUxV25M1SghLVLgsWpIxr31rxjN3sP6mrpE7HGKVukbgd7HGV5PxjF5bE/2c+tcTjf6Sd3DRreRtYzHlwxuRScvIf5MiomqKO6G0MX8lQsW9K1Y122Tpy/hb2hlCxSz8oLLAo032uwtOzO7BruVoIdwQX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580808; c=relaxed/simple;
	bh=H/MeD4ThwDgkLhQV8hx2BQbg6JkHZVSJTD8llU6KeIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJpHwLE3Q0+bSr5cEWRvoYp8LBbUjfiX/qHxiyMj/9A6u4rX+O/7K8Y+MyqX6gWsaB+01IwA7J3ZC8z4h8ox9adPw4cxNfggeI61QfYKcBl6SE03hjbW14rUPm0VwABsbW0lnufA53CfMAps5h8QgovniDj6kJw95blYbb2IPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRZai1hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380FCC116C6;
	Fri, 16 Jan 2026 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768580808;
	bh=H/MeD4ThwDgkLhQV8hx2BQbg6JkHZVSJTD8llU6KeIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRZai1hi5GnZ7o5B0YlQpG6n3Y2lVrXlZSP6eukJ8jhsgruXFoxluFAsb/E+lS3SG
	 J3cYxlw2Xs5ZH8i29vqcZCDrEwo/quW000za2dDk1wIMG0CP/I5sWUNlP2hzOvR56J
	 u8upsirQ6PfB+B9fxWgBbgKVIWZ/A/rrVEO/xWkwA8foNa3VXPCWoFFQrzih9WzdS7
	 drcxze0RYqBI4po16pPM3/J7xhZZE4d6n+yI4pbVAL2q3rxJpPxu2E8xzzjjG/MA8f
	 hxku5FYa7DLmzZ4hh8CXy3VKHJsXe/v00aql0VTPgC9L0ELQFk8gxTNwCO49UI3kjk
	 b6YQuM5hzVFqg==
Date: Fri, 16 Jan 2026 16:26:44 +0000
From: Simon Horman <horms@kernel.org>
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net] idpf: Fix flow rule delete failure due to
 invalid validation
Message-ID: <aWpmxMH5PxEpxKtC@horms.kernel.org>
References: <20260113180113.2478622-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113180113.2478622-1-sreedevi.joshi@intel.com>

On Tue, Jan 13, 2026 at 12:01:13PM -0600, Sreedevi Joshi wrote:
> When deleting a flow rule using "ethtool -N <dev> delete <location>",
> idpf_sideband_action_ena() incorrectly validates fsp->ring_cookie even
> though ethtool doesn't populate this field for delete operations. The
> uninitialized ring_cookie may randomly match RX_CLS_FLOW_DISC or
> RX_CLS_FLOW_WAKE, causing validation to fail and preventing legitimate
> rule deletions. Remove the unnecessary sideband action enable check and
> ring_cookie validation during delete operations since action validation
> is not required when removing existing rules.
> 
> Fixes: ada3e24b84a0 ("idpf: add flow steering support")
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thanks,

I agree with your analysis.
And that the problem was introduced by the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

