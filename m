Return-Path: <netdev+bounces-219401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9BAB411ED
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EED5E07C6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45841DE2A5;
	Wed,  3 Sep 2025 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1Jkf2QJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260F2566;
	Wed,  3 Sep 2025 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862912; cv=none; b=H/7GEQJCM3iT+dWQxFIIxla9VHNEROkD+HrUUofm/1uI9K+itGS5J6qBUuoO+GRWsmXcO4FoMvxkNZYGLhs4kTZEmfvyohSiho3BVYa/nM1W+kBqu+LS8blU/g7VcUYzjRkAlKy3UQHMRGoCxG9so1dQ77Gk+/vEUwMXKgaAEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862912; c=relaxed/simple;
	bh=91f4ejBaiZx+nJEgw2oR6OjbxgiL6Xnd7YDBpAbKlJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sw73qN229ZDJP5lIKrdHCOU50m0Em6oE04Ei27qSFcvcH6Fmx6P98UJvhwjnX06bwUyfihRJBX2jrFkqziaIKbQ0DFwPGaIYtQgib/xB3dl/YQBnP15TzYf+9ec4CH+SWlPuLjQrrGTEZUQUd2PXsQGvaDwKs5RFW9TnCAAgt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1Jkf2QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3824C4CEED;
	Wed,  3 Sep 2025 01:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756862912;
	bh=91f4ejBaiZx+nJEgw2oR6OjbxgiL6Xnd7YDBpAbKlJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q1Jkf2QJwqzDQ5WOiPoE5VwUHLDCGkskS87tfNqFOvY26ABHJ2MTpshPxwzBw8PA+
	 pEuOAAUQyZ0pivBsY7k54bo1zo3hO5HfphFfSEWj9WOMEaCH4JhnI6kd1WeXV1Wvwj
	 dj2xQYQSKGsUFZvuwz1aTjFsi+5GBbP08QkvhO8uZmUeiyOvdA8MVD2hd1s8clSbBJ
	 90QJN8CF4LCHG2EwynlAQiE0aKcA6f+TNierJui7Ns9pnAMlvqZVlHLG94V+Q2Qq7e
	 jIXPhxM6f9QsYuJ6X8AwwdZI77S18YJ9hEZTA57DHizpVhCDs2zmrFJ5HdOEBTowha
	 dOM5w+SZT+frg==
Date: Tue, 2 Sep 2025 18:28:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
 <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
 <mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman
 Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v03 11/14] hinic3: Add Rss function
Message-ID: <20250902182829.2fc36565@kernel.org>
In-Reply-To: <aefef696392e1eadce2c9de833dc40feb439df8e.1756524443.git.zhuyikai1@h-partners.com>
References: <cover.1756524443.git.zhuyikai1@h-partners.com>
	<aefef696392e1eadce2c9de833dc40feb439df8e.1756524443.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 16:08:50 +0800 Fan Gong wrote:
> +static void hinic3_fillout_indir_tbl(struct net_device *netdev, u16 *indir)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	u16 i, num_qps;
> +
> +	num_qps = nic_dev->q_params.num_qps;
> +	for (i = 0; i < L2NIC_RSS_INDIR_SIZE; i++)
> +		indir[i] = i % num_qps;

ethtool_rxfh_indir_default()

> +/* Get number of CPUs on same NUMA node of device. */
> +static unsigned int dev_num_cpus(struct device *dev)
> +{
> +	unsigned int i, num_cpus, num_node_cpus;
> +	int dev_node;
> +
> +	dev_node = dev_to_node(dev);
> +	num_cpus = num_online_cpus();
> +	num_node_cpus = 0;
> +
> +	for (i = 0; i < num_cpus; i++) {
> +		if (cpu_to_node(i) == dev_node)
> +			num_node_cpus++;
> +	}
> +
> +	return num_node_cpus ? : num_cpus;

Please use netif_get_num_default_rss_queues().
If you think its heuristic should be improved -- fix it,
but don't invent driver-local logic.

> +static void decide_num_qps(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	unsigned int dev_cpus;
> +
> +	dev_cpus = dev_num_cpus(&nic_dev->pdev->dev);
> +	nic_dev->q_params.num_qps = min(dev_cpus, nic_dev->max_qps);

