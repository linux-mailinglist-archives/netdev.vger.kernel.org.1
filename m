Return-Path: <netdev+bounces-203443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90636AF5F53
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360BA189A958
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE122FC3C3;
	Wed,  2 Jul 2025 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIdrkV9V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D22F85EF
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475609; cv=none; b=YzQ4EXmorszJKByfhVsSyBqXjLeeAsN8QHSsdVgtBYE4ZklmNYnsYUn9WvUUvX2AuK0aXUvcl2vatpYlGjCgauu5aGQCe3UkGS8dG/KHinl7Fpa47cxO/Hj5cxByMDw2d0P28O7Fvvna3kBWBIQmWIDX3snNiST4rOWRJLNzhf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475609; c=relaxed/simple;
	bh=lD8+0GgmxZvEYmknjFXzg4FO5vQ3ovohbubFZd9SlUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWL56BwiF3yvQs2RPJJxWa240/AmplqudzZ4ZY4ArD6TxNlsyYlhM+qN12BJ6dOiMIpHYygQ0XYbHqFtUl20kVSntDgEwz5gmptbAKivAcUNSIDBQFZOSVIi8wiATC4yfpQN4cnnqORomHj7WOWCPwAgFR+g+FOBgQC4bagRtHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIdrkV9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D20FC4CEE7;
	Wed,  2 Jul 2025 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751475609;
	bh=lD8+0GgmxZvEYmknjFXzg4FO5vQ3ovohbubFZd9SlUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIdrkV9VG4AcTzWFspRGMet55CVIJNNAgAb7OiY+1514JyL4qL++8+RnnBcQ8wNJE
	 CbK6ZFkCdRgkZJo0685o/zZytA5JWpjXNm/j35yvObk7Vk24Uf6wOggxyX3cg60Qa+
	 tHC10uFRAgfMek8a+KejrP9ZyUG7aBLN0Bq2rFnUGbFKqIztWw1PhmLgTNOZMeioFl
	 PwZq7njPf9hgn/UHEg+1/ebxKjfl92Pv3gj1bEmmuxg5kXOf84tOsE/0Y3ezt8mEUY
	 BhRHUAZbFrf6m+LLmN+cj5fcJVn+jRRDYbv5vp4GoO7DcVNkO8W0sHo99kK6Q7UdxO
	 qjF1S9F/iwH1A==
Date: Wed, 2 Jul 2025 18:00:05 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michael.chan@broadcom.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net v2] bnxt_en: eliminate the compile warning in
 bnxt_request_irq due to CONFIG_RFS_ACCEL
Message-ID: <20250702170005.GH41770@horms.kernel.org>
References: <20250702064822.3443-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702064822.3443-1-kerneljasonxing@gmail.com>

On Wed, Jul 02, 2025 at 02:48:22PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> I received a kernel-test-bot report[1] that shows the
> [-Wunused-but-set-variable] warning. Since the previous commit I made, as
> the 'Fixes' tag shows, gives users an option to turn on and off the
> CONFIG_RFS_ACCEL, the issue then can be discovered and reproduced with
> GCC specifically.
> 
> Like Simon and Jakub suggested, use fewer #ifdefs which leads to fewer
> bugs.
> 
> [1]
> All warnings (new ones prefixed by >>):
> 
>    drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_request_irq':
> >> drivers/net/ethernet/broadcom/bnxt/bnxt.c:10703:9: warning: variable 'j' set but not used [-Wunused-but-set-variable]
>    10703 |  int i, j, rc = 0;
>          |         ^
> 
> Fixes: 9b6a30febddf ("net: allow rps/rfs related configs to be switched")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506282102.x1tXt0qz-lkp@intel.com/
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> Link: https://lore.kernel.org/all/20250629003616.23688-1-kerneljasonxing@gmail.com/
> 1. use a better approach with fewer #ifdefs (Simon, Jakub)

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


