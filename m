Return-Path: <netdev+bounces-27248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B513477B27A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD221C203B7
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3673A8820;
	Mon, 14 Aug 2023 07:31:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708A1842
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9652BC433C7;
	Mon, 14 Aug 2023 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691998264;
	bh=+wVLxwxYeITuhnEHSDMVdq/EHuC0zXvhqJzjEpHNoL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MtyrHjkaqZOC8vTm60mW7OIGLTc37l2BnMN6vw/UILe6ZHa49edhBQLwrTmUh62xp
	 LwxZD6HPkH1QLaMtRgohb+gMo4JO/kDwiJW6uTPaHRx+wETPNSIxLrD4rgvZiaionl
	 0UbmAnXFwUYXrWI2L8hp0N7ZrbqIwQt4AVFuKATFEOQYZJJ1j8boxB+NxDjVZwZN/2
	 8atPLhLzWgiSOKuRFiZrZJ7bqpwjNF85rU/v1AavbZmqqnlQEM4X3KHVv2lqqviMFL
	 8hocmKb4UrTJ9PJzrBlYndcQcFw2E87wshzSKahFdXtoJlKOcg8t59rbi2Bo0t3nxa
	 4z2yM6onN7tAw==
Message-ID: <9f69629b-b341-44d0-de31-f8ac3f22fa6b@kernel.org>
Date: Mon, 14 Aug 2023 09:30:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Tx queues with
 coe
To: Rohan G Thomas <rohan.g.thomas@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230810150328.19704-1-rohan.g.thomas@intel.com>
 <20230810150328.19704-2-rohan.g.thomas@intel.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230810150328.19704-2-rohan.g.thomas@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/08/2023 17:03, Rohan G Thomas wrote:
> Add dt-bindings for the number of tx queues with coe support. Some
> dwmac IPs support tx queues only for few initial tx queues, starting
> from tx queue 0.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>

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


