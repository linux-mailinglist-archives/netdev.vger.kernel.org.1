Return-Path: <netdev+bounces-24644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B96770EBF
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 10:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C4D1C20AFC
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C398484;
	Sat,  5 Aug 2023 08:24:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D8538B
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 08:24:10 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C97410CF;
	Sat,  5 Aug 2023 01:24:08 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RHwXJ0fCwz1Z1WS;
	Sat,  5 Aug 2023 16:21:20 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 5 Aug 2023 16:24:05 +0800
Subject: Re: [PATCH v2] wifi: iw_handler.h: Remove unused declaration
 dev_get_wireless_info()
To: Simon Horman <horms@kernel.org>
CC: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20230804133617.43564-1-yuehaibing@huawei.com>
 <ZM3/+pY9Fovc5AC9@vergenet.net>
From: Yue Haibing <yuehaibing@huawei.com>
Message-ID: <e19091f1-497a-b673-9010-2e0a48d5942e@huawei.com>
Date: Sat, 5 Aug 2023 16:24:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZM3/+pY9Fovc5AC9@vergenet.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/5 15:53, Simon Horman wrote:
> On Fri, Aug 04, 2023 at 09:36:17PM +0800, Yue Haibing wrote:
>> Commit 556829657397 ("[NL80211]: add netlink interface to cfg80211")
>> declared but never implemented this, remove it.
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>> v2: fix comment
>> ---
>>  include/net/iw_handler.h | 11 ++---------
>>  1 file changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
>> index d2ea5863eedc..b2cf243ebe44 100644
>> --- a/include/net/iw_handler.h
>> +++ b/include/net/iw_handler.h
>> @@ -426,17 +426,10 @@ struct iw_public_data {
>>  
>>  /**************************** PROTOTYPES ****************************/
>>  /*
>> - * Functions part of the Wireless Extensions (defined in net/core/wireless.c).
>> - * Those may be called only within the kernel.
>> + * Functions part of the Wireless Extensions (defined in net/wireless/wext-core.c).
> 
> Can I confirm that the wireless.c -> wext-core.c change is intentional?
> It doesn't seem strictly related to the patch description.

Commit 11433ee450eb ("[WEXT]: Move to net/wireless") rename  net/core/wireless.c to net/wireless/wext.c
then commit 3d23e349d807 ("wext: refactor") refactor wext.c to wext-core.c
The wext functions now sits in net/wireless/wext-core.c
This may need describe in patch description.
> 
>> + * Those may be called by driver modules.
>>   */
>>  
>> -/* First : function strictly used inside the kernel */
>> -
>> -/* Handle /proc/net/wireless, called in net/code/dev.c */
>> -int dev_get_wireless_info(char *buffer, char **start, off_t offset, int length);
>> -
>> -/* Second : functions that may be called by driver modules */
>> -
>>  /* Send a single event to user space */
>>  void wireless_send_event(struct net_device *dev, unsigned int cmd,
>>  			 union iwreq_data *wrqu, const char *extra);
>> -- 
>> 2.34.1
>>
> .
> 

