Return-Path: <netdev+bounces-42115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89987CD29B
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 05:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9455B20FE1
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D844436;
	Wed, 18 Oct 2023 03:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D94421
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 03:18:47 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D42ABA;
	Tue, 17 Oct 2023 20:18:44 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VuPHcIo_1697599120;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VuPHcIo_1697599120)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 11:18:41 +0800
Date: Wed, 18 Oct 2023 11:18:40 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net/smc: change function name from
 smc_find_ism_store_rc to smc_find_device_store_rc
Message-ID: <20231018031840.GX92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231017124234.99574-1-guangguan.wang@linux.alibaba.com>
 <20231017124234.99574-2-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017124234.99574-2-guangguan.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 08:42:33PM +0800, Guangguan Wang wrote:
>The function smc_find_ism_store_rc is not only used for ism, so it is
>reasonable to change the function name to smc_find_device_store_rc.
>
>Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>---
> net/smc/af_smc.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index 35ddebae8894..b3a67a168495 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -2122,7 +2122,7 @@ static void smc_check_ism_v2_match(struct smc_init_info *ini,
> 	}
> }
> 
>-static void smc_find_ism_store_rc(u32 rc, struct smc_init_info *ini)
>+static void smc_find_device_store_rc(u32 rc, struct smc_init_info *ini)
> {
> 	if (!ini->rc)
> 		ini->rc = rc;
>@@ -2164,7 +2164,7 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
> 	mutex_unlock(&smcd_dev_list.mutex);
> 
> 	if (!ini->ism_dev[0]) {
>-		smc_find_ism_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
>+		smc_find_device_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
> 		goto not_found;
> 	}
> 
>@@ -2181,7 +2181,7 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
> 		ini->ism_selected = i;
> 		rc = smc_listen_ism_init(new_smc, ini);
> 		if (rc) {
>-			smc_find_ism_store_rc(rc, ini);
>+			smc_find_device_store_rc(rc, ini);
> 			/* try next active ISM device */
> 			continue;
> 		}
>@@ -2218,7 +2218,7 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
> 		return;		/* V1 ISM device found */
> 
> not_found:
>-	smc_find_ism_store_rc(rc, ini);
>+	smc_find_device_store_rc(rc, ini);
> 	ini->smcd_version &= ~SMC_V1;
> 	ini->ism_dev[0] = NULL;
> 	ini->is_smcd = false;
>@@ -2268,7 +2268,7 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
> 	ini->smcrv2.daddr = smc_ib_gid_to_ipv4(smc_v2_ext->roce);
> 	rc = smc_find_rdma_device(new_smc, ini);
> 	if (rc) {
>-		smc_find_ism_store_rc(rc, ini);
>+		smc_find_device_store_rc(rc, ini);
> 		goto not_found;
> 	}
> 	if (!ini->smcrv2.uses_gateway)
>@@ -2285,7 +2285,7 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
> 	if (!rc)
> 		return;
> 	ini->smcr_version = smcr_version;
>-	smc_find_ism_store_rc(rc, ini);
>+	smc_find_device_store_rc(rc, ini);
> 
> not_found:
> 	ini->smcr_version &= ~SMC_V2;
>@@ -2332,7 +2332,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
> 	/* check for matching IP prefix and subnet length (V1) */
> 	prfx_rc = smc_listen_prfx_check(new_smc, pclc);
> 	if (prfx_rc)
>-		smc_find_ism_store_rc(prfx_rc, ini);
>+		smc_find_device_store_rc(prfx_rc, ini);
> 
> 	/* get vlan id from IP device */
> 	if (smc_vlan_by_tcpsk(new_smc->clcsock, ini))
>@@ -2359,7 +2359,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
> 		int rc;
> 
> 		rc = smc_find_rdma_v1_device_serv(new_smc, pclc, ini);
>-		smc_find_ism_store_rc(rc, ini);
>+		smc_find_device_store_rc(rc, ini);
> 		return (!rc) ? 0 : ini->rc;
> 	}
> 	return prfx_rc;
>-- 
>2.24.3 (Apple Git-128)

