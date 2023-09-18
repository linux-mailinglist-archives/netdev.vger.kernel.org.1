Return-Path: <netdev+bounces-34539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737547A4884
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 13:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5D32826F8
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED761C6A5;
	Mon, 18 Sep 2023 11:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA238F8E
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:36:03 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D27C126
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 04:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695036916; x=1726572916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EJt1XHLN4hn10P9i9S0B/00v+QHxsfL1yMDSg+djlgA=;
  b=OgYTI2Z0K4o9KNQjzmDLvlEsgqHDWgxStbspYf+oNk6HisyOYt1nI5RO
   9sZjYoSDAMo60k49M25+conyZZ27A+PfLv/jdKNdLUw3jWQs/Z3VvOTWM
   eESH7EzoRGsTM9IwvkwBSlpCn4k1ktsjsmDhqlr5D0vtU1JdmgJcgM8EH
   hKY1lLfcLZ4B3JZXGr4Hx82MSFKsZ33eyh8CxDkry/nhuYbFNf1t7UUA6
   TT9D3KWRAPWzyx+UyPyDXIr/kH+nXlrleTDjrFMxcgiD9WLrTkgq96xzA
   W/K3Z8COriB98Y1cdfLFeGTqsXVswKhgtNZweX0v7CrFM682vvENBoMSY
   Q==;
X-CSE-ConnectionGUID: +/8SrzcURK210XKyHo4PcQ==
X-CSE-MsgGUID: J0UD+J1OQ6KfyGjmWd+OkA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="5200042"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 04:35:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 18 Sep 2023 04:34:49 -0700
Received: from DEN-LT-70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 18 Sep 2023 04:34:48 -0700
Date: Mon, 18 Sep 2023 11:34:48 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<dsahern@gmail.com>
Subject: Re: [patch iproute2-next 2/4] devlink: introduce support for netns
 id for nested handle
Message-ID: <20230918113448.c6qypl3xsppv4usz@DEN-LT-70577>
References: <20230918105416.1107260-1-jiri@resnulli.us>
 <20230918105416.1107260-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230918105416.1107260-3-jiri@resnulli.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static int nesns_name_by_id_func(char *nsname, void *arg)

Hi Jiri,
nesns -> netns?

> +{
> +       struct netns_name_by_id_ctx *ctx = arg;
> +       int32_t ret;
> +
> +       ret = netns_id_by_name(nsname);
> +       if (ret < 0 || ret != ctx->id)
> +               return 0;
> +       ctx->name = strdup(nsname);
> +       return 1;
> +}
> +
> +static char *netns_name_by_id(int32_t id)
> +{
> +       struct netns_name_by_id_ctx ctx = {
> +               .id = id,
> +       };
> +
> +       netns_foreach(nesns_name_by_id_func, &ctx);

.. and here

> +       return ctx.name;
> +}
> +

/Daniel

