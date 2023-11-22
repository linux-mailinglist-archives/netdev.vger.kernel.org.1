Return-Path: <netdev+bounces-49934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE3D7F3E94
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 08:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651891C20A09
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 07:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C931799D;
	Wed, 22 Nov 2023 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ACE110;
	Tue, 21 Nov 2023 23:05:39 -0800 (PST)
X-UUID: c4ecf16c6ac744a6bd74b93463420173-20231122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:646ed184-da94-4180-af12-41e1c93f27bb,IP:5,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:646ed184-da94-4180-af12-41e1c93f27bb,IP:5,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:38365860-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:2311212011149OSNONXV,BulkQuantity:4,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c4ecf16c6ac744a6bd74b93463420173-20231122
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 572602639; Wed, 22 Nov 2023 15:05:32 +0800
Message-ID: <9b4d2367-97af-4e44-80aa-e591022afeb6@kylinos.cn>
Date: Wed, 22 Nov 2023 15:05:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, edumazet@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
 <20231119143913.654381-1-chentao@kylinos.cn>
 <7948d79d8e8052c600a208142755b7a74b4aeee0.camel@redhat.com>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <7948d79d8e8052c600a208142755b7a74b4aeee0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your reply.

I'll update it in v3,and add send it in a new thread.


Thanks,
Kunwu

On 2023/11/21 20:11, Paolo Abeni wrote:
> This does not look like the correct fixes tag, sparse warning is
> preexistent. Likely 23aebdacb05dab9efdf22b9e0413491cbd5f128f
> 
> Please sent a new revision with the correct tag, thanks

