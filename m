Return-Path: <netdev+bounces-22664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A107689E1
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 04:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6DA1C209AD
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 02:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09904629;
	Mon, 31 Jul 2023 02:11:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F3362
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:11:39 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6148CF;
	Sun, 30 Jul 2023 19:11:36 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VoXHPnX_1690769491;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VoXHPnX_1690769491)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 10:11:32 +0800
Date: Mon, 31 Jul 2023 10:11:24 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: Remove unused function declarations
Message-ID: <ZMcYTNPFigmPF2ml@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20230729121929.17180-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729121929.17180-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 08:19:29PM +0800, Yue Haibing wrote:
> commit f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early()")
> left behind smc_lgr_schedule_free_work_fast() declaration.
> And since commit 349d43127dac ("net/smc: fix kernel panic caused by race of smc_sock")
> smc_ib_modify_qp_reset() is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

LGTM, thanks.

Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

> ---
>  net/smc/smc_core.h | 1 -
>  net/smc/smc_ib.h   | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 1645fba0d2d3..3c1b31bfa1cf 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -539,7 +539,6 @@ int smc_vlan_by_tcpsk(struct socket *clcsock, struct smc_init_info *ini);
>  
>  void smc_conn_free(struct smc_connection *conn);
>  int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini);
> -void smc_lgr_schedule_free_work_fast(struct smc_link_group *lgr);
>  int smc_core_init(void);
>  void smc_core_exit(void);
>  
> diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
> index 034295676e88..4df5f8c8a0a1 100644
> --- a/net/smc/smc_ib.h
> +++ b/net/smc/smc_ib.h
> @@ -96,7 +96,6 @@ void smc_ib_destroy_queue_pair(struct smc_link *lnk);
>  int smc_ib_create_queue_pair(struct smc_link *lnk);
>  int smc_ib_ready_link(struct smc_link *lnk);
>  int smc_ib_modify_qp_rts(struct smc_link *lnk);
> -int smc_ib_modify_qp_reset(struct smc_link *lnk);
>  int smc_ib_modify_qp_error(struct smc_link *lnk);
>  long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev);
>  int smc_ib_get_memory_region(struct ib_pd *pd, int access_flags,
> -- 
> 2.34.1

