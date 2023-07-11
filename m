Return-Path: <netdev+bounces-16742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C4E74E9E2
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009C11C20CCC
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE75E1774E;
	Tue, 11 Jul 2023 09:09:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364517723
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:09:03 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id EE237A6
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 02:09:01 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 01E8E6062ABEE;
	Tue, 11 Jul 2023 17:08:51 +0800 (CST)
Message-ID: <8e29ce60-f194-877c-e45f-7d1f350c5a43@nfschina.com>
Date: Tue, 11 Jul 2023 17:08:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 06/10] ice: remove
 unnecessary (void*) conversions
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: yunchuan <yunchuan@nfschina.com>
In-Reply-To: <da09fbe5-17e6-bea4-80dd-be4a0394541e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/11 16:35, Przemek Kitszel wrote:

> On 7/10/23 08:41, Su Hui wrote:
>> From: wuych <yunchuan@nfschina.com>
>>
>> Pointer variables of void * type do not require type cast.
>
> You should rather tell what are you doing here, perhaps:
> Drop casts on dim->priv access, which is "void *".
>
Thanks for you advice!
Should I resend this patch to modify this?
>>
>> Signed-off-by: wuych <yunchuan@nfschina.com>
>
> You have to provide your own Sign-off when sending patches of other devs.
>
> Also, preferable format is "Name Surname <email>", not a 
> nickname/corpo-id.
>
So sorry for this , I have already changed this to my full name "Wu 
Yunchuan".

Wu Yunchuan

>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c 
>> b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 93979ab18bc1..52af3bd80868 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -6242,7 +6242,7 @@ static void ice_tx_dim_work(struct work_struct 
>> *work)
>>       u16 itr;
>>         dim = container_of(work, struct dim, work);
>> -    rc = (struct ice_ring_container *)dim->priv;
>> +    rc = dim->priv;
>>         WARN_ON(dim->profile_ix >= ARRAY_SIZE(tx_profile));
>>   @@ -6262,7 +6262,7 @@ static void ice_rx_dim_work(struct 
>> work_struct *work)
>>       u16 itr;
>>         dim = container_of(work, struct dim, work);
>> -    rc = (struct ice_ring_container *)dim->priv;
>> +    rc = dim->priv;
>>         WARN_ON(dim->profile_ix >= ARRAY_SIZE(rx_profile));
>
> Code per-se looks ok

