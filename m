Return-Path: <netdev+bounces-79094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF215877CB6
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BAA1F20FD5
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508EA17577;
	Mon, 11 Mar 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRGTBGb4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B817999
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149330; cv=none; b=DVSDYkYlMEORqlSBeQXYhh83hlbrMpvJU6FyRvDjPnYa6F8yp/HJW9movLwZKKmRGQbJ1qTIDpLBsxrg3UuhvLXPJer22dUQWlvSFhqc0OspUVfi9O+b2/qqG0Aq7QNeWUaResm+8Ya0hlzr6/1KnrCxZVJ+H3e1Ag3WgZ2NQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149330; c=relaxed/simple;
	bh=OqhmO6M3OHz6ppHWuh2pIzQYWuzYKvEaLefXwN5PfEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAMLZNWDRiTRUIizq9wQjViI/q2CKncI/Ysa/pv7Cg+6Van4dTTHtP2rT3PFPnvRVvJJDqf/58Kb0xyRH2WcMWQ0+0LNd4/ZtpanFvuqJjbTe25K9guIRSuBR73nKddNIVEc+X4HUfAtYgCrlEkls5gKsXxGiB+Sc5Y7SyEuMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRGTBGb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD1DC433F1;
	Mon, 11 Mar 2024 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710149330;
	bh=OqhmO6M3OHz6ppHWuh2pIzQYWuzYKvEaLefXwN5PfEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRGTBGb4d/85qIcRIb+cDC+vz6Vq2LQ348+qOGO5naGfsMooKur8+z6c+gkAbhgxP
	 pfe2jrap8Yn97MhXd4pKO2IqiDyIxnIm7dfUv3jye3Q9lCTuP1C5PEE7qHNc3/6cje
	 mFAKpO6Mv84eYA5Cy6jXPShr59hV4qGT5iP4yOvuehnNfjRs17A5rivRBk4LUL/4kf
	 nCSB2H7yhTPDqEISirN5WgbqeGv6knUDQ9ga+mzOM82A7BEm9mmai3YCIq0QdRF8Kb
	 9lCzhT4JRprKCYUZrMKzBmXJN0f0h/MTdm9rtWmQXifit5ft6YxRYzqJzcs4LxR5wz
	 dl8kFCjlL1R2g==
Date: Mon, 11 Mar 2024 09:28:43 +0000
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] netdevsim: replace pr_err with
 {dev,netdev,}_err wherever possible
Message-ID: <20240311092843.GK24043@kernel.org>
References: <20240310015215.4011872-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310015215.4011872-1-dw@davidwei.uk>

On Sat, Mar 09, 2024 at 05:52:15PM -0800, David Wei wrote:
> Replace pr_err() in netdevsim with {dev,netdev,}_err if possible,
> preferring the most specific device available.
> 
> Not all instances of pr_err() can be replaced however, as there may not
> be a device to associate the error with, or a device might not be
> available.
> 
> Tested by building and running netdevsim/peer.sh selftest.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


