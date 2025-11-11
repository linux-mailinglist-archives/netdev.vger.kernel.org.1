Return-Path: <netdev+bounces-237433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14486C4B472
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 04:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56DF3AFF2C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC82313278;
	Tue, 11 Nov 2025 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkKncGeC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3A30F7FA;
	Tue, 11 Nov 2025 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830301; cv=none; b=aTpsbq1rUmjD6ghNBVD7W8EixNGGGZHT51UsdkDJBF2co2MTHm1n9KW8F2Zwd7+hKF/C2l8ecWHNdNjA/BIc2mlxPT3+2NfyjYtj7FSGnzNWoC5giUnYHUDak5a2lZq4XJpVtIU+Ua2vKORjcw7DCh1bWIozv6j+IIFdCX/37do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830301; c=relaxed/simple;
	bh=IdEozLKYvHaOq3HzdNOAAfYq9jXios/DLpMqxSgeiLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaE5NWkzArHSJ/QRR0aYJL0tif47xZPrJcfu2cTY53iuJO4nuhotB8G7KyQGEqYtQ6MyDXF2A+MGlaYHD/e68nn/1UR+fTnrVMWhH/galcFxpMSwdfdla22+gSEMqRFWBN4QAxOjWNnPfKDbFMd2XHW7n6P0Ho7ZBsmNVzCEfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkKncGeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ABDC116B1;
	Tue, 11 Nov 2025 03:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762830301;
	bh=IdEozLKYvHaOq3HzdNOAAfYq9jXios/DLpMqxSgeiLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kkKncGeCAD69n3dgHD3JJrUvtPdJS6SpLkKgSyvpT2TcF8sqUYHTw8X5Sfh1wwI+E
	 PjRz+I7JFOBRqVDZ+pS3Zs8CzlPEkPl9HywOVILeNtSavkn5U08DWJxR8Yf6amWOvN
	 DyZ0wl6yWUlRMzx5BoFh7/NFmNzvCXemjV3wjUoSeQNIRKevhLJvjfoyvfuDej5EW6
	 wQ2voYLBqJVAOj0+uTG8/clwhAya/8K5sPUMsa56WLaknbe6GINExLPHILqWbUR6By
	 fZcQ6vxJLe24ZvzImqcLnI/yz+VkfIBM/jPkNCez8CVG/cKsGOx5u6sKqY4jb4K3lm
	 gbtFCXcSnSLyA==
Date: Mon, 10 Nov 2025 19:04:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
 <shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
 <luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur
 Stavi <gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v06 5/5] hinic3: Add netdev register interfaces
Message-ID: <20251110190459.1e67306d@kernel.org>
In-Reply-To: <992e9004fe0c32964a3d32a298dc9d869c00d6cb.1762581665.git.zhuyikai1@h-partners.com>
References: <cover.1762581665.git.zhuyikai1@h-partners.com>
	<992e9004fe0c32964a3d32a298dc9d869c00d6cb.1762581665.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Nov 2025 14:41:40 +0800 Fan Gong wrote:
> Add netdev notifier to accept netdev event.
> Refine port event type to change link status.

Please explain the "why", why is this patch needed.
This commit message is woefully inadequate for this patch.
Plus the patch seems to, again, be doing multiple things.

> +static int hinic3_netdev_event(struct notifier_block *notifier,
> +			       unsigned long event, void *ptr)
> +{
> +	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(ndev);
> +	u16 vlan_depth;
> +
> +	if (!is_vlan_dev(ndev))
> +		return NOTIFY_DONE;
> +
> +	netdev_hold(ndev, &nic_dev->tracker, GFP_ATOMIC);
> +
> +	switch (event) {
> +	case NETDEV_REGISTER:
> +		vlan_depth = hinic3_get_vlan_depth(ndev);
> +		if (vlan_depth == HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT) {
> +			ndev->vlan_features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
> +		} else if (vlan_depth > HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT) {
> +			ndev->hw_features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
> +			ndev->features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
> +		}

Why are you doing this? Are vlan_features inherited across multiple
layers of vlan devices? Vlan tags can be pushed in multiple ways, not
just by stacking a device on top. If your device can't handle stacked
vlans and (somehow?) the stack is serving you multi-vlan frames I think
you need to fix it in ndo_features_check

