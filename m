Return-Path: <netdev+bounces-120518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51D959B22
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B6CB248F5
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2F0134AC;
	Wed, 21 Aug 2024 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J60k7Img"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152A1531DD;
	Wed, 21 Aug 2024 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241211; cv=none; b=YSkMocGEFAwDQg4BrOgzhcW6W1FBHFow1oLBHlAxmVdanRvM0Ba26vbpgILqWUJXqqFxXT7u97gSv7MA8WdYgvvAl1cWxrH6jI1aLI6E8bdmCd77rXXWOD48BmXqyEWr7iBSQq7RDRSVnmDWutuzFMFx7T4QHU16S9TJYNyyl0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241211; c=relaxed/simple;
	bh=SjvoXMNdM73BPuawH5vc8ASiJ4k7N2z502aoHa7wGB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xx2VgSeOSBTwljE3U4bTgGp4V5WT5WGL13I1+8rMhfmYzmbPSNC4grPzUVjHCLPtYcf/TAV7j0Om/qc6iJskZieaznE4UuaxRDE4nKKpALXDDn/mTKezNo4IRsIAeEc2wU3pbu75DJSKUzxF+omD3PdaDhYjOQXqBBIqqRYodg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J60k7Img; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B23DC32782;
	Wed, 21 Aug 2024 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724241210;
	bh=SjvoXMNdM73BPuawH5vc8ASiJ4k7N2z502aoHa7wGB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J60k7ImgqJtAuMSYlFwUmt8jq1IGk0xtivF1yoSEqx1TMeh4Q7NyaMyGt1QP6qMVM
	 8u8F9L6TFSwsE+8uLgNKlHkOWsFZLDE39Cg4bt8qGj7p7iSSn/z7FLQnfj/zGQnl0F
	 +EwJXmJ3FjFgCxeu0BHj1B/t7e/BVArUBcdYITfrgXPLyNZtohrC2ljDDaJYIlY/G4
	 IrvCwNLcngiZ9ENKix1Gr/MepK6BC+OZuxiSmnMawfJsSSDVH6+hKts65twfpXqfi1
	 i6LhtKDdIgXJ/qwuJ+tcvm/b27KVC5zEb3I0MuXqFcfIMPkW1MT5mq18gAzLlmKAB5
	 sD1Mwq0Z8ICJQ==
Message-ID: <ae36c591-3b26-44a7-98a4-a498ee507e27@kernel.org>
Date: Wed, 21 Aug 2024 14:53:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ti: icssg-prueth: Enable IEP1
To: "Anwar, Md Danish" <a0501179@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-2-danishanwar@ti.com>
 <aee5b633-31ce-4db0-9014-90f877a33cf4@kernel.org>
 <9766c4f6-b687-49d6-8476-8414928a3a0e@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <9766c4f6-b687-49d6-8476-8414928a3a0e@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/08/2024 14:33, Anwar, Md Danish wrote:
> Hi Roger,
> 
> On 8/21/2024 4:57 PM, Roger Quadros wrote:
>> Hi,
>>
>> On 13/08/2024 10:42, MD Danish Anwar wrote:
>>> IEP1 is needed by firmware to enable FDB learning and FDB ageing.
>>
>> Required by which firmware?
>>
> 
> IEP1 is needed by all ICSSG firmwares (Dual EMAC / Switch / HSR)
> 
>> Does dual-emac firmware need this?
>>
> 
> Yes, Dual EMAC firmware needs IEP1 to enabled.

Then this need to be a bug fix?
What is the impact if IEP1 is not enabled for dual emac.

> 
>>> Always enable IEP1
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---

-- 
cheers,
-roger

