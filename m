Return-Path: <netdev+bounces-144937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0B9C8CB8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15AD281D71
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE484EB50;
	Thu, 14 Nov 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IrXdcmk1"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10130487BF
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594001; cv=none; b=TZ5FOE3FaODPNqMyDQhuz0gzevHQ7oTdt1WraDxhmKlUGwC38Vmsx1ypyCJm4K66giCBzCL6NYW9mHfnP/xup8Pl5T/ntZ9IKqpdq0cvZMST+ec6ybTIGpSo6XjIa2hpssQi208f67CaZeMlVoE2c16jJOxES5L7N9Vp/BWzQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594001; c=relaxed/simple;
	bh=c8t1hemtFw1xViiMrD+rCPlEMxNhgMSg9nPhSzeKpns=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NjIT8feAN8PfzpyZAas3JDEflTsw+cAoNV8ArAIWH/zkIdmw7rox0T/bpf+vQTM3s5EjiMYBtnmGCmLCh4YbL/nt6lf2Rd7uxvmmUT9QweiD/8TMcPjBgsQO+TS7eI8hRk++GSAuOFsl1XolPaTqJOEEPHAOHSK3EFn6LGJueRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IrXdcmk1; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ba2cd34-7698-43c4-a8a1-28c6f3744c93@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731593998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWhox2G4k38nvKDOICoKVGTbQD3IQLQ5MwRVPjzIQ70=;
	b=IrXdcmk1h67OCSFEucFXifi+ju5x+YluVK87Dm3Hdzc1cS6bLfKKoq664OTwgztVcXdEr1
	9aQ6quoudrZFxTRM4o8n+Of5nWpi7oKsS8IxrdfOAZFXx+pNvoMux0waPwtqxxHWvU2SQa
	kICOczzqqNgknJ33eq1Snk+TutJtACs=
Date: Thu, 14 Nov 2024 14:19:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 4/5] net: phy: Makefile: Add makefile support
 for ptp in Microchip phys
To: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
 arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com
References: <20241114120455.5413-1-divya.koppera@microchip.com>
 <20241114120455.5413-5-divya.koppera@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241114120455.5413-5-divya.koppera@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/11/2024 12:04, Divya Koppera wrote:
> Add makefile support for ptp library.
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
> v1 -> v2 -> v3 -> v4
> - No changes
> ---
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

