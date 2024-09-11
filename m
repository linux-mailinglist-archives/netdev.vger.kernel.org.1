Return-Path: <netdev+bounces-127237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E4974B70
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D93D1F22038
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C512D139D19;
	Wed, 11 Sep 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAJ3GDqe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5226F2F4;
	Wed, 11 Sep 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039979; cv=none; b=AG4X97ql2/vMUCsuOdvTlAMud2vsOqYD+fQwF7KvrSPJNdwvJ1ApsaLQDrnDXEE8fjOkfQp/2lRsNoVVXNrur8M6h5M9r5U97iZMzoSznaxEbi6+GvuC7gVcjYR4IvWfTZZBBq04+Gj++bLA5YdqEXDjM3Px1zVReL3jt3/ey8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039979; c=relaxed/simple;
	bh=5kp3LjJn/6gKP6wSSNHyyu9tb3T/6Zi3UEaZBQ5W3tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9UZfNFfeOvz6OBrXdCFrsdA5mCMWlpT9V3BFu42NAswhHLkCRmYox+xPt4Gx0i7PxqrYaCUHnT2cIlkBb0D58aFrDenDuPXXlXVPxgO5eLq80kXHDsl4zhYgpFBlN0w4TPwOIZdksxkoLUsdHy78woiULmlH79EoQAz9SKiSdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAJ3GDqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA26C4CEC5;
	Wed, 11 Sep 2024 07:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726039979;
	bh=5kp3LjJn/6gKP6wSSNHyyu9tb3T/6Zi3UEaZBQ5W3tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QAJ3GDqe8XWTXD+8yNVRUlyAkn3z6Xhrj0QrdXXLsTtBvnhbOoYHeXWvT5NBNAOtI
	 ga8yDhkHs/rftdn6qqBDsoP362W/M6P8bcRMrLJR11Wdq8BRgKZ2IQyly9H95ePCLq
	 EX7uVw4EXv5faSlJ/XP2HQeg3Xfc3NiiWDgA4/ODs06A6ezRGY6tl9nrOqSeo7tUUr
	 0QDoZjheBA24KdtbuGdJSiKaAnmUtl5mXO3wCfqCxx2b6Px2pqYmz3uHoC+0eCB+PH
	 H/wylli+x0ctZjkbGsqN3UvNTPBLsIprGAgmve7Ei9lkwbaMYMxdBY659HDAX5IqAt
	 5/oK8Z6I6y8mQ==
Date: Wed, 11 Sep 2024 08:32:55 +0100
From: Simon Horman <horms@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yuehaibing@huawei.com,
	linux-kernel@vger.kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 1/2] net: ethtool: Add new parameters and a
 function to support EPL
Message-ID: <20240911073255.GK572255@kernel.org>
References: <20240910090217.3044324-1-danieller@nvidia.com>
 <20240910090217.3044324-2-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910090217.3044324-2-danieller@nvidia.com>

On Tue, Sep 10, 2024 at 12:02:16PM +0300, Danielle Ratson wrote:
> In the CMIS specification for pluggable modules, LPL (Local Payload) and
> EPL (Extended Payload) are two types of data payloads used for managing
> various functions and features of the module.
> 
> EPL payloads are used for more complex and extensive management
> functions that require a larger amount of data, so writing firmware
> blocks using EPL is much more efficient.
> 
> Currently, only LPL payload is supported for writing firmware blocks to
> the module.
> 
> Add EPL related parameters to the function ethtool_cmis_cdb_compose_args()
> and add a specific function for calculating the maximum allowable length
> extension for EPL. Both will be used in the next patch to add support for
> writing firmware blocks using EPL.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


