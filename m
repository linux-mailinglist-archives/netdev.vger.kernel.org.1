Return-Path: <netdev+bounces-206304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CAEB02862
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 02:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707B57B9CA6
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098AE78F58;
	Sat, 12 Jul 2025 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXpvlekc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE46288D2;
	Sat, 12 Jul 2025 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281005; cv=none; b=KY4DoNsbvnSvSww5R0ydoD611+uWAktbKcgovH87nCKgKJi7z34CzOShdbIcHJcNoQwfRyEoS3XunyGs7QO5ASQ3oEfIptRVppYUfErP+N+vL8P5bY/LuIOErqa3wiDyZW0OxiU89H9smkmOVbXgRihOS7Thp9wtidKlwF+qDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281005; c=relaxed/simple;
	bh=N7T8fp/TykjVgARHYgLV5Gqff32nPYS+SnujgOw7C0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFFCSr63rVEkx3Z6IEs0n17HT+pwRczYVa5d9Sv/tf8wfOHuqFkZTmx+Ym6up4EfX2Opqk9xGjbjFXtmmGdaL7MqVolmGOLbc4Ipv/eRztIxcVkU/xvyTxPUZpjprf9qtYSxd5YIBcYbvDigBVDW+3+tRj0ScOBAS4pLVUvY8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXpvlekc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8379AC4CEED;
	Sat, 12 Jul 2025 00:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752281005;
	bh=N7T8fp/TykjVgARHYgLV5Gqff32nPYS+SnujgOw7C0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kXpvlekcgihMfw6+PyVzMNUN0mhwQ9D7FVUKXsYES/ecjJC97MrQKqwW8Lymh+qO2
	 EIo6HFNCwYmeGl1TfZaX7mzj4EroatpFZlIbhVSD25KF7Lc3hf6vbpHOr9YlxIp95o
	 VEjUtwdtK1sMkxpDAMPaYEM8lx0KNaWNlS1qUr5zEww9e+pKbNyTwPA6Vb5iy1RjbD
	 ZsZMuldvMj5QnBxPiJnpkM6otkWVi7rjVySwCX/z7nqudOuun7BUKj7QVOvL30cwYj
	 YjJtNxOlektTT9DJdwUIOxbhoveFMSRk9AAZcOcb3mhtCXTIoJJ9O/fkL3x7hYAxth
	 Pdz6mclN2fb9A==
Date: Fri, 11 Jul 2025 17:43:23 -0700
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
 <shijing34@huawei.com>, Fu Guiming <fuguiming@h-partners.com>, Meny Yossefi
 <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
 <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v08 1/8] hinic3: Async Event Queue interfaces
Message-ID: <20250711174323.5f756f47@kernel.org>
In-Reply-To: <4b002d861f1f58ff4b970ef5fecf9d18338fde1c.1752126177.git.zhuyikai1@h-partners.com>
References: <cover.1752126177.git.zhuyikai1@h-partners.com>
	<4b002d861f1f58ff4b970ef5fecf9d18338fde1c.1752126177.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 14:08:17 +0800 Fan Gong wrote:
> +u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg)
> +{
> +	void __iomem *addr = hinic3_reg_addr(hwif, reg);
> +	__be32 raw_val;
> +
> +	raw_val = (__force __be32)readl(addr);
> +
> +	return be32_to_cpu(raw_val);
> +}
> +
> +void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val)
> +{
> +	void __iomem *addr = hinic3_reg_addr(hwif, reg);
> +	__be32 raw_val = cpu_to_be32(val);
> +
> +	writel((__force u32)raw_val, addr);

You should probably use iowrite32be and ioread32be here

> +	queue_work_on(WORK_CPU_UNBOUND, aeqs->workq, &eq->aeq_work);

What's the point of calling queue_work_on() if you're passing UNBOUND

> +	wmb();    /* Write the init values */

barriers are not a flush, you need to say what writes this is
_separating_

> +	err = request_irq(eq->irq_id, aeq_interrupt, 0,
> +			  eq->irq_name, eq);
> +
> +	return err;

you can return request_irq()s retval directly

> +	synchronize_irq(eq->irq_id);
> +	free_irq(eq->irq_id, eq);

no need to sync irq before free
-- 
pw-bot: cr

