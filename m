Return-Path: <netdev+bounces-185810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA22A9BCA1
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B87A7B3F5E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C788213C3C2;
	Fri, 25 Apr 2025 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+R+F4NF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953B043AA8;
	Fri, 25 Apr 2025 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547048; cv=none; b=olJdM3pTBefoWaMluytXNkJG/SEb3tatoQiLsu3XrzlQtTlLwQLPr4umWN0ahNz0CRFC5UxRREjSsRDBSetlS9bQT0DyNKY/Qs3OrFdUtaZUtkWUkhETpAE+6woMrMCZiAHbxb2KSJ+Ov1cmEfSZggKGvqPgvJ2xRHZx5jZmx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547048; c=relaxed/simple;
	bh=QRw/DYAEbDloOCSEsv2ywKTtmu3aHUR7BaB6HZib6wM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0weXIgBgDqjzBxzFv3oyomVtRUl+cCC+rJcfWFRvAyA5SS092NDYd9ZgpxCBCg3mA2QbTDuTbs0D9uVgOIFIxsLsyKXuciOsEIlkhsinX43E0wL8QECltzSWEbwOCAomYnP5cBzjfpzhJA1RNM2kpr52Y2ZzbiEE6G2CEcXzYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+R+F4NF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0421EC4CEE3;
	Fri, 25 Apr 2025 02:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745547048;
	bh=QRw/DYAEbDloOCSEsv2ywKTtmu3aHUR7BaB6HZib6wM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s+R+F4NFC237tjSlVacoyM9H1w6BD1NCkul7bNNG/I9DDPY06EL/ptwxpcRoEFbur
	 FVJdEsCRgmI7RlusgdOey1F4mgLu6n9ZazFryUnkndZqphStmCG3enRz4NzizaR72n
	 qDmcuHKr2ycYw4YPg+XYnEUUCVBp9E/yUpAffhiKJYIbbBmO/U26JLkAOdjzRk2XPK
	 OZWHGUMXw/5BzGlOf3ATwPC3U3lSaxBe47OcL5zealmO0gvcAamn81t0eoPxGOhlaR
	 3ob7ZAcI7alRC/l10h71D/PJY/KHz9ypGrynGG8ftUlqz5YdXa585FGehQ8QIFL90l
	 De5yUUqg/0avw==
Date: Thu, 24 Apr 2025 19:10:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: Fan Gong <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Lee Trager
 <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Joe
 Damato <jdamato@fastly.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v12 1/1] hinic3: module initialization and
 tx/rx logic
Message-ID: <20250424191046.523383fd@kernel.org>
In-Reply-To: <cc01acb5ebc96c4edc7f85955379fb50ce27484b.1745411775.git.gur.stavi@huawei.com>
References: <cover.1745411775.git.gur.stavi@huawei.com>
	<cc01acb5ebc96c4edc7f85955379fb50ce27484b.1745411775.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 15:41:53 +0300 Gur Stavi wrote:
> +	/* flip page offset to other buffer */
> +	rx_info->page_offset ^= rxq->buf_len;
> +	get_page(page);

Please don't implement local page recycling. Use page_pool instead,
it's been around for almost a decade and because its explicitly
managed by the networking stack its much more effective.

I pointed the same thing out during Yunsilicon XSC driver review,
which is ongoing in parallel. You should really read the mailing list
if you want to make progress with work within the community.

> +reuse_rx_page:
> +	hinic3_reuse_rx_page(rxq, rx_info);
> +	return;
> +
> +unmap_page:
> +	/* we are not reusing the buffer so unmap it */
> +	dma_unmap_page(rxq->dev, rx_info->buf_dma_addr, rxq->dma_rx_buff_size, DMA_FROM_DEVICE);

nit: please wrap the lines at 80 chars, unless it hurts readability.
You can use --max-line-length=80 with checkpatch
-- 
pw-bot: cr

