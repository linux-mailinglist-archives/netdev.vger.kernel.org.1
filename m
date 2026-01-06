Return-Path: <netdev+bounces-247266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E7CF65AC
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D23430A5EBE
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDB72D7D27;
	Tue,  6 Jan 2026 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRt+xple"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44622D6E7E;
	Tue,  6 Jan 2026 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663621; cv=none; b=JKS6YLXgQidwgO3QrvIqUvoa9TXZCp7jjFJHCAeoWr5UJO6fCBUkrV/HjjvPNveaW+iJBkUII7LR4l9MI8JKRFsp3bBIEX1DM+SjYbVBr+7PKxwm5svvzd7gjJ+o0HX7WVIddfXS9QJCUR+V19tB01NjGFVpGHsgHCaVbUs218c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663621; c=relaxed/simple;
	bh=9pSPigvRF/w+vWmJjy6s+rfcxL9aetwFUojgJCsxvok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJBdbp7tvGPiPTQPPBJls9oFD5vxQgNujdmNEcBS0SqzZZZbGMNSWiGlhVuQKrzSLsuuNxaGLVj16VvgE4i5c1Ud/yW3bD5rGOSJvCyhqFkT47y5RjcidyEGZdFXYwEzitBTSOY1dDCru5wjiw7MghIfuEWod92RlntrE+dcrUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRt+xple; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9617FC116D0;
	Tue,  6 Jan 2026 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663621;
	bh=9pSPigvRF/w+vWmJjy6s+rfcxL9aetwFUojgJCsxvok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PRt+xpleZe2nusaRbfIB9iLvP1nLZ5hs5B+b2cGRkVJ2uxF5DBQ+X+MWluVISJB0C
	 SPoHOFPbs5PK5pcI6fmArP8WriAJ124WIGUFTOjTXTIflqPEyMUsjfndP8NHcdE4NA
	 470PAWxl1m6ca6A5Ko6m9MUtr17kETE81J9C/vz4wdsq/4TnKn3NKX+M/XRNZ/Vyct
	 JQigsx7d4u0rwXOwlk0OlOM0945+AtfEQ5bP55NkLRwRkZQx5u6hF4NPBlFcKHow7y
	 PMH4EcgqP3iFe1yMH5tifKseXpbUmgidGo+iAlN7hSugNMdjY8zZES3aHiNHl5Ia14
	 uJ/qUYtno0sBg==
Date: Mon, 5 Jan 2026 17:40:19 -0800
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
 <luoyang82@h-partners.com>
Subject: Re: [PATCH net-next v08 4/9] hinic3: Add .ndo_set_features and
 .ndo_fix_features
Message-ID: <20260105174019.1bbe2bd3@kernel.org>
In-Reply-To: <f46d3f76a7662374544d2b0dd16ed1ef04f1b8e9.1767495881.git.zhuyikai1@h-partners.com>
References: <cover.1767495881.git.zhuyikai1@h-partners.com>
	<f46d3f76a7662374544d2b0dd16ed1ef04f1b8e9.1767495881.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

AI code review points out:

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
> index 7fec13bbe60e..c8944c51e6bf 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c

[ ... ]

> +int hinic3_set_rx_vlan_offload(struct hinic3_hwdev *hwdev, u8 en)
> +{
> +	struct l2nic_cmd_vlan_offload vlan_cfg = {};
                                              ^^^^
Note the zero initialization here.

[ ... ]

> +int hinic3_set_vlan_filter(struct hinic3_hwdev *hwdev, u32 vlan_filter_ctrl)
> +{
> +	struct l2nic_cmd_set_vlan_filter vlan_filter;
                                                   ^
Should this be zero-initialized with = {} like the other similar
functions in this file (hinic3_set_rx_lro, hinic3_set_rx_lro_timer,
hinic3_set_rx_vlan_offload)?

When hinic3_send_mbox_to_mgmt() fails, vlan_filter.msg_head.status
contains garbage which is then printed in the dev_err() message below.
Additionally, the uninitialized rsvd[2] and msg_head fields are sent to
the firmware in the mailbox message.

> +	struct mgmt_msg_params msg_params = {};
> +	int err;

