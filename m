Return-Path: <netdev+bounces-47873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9F97EBB95
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C201C2082F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 03:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D764C;
	Wed, 15 Nov 2023 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113B647
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 03:10:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F7CC;
	Tue, 14 Nov 2023 19:10:26 -0800 (PST)
X-UUID: df0923009789443b92081bd86a10a190-20231115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c51b2fcb-1af7-4c37-a47a-515b1231aefe,IP:5,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-INFO: VERSION:1.1.32,REQID:c51b2fcb-1af7-4c37-a47a-515b1231aefe,IP:5,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:8db4a972-1bd3-4f48-b671-ada88705968c,B
	ulkID:231115111019276MBX4M,BulkQuantity:0,Recheck:0,SF:24|100|17|19|42|101
	|66|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: df0923009789443b92081bd86a10a190-20231115
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1716298209; Wed, 15 Nov 2023 11:10:15 +0800
Message-ID: <65077e87-25a6-40dd-a81d-8a6987979b28@kylinos.cn>
Date: Wed, 15 Nov 2023 11:10:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i40e: Use correct buffer size
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jeffrey.t.kirsher@intel.com, shannon.nelson@amd.com,
 kunwu.chan@hotmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <20231112110146.3879030-1-chentao@kylinos.cn>
 <20231113093112.GL705326@kernel.org>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20231113093112.GL705326@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Simon,
Thank you very much for taking the valuable time to point out my 
problems and shortcomings in detail.
It's my  bad.I misinterpreted 'IFALIASZ' in 'include/uapi/linux/if.h' as 
'IFNAMSIZ'. This led me to think that 'IFNAMSIZ' could be up to 256. 
Sorry again for the trouble.
Yes, it is good code to dynamically calculate the size of the parts that 
make up the 'buffer' and add them up to the size of the whole 'buffer', 
I got lazy because I saw that the other parts had a lot of fixed 'buffer 
size'. I will immediately modify the patch according to your detailed 
suggestions.
 From the code analysis, this place should have a 'snprintf truncation' 
problem, but the impact may not be very big, I found the potential 
problem during the compilation process, after changing the buffer size, 
recompilation will not alarm.
I'll follow your detailed suggestions and remove the 'Fixes' tag and add 
'iwl-next' to the subject.
Thank you again for your reply and guidance.

在 2023/11/13 17:31, Simon Horman 写道:
> [PATCH iwl-next]

