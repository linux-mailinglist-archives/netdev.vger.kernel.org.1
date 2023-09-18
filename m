Return-Path: <netdev+bounces-34500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324317A4687
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDC11C20BE8
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF3C1C684;
	Mon, 18 Sep 2023 10:01:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C81C2AC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:01:53 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427E4116;
	Mon, 18 Sep 2023 03:01:51 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38IA1YXm101897;
	Mon, 18 Sep 2023 05:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1695031294;
	bh=b7pNnd8aJrcFVKBTB/EY8A3OQLyHTJiTTs5ofLA5H2o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XRRLLxpegvWPHwE9bqjMTkWL+B7ZiJ0oL/UH2adncSHI0umB21MVHM4Y4EwgBAB+c
	 Z0He48UNJ1KQQGu7QrLIDf4ZrjqhhnDOK30FdF8j9AzI2qCtgu99yD4DrTtc+Lp1Fk
	 9fTXONelencuxMP5ibAoyZdqDcpnq+yfLB53vqLs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38IA1YxO001164
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Sep 2023 05:01:34 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Sep 2023 05:01:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Sep 2023 05:01:34 -0500
Received: from [10.250.135.44] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38IA1Ssl047488;
	Mon, 18 Sep 2023 05:01:29 -0500
Message-ID: <4c4eaedc-4a53-3816-1c18-92375f043ba1@ti.com>
Date: Mon, 18 Sep 2023 13:01:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] net: ti: icss-iep: add dependency for PTP
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC: kernel test robot <lkp@intel.com>, Md Danish Anwar <danishanwar@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20230916050701.15480-1-rdunlap@infradead.org>
Content-Language: en-US
From: Roger Quadros <rogerq@ti.com>
In-Reply-To: <20230916050701.15480-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 16.9.2023 8.07, Randy Dunlap wrote:
> When CONFIG_PTP_1588_CLOCK=m and CONFIG_TI_ICSS_IEP=y,
> there are build errors when referencing PTP functions.
> Fix this by making TI_ICSS_IEP depend on PTP_1588_CLOCK_OPTIONAL.
> Also, since TI_ICSSG_PRUETH selects TI_ICSS_IEP and selects don't
> follow dependencies, make the former also depend on
> PTP_1588_CLOCK_OPTIONAL.
> 
> Fixes these build errors:
> 
> aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_get_ptp_clock_idx':
> icss_iep.c:(.text+0x234): undefined reference to `ptp_clock_index'
> aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_exit':
> icss_iep.c:(.text+0x634): undefined reference to `ptp_clock_unregister'
> aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_init':
> icss_iep.c:(.text+0x1848): undefined reference to `ptp_clock_register'
> 
> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: lore.kernel.org/r/202309151207.NPDMiINe-lkp@intel.com
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Md Danish Anwar <danishanwar@ti.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org

Reviewed-by: Roger Quadros <rogerq@kernel.org>

