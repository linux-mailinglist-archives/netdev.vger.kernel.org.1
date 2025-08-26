Return-Path: <netdev+bounces-216979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA914B36F18
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3859D1BC1F8E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315BB352078;
	Tue, 26 Aug 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jOHZuSr1"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1C35206F
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223420; cv=none; b=fLscR/sYH0xYhHpWptwJDouF39SkSpvjljD5hc6/Qscl7FkskG2Wtwu6NfvX7CD0ZxsId0hNe5lJm7MbATIJqIkqtx780E6CBOscuBPW9k678K3SvbfnmQ4W2ENkonaTI8WF4RPzJZAM0mGqmz7CoF3wm4W6ZAUjPBcXQGf/g8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223420; c=relaxed/simple;
	bh=FO3fWrT9CkYZh2JZaTvzuW+cGA21QVRcsAsxDcz2pvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRNXoL7iUyh8osi1GCetk2Vm2Dsnz095rFB97apw1NhTkDo8Lplk2UtEielhFRNGZoZ7KxIlW2zyJiv53usYhxjiibV9RnONEKwbueAv8yiNyo4+yVvgCkzQKbF2IRahw0IPKJUNqutDGj/JKKY0+jUjO54Pzsdv3ATnK5IYg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jOHZuSr1; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8351e9e6-644e-4ff5-8ba1-fc643640c033@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756223405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwWNoRwD+zC/ISIWXResjG03lEV7XS1UMfZXQpIbYK4=;
	b=jOHZuSr1tLTt3GUOnOwR7bkroTLPv2hKJWiunV8OztvOE1F/ZFGzaBnD7WdVp+8/3P3gxv
	WeH4e+fmQZgdPKQqHw631m4NzqrwMleRFZI24muB5x438+6cdPb6tVvYMEHzyB03ngg+zB
	RNh0zO4GVCOt/6tdpxjbQKixQej1bFs=
Date: Tue, 26 Aug 2025 16:49:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v01 06/12] hinic3: Nic_io initialization
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
 <80632b268b7aa257852f68e4fe67081c59290a76.1756195078.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <80632b268b7aa257852f68e4fe67081c59290a76.1756195078.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/08/2025 10:05, Fan Gong wrote:
> Add nic_io initialization to enable NIC service, initialize function table
> and negotiate activation of NIC features.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   .../net/ethernet/huawei/hinic3/hinic3_hwdev.c | 15 +++++
>   .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 24 ++++++++
>   .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  2 +
>   .../ethernet/huawei/hinic3/hinic3_nic_io.c    | 61 ++++++++++++++++++-
>   4 files changed, 99 insertions(+), 3 deletions(-)

[...]

> +int hinic3_init_function_table(struct hinic3_nic_dev *nic_dev)
> +{
> +	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
> +	struct l2nic_func_tbl_cfg func_tbl_cfg;
> +	u32 cfg_bitmap;
> +
> +	func_tbl_cfg.mtu = 0x3FFF; /* default, max mtu */
> +	func_tbl_cfg.rx_wqe_buf_size = nic_io->rx_buf_len;

func_tbl_cfg can still have garbage in rsvd field, which then will be
passed down to FW. Better to init it to 0 to avoid exposing data.

> +
> +	cfg_bitmap = BIT(L2NIC_FUNC_TBL_CFG_INIT) |
> +		     BIT(L2NIC_FUNC_TBL_CFG_MTU) |
> +		     BIT(L2NIC_FUNC_TBL_CFG_RX_BUF_SIZE);
> +
> +	return hinic3_set_function_table(nic_dev->hwdev, cfg_bitmap,
> +					 &func_tbl_cfg);
> +}
> +

[...]

> +static int init_nic_io(struct hinic3_nic_io **nic_io)
> +{
> +	*nic_io = kzalloc(sizeof(**nic_io), GFP_KERNEL);
> +	if (!(*nic_io))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>   int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev)
>   {
> -	/* Completed by later submission due to LoC limit. */
> -	return -EFAULT;
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	struct hinic3_nic_io *nic_io;
> +	int err;
> +
> +	err = init_nic_io(&nic_io);
> +	if (err)
> +		return err;

there is no need for init_nic_io(). you can call kzalloc() directly
in hinic3_init_nic_io() and return -ENOMEM in case of NULL return

> +
> +	nic_dev->nic_io = nic_io;
> +

