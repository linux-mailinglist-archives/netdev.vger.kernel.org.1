Return-Path: <netdev+bounces-32545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDE1798402
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 10:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23111C20BFE
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E131FB3;
	Fri,  8 Sep 2023 08:27:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B831C39
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 08:27:28 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8B6173B;
	Fri,  8 Sep 2023 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694161646; x=1725697646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FzT8TL13NzGb10QuW1utIyMOVes5T8f09DiXw3j6oxY=;
  b=I5IqzipmIeeOYEDfQ8gzTs3pFW/yKixEsYD51OoQUkSVD/3fLOk5lt58
   /oI3t4GXllbB4vcrlQHJpmb2bU5+Nn9MIvIEYA3q+gp5uw3YHoR8GQNfD
   0oXJCt1I+z2wpOvHyq/PWb1fs1YY60PUt3qLuiKN9fyTxftndUu44V+L7
   XjOOlGT9tNdpfxB3DzaNjVtctvTfm5jdso64qHaL6SAdmOtMNjjlVWdVj
   Vj2D2YWEiMUkVZPtUSqFOG3sVCy32DXnoWpOythYLwtYvtLsXHzLe94Io
   67EgOXngTIkmjiKdobwYPw3FDgeR+OuJMRKnuIh70m5qF4nItMgGfAarw
   Q==;
X-CSE-ConnectionGUID: I724LJMBTBKswurpylKHfQ==
X-CSE-MsgGUID: ARfNFCqWTxeDSWkQTmYExA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="170591215"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2023 01:27:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 8 Sep 2023 01:27:26 -0700
Received: from DEN-LT-70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 8 Sep 2023 01:27:23 -0700
Date: Fri, 8 Sep 2023 08:27:23 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Lars Povlsen <lars.povlsen@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net-next] net: microchip: sparx5: clean up error checking
 in vcap_show_admin()
Message-ID: <20230908082723.rcpkr7bagcptt3he@DEN-LT-70577>
References: <b88eba86-9488-4749-a896-7c7050132e7b@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b88eba86-9488-4749-a896-7c7050132e7b@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The vcap_decode_rule() never returns NULL.  There is no need to check
> for that.  This code assumes that if it did return NULL we should
> end abruptly and return success.  It is confusing.  Fix the check to
> just be if (IS_ERR()) instead of if (IS_ERR_OR_NULL()).
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202309070831.hTvj9ekP-lkp@intel.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This bug is old, but it doesn't affect runtime so it should go to
> net-next.
> 

LGTM.

Thanks Dan!

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

