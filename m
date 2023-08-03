Return-Path: <netdev+bounces-24049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB22376E9BE
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D0228211F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AABF1F16B;
	Thu,  3 Aug 2023 13:14:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1B1E528
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:14:02 +0000 (UTC)
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 06:13:31 PDT
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14E44AF
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:13:31 -0700 (PDT)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTP
	id RQRQqgwgnEoVsRY2xqMrJz; Thu, 03 Aug 2023 13:07:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RY2wqxSNhD0IYRY2wqBIxP; Thu, 03 Aug 2023 13:07:18 +0000
X-Authority-Analysis: v=2.4 cv=KJxJsXJo c=1 sm=1 tr=0 ts=64cba686
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=jrvim2RH1L3wMXzH:21 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10
 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=QyXUC8HyAAAA:8 a=fF_4TrJMPpZj9-LtZ0UA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Fp8MccfUoT0GBdDC_Lng:22
 a=HTSSj-r2zjXQe2K4smQw:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TrPrZnKuJJSSJ+dXrKbFzYevoKcKzEYZ0/DLaAFOEWM=; b=RtGIn+y9q92Ki2wmlgoaBldI4s
	42oJnedr6u4hfx2zKQM8kd5myn07sMphG60g/mNbv3jqj2ELiyIrFf9iUJqFlQwIDOdslws08bvXA
	QHoOWHEPqLWfJsZsfAiSvs5Pw2ymbZtKb/z1oedNPeYUmgIDqcl9sM+zVZuKLK3gzNjPaFJMfADpS
	jTAHlVfP656m7lZXTTyENU+HnSa7P+Z6ZNnEjsnkhE/ErC4wSD9m0pa8bIrphjfvSmOeUdGUQjGrd
	4pdZuNti/r7YtFpWKq2nmkZ0yj+FFkyarlCN0D6lU1jBkHcCib8Dq0UlThNs/XO5GB7S/2iAx10DP
	QMIbvNKg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:38128 helo=[192.168.15.8])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qRY2v-004AfZ-0o;
	Thu, 03 Aug 2023 08:07:17 -0500
Message-ID: <58c12dc4-87e2-5c91-5744-27777acfa631@embeddedor.com>
Date: Thu, 3 Aug 2023 07:08:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 1/2] eth: bnxt: fix one of the W=1 warnings about
 fortified memcpy()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com
References: <20230727190726.1859515-1-kuba@kernel.org>
 <20230727190726.1859515-2-kuba@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230727190726.1859515-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qRY2v-004AfZ-0o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:38128
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKCYiiZwTaut4ww0VKZ8TCMgyIKE76KzSLUH4SQDOi0YO8rv7f5PM7PAowj4Ewxl6Y4LRhcDkSLhyPrkzxO9AK2ofvohROm1gNBf9UrYrKkx/16B+qTW
 XmwJlf7trdt02wBEf5+0W56MCQyt7tjGonDn68iLfv3eyeP2BJ2aF3bv5mAYXnLon0d4PR0zFpOvcihXZWMTctvOA0TehvuTyBY=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/27/23 13:07, Jakub Kicinski wrote:
