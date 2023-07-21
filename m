Return-Path: <netdev+bounces-19953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D41C875CF3F
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBA128274F
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73381F958;
	Fri, 21 Jul 2023 16:26:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F81F946
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E561C433C8;
	Fri, 21 Jul 2023 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689956779;
	bh=WL2709V7eAgLoPYAlshlm4ASA+zokq6+PqUZyFxv+DM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aAq8uHd8HFGwxapczl08Jl6HfT7SWJGa7hodSjSL8iXf5IOAWZzGgzXW3bv/HEx/6
	 u63ZwW2Yv3gbaKiYvcqaU+uhNXe8ALOfUE8j/NMI8T6MOimgXy/KcweVxLz8GdI3IC
	 lhxlR1ymyNVgH1aDTw8f4UUREHQiszKjX1p3vyLpqryx8MKcw/ADGt5SwptqEarDTQ
	 p6drq4J5gD0BbcNM9bXJ8gSjl0b6BfVFApNal0AjXdET+2o5AJxF3TgnvVHALehreZ
	 HVPCIMEIpbjAzypiSo5W4O++b04VymxIDoBnwDqLqGV8v+WZ/1YTffFchL/xiG1Ugc
	 oMV5J7utIwdoA==
Message-ID: <d58cd6cc-70a9-3759-9af2-c4a292440767@kernel.org>
Date: Fri, 21 Jul 2023 18:26:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-bindings:
 net: snps,dwmac: Add description for rx-vlan-offload
Content-Language: en-US
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Boon@ecsmtp.png.intel.com" <Boon@ecsmtp.png.intel.com>,
 "Khai@ecsmtp.png.intel.com" <Khai@ecsmtp.png.intel.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
 "Tham, Mun Yew" <mun.yew.tham@intel.com>,
 "Swee, Leong Ching" <leong.ching.swee@intel.com>,
 "G Thomas, Rohan" <rohan.g.thomas@intel.com>,
 Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
 <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
 <DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2023 17:28, Ng, Boon Khai wrote:
> This is a new device bringup, thus the DT is not available yet. The DTS will be upstreamed
> by my another colleague, unless, if I can upstream only my part on the setting? 
> 
>> Please kindly resend and include all necessary To/Cc entries.

To be clear, since you do not agree with my comment you skipped vital
lists, this was not tested by automation so it is NAK from me.

Sorry.

Best regards,
Krzysztof


