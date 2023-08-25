Return-Path: <netdev+bounces-30646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6067788643
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AA71C20F8B
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 11:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6FBD2EC;
	Fri, 25 Aug 2023 11:47:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA884CA4E
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 11:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B902C433C9;
	Fri, 25 Aug 2023 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692964032;
	bh=JnIi+XYJohnJ8+LrEfmmJZMP28NPWLZ36odMjeUA/DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XuMJ8/bpdyIxwOgkwTnjvVY3NPG0B4dQyJpN0L1G/PbGNhVtwj5EMeWZVd9Gu4B5C
	 H7bjDcc/IL7mOt7afGdwlVuVYYJHH4wVNvg0Ds8BzDQcEjzIZeWPUlSJUyIDNX/4Zu
	 kUibUZ44XLkIwwfHBAWhCy3nvzv2xgE8xRe4ZyzR3CQHzdalSoneTyzVCTdTIvMbVs
	 0+jjWaSHfTQDOYC5OTJkg+OFit1/t90Hy5hKwoS2r7oiuZj4iTkuYBH7E1Ala35Jrq
	 2YgTEnMcERo8MZBpsDKFU5XX8mA2RBcTB6Pukd0qha3FYt3YGslOt73PSWsHNbeWJz
	 HQ4E+wZPyrObw==
Date: Fri, 25 Aug 2023 13:47:06 +0200
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: brett.creeley@amd.com, davem@davemloft.net, netdev@vger.kernel.org,
	kuba@kernel.org, drivers@pensando.io
Subject: Re: [PATCH net 0/5] pds_core: error handling fixes
Message-ID: <20230825114706.GN3523530@kernel.org>
References: <20230824161754.34264-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824161754.34264-1-shannon.nelson@amd.com>

On Thu, Aug 24, 2023 at 09:17:49AM -0700, Shannon Nelson wrote:
> Some fixes for better handling of broken states.
> 
> Shannon Nelson (5):
>   pds_core: protect devlink callbacks from fw_down state
>   pds_core: no health reporter in VF
>   pds_core: no reset command for VF
>   pds_core: check for work queue before use
>   pds_core: pass opcode to devcmd_wait
> 
>  drivers/net/ethernet/amd/pds_core/core.c    | 11 +++++++----
>  drivers/net/ethernet/amd/pds_core/dev.c     |  9 +++------
>  drivers/net/ethernet/amd/pds_core/devlink.c |  3 +++
>  3 files changed, 13 insertions(+), 10 deletions(-)

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


