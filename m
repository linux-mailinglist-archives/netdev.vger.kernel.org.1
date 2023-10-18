Return-Path: <netdev+bounces-42340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F97CE5C4
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8079DB20A7A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306273FE3A;
	Wed, 18 Oct 2023 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YLTf2AmI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAA5154AC
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 18:00:56 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA63A1B9;
	Wed, 18 Oct 2023 11:00:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39II0aU5127006;
	Wed, 18 Oct 2023 13:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1697652036;
	bh=YH8IQA8Foqx4OXaUGpFSL2kL5Irsm59+S3kAk/xw1sU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YLTf2AmIaWAUeT2W0+o/As3KJ08JO7HjSvwipEIAPr8f7oK/lyZctHMUrbhSOi9LY
	 er2REnO9I4aMfkXfU2eE6i38r/hWCWy3qkuR3AwoXdRqplhAuZqGnTlNG9c+jZwPBi
	 7ZdRlkfsifayyCYBA4g7PIdWv6YpE+baLO7dp1yA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39II0aNt089180
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Oct 2023 13:00:36 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 13:00:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 13:00:35 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39II0ZXL008590;
	Wed, 18 Oct 2023 13:00:35 -0500
Date: Wed, 18 Oct 2023 13:00:35 -0500
From: Nishanth Menon <nm@ti.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Neha Malcom Francis
	<n-francis@ti.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>, <rogerq@ti.com>,
        <andrew@lunn.ch>, <f.fainelli@gmail.com>, <horms@kernel.org>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: Fix the
 revision string for J721E
Message-ID: <20231018180035.saymfqwc2o3xpdf4@pretense>
References: <20231018140009.1725-1-r-gunasekaran@ti.com>
 <20231018154448.vlunpwbw67xeh4rj@unfasten>
 <20231018105236.347b2354@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018105236.347b2354@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10:52-20231018, Jakub Kicinski wrote:
> On Wed, 18 Oct 2023 10:44:48 -0500 Nishanth Menon wrote:
> > A) netdev maintainers could provide me an rc1 based immutable tag
> 
> FWIW that shouldn't be a problem, assuming my script to do so didn't
> bit rot :)
> 
> Does it really have to be rc1 or something more recent would work?

Thanks Jakub. SoC tree needs me to send based off rc1 for new features.
I'd rather not mess with that.

Sure if we are doing an fixes pull, we can figure something out to
sync. rc1 saves us the headache of conflict of me sending a PR merge
while netdev maintainers aren't expecting it to be merged to master
via soc tree.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

