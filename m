Return-Path: <netdev+bounces-161174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E036BA1DC03
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D9F7A3683
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB43018CBFC;
	Mon, 27 Jan 2025 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qkJ8mp44"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FCC1EA91
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002320; cv=none; b=q3pcbEGsBHRfO86r06SBtlb6VR7pjR+9nZ9VzCJonDHUcQonC1ykyLxout2W75BLkWr+lTyjlNY+wHTeXWAnFVN4TU+EsP9VpVl4/1o3/vs8yTSUYPJIQk3XOcxcqwXO7mBeaeF5MjGRXtJFZYdpDiTiO6RCskrONRM6n5rHlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002320; c=relaxed/simple;
	bh=ZLCYLVFPaphRGJltsPOu1j0v3nQ9Ra/U5rdLPeqfmeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSMKjfdZ66ogZVTzsnAsF6xzdIDOJ7PR/emjTz1pwHbtbZwkZugwAPErgObhfaylNxndkKxq/Jzln9oWLf8bxV3/xrlCJ9JNtHTz3pDG1URwV1PmZ9Pp+pegcrBG9JW8Kg8sWMPsoHOYtL65azui7F7kYNu4ztx/1n3EMYCz36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qkJ8mp44; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bd0f4776-1a7a-4b99-9245-49a636be8238@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738002301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Imgxozkm6aUWVB9gzKkThS2UchPua13u8YtM2MiEcIQ=;
	b=qkJ8mp449t69E5hfdt/+sgt2Pz8v/LBsRF/xab3q2SHHaSEVN91uDDJTnX5k6ctYh5um89
	vepBVGo0sP6O40g9WKSydJo4q1hvS2DNaTYYRdjkCENWeeYItK9CY5JjoBViwawMCFiFlS
	rHoTe1SOGziwra6qKvkPG1guNr1xOeg=
Date: Tue, 28 Jan 2025 02:24:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability value
 when FIFO size isn't specified
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Furong Xu <0x1207@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 1/27/25 09:38, Kunihiko Hayashi 写道:
> When Tx/Rx FIFO size is not specified in advance, the driver checks if
> the value is zero and sets the hardware capability value in functions
> where that value is used.
> 
> Consolidate the check and settings into function stmmac_hw_init() and
> remove redundant other statements.
> 
> If FIFO size is zero and the hardware capability also doesn't have upper
> limit values, return with an error message.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng


