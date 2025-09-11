Return-Path: <netdev+bounces-222108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C638B53251
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1686AA85393
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A342322C9B;
	Thu, 11 Sep 2025 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWutjt32"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400EF322C63;
	Thu, 11 Sep 2025 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593887; cv=none; b=A4ZcKJ/kymKVt7OMaAwIm9jABGsqzVhH447TodO7WH/w/SaIWNnddy9QADpjiclOo6P0BJp22HHgQ+MLMMAnDz92Nt10OfSnjtwGly7VPonbBNo12HBMalTYWajnw9EDof1dVQFzZ+nLiCjER+llhE9uC2jNQ/Sz/hpTgY/kPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593887; c=relaxed/simple;
	bh=Nfp9loWsUAIvLuDHuc9ZNWAFAiOrY8CU8Sj5UYLAyyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWI2MIH1YwJqh/gJD90w/8pQe3uKpwMc9GnbF6ue3gzgHHYknJoQ/8A8dNPTbbR42NwDqbyAh+nXOYsAfOIyajJt+eDmDIQatcty39Dma0f14M0XI5XLJek2Ces7c6aMr2kCUBEGMB7ewP/NWRM0qzyJSt72eh+nOQHCzAtNdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWutjt32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B15CC4CEF0;
	Thu, 11 Sep 2025 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757593887;
	bh=Nfp9loWsUAIvLuDHuc9ZNWAFAiOrY8CU8Sj5UYLAyyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWutjt325QtNw+LfmxqjhbtdNBmBXLC3zMAEil7r/RG8DL01OctgfwFxRHrh8BVmd
	 sy0SdSpIM4SQZKoUZ+WPXd6nNJihJH44S0FqlCCzT5J2MTHqIQ287PYaQDEwk76z4k
	 BTsS/q8qgjj+OKFZ9VTVzJVKGUPRE2Y68uZUnvytJzTewNWWA8lBO1ir9dRn0HqGBx
	 rfxTJxbF9B93FY+uvk6kIqFXD8gM4Zqgp9y3cHNzkZgbxR9B8PtoE7LoDTLPHLkz7W
	 WhjLjOUBBY7jeLgcWFxsA7aQiV8wl9aMEfv6Fvpy0cLopmri2M9yIt0zmlGv6psA2P
	 tkdOTibCyjaKQ==
Date: Thu, 11 Sep 2025 13:31:20 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v05 03/14] hinic3: HW common function
 initialization
Message-ID: <20250911123120.GG30363@horms.kernel.org>
References: <cover.1757401320.git.zhuyikai1@h-partners.com>
 <95f3ae76e2db6411f4509056d916c63f49e9270c.1757401320.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f3ae76e2db6411f4509056d916c63f49e9270c.1757401320.git.zhuyikai1@h-partners.com>

On Tue, Sep 09, 2025 at 03:33:28PM +0800, Fan Gong wrote:
> Add initialization for data structures and functions(cmdq ceq mbox ceq)
> that interact with hardware.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

The nits below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c

...

> @@ -61,3 +62,176 @@ int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
>  
>  	return 0;
>  }
> +
> +static int hinic3_comm_features_nego(struct hinic3_hwdev *hwdev, u8 opcode,
> +				     u64 *s_feature, u16 size)
> +{
> +	struct comm_cmd_feature_nego feature_nego = {};
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	feature_nego.func_id = hinic3_global_func_id(hwdev);
> +	feature_nego.opcode = opcode;
> +	if (opcode == MGMT_MSG_CMD_OP_SET)
> +		memcpy(feature_nego.s_feature, s_feature, (size * sizeof(u64)));

nit: This could use array_size()

> +
> +	mgmt_msg_params_init_default(&msg_params, &feature_nego,
> +				     sizeof(feature_nego));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
> +				       COMM_CMD_FEATURE_NEGO, &msg_params);
> +	if (err || feature_nego.head.status) {
> +		dev_err(hwdev->dev, "Failed to negotiate feature, err: %d, status: 0x%x\n",
> +			err, feature_nego.head.status);
> +		return -EINVAL;
> +	}
> +
> +	if (opcode == MGMT_MSG_CMD_OP_GET)
> +		memcpy(s_feature, feature_nego.s_feature, (size * sizeof(u64)));

Ditto.

> +
> +	return 0;
> +}

...

