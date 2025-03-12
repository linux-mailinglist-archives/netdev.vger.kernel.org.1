Return-Path: <netdev+bounces-174228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0011A5DE39
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA9B16C848
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9DD24DFF5;
	Wed, 12 Mar 2025 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYDXXwUa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C324DFEC;
	Wed, 12 Mar 2025 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786772; cv=none; b=nCGwgAEXrw5573vOD4w9oXrjfcdE2bKIbm7hmOQaFF8RuL6ffPwBi++s1DJDUFl8e88ZrBu/7AylD4g/lrhoDDLUEZHqEfsf3bSudoBaQcV7WDBh2rQJH6JGm86z0CwV2ifFILMt4RItWHxqaQAyUqRLytvoaGuaSrMyGcVTzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786772; c=relaxed/simple;
	bh=blSMd+ip1wX3c56Bl/lVcDQMN77dkbGIeDaWs3/81Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCU9pMTCLpWdcXue2x84ELUYmftnLmwtFPMdKFTKGocBJcnyBsgmnn//32nJtbAxkKd2VkNoFMpmdRSXDu2aRrPI8WYCd4aGjn3s0eDkMaZSXkW5FdWLwJU5OhqqNcfqhEReXdW0pyJRURvyQy88fgK/o95FI8YNeKzIAE2lm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYDXXwUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961E7C4CEEC;
	Wed, 12 Mar 2025 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741786772;
	bh=blSMd+ip1wX3c56Bl/lVcDQMN77dkbGIeDaWs3/81Is=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UYDXXwUaqosXaV3w71qysm01C6xWaetISPv62DTByD3/fU58nUD6BFjottqgr8mA4
	 vnMlpO6D9EU7mvJgtpswUt0ub/3QFRvahfKqPbToTDMliU3cdegUGD2KXuylJUalhS
	 EzzOkrs617JKCRaw51WfOQT3UF2mdJIRCyAQq4plh12xNd6sW/9NSyZHrtAy8etvux
	 eRUuaI8m3G3kMBoLLpdbN/xW/8WXbW1LBaZOpE2G6aRut2I1VeCbm+wXQxFyIFoz1B
	 z72L7s7d3rpYZqaAmkId9xIr9UTq1AmpsPFxjesYyXMkXByxECEiLLAebNsf6VeZyz
	 PPTlDZMwVerkg==
Message-ID: <80a1f61a-b2aa-414f-b446-087db7fc54a5@kernel.org>
Date: Wed, 12 Mar 2025 15:39:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ethernet: ti: am65-cpsw: Fix NAPI
 registration sequence
To: Siddharth Vadapalli <s-vadapalli@ti.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, alexander.sverdlin@siemens.com,
 dan.carpenter@linaro.org, c-vankar@ti.com, jpanis@baylibre.com,
 npitre@baylibre.com
Cc: vigneshr@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20250311154259.102865-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250311154259.102865-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/03/2025 17:42, Siddharth Vadapalli wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Registering the interrupts for TX or RX DMA Channels prior to registering
> their respective NAPI callbacks can result in a NULL pointer dereference.
> This is seen in practice as a random occurrence since it depends on the
> randomness associated with the generation of traffic by Linux and the
> reception of traffic from the wire.
> 
> Fixes: 681eb2beb3ef ("net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path")
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>


