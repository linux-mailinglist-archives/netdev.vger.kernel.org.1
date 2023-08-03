Return-Path: <netdev+bounces-24203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C811C76F396
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 21:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81164282068
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E042593B;
	Thu,  3 Aug 2023 19:41:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC125178
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 19:41:22 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C93C3B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691091675; x=1722627675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6A9na0vZlLFGH8WLs5AunuicvqcJ/LkL555+PBSJWsw=;
  b=ktA3Crlkgtdlh7+ZD6TYMaxGbttKd9UwRa5EW9llIOP3USc7yqIaNnI8
   bjmC1qOisKKs5QZGIgNjCBevwJAr6V6OEJz7YfGKvJX0wqmjAbyxdleVS
   hVhOYXX51+6DR8XRP8axj/aCZ1StxQdY/ddtVr9W9V0WNs7N8KHIPRORs
   1yOolCHLXzThNkMwCgjmiMblsUUemfwvkLxZJ+O0BfWv1xKuH0Qw000VS
   U6c+ccCa8bb7LZPSf59H+u2HgqfyweKQG6fjwUEZWPe9ZWkDFcR5Rdzbr
   jLQ7I1WUfmobb5Mt3Vch0UjDNI8iBC0UNR4QkUfNp/2jJ4tY+12lDJOaA
   g==;
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="239674845"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2023 12:41:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 3 Aug 2023 12:41:07 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 3 Aug 2023 12:41:07 -0700
Date: Thu, 3 Aug 2023 21:41:06 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Zhu Wang <wangzhu9@huawei.com>
CC: <UNGLinuxDriver@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH -next] net: lan966x: Do not check 0 for
 platform_get_irq_byname()
Message-ID: <20230803194106.cvzvgy6npx5ztupb@soft-dev3-1>
References: <20230803082900.14921-1-wangzhu9@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230803082900.14921-1-wangzhu9@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The 08/03/2023 16:29, Zhu Wang wrote:
> [Some people who received this message don't often get email from wangzhu9@huawei.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Since platform_get_irq_byname() never returned zero, so it need not to
> check whether it returned zero, it returned -EINVAL or -ENXIO when
> failed, so we replace the return error code with the result it returned.
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>

Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index fbb0bb4594cd..824961ec1370 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -1108,8 +1108,8 @@ static int lan966x_probe(struct platform_device *pdev)
> 
>         /* set irq */
>         lan966x->xtr_irq = platform_get_irq_byname(pdev, "xtr");
> -       if (lan966x->xtr_irq <= 0)
> -               return -EINVAL;
> +       if (lan966x->xtr_irq < 0)
> +               return lan966x->xtr_irq;
> 
>         err = devm_request_threaded_irq(&pdev->dev, lan966x->xtr_irq, NULL,
>                                         lan966x_xtr_irq_handler, IRQF_ONESHOT,
> --
> 2.17.1
> 

-- 
/Horatiu

