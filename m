Return-Path: <netdev+bounces-27249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBD477B27D
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA98C280FBF
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCDD882E;
	Mon, 14 Aug 2023 07:31:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD796D24
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87029C433C7;
	Mon, 14 Aug 2023 07:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691998291;
	bh=XytP3I80/0qufxxP+Bp149TyvqLgWEhhNGRMhkFuP8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lzqPw2AgE4+UGkJStKw9SIJ0h9KJoJx06ku5WLR710wEQlF+qBsw6VLNtMAKiL1fl
	 KBlxFLEsJQw+15Lw4m7RgT4xskqKJoR1jjFN2ZtEwTjZUr8qmQBm3ynzs9Fb0X3BrP
	 OFHTcjMCjg0g/AMWb83R/ta7GHitcFWnFcDHLx3o+AMsPTkqRUT/6c4LdRCkiINnZW
	 j2hShuxqRM0Rw15EaUkpRQGAWjOx8cfyW8wCAxBG6wUF/hRylxx/QsjowN40pq4oY0
	 oKLIDi8b2ccFRxyoQr3+4wgrLGEuHZGrTYkSh8zG3JK1bKqScwu+8/X0hNoK/u4nHf
	 2knCU6MfrW4zw==
Message-ID: <e3939093-b9f3-d722-d6db-84cd739f9c0c@kernel.org>
Date: Mon, 14 Aug 2023 09:31:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Content-Language: en-US
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
 <20230811190032.13391-1-rohan.g.thomas@intel.com>
 <20230811190032.13391-2-rohan.g.thomas@intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230811190032.13391-2-rohan.g.thomas@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/08/2023 21:00, Rohan G Thomas wrote:
> Add dt-bindings for the number of tx queues with coe support. Some
> dwmac IPs support tx queues only for a few initial tx queues,
> starting from tx queue 0.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>

1. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC. It might happen, that command when run on an
older kernel, gives you outdated entries. Therefore please be sure you
base your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

2. Do not attach (thread) your patchsets to some other threads
(unrelated or older versions). This buries them deep in the mailbox and
might interfere with applying entire sets.


Best regards,
Krzysztof


