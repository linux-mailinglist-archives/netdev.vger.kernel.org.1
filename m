Return-Path: <netdev+bounces-57217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A98125DF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC0B1F21A46
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3F31378;
	Thu, 14 Dec 2023 03:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13D785;
	Wed, 13 Dec 2023 19:22:53 -0800 (PST)
X-UUID: cb819b51fc094807a3539f40913cb22c-20231214
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:a7d41c09-084b-4d27-867a-a7035c8e7d43,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.33,REQID:a7d41c09-084b-4d27-867a-a7035c8e7d43,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:01c127bd-2ac7-4da2-9f94-677a477649d9,B
	ulkID:231214112251LVGO6IGL,BulkQuantity:0,Recheck:0,SF:24|17|19|44|64|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: cb819b51fc094807a3539f40913cb22c-20231214
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 69105480; Thu, 14 Dec 2023 11:22:48 +0800
Message-ID: <0bc0a282-8a3d-460f-81af-ecf4cb92363c@kylinos.cn>
Date: Thu, 14 Dec 2023 11:22:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: vsc73xx: Add null pointer check to
 vsc73xx_gpio_probe
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kunwu Chan <kunwu.chan@hotmail.com>
References: <20231211024549.231417-1-chentao@kylinos.cn>
 <20231212132755.261ee49d@kernel.org>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20231212132755.261ee49d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your reply.

I'll remove 'dev_err' in v2 patch.

Thanks again.

On 2023/12/13 05:27, Jakub Kicinski wrote:
> On Mon, 11 Dec 2023 10:45:49 +0800 Kunwu Chan wrote:
>>   	vsc->gc.label = devm_kasprintf(vsc->dev, GFP_KERNEL, "VSC%04x",
>>   				       vsc->chipid);
>> +	if (!vsc->gc.label) {
>> +		dev_err(vsc->dev, "Fail to allocate memory\n");
>> +		return -ENOMEM;
>> +	}
> 
> Don't add error prints on memory allocations.
> There will be an OOM splat in the logs.

