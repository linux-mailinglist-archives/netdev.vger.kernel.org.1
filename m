Return-Path: <netdev+bounces-42294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3234D7CE16C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A97B2135A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5FC3B2AE;
	Wed, 18 Oct 2023 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Oe+C2tKY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECDF3B288
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:45:05 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EFC118;
	Wed, 18 Oct 2023 08:45:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IFinrK079557;
	Wed, 18 Oct 2023 10:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1697643889;
	bh=/ZywHds19OF8HgvTVTSGg8Wo3OLLlAOYwDmxLDtIUMI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Oe+C2tKY9UB/+03MhksDPTI9LlmzUpd1II2ZhfYIPlV+t5hcan100OuXwJfrBF33J
	 W93rOEkMI0mR5RdGp32+ZBNEXgBnGP3VV4TNHGQ8Duzndv8AAHKE55QqLUgcRbIxoY
	 dE4EmZwVR/R+KHAup/hz7dOT44ShcigrueL5XLOs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IFin8o029902
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Oct 2023 10:44:49 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 10:44:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 10:44:48 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IFim0D005933;
	Wed, 18 Oct 2023 10:44:48 -0500
Date: Wed, 18 Oct 2023 10:44:48 -0500
From: Nishanth Menon <nm@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Neha Malcom Francis
	<n-francis@ti.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rogerq@ti.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <horms@kernel.org>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: Fix the
 revision string for J721E
Message-ID: <20231018154448.vlunpwbw67xeh4rj@unfasten>
References: <20231018140009.1725-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018140009.1725-1-r-gunasekaran@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 19:30-20231018, Ravi Gunasekaran wrote:
> Prior to the commit 07e651db2d78 ("soc: ti: k3-socinfo: Revamp driver
> to accommodate different rev structs"), K3 SoC's revision was
> interpreted as an incremental value or one-to-one mapping of the
> JTAG_ID's variant field. Now that the revision mapping is fixed,
> update the correct revision string for J721E in k3_mdio_socinfo,
> so that MDIO errata i2329 is applied for J721E SR1.1.
> 
> Fixes: 07e651db2d78 ("soc: ti: k3-socinfo: Revamp driver to accommodate different rev structs")
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  drivers/net/ethernet/ti/davinci_mdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
> index 628c87dc1d28..998fe2717cf9 100644
> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> @@ -519,7 +519,7 @@ static const struct soc_device_attribute k3_mdio_socinfo[] = {
>  	{ .family = "J7200", .revision = "SR1.0", .data = &am65_mdio_soc_data },
>  	{ .family = "J7200", .revision = "SR2.0", .data = &am65_mdio_soc_data },
>  	{ .family = "J721E", .revision = "SR1.0", .data = &am65_mdio_soc_data },
> -	{ .family = "J721E", .revision = "SR2.0", .data = &am65_mdio_soc_data },
> +	{ .family = "J721E", .revision = "SR1.1", .data = &am65_mdio_soc_data },
>  	{ .family = "J721S2", .revision = "SR1.0", .data = &am65_mdio_soc_data},
>  	{ /* sentinel */ },
>  };
> 
> base-commit: 2dac75696c6da3c848daa118a729827541c89d33

Uggh.. This is a bit of chicken or hen problem here that creates
bisectability issues (thanks for linux-next for exposing this).

Neha's patch I picked up is a valid fix, though this side effect was
unfortunate.

My suggestion is:
a) I will drop
   https://lore.kernel.org/all/20231016101608.993921-4-n-francis@ti.com/
   from my queue for this window.
b) please identify other places where we could have this situation.
https://www.ti.com/lit/pdf/spruiu1 seems to indicate just SR1.0 for
J7200.

We then have the following steps potentially

Drop the fixes and Maintain both SR2.0 and SR1.0 (add SR1.1) so that
we can merge the socinfo fixes without breaking bisectability.

To merge, the following options exist:
A) netdev maintainers could provide me an rc1 based immutable tag
B) if netdev maintainers can give me a ack to carry this patch(or patch
   series for relevant SoCs) on my tree, I can apply the fixes before
   picking up the socinfo fixups.
C) I can wait a kernel window to the nearest rc1 *after* netdev fixes
   are merged in to pick up socinfo fix.

Once A/B/C is done (I would like netdev maintainers to suggest which way
to go), we can drop the "invalid" SoC SR ID.

I don't see a cleaner way to get this inter-dependency integrated.

Also in the future, please CC me as the reporter and for Soc-fixes
dependency issues (I am listed in the MAINTAINERS file).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

