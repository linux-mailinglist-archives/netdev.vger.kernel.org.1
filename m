Return-Path: <netdev+bounces-24230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5076F5FC
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 01:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E727428239A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 23:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57026B02;
	Thu,  3 Aug 2023 23:07:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD736EA0
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 23:07:40 +0000 (UTC)
Received: from out-96.mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE04198C
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 16:07:38 -0700 (PDT)
Message-ID: <b19ba244-64cc-4c12-67f6-3bbb2e4b009f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691104056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbpp346CZuq1GChClCsVWCUvJCADNiWZDc/s2Tbg8JM=;
	b=WEhEqp3wCmo28iy8QjgcP7ZoyH/wsOe4s4kHTMkT9nR7MTMVY7WhKVAvyB//MN8OUSRmmD
	yq2VZqfgssIRIHO9N0zkK8YBGBG3FhDEib/ckUAYQgSpantXSeJUnpQdjlZ/MNqx/T+3ni
	YJHhgROTNhTS/LJxy3MFkiG0BY5wgg4=
Date: Thu, 3 Aug 2023 16:07:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] eth: dpaa: add missing net/xdp.h include
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, kernel test robot <lkp@intel.com>, madalin.bucur@nxp.com,
 martin.lau@kernel.org
References: <20230803230008.362214-1-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230803230008.362214-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/3/23 4:00 PM, Jakub Kicinski wrote:
> Add missing include for DPAA (fix aarch64 build).
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308040620.ty8oYNOP-lkp@intel.com/
> Fixes: 680ee0456a57 ("net: invert the netdevice.h vs xdp.h dependency")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: madalin.bucur@nxp.com
> CC: martin.lau@kernel.org
> ---
>   drivers/net/ethernet/freescale/dpaa/dpaa_eth.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> index 35b8cea7f886..ac3c8ed57bbe 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> @@ -8,6 +8,7 @@
>   
>   #include <linux/netdevice.h>
>   #include <linux/refcount.h>
> +#include <net/xdp.h>

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>



