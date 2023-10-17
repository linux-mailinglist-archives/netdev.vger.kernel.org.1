Return-Path: <netdev+bounces-41680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286237CBA62
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58FC0B20F9C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 05:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78C3C155;
	Tue, 17 Oct 2023 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQTTaE9y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA34946E
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 05:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1A4C433C7;
	Tue, 17 Oct 2023 05:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697521997;
	bh=wvervu08O2tB/wlrgscAj5HHqJoy64a2u9WnJdsQOFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQTTaE9yO3KV+mdxcLE30eAfRNTaWZ5ElqHxXZbGUVIasU6Zw0gZM5jTFKdTt4xBW
	 ybQKX17tDDtSD2a18ORTdat92dlUlSXEEzywQS/12eT4FhCxF1Y6aiuxijqIHvhx/n
	 4Osfa162GVTb/XzTTio4x+hUSp7FOzw4K7DDNvNglqjJ3dM7QcQN0ym9oRtEdYcJax
	 snyXBLq+TBdWj1MDNw1rmEKxOhJrIsBUd/C4M2HSq7ZYu5WGbvCNHslpcU4OzbVc9G
	 u4myW1NvKzTmSTfGK3n0w6/nLI/OFnf0bB6FJpCJDrUy9cyoEBkPLnQEnBGVft2na7
	 daAWzzxc5e9Kw==
Date: Tue, 17 Oct 2023 07:53:13 +0200
From: Simon Horman <horms@kernel.org>
To: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc: m.chetan.kumar@intel.com, linuxwwan@intel.com, loic.poulain@linaro.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net: wwan: iosm: Fixed multiple typos in
 multiple files
Message-ID: <20231017055313.GD1751252@kernel.org>
References: <20231014121407.10012-1-m.muzzammilashraf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014121407.10012-1-m.muzzammilashraf@gmail.com>

On Sat, Oct 14, 2023 at 05:14:07PM +0500, Muhammad Muzammil wrote:
> iosm_ipc_chnl_cfg.h: Fixed typo
> iosm_ipc_imem_ops.h: Fixed typo
> iosm_ipc_mux.h: Fixed typo
> iosm_ipc_pm.h: Fixed typo
> iosm_ipc_port.h: Fixed typo
> iosm_ipc_trace.h: Fixed typo
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>

Thanks Muhammad,

Please consider targeting Networking patches to either
'net' for bug fixes or 'net-next' for other patches.

	Subject: [PATCH net-next] ...

Looking at the git log the 'drivers: ' part of the prefix should be
dropped.

	Subject: [PATCH net-next] net: iosm: ...

And lastly, if you do spin a v2 of this patch, you might
consider also fixing the misspelling of 'defering' in iosm_ipc_imem_ops.h.

The above notwithstanding, these typo corrections look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

