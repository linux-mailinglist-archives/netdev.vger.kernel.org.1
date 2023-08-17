Return-Path: <netdev+bounces-28398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E08277F546
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18028281E4A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB48A134AE;
	Thu, 17 Aug 2023 11:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135D12B8F
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A507C433C8;
	Thu, 17 Aug 2023 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692271814;
	bh=3k5gnRaLKoW6X/EEBv0L6dRfrVQFqZmbkteYQhexJfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UE/cEvpae8R2f4Y4/t6QYvZ2LIogr3akbgGep+6TI4C4SCN7joOvsibZbpuGbDjyx
	 NoWk1HcKz3sg1haTNceJdJ4JCwAr3uBSFoGr75kK/CB5V5Wr2ljzOFJkkn6NSkWVKJ
	 j4o2Ellg/dpRW1DgUB38wmLAlVe2hDVpEybRySr4MtXWqq6xkYAX8jZULULbnRfsvA
	 lTbH+FQvFix9PiylZsq8g8P4SREPnPoy8gIQW8i9lb08447ZvpZAXnXRAYGle0wse8
	 gAhs1dpTGEWEC17xFZwAmtwtsqc7nGcqMk/a59usfnFvAig6xqovRsK1usH25Wppm+
	 wLGQiVpYuw2aw==
Date: Thu, 17 Aug 2023 14:30:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next 02/14] ice: refactor ice_ddp to make functions
 static
Message-ID: <20230817113010.GK22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-3-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:24PM -0700, Tony Nguyen wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> As following methods are not used outside of ice_ddp,
> they can be made static:
> ice_verify_pgk
> ice_pkg_val_buf
> ice_aq_download_pkg
> ice_aq_update_pkg
> ice_find_seg_in_pkg
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ddp.c | 120 ++++++++++++-----------
>  drivers/net/ethernet/intel/ice/ice_ddp.h |  10 --
>  2 files changed, 61 insertions(+), 69 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

