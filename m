Return-Path: <netdev+bounces-233557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 626CFC15617
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E42F234779D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40C1340A6F;
	Tue, 28 Oct 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EZsqhVxV"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151133F8C3
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664674; cv=none; b=tun7xRnB6+s/if6JYA8tmJSTAw9XrOTQmWJd/VZbjAWNb3qX4FaFIsn7gKsSNgAbgQX78pLOMq+FOOFySY5CKqLAH2Hh6I9lp5eFhNDedKnwed8MBkz1lXdR55KmMtYZ56rmIhicsFrnctXPDQAUnJ+qD7CgYybM4JGpumNpqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664674; c=relaxed/simple;
	bh=h/fTVymgaJvkfoyoT2CPgZRPWZR24/ZVWdHWtw5oQqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5QIueDFG5MTg60fDY7dzteUT+s4SF0Y4nnIhWU43xYIpUXbAO+xHwxSl5ElbeSjcvAEDLsv+LhLtrRuFshT9zLGBouHAT5hvS7/D4fjMUPOjuDdno9emab3sXYTJNvwZxL3RX3EbVvtbA1UTbxVAF7a+SlMvsZOBJ1oHyk7OMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EZsqhVxV; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <13a02578-c021-4d5f-bf82-1ba6c62c5c90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761664669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZjTeHSm+oCOfSwkgA7mhxuIt7AJ24gnrh8+9ZuDjVU=;
	b=EZsqhVxVrEW+IRLJXgZ50JogB1P10gvjfnadeu6Xw/yAaQCcblp62rI4PIokh2ZsHrGCDF
	a6n+DspFOINYsm+advWV1UzMwGVOIt6Hmra4e0YKN1QjBNN5ZAgvKisArCYYk0NyHt5IOJ
	vFWXkT8mi0Z7wR4wqbcuC0yWI3sht1k=
Date: Tue, 28 Oct 2025 15:17:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v16 4/5] net: rnpgbe: Add basic mbx_fw support
To: Dong Yibo <dong100@mucse.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, danishanwar@ti.com, geert+renesas@glider.be,
 mpe@ellerman.id.au, lorenzo@kernel.org, lukas.bulwahn@redhat.com
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251027032905.94147-1-dong100@mucse.com>
 <20251027032905.94147-5-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251027032905.94147-5-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/10/2025 03:29, Dong Yibo wrote:
> Add fundamental firmware (FW) communication operations via PF-FW
> mailbox, including:
> - FW sync (via HW info query with retries)
> - HW reset (post FW command to reset hardware)
> - MAC address retrieval (request FW for port-specific MAC)
> - Power management (powerup/powerdown notification to FW)
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

