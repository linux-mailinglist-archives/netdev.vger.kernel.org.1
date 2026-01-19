Return-Path: <netdev+bounces-251104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBA4D3AB70
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10133012BC6
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E23793C9;
	Mon, 19 Jan 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYpUirp9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F37E3793C2;
	Mon, 19 Jan 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832114; cv=none; b=iUopmmADiLTBEZLLa24s4o3BAkRzVFgWQOjMExH7AQI51c5zsqDch5gX4jkVJNFO5+qgOQR13uaLlC71ZAMODtW5rEOZ/1tgWQLHux9FAgWL9wVIAh2/CAZX1q5hp2H/O+si0KwZyEk8gEvBO3Wpif9QDCHzK0p7W0/wRJgGbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832114; c=relaxed/simple;
	bh=Hj3/9ZMFdm1YRHPhaH+cJZLcHlpCWDcrFvGiq/NC5Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNGlb3BPeaDGzOONA8fpX4ZeDr5FC8JNNQAKqTmH+a5SidZLJsuBPC0/LPGpeuc3fxFlTu3CpOk3ppX+so6EIqcQUD8nKsUx8leeOqjEfvnwbXTag3ntubF0OB5rHoIM6dwJDp0wGYUWNfG/CLaiVGZrloQQU7454dqLSO5jV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYpUirp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EA0C116C6;
	Mon, 19 Jan 2026 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832113;
	bh=Hj3/9ZMFdm1YRHPhaH+cJZLcHlpCWDcrFvGiq/NC5Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYpUirp9YsHdKHqpu9296GJtLRxg/BR+TraVgXjCQmLSyaljSiq7VCunIqM8aDtf8
	 uhACOO2uEMkiXAw0K39LUgXVyEonCUvOh4iSsAlmM/7xYKdC8x2NJLmn3Y4/sk7DfL
	 /DElFw0AsiwxrpCd8lEOzDXZdWonpPQRWGnniP9d/Ejj3hr73mYFyHRaQF8TrF8KKS
	 R+KYZgOSaO8Sjs3PA9tGD/d9dtTdGl3u09sEEHMj655xXaBjx82yUOpGqC0GhQVSdn
	 U8XHLMeEUlHc5jUPUS7AbD9ifvGHhpld8SAe6QRfYSuTXYzIM21aNJEdU9Pd92V3/e
	 atnqIpApKnjUg==
Date: Mon, 19 Jan 2026 14:15:08 +0000
From: Simon Horman <horms@kernel.org>
To: "wanquan.zhong" <zwq2226404116@163.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com, ricardo.martinez@linux.intel.com,
	netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	davem@davemloft.net, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	"wanquan.zhong" <wanquan.zhong@fibocom.com>
Subject: Re: [PATCH] [PATCH v2] wwan: t7xx: Add CONFIG_WWAN_ADB_PORT to
 control ADB debug port
Message-ID: <aW48bAZWZr8Bit8x@horms.kernel.org>
References: <20260114095434.148984-1-zwq2226404116@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114095434.148984-1-zwq2226404116@163.com>

On Wed, Jan 14, 2026 at 05:54:34PM +0800, wanquan.zhong wrote:
> From: "wanquan.zhong" <wanquan.zhong@fibocom.com>
> 
> Add a new Kconfig option for MediaTek T7xx WWAN devices, to
> conditionally enable the ADB debug port functionality. This option:
> - Depends on MTK_T7XX (specific to MediaTek T7xx devices)
> - Defaults to 'y', as disabling it may cause difficulties for T7xx
> debugging
> - Requires EXPERT to be visible (to avoid accidental enablement)
> 
> In t7xx_port_proxy.c, wrap the ADB port configuration struct with
> CONFIG_WWAN_ADB_PORT, so the port is only exposed when
> the config is explicitly enabled.
> 
> This addresses security concerns in certain systems (e.g., Google
> Chrome OS)where root privileges could potentially trigger ADB
> configuration of WWAN devices.Note that only ADB port is restricted
> while MIPC port remains unrestricted,as MIPC is MTK's internal
> protocol port with no security risks.

Hi,

I'm entirely unfamiliar with the security model here.

But is it possible for someone with root privileges to replace
the driver, e.g. to one with ADB enabled?

> 
> While using a kernel config option for a single array element in t7xx may
> seem like resource overhead, this is the most straightforward
> implementation approach. Alternative implementation suggestions are
> welcome.
> 
> Signed-off-by: wanquan.zhong <wanquan.zhong@fibocom.com>

...

