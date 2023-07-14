Return-Path: <netdev+bounces-17967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF06753DC7
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 16:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350AE2820DC
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C81FD310;
	Fri, 14 Jul 2023 14:41:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44F13709
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 14:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47644C433C8;
	Fri, 14 Jul 2023 14:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689345705;
	bh=v+hmI+E8CFdIbhaPE1cYJ5+Z9tHO+FMtoE5Rt2xNFs4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KaySazSW4dAVye5Rx3jIjrpyFsxxWb121CCaz7nDXENbmARMFaZ4TAQCwliW2Kkmj
	 hrxhsdYCQsxkOLIsWVl+YCyeYjVkb4bY/6pDnEYwhP3veOkCuhUEz9Jk3CbKKDibTp
	 2xaV+f9PQrgRJ2IkZ8blE0te1inkgKWVz0q1x1XgNFpej/JGdezJWTM0CXBuPmEVBk
	 NY/bN81BkReE3BF0oK8A5VECg3CHjUqyj+/CKKC/VEVGSd3594UKKIKr9rciRTh2U4
	 /fQMSqeYC/cpWWCyX42/YVIoQ1rT60mjcSn29XuYRuOkPqZpnmhdABFaf2uVqhoruD
	 /DJUADUGvmNvQ==
Message-ID: <26f27cf3-fd9b-462f-c337-a439e750dfb1@kernel.org>
Date: Fri, 14 Jul 2023 09:41:42 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] net: dwmac_socfpga: use the standard "ahb" reset
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, joabreu@synopsys.com,
 robh+dt@kernel.org, krzysztof.kozlowskii+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20230710211313.567761-1-dinguyen@kernel.org>
 <20230710211313.567761-2-dinguyen@kernel.org>
 <20230712170840.3d66da6a@kernel.org>
 <c8ffee03-8a6b-1612-37ee-e5ec69853ab7@kernel.org>
 <1061620f76bfe8158e7b8159672e7bb0c8dc75f2.camel@redhat.com>
 <20230713095116.15760660@kernel.org>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230713095116.15760660@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/13/23 11:51, Jakub Kicinski wrote:
> On Thu, 13 Jul 2023 14:39:57 +0200 Paolo Abeni wrote:
>>> However for ABI breaks with scope limited to only one given platform, it
>>> is the platform's maintainer choice to allow or not allow ABI breaks.
>>> What we, Devicetree maintainers expect, is to mention and provide
>>> rationale for the ABI break in the commit msg.
>>
>> @Dinh: you should at least update the commit message to provide such
>> rationale, or possibly even better, drop this 2nd patch on next
>> submission.
> 
> Or support both bindings, because the reset looks optional. So maybe
> instead of deleting the use of "stmmaceth-ocp", only go down that path
> if stpriv->plat->stmmac_ahb_rst is NULL?

I think in a way, it's already supporting both reset lines. The main 
dwmac-platform is looking for "ahb" and the socfpga-dwmac is looking for 
"stmmaceth-ocp".

So I'll just drop this patch.

Thanks for all the review.

Dinh

