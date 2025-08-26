Return-Path: <netdev+bounces-216926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CC3B3620C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E742B7C0C2D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363D1196C7C;
	Tue, 26 Aug 2025 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksJKezMk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DA2BE032;
	Tue, 26 Aug 2025 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213761; cv=none; b=aftocYwlrGYt1ssNvn9cFXk3DoutQ9183hElqsHqSFG00UZHulbVcO3NEkNwdPB9myv9WHw2iy3M2uGXWMfU/lIWrDxAB0GECwyIn2FK7s2sK9bnl5UJ3pYYTrRR8dKdGpXU2s/Awih+llqB/bPrL8IH/rGjKKxWXKKn6MA5FV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213761; c=relaxed/simple;
	bh=6dZlsnWsf374WhkOcVkKUPAlAKa77gNokg7mV4fgGNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjD/7c3th8/M3GOh7dT/Q4IZKRiwPQ6l7oWOzmzK53hm6+jhaOZD5A7PzO6qgeWtSHw6jA2UXlnwHTHvMmVLgmFYC3MWwlMpxPInD+AnLD2tDJI47AYlBswVSVBVlC/+OtlvFGSuV3qOhqHrJO0KjOgmtKB6fKTbMb4ZThZ6TuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksJKezMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A2FC4CEF1;
	Tue, 26 Aug 2025 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756213759;
	bh=6dZlsnWsf374WhkOcVkKUPAlAKa77gNokg7mV4fgGNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ksJKezMkGVns7hqhMdj/QheZBOZa97izPOEoDTnm+e672wOcXLxQb4YzbUXx1rgRl
	 lNX56B6coAbi8jrzLWH4Dt2lZ/7Zf8Zv+RjZd+074bnVV49AsxWe0QRzoNHGyn/7/s
	 QtTWDDvXxh+4ju77r++gP88SLHUQSDbM/iPi6r1m9TLW0Hxdnh4TbrdIB8bd8allc7
	 bVN30MPIYfMC99SC5E06he2mQFTUgiTGh20fAF50NIUx8Ve6hmsyukpwGB5FhDlrg1
	 ltrqPY9WHeUjUl4mvnRQqMl8ZzS/nzCFl7ngQEbUpLmW6VL4EOtFY2VboKEb9U+SqQ
	 aexjHKrBLEHkg==
Date: Tue, 26 Aug 2025 06:09:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
 <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <yzhu@maxlinear.com>, <sureshnagaraj@maxlinear.com>
Subject: Re: [PATCH net-next v2 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Message-ID: <20250826060918.1f6ffa3e@kernel.org>
In-Reply-To: <20250826031044.563778-3-jchng@maxlinear.com>
References: <20250826031044.563778-1-jchng@maxlinear.com>
	<20250826031044.563778-3-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 11:10:44 +0800 Jack Ping CHNG wrote:
> +	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		if (!of_device_is_compatible(np, "mxl,eth-mac"))
> +			continue;
> +
> +		ret = mxl_eth_create_ndev(pdev, np, &ndev);
> +		if (ret)
> +			goto err_cleanup;
> +
> +		drvdata->ndevs[i++] = ndev;
> +		if (i >= MXL_NUM_PORT)
> +			break;
> +	}

You need a of_node_put(np) before the goto and the break;
-- 
pw-bot: cr

