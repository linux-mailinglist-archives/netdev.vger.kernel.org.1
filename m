Return-Path: <netdev+bounces-25435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9944773F43
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740D1280A19
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7C01B7F4;
	Tue,  8 Aug 2023 16:42:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D51B7F0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:42:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B93815CB6;
	Tue,  8 Aug 2023 09:42:17 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKxWZ6Xy0zVk7m;
	Tue,  8 Aug 2023 23:12:42 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 23:14:36 +0800
Subject: Re: [PATCH] mac80211: mesh: Remove unused function declaration
 mesh_ids_set_default()
To: Johannes Berg <johannes@sipsolutions.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<nbd@nbd.name>, <pagadala.yesu.anjaneyulu@intel.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20230731140712.1204-1-yuehaibing@huawei.com>
 <cdf75cdfeb3640e7096940b3f15a8cd86bf5451e.camel@sipsolutions.net>
From: Yue Haibing <yuehaibing@huawei.com>
Message-ID: <6c95c1e8-67f2-0da4-b853-c306f67926cc@huawei.com>
Date: Tue, 8 Aug 2023 23:14:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cdf75cdfeb3640e7096940b3f15a8cd86bf5451e.camel@sipsolutions.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/8 16:24, Johannes Berg wrote:
> On Mon, 2023-07-31 at 22:07 +0800, Yue Haibing wrote:
>> Commit ccf80ddfe492 ("mac80211: mesh function and data structures definitions")
>> introducted this but never implemented.
>>
> 
> Btw, are you detecting these with some kind of tool? Having the tool
> would probably be more useful than you sending all these patches all the
> time ...
> 
Just use grep to check like below

grep -rP --include=*.c '^(?:\w+\s+){1,3}\*{0,3}\s{0,3}\w+[\t]*\(' * |grep -P -oh '\w+\s*\('|sort| uniq -c| sort -n| grep -P '^\s+1\b'|sed -r -e 's/^\s+1\s+//' -e 's/\(//'|while read line ;
 do
        IS=`git grep -w $line |wc -l` ;
        if [ $IS -eq 1 ];then
                git grep -wn $line
        fi
done


> johannes
> .
> 

