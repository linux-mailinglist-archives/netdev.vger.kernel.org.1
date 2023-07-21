Return-Path: <netdev+bounces-19782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68FE75C418
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 12:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C5A2821EE
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2624418C0D;
	Fri, 21 Jul 2023 10:11:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21F3234
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD37CC433C7;
	Fri, 21 Jul 2023 10:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689934272;
	bh=Og6dYNFo6r+p40Vl2/CzNSsEFtjuUHHzY564GTompQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=otyAwT+2Krh0ZKKvuVWmoB3cUAxYd687ztyhGeY+sW7VKv6tqDWNFK+mC0SZhWcoW
	 O08eM2Ao9kD5RruBvgiaYE60ltVXVKTUABV2w9Pm+uluM/YQ64oJUHQZXx59sN5wXH
	 FXSGvIAXcjHXRi4+eQ3023Mk5fodqrSz0iVaT3PINkm43MBcloQHn3WplT4dfVAssc
	 YgZTYJPP9BqE9Oa2ZAnH0l5OWCVb1ZxTo1RU/kLcY8qxTqQviC2u3Vu9o+VRZ5ME3K
	 s9i+bwY+nQkgM7UxjVg2vGZeGGVWUhNcfoOaprxvBZxDoZhpfu/ixOcex5kkNP8o/O
	 AR3o4zSeA+6xQ==
Message-ID: <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
Date: Fri, 21 Jul 2023 12:10:57 +0200
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
To: Boon@ecsmtp.png.intel.com, Khai@ecsmtp.png.intel.com,
 "Ng <boon.khai.ng"@intel.com, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Boon Khai Ng <boon.khai.ng@intel.com>,
 Shevchenko Andriy <andriy.shevchenko@intel.com>,
 Mun Yew Tham <mun.yew.tham@intel.com>,
 Leong Ching Swee <leong.ching.swee@intel.com>,
 G Thomas Rohan <rohan.g.thomas@intel.com>,
 Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230721062617.9810-2-boon.khai.ng@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2023 08:26, Boon@ecsmtp.png.intel.com wrote:
> From: Boon Khai Ng <boon.khai.ng@intel.com>
> 
> This patch is to add the dts setting for the MAC controller on
> synopsys 10G Ethernet MAC which allow the 10G MAC to turn on
> hardware accelerated VLAN stripping. Once the hardware accelerated
> VLAN stripping is turn on, the VLAN tag will be stripped by the

Subject prefix is totally bogus.


> 10G Ethernet MAC.
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
> Reviewed-by: Shevchenko Andriy <andriy.shevchenko@linux.intel.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof


