Return-Path: <netdev+bounces-184355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D0CA94F1D
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 12:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1917A5D80
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353F25FA09;
	Mon, 21 Apr 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Jr9bFziy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187DA92E;
	Mon, 21 Apr 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745229684; cv=none; b=ks4tFRLrdQ3XoLb04CakU4W/DR76gJWtiZQJTkTTKChu7lvBiwxxi/COfkvSBAwgQpImNYl8lrq+cLfQxIyN88LavP/Ehi3UaEXFC43DEXG3u5G9ZgRqUmk7qY8G7udwyKPJ2jqosqsPODa1NPSE38XKsgp5v+9ppN64QpgB5CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745229684; c=relaxed/simple;
	bh=oGkBMnPlWAAjsXcjxrVpQDeRO42P/LgMECqNM7eHB3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHeXyX4wqlj+Vt69D7GZeoxJV+Z6AKene6erH+tdg4E3gW8Fs8pvqOGttqyS1xUahyFqRmNQN10JBsXrDzkLUi6Vuex8LNieYxDrs7hw4m6FVA27WQIsk4ujPRN+wSl42jCi4ovwOuUU2MZ4/x7m+1KGAJfzURjO3E9KgruehYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Jr9bFziy; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 6nodu94BFBkGO6nogufHf5; Mon, 21 Apr 2025 11:52:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745229122;
	bh=wZeewDiYHHmFq11xB3jS4aVNbHi62o7MBMuIWgCm9oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Jr9bFziyT71sudM8/yGIqqBbNHxEobp6eP7D3Tt69vg8+TOSGezbr9ZMQVzN2k/qX
	 tVO5dwV5Uy5Sc1mGcmXwDBWIlBjpuWGimGW0DTu50DiC07WPP7JHhrmrWfGGpP7sKy
	 JsEDxnUGj31jXzNcnGWSRcDYna3oGfAZOrdZUSfYuBn5Em8Fwti67VsVEL9lSHLISx
	 qSpc/Q1KjTVco2rb5nTyaDkCvho1RU5i+/AN9VudW8PoZXsMUSUzzI0ytqCNPzvcJt
	 3Q31TZfQUmZhpiAtCPXjG2eM0wM0NUKkcdLm5lmQBs68bAPR/59G7cQQyRzPZHwlXM
	 gyBmAA4YiViZA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 21 Apr 2025 11:52:02 +0200
X-ME-IP: 90.11.132.44
Message-ID: <f7b99e11-c331-4613-8112-4fb5387649e8@wanadoo.fr>
Date: Mon, 21 Apr 2025 11:51:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/1] hinic3: module initialization and tx/rx
 logic
To: Gur Stavi <gur.stavi@huawei.com>, Fan Gong <gongfan1@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
 Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>
References: <cover.1745221384.git.gur.stavi@huawei.com>
 <60ec4dd1d484d9df8cdb8310980676bb2f6c5559.1745221384.git.gur.stavi@huawei.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <60ec4dd1d484d9df8cdb8310980676bb2f6c5559.1745221384.git.gur.stavi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/04/2025 à 09:47, Gur Stavi a écrit :
> From: Fan Gong <gongfan1@huawei.com>
> 
> This is [1/3] part of hinic3 Ethernet driver initial submission.
> With this patch hinic3 is a valid kernel module but non-functional
> driver.
> 
> The driver parts contained in this patch:
> Module initialization.
> PCI driver registration but with empty id_table.
> Auxiliary driver registration.
> Net device_ops registration but open/stop are empty stubs.
> tx/rx logic.
> 
> All major data structures of the driver are fully introduced with the
> code that uses them but without their initialization code that requires
> management interface with the hw.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> Co-developed-by: Gur Stavi <gur.stavi@huawei.com>
> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
> ---

Hi,

a few nitpick, should it help and in case of a v12.


> +static const struct auxiliary_device_id hinic3_nic_id_table[] = {
> +	{
> +		.name = HINIC3_NIC_DRV_NAME ".nic",
> +	},
> +	{},

Unneeded trailing , after a terminator.

> +};

...

> +int hinic3_alloc_txqs(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	u16 q_id, num_txqs = nic_dev->max_qps;
> +	struct pci_dev *pdev = nic_dev->pdev;
> +	struct hinic3_txq *txq;
> +	u64 txq_size;
> +
> +	txq_size = num_txqs * sizeof(*nic_dev->txqs);
> +	if (!txq_size) {

I think that if (!num_txqs) would be enough.

> +		dev_err(hwdev->dev, "Cannot allocate zero size txqs\n");
> +		return -EINVAL;
> +	}
> +
> +	nic_dev->txqs = kzalloc(txq_size, GFP_KERNEL);

and kcalloc() could be used here. (even if it is trivial that it can not 
overflow)

> +	if (!nic_dev->txqs)
> +		return -ENOMEM;
> +
> +	for (q_id = 0; q_id < num_txqs; q_id++) {
> +		txq = &nic_dev->txqs[q_id];
> +		txq->netdev = netdev;
> +		txq->q_id = q_id;
> +		txq->q_depth = nic_dev->q_params.sq_depth;
> +		txq->q_mask = nic_dev->q_params.sq_depth - 1;
> +		txq->dev = &pdev->dev;
> +	}
> +
> +	return 0;
> +}

...

> +netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	u16 q_id = skb_get_queue_mapping(skb);
> +	struct hinic3_txq *txq;
> +
> +	if (unlikely(!netif_carrier_ok(netdev))) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;

Why not goto err_drop_pkt;?

> +	}
> +
> +	if (unlikely(q_id >= nic_dev->q_params.num_qps)) {
> +		txq = &nic_dev->txqs[0];

Why update txd? It won't be used after the goto.

> +		goto err_drop_pkt;
> +	}
> +	txq = &nic_dev->txqs[q_id];
> +
> +	return hinic3_send_one_skb(skb, netdev, txq);
> +
> +err_drop_pkt:
> +	dev_kfree_skb_any(skb);
> +	return NETDEV_TX_OK;
> +}

...

CJ

