Return-Path: <netdev+bounces-64483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7368354E8
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 09:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B242FB239D2
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BAE1E519;
	Sun, 21 Jan 2024 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ID4niUS6"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06489FBFC
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705826126; cv=none; b=WOdMg/PqEvnn/kE6CaKvamy8NuHcAwBuT20vgzkNTUKtWgTE8Ir4lULEthM5+BBTMMpkbKCdHPtnDV3xcrgIHwVj+UbKRKDjIVTZNP8i6YFu4uEvxJmzK1F7T2xKekA63gQv2RSNDCCL8atgPj2k9ywKoAMt0XCrMbqabf12dho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705826126; c=relaxed/simple;
	bh=E1j4lbGFKciuXk1Yg1UrA3T+hieubxNYeula/VLi/l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keAC+MFq5Tr2mYMyPcYRWyTNF1bC8HpnXLheZe/hYzH39D+8KCqQxlcJlIu0sDpj6uh6TtwMdbYwVX4XLOglPXwO6yDM1qg2P6QY1u/M+bj8VvzehLpazchzxyMdMPXpwrLzC7sTIjKL40N0aNunXfORk46qgGx5aiPZ9LaUNdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ID4niUS6; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <27319d3d-61dd-41e3-be6c-ccc08b9b3688@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705826119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+nKUquRVnsiH6ByWnfEanFY19iANj8L7VwJgB+g6PQ=;
	b=ID4niUS6btI4yknwMoJD2+kTFdn7M75cHav8CR/B+ezHxDwlWG4Pzvu8SUvG/lvDekjZN9
	v1QDEEgSL2mZApw6FtqFgNKAWIf7pdnrafm3xvkoHswrxrbQJRnPi6fDt62Qq5XbQlyvXk
	q0lkR9tyN1Vb61M3GOZiVrCrATcjaFk=
Date: Sun, 21 Jan 2024 16:34:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Linux Kernel Bug] UBSAN: array-index-out-of-bounds in
 rds_cmsg_recv
To: Chenyuan Yang <chenyuan0y@gmail.com>, santosh.shilimkar@oracle.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, "syzkaller@googlegroups.com"
 <syzkaller@googlegroups.com>, Zijie Zhao <zzjas98@gmail.com>
References: <CALGdzuoVdq-wtQ4Az9iottBqC5cv9ZhcE5q8N7LfYFvkRsOVcw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CALGdzuoVdq-wtQ4Az9iottBqC5cv9ZhcE5q8N7LfYFvkRsOVcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/1/19 22:29, Chenyuan Yang 写道:
> Dear Linux Kernel Developers for Network RDS,
> 
> We encountered "UBSAN: array-index-out-of-bounds in rds_cmsg_recv"
> when testing the RDS with our generated specifications. The C
> reproduce program and logs for this crash are attached.
> 
> This crash happens when RDS receives messages by using
> `rds_cmsg_recv`, which reads the `j+1` index of the array
> `inc->i_rx_lat_trace`
> (https://elixir.bootlin.com/linux/v6.7/source/net/rds/recv.c#L585).
> The length of `inc->i_rx_lat_trace` array is 4 (defined by
> `RDS_RX_MAX_TRACES`,
> https://elixir.bootlin.com/linux/v6.7/source/net/rds/rds.h#L289) while
> `j` is the value stored in another array `rs->rs_rx_trace`
> (https://elixir.bootlin.com/linux/v6.7/source/net/rds/recv.c#L583),
> which is sent from others and could be arbitrary value.

I recommend to use the latest rds to make tests. The rds in linux kernel 
upstream is too old. The rds in oracle linux is newer.

Zhu Yanjun

> 
> This crash might be exploited to read the value out-of-bound from the
> array by setting arbitrary values for the array `rs->rs_rx_trace`.
> 
> If you have any questions or require more information, please feel
> free to contact us.
> 
> Best,
> Chenyuan


