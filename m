Return-Path: <netdev+bounces-55146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93A8098FE
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 03:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F7C1C20CA2
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 02:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3B5187A;
	Fri,  8 Dec 2023 02:05:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF199171E;
	Thu,  7 Dec 2023 18:05:38 -0800 (PST)
X-UUID: 28a566b3f8204084b30c96f2d8731c4f-20231208
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:9e21759c-9205-4365-ad3d-d091008edafa,IP:5,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-8,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-8
X-CID-INFO: VERSION:1.1.33,REQID:9e21759c-9205-4365-ad3d-d091008edafa,IP:5,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-8,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-8
X-CID-META: VersionHash:364b77b,CLOUDID:7da28a73-1bd3-4f48-b671-ada88705968c,B
	ulkID:2312080726120IXEW9CF,BulkQuantity:4,Recheck:0,SF:44|101|64|66|24|100
	|17|19|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 28a566b3f8204084b30c96f2d8731c4f-20231208
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1069750080; Fri, 08 Dec 2023 10:05:28 +0800
Message-ID: <b0745f11-0483-4898-9b92-dc73afd5e64b@kylinos.cn>
Date: Fri, 8 Dec 2023 10:05:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iwl-next] i40e: Use correct buffer size in
 i40e_dbg_command_read
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jeffrey.t.kirsher@intel.com,
 shannon.nelson@amd.com, kunwu.chan@hotmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 intel-wired-lan@lists.osuosl.org
References: <20231205095844.2532859-1-chentao@kylinos.cn>
 <2a0f3c2a-71fe-4c79-8827-e53088bf3761@intel.com>
 <92e5cc01-e8b3-b6d2-e884-3d6bd001f0d0@intel.com>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <92e5cc01-e8b3-b6d2-e884-3d6bd001f0d0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the reminder. It was my negligence.

I'll resend the v5 patch:
1. Keep 'Signed-off-by' be the last tag in the block
2. Cc to 'intel-wired-lan@lists.osuosl.org'
3. Cc to my personal email 'kunwu.chan@hotmail.com'

Thanks again,
Kunwu

On 2023/12/8 07:25, Tony Nguyen wrote:
> 
> 
> On 12/6/2023 4:40 AM, Alexander Lobakin wrote:
>> From: Kunwu Chan <chentao@kylinos.cn>
>> Date: Tue, 5 Dec 2023 17:58:44 +0800
>>
>>> The size of "i40e_dbg_command_buf" is 256, the size of "name"
>>> depends on "IFNAMSIZ", plus a null character and format size,
>>> the total size is more than 256.
>>>
>>> Improve readability and maintainability by replacing a hardcoded string
>>> allocation and formatting by the use of the kasprintf() helper.
>>>
>>> Fixes: 02e9c290814c ("i40e: debugfs interface")
>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>> Suggested-by: Simon Horman <horms@kernel.org>
>>> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>> Your Signed-off-by must be the last tag in the block.
>> Perhaps the maintainer could fix it when taking, so that you wouldn't
>> need to send a new version only due to that.
> 
> You missed Intel Wired LAN (intel-wired-lan@lists.osuosl.org) on this, 
> though the other versions did have it. Could you fix this up and be sure 
> to include Intel Wired LAN?
> 
> Thanks,
> Tony
> 
>>> ---
>>> v2
>>>     - Update the size calculation with IFNAMSIZ and 
>>> sizeof(i40e_dbg_command_buf)
>>> v3
>>>     - Use kasprintf to improve readability and maintainability
>>> v4
>>>     - Fix memory leak in error path

