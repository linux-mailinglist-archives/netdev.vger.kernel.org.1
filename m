Return-Path: <netdev+bounces-62920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE26829D9D
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 16:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880562822B7
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042BC4A9AD;
	Wed, 10 Jan 2024 15:35:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775D4C3B1
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1404:4e00:4d59:1b1c:57c3:2fd1]
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <john@phrozen.org>)
	id 1rNabT-002iNz-TO; Wed, 10 Jan 2024 16:34:51 +0100
Message-ID: <fc232f99-ab04-406e-9f76-b328b2339d31@phrozen.org>
Date: Wed, 10 Jan 2024 16:34:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/7] MAINTAINERS: eth: mtk: move John to CREDITS
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
 <20240109164517.3063131-2-kuba@kernel.org> <20240110144851.GC9296@kernel.org>
From: John Crispin <john@phrozen.org>
In-Reply-To: <20240110144851.GC9296@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10.01.24 15:48, Simon Horman wrote:
> On Tue, Jan 09, 2024 at 08:45:11AM -0800, Jakub Kicinski wrote:
>> John is still active in other bits of the kernel but not much
>> on the MediaTek ethernet switch side. Our scripts report:
>>
>> Subsystem MEDIATEK ETHERNET DRIVER
>>    Changes 81 / 384 (21%)
>>    Last activity: 2023-12-21
>>    Felix Fietkau <nbd@nbd.name>:
>>      Author c6d96df9fa2c 2023-05-02 00:00:00 42
>>      Tags c6d96df9fa2c 2023-05-02 00:00:00 48
>>    John Crispin <john@phrozen.org>:
>>    Sean Wang <sean.wang@mediatek.com>:
>>      Author 880c2d4b2fdf 2019-06-03 00:00:00 5
>>      Tags a5d75538295b 2020-04-07 00:00:00 7
>>    Mark Lee <Mark-MC.Lee@mediatek.com>:
>>      Author 8d66a8183d0c 2019-11-14 00:00:00 4
>>      Tags 8d66a8183d0c 2019-11-14 00:00:00 4
>>    Lorenzo Bianconi <lorenzo@kernel.org>:
>>      Author 7cb8cd4daacf 2023-12-21 00:00:00 98
>>      Tags 7cb8cd4daacf 2023-12-21 00:00:00 112
>>    Top reviewers:
>>      [18]: horms@kernel.org
>>      [15]: leonro@nvidia.com
>>      [8]: rmk+kernel@armlinux.org.uk
>>    INACTIVE MAINTAINER John Crispin <john@phrozen.org>
>>
>> Signed-off-by: John Crispin <john@phrozen.org>
> I am curious, did John sign off on this?

I did indeed. gave Jakub the SoB when he asked but sending the this patch.

for correctness here it is again

Signed-off-by: John Crispin <john@phrozen.org>

>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Other than the above, this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

