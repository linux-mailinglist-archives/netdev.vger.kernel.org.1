Return-Path: <netdev+bounces-20084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A5475D8D5
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 03:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F1928254E
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 01:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA763BD;
	Sat, 22 Jul 2023 01:56:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFDD2F48
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 01:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDFBC433C7;
	Sat, 22 Jul 2023 01:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689990959;
	bh=YIMeHkWDQz0s9WX+GvHlnTsrUYqiF/JbCOjQIvlM93w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QtG+EqkDWjYmXfT6W2+RRIIw3VCT7iNprPoryweITTLIZQAFRd3gVufVMWUxmmsul
	 HCKR1AN0lxPA3hmXAiLaXAVRuKsI2gc+opDB2OjYyOMIdj3TpUcB4uZAXG84LT8AiK
	 Ris27qqhb6z6/DcvMi6iORTY3J9T2iSD6evm9sIK4BvedCmlTyRcPW+QhpL4MA5ki1
	 tiYrRGQaOBr/oeJ9jfuUtH1bDrayxlOTcNcAMpk5oNHYJKqSvVAz6YFQnU6zDNti4W
	 5+SDb60GfJEblfk6305HyRSK2/rf1QC2g91xGVXnUyhaq9GCzeaU6tQ3SZv4zmLkO+
	 VMBF6BtTXD6YA==
Date: Fri, 21 Jul 2023 18:55:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Ng, Boon Khai" <boon.khai.ng@intel.com>, "Boon@ecsmtp.png.intel.com"
 <Boon@ecsmtp.png.intel.com>, "Khai@ecsmtp.png.intel.com"
 <Khai@ecsmtp.png.intel.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Shevchenko, Andriy"
 <andriy.shevchenko@intel.com>, "Tham, Mun Yew" <mun.yew.tham@intel.com>,
 "Swee, Leong Ching" <leong.ching.swee@intel.com>, "G Thomas, Rohan"
 <rohan.g.thomas@intel.com>, Shevchenko Andriy
 <andriy.shevchenko@linux.intel.com>, Joe Perches <joe@perches.com>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2]
 dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
Message-ID: <20230721185557.199fb5b8@kernel.org>
In-Reply-To: <8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
	<20230721062617.9810-2-boon.khai.ng@intel.com>
	<e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
	<DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
	<8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 18:21:32 +0200 Krzysztof Kozlowski wrote:
> > $ ./scripts/get_maintainer.pl  --scm  -f drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c  
> 
> That's not how you run it. get_maintainers.pl should be run on patches
> or on all files, not just some selection.

Adding Joe for visibility (I proposed to print a warning when people 
do this and IIRC he wasn't on board).

