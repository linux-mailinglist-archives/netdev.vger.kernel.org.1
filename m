Return-Path: <netdev+bounces-220685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E470B47C89
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 19:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B78C189A7CC
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EAB2853F3;
	Sun,  7 Sep 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pc5F4vkf"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C726285050
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757264539; cv=none; b=E6BxlaEaNgRi6GVK1bj5dKxzeqFrPAJwIAG+w/8wnpQHZypNuY/ViobsWAry2S+K6iWQBCRv2xN+ORV3+W6Wniuris1/pZDnxjnEL/OmuXAeMqM5kCNz8JSKCQvHrY2BUEm+nSVhLJKZfxw6X7Wtvkzi5XYm4UG6jTIWrV5wadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757264539; c=relaxed/simple;
	bh=pZD4tEIZUEKClZFShsoJNa/2iBOVNA9IPvLNH9RRFF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARDklxT0/DUY4t1noRlvV7kFDrFImz5wtdnVfwj90FoLSVD8AV1r1NERjX1h+MOG5FK8Dbl5ez7RLj+6b/mIYdn5pjADNhsfKI44xEg3GUXNYH9XxFH3kUfXtY/HkM/HazD3/w26c6YPfqeVRbczUTN6Vljadnr5OWqLBFDz8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pc5F4vkf; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <98c93693-0647-4c7e-ac1c-729502beab76@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757264534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BpoMe7d7Kugc9Y1D7mPUdyY4RnJVBGdaC/+fYtsNMQ=;
	b=Pc5F4vkfsytINfbG8VdYiuuX2FOWy8zm5XNcsP53lO+I+fCOOMtJznKQkytd5iuDzJBH5Y
	Uu5SIdP8Qp1yor43oYoRkPBZE461WtY6V4HDLYBKedKYuwBvW4kQ+jkdHF8DW2bx8RBRjj
	WubaymY0/1EV3nSTx7Nmutck9Qw2Z1g=
Date: Sun, 7 Sep 2025 18:02:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v04 06/14] hinic3: Nic_io initialization
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>,
 Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
 Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1757057860.git.zhuyikai1@h-partners.com>
 <0d48674ae76a54bf52dcdba64fb60eb26e7e7e70.1757057860.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <0d48674ae76a54bf52dcdba64fb60eb26e7e7e70.1757057860.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/09/2025 09:28, Fan Gong wrote:
> Add nic_io initialization to enable NIC service, initialize function table
> and negotiate activation of NIC features.

[...]

> +static DEFINE_IDA(hinic3_adev_ida);
> +
> +static int hinic3_adev_idx_alloc(void)
> +{
> +	return ida_alloc(&hinic3_adev_ida, GFP_KERNEL);
> +}
> +
> +static void hinic3_adev_idx_free(int id)
> +{
> +	ida_free(&hinic3_adev_ida, id);
> +}
> +
>   int hinic3_init_hwdev(struct pci_dev *pdev)
>   {
>   	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
> @@ -451,6 +463,7 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
>   	hwdev->pdev = pci_adapter->pdev;
>   	hwdev->dev = &pci_adapter->pdev->dev;
>   	hwdev->func_state = 0;
> +	hwdev->dev_id = hinic3_adev_idx_alloc();

Why do you need dev_id? It's not used anywhere in the patchset. The
commit doesn't explain it neither...


