Return-Path: <netdev+bounces-26572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F57782DB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6285E1C20DAC
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 21:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD0623BF8;
	Thu, 10 Aug 2023 21:52:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C622F02
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 21:52:04 +0000 (UTC)
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 14:52:03 PDT
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E22728
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:52:03 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTP
	id UAVeqFQklez0CUDXwq6IB3; Thu, 10 Aug 2023 21:50:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id UDY7qoKZGH4LtUDY7qXKy0; Thu, 10 Aug 2023 21:50:32 +0000
X-Authority-Analysis: v=2.4 cv=Ws04jPTv c=1 sm=1 tr=0 ts=64d55ba8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=c7P8IOsjiO9zm4Xs_OAA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N4LwCmZmu8Qi0zP718AGZRcxN+/+SzgTW0w6lkTTTYk=; b=Hn1RBXsehMIa5WQqHhxt3DZ9KR
	wI/ZbhM9WFlcghBwguWxa3S6O7YL8pG9TqfCBoc9KI5P3CxX5o8czbQMVd9S7tng4lduHs8NakpRl
	OSKz+B3cnW4LhPURXxm/+LOwxuhZJFz25gZ2C8RgW38ntvoiHi4smFapEJmWnxyx9c92NnlbYC0h1
	znce0vhn5vGNuQTvg3M3I9Peff6kmmHGo1n9emL+JFx7P0C6oqF75daCJphSJ0msh1sBadtNf2Zeu
	nzMQev4Qlf1MeOFVb23y9SLd9e7QAk7ziTqqhr/O3isIeUCHP5jkORWNhfkf/pYDyV77VbGtvdXRS
	wHjTag8g==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:50906 helo=[192.168.15.8])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qUDY6-000TYv-2k;
	Thu, 10 Aug 2023 16:50:30 -0500
Message-ID: <f4caa3f6-66d2-db44-0e21-900fe663da48@embeddedor.com>
Date: Thu, 10 Aug 2023 15:51:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH 2/4][next] i40e: Replace one-element
 array with flex-array member in struct i40e_profile_segment
Content-Language: en-US
To: Justin Stitt <justinstitt@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1690938732.git.gustavoars@kernel.org>
 <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
 <20230810173404.jjuvqo5tv57en7pg@google.com>
 <20230810204953.wwwvbl57m3cebf27@google.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230810204953.wwwvbl57m3cebf27@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qUDY6-000TYv-2k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:50906
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ+MAjlHFxsfH9xfrJnosMoKEnNRDHcnaXDiQrvf+JS2q2FCHtYYuGcWYPfvAONI1Yjk2ECeRGHbfMQKlCdb+G+UrYaqNfTd9JcGbu1z1YmYB0jKMnRq
 6HfzyW/aDP5+cW6UuhIjzzpI4CO9O22npbb9dwaoLLOnPaPSNHVt8iaBXrY3/MEA1bwgG4oe9Lfom7dfxzNeGIjfeTiBUhs84lc=
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/10/23 14:49, Justin Stitt wrote:
> On Thu, Aug 10, 2023 at 05:34:04PM +0000, Justin Stitt wrote:
>> On Tue, Aug 01, 2023 at 11:05:59PM -0600, Gustavo A. R. Silva wrote:
>>> One-element and zero-length arrays are deprecated. So, replace
>>> one-element array in struct i40e_profile_segment with flexible-array
>>> member.
>>>
>>> This results in no differences in binary output.
>>>
>>> Link: https://github.com/KSPP/linux/issues/335
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>   drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> Tested-by: Justin Stitt <justinstitt@google.com>
> Whoops, this should be:
> Reviewed-by: Justin Stitt <justinstitt@google.com>
> 
> I did not test, I just verified there are no binary differences produced
> by this patch.

In that case, `Build-tested-by` seems more appropriate.

Anyways, the series has been applied already.

--
Gustavo


