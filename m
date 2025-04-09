Return-Path: <netdev+bounces-180666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC4EA82128
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7FB4A7FE7
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E80253B76;
	Wed,  9 Apr 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYeHh3Qk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865A1D6DBC;
	Wed,  9 Apr 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191685; cv=none; b=fDdfki3qXyGjx/atb3iNf03G7wJx6GvhLqitMLu+Ebdc4VHvpxbo2h2O1MJ1yVA0Uv/2dYe1ei76DOt4boUnnGIKmMAunQE5BwNd3s0s/1Jf8LRgWrlCFddUqxEA6BqYETkq8LgGm37bNkPKu/ZiLUGG731GRYZJI5m2DrBgkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191685; c=relaxed/simple;
	bh=SSWXGbMbWlXPGAjVFsgzQ5wey6PzlzXdkTCbUIl2LQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVyy3L9eARLJ5ENAHHq+HDoIof332huWaNErPexjQX+Kuq8snh1oYxSWJdspkn5RcVSnqThjQQPvMqJgq5PKSeOpNSMGssWa860UBVRgauY2D5IFL4cjO+0fa8/JMlDvFk50D9u1rWOztrMB+GNJQDdlKCfwE7SbrR1k+TRPu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYeHh3Qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4357CC4CEE3;
	Wed,  9 Apr 2025 09:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744191685;
	bh=SSWXGbMbWlXPGAjVFsgzQ5wey6PzlzXdkTCbUIl2LQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYeHh3QkFP56AgwddPbzrHyA6SwJft+TNHRXDnM0myYIYU8/lDVtqPhsbkW8WNPDd
	 Mm2RVqSTwEuOhsnVgbOXxCLSsrhaGwfIn0KpjvFKOvFEmwxKl8S7C9CXGvfGkeUsWT
	 1lupdtGQDVGSWSw1Nk9+HwvK9Ms98x4EMPunrjq7uY3RCJPLJ+Y79rEmdRrxHZSrI5
	 VHLg8Q/jck8FUmAK8eY6OJaWQz2xAi30xyGYrM3MdW2GO/l6C3mNu4wYRj3SNXtLhq
	 pRBOsOrNJKS4O7LBjwSqk7LfQeoWDP6gxke99RnyKZ2Hv65j8Z85BqPqATNw1gZY96
	 ly7PPU2HrZONQ==
Date: Wed, 9 Apr 2025 10:41:21 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 2/6] pds_core: remove extra name description
Message-ID: <20250409094121.GK395307@horms.kernel.org>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
 <20250407225113.51850-3-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407225113.51850-3-shannon.nelson@amd.com>

On Mon, Apr 07, 2025 at 03:51:09PM -0700, Shannon Nelson wrote:
> Fix the kernel-doc complaint
> include/linux/pds/pds_adminq.h:481: warning: Excess struct member 'name' description in 'pds_core_lif_getattr_comp'
> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

FWIIW, I'm of two minds about this a) having a fixes tag and b) being for
net.  But I agree that it is a good change. And not worth nit-pick energy.

Reviewed-by: Simon Horman <horms@kernel.org>