> Fix a W=1 warning with gcc 13.1:
> 
> In function ‘fortify_memcpy_chk’,
>      inlined from ‘bnxt_hwrm_queue_cos2bw_cfg’ at drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:133:3:
> include/linux/fortify-string.h:592:25: warning: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
>    592 |                         __read_overflow2_field(q_size_field, size);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The field group is already defined and starts at queue_id:
> 
> struct bnxt_cos2bw_cfg {
> 	u8			pad[3];
> 	struct_group_attr(cfg, __packed,
> 		u8		queue_id;
> 		__le32		min_bw;
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: michael.chan@broadcom.com
> 
> Michael, the other warning looks more.. interesting.
> The code does:
> 
> 	data = &resp->queue_id0 + offsetof(struct bnxt_cos2bw_cfg, queue_id);
> 
> which translates to: data = &resp->queue_id0 + 3, but the HWRM struct
> says:
> 
> struct hwrm_queue_cos2bw_qcfg_output {
> 	__le16	error_code;
> 	__le16	req_type;
> 	__le16	seq_id;
> 	__le16	resp_len;
> 	u8	queue_id0;
> 	u8	unused_0;
> 	__le16	unused_1;
> 	__le32	queue_id0_min_bw;
> 
> So queue_id0 is in the wrong place?
> Why not just move it in the spec?
> Simplest fix for the warning would be to assign the 6 fields by value.
> But to get the value of queue_id we'd need to read unused_1 AFACT? :o
> Could you please fix this somehow? Doing W=1 builds on bnxt is painful.

It seems I just ran into the same issue you're talking about here. See:

In function 'fortify_memcpy_chk',
     inlined from 'bnxt_hwrm_queue_cos2bw_qcfg' at drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:165:3:
include/linux/fortify-string.h:592:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd 
parameter); maybe use struct_group()? [-Wattribute-warning]
   592 |                         __read_overflow2_field(q_size_field, size);
       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Here is a potential fix for that:

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index 31f85f3e2364..e2390d73b3f0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -144,7 +144,7 @@ static int bnxt_hwrm_queue_cos2bw_qcfg(struct bnxt *bp, struct ieee_ets *ets)
         struct hwrm_queue_cos2bw_qcfg_output *resp;
         struct hwrm_queue_cos2bw_qcfg_input *req;
         struct bnxt_cos2bw_cfg cos2bw;
-       void *data;
+       struct bnxt_cos2bw_cfg *data;
         int rc, i;

         rc = hwrm_req_init(bp, req, HWRM_QUEUE_COS2BW_QCFG);
@@ -158,11 +158,11 @@ static int bnxt_hwrm_queue_cos2bw_qcfg(struct bnxt *bp, struct ieee_ets *ets)
                 return rc;
         }

-       data = &resp->queue_id0 + offsetof(struct bnxt_cos2bw_cfg, queue_id);
+       data = (struct bnxt_cos2bw_cfg *)&resp->queue_id0;
         for (i = 0; i < bp->max_tc; i++, data += sizeof(cos2bw.cfg)) {
                 int tc;

-               memcpy(&cos2bw.cfg, data, sizeof(cos2bw.cfg));
+               memcpy(&cos2bw.cfg, &data->cfg, sizeof(cos2bw.cfg));
                 if (i == 0)
                         cos2bw.queue_id = resp->queue_id0;

Also, 0-day guys just reported[1] to me a -Wstringop-overflow in a similar piece of code
in the same file. See:

drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:133:17: warning: writing 12 bytes into a region of size 1 [-Wstringop-overflow=]

And I think this is a potential solution for that:

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index 31f85f3e2364..01e0ac246e11 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -98,7 +98,7 @@ static int bnxt_hwrm_queue_cos2bw_cfg(struct bnxt *bp, struct ieee_ets *ets,
  {
         struct hwrm_queue_cos2bw_cfg_input *req;
         struct bnxt_cos2bw_cfg cos2bw;
-       void *data;
+       struct bnxt_cos2bw_cfg *data;
         int rc, i;

         rc = hwrm_req_init(bp, req, HWRM_QUEUE_COS2BW_CFG);
@@ -129,8 +129,10 @@ static int bnxt_hwrm_queue_cos2bw_cfg(struct bnxt *bp, struct ieee_ets *ets,
                                 cpu_to_le32((ets->tc_tx_bw[i] * 100) |
                                             BW_VALUE_UNIT_PERCENT1_100);
                 }
-               data = &req->unused_0 + qidx * (sizeof(cos2bw) - 4);
-               memcpy(data, &cos2bw.cfg, sizeof(cos2bw) - 4);
+               data = (struct bnxt_cos2bw_cfg *)(&req->unused_0 + qidx *
+                                                 sizeof(cos2bw.cfg) -
+                                                 offsetof(struct bnxt_cos2bw_cfg, cfg));
+               memcpy(&data->cfg, &cos2bw.cfg, sizeof(cos2bw.cfg));
                 if (qidx == 0) {
                         req->queue_id0 = cos2bw.queue_id;
                         req->unused_0 = 0;

If you agree with these changes I can send them as proper patches.

Thanks
--
Gustavo

[1] https://lore.kernel.org/lkml/202308031558.MhRIyeiu-lkp@intel.com/

> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
> index caab3d626a2a..31f85f3e2364 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
> @@ -130,7 +130,7 @@ static int bnxt_hwrm_queue_cos2bw_cfg(struct bnxt *bp, struct ieee_ets *ets,
>   					    BW_VALUE_UNIT_PERCENT1_100);
>   		}
>   		data = &req->unused_0 + qidx * (sizeof(cos2bw) - 4);
> -		memcpy(data, &cos2bw.queue_id, sizeof(cos2bw) - 4);
> +		memcpy(data, &cos2bw.cfg, sizeof(cos2bw) - 4);
>   		if (qidx == 0) {
>   			req->queue_id0 = cos2bw.queue_id;
>   			req->unused_0 = 0;

