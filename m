Return-Path: <netdev+bounces-28402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3702777F55F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AA41C21312
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3D134C7;
	Thu, 17 Aug 2023 11:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632312B8E
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ADEC433C8;
	Thu, 17 Aug 2023 11:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692272244;
	bh=88lKxhHG2bfVDe/2nd6PhCXdHvO4tjFHu72gk3MAvfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMiI8EbJmWmo0q4v9wl68B69O8EcprEJGTrUrFeOZjWeDTTxWLQBUNo+o90z2788S
	 NM0BL4vMitEsT+Mdhvxj8iQqRn36PxnhUJQSYvGAI2YMyuZyKkM5w9gQA1OMs4KC8T
	 ZXOg+BFFjsI6VsfAvtPX1ReK3gn7VyFxVYLPcH712MbfG1jQADD4mN3xAnqmp9LBjX
	 YCZvKJ0An1qGOPwJKjH0fqlWsIfYUYS6PCFAZS0/VeG9BqHj13GuceiXY6yYCa729A
	 1GP+apJv2wN1DdHL0dYlMOEl4AQ+TfvJFnKW8ZbQueqJTVi31ZAT80gHJTqGF9uLmf
	 97lKh7WOCFySQ==
Date: Thu, 17 Aug 2023 14:37:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next 06/14] ice: refactor ice_ptp_hw to make
 functions static
Message-ID: <20230817113719.GO22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-7-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-7-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:28PM -0700, Tony Nguyen wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> As following methods are not used outside ice_ptp_hw,
> they can be made static:
> ice_read_phy_reg_e822
> ice_write_phy_reg_e822
> ice_ptp_prep_port_adj_e822
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 6 +++---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 3 ---
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

