Return-Path: <netdev+bounces-143296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BBB9C1DAC
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DFB1C22F17
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6371EABB1;
	Fri,  8 Nov 2024 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyLcjKLL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93C1EABA9;
	Fri,  8 Nov 2024 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071509; cv=none; b=DRFcuwxfTeOjmguFNJ68oQO1kZeey6yxGgLfMhExS9o8jejJxjkGQNvcPhyEoCRvxpFYpxPhhaXn1l0gy/V434iO9NlCdoyj5U3HbSrafihfccr1l2+PnyzXwGpJgdjvV/Z95oCm8MOJ3jxILjClJdRSAmeI/5sIt/7KNj2K+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071509; c=relaxed/simple;
	bh=zK0GRqp/V3HoI4yu30aVffYgP16alBb/iJp52nxyaXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFa1NR4nWxBlcG2qcKa6hbIa3Zjhi9au2yvOZHxeXBeLs2UmEyJror8jzoARtxcoV+FbPfsY/FK1irP52V5tpWOtOVf5arfvNz3dmQPPHysgP37+nLaZ1aw6vzKyUWax4YvAh3nA+IBfDGtjMJPjwTOHA55OsdMavMBFmHH7F0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyLcjKLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0CAC4CECD;
	Fri,  8 Nov 2024 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731071509;
	bh=zK0GRqp/V3HoI4yu30aVffYgP16alBb/iJp52nxyaXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DyLcjKLLq/dqNJkHXkzMFBK0EoQQqXkZypILttHc3BZu+/UrHNom00DprSYwwoNO9
	 6D6ZesOOA4nN+dCP77wMpJ9cg8TgtIw7fiUcJ4KPQkXfbFA96okJEf0sSEVnqIMLcS
	 DgMSnLpeyBLKsltzYLJriHP1lLxXyRfhK6m6+gChBTZVWQEhCqsGqk8Z0c7/aM6+d4
	 ffzgG5FUSj48K5dBr7gbRqDvNkA41oNcVAWhooL7b5Gq/51mu/OoQSh+tmJ1CQNcWZ
	 pnU/A3FP8JgGxsn1BWUU9nxvgyiSBiu/QfKCmnaYEGQwEoHKtGhvgd4Xe2JZgLucG4
	 Zy8dIyBQW7m4Q==
Message-ID: <c26abf19-782b-400c-9c06-c26edcb4c00b@kernel.org>
Date: Fri, 8 Nov 2024 07:11:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] arm: dts: socfpga: use reset-name "stmmaceth-ocp"
 instead of "ahb"
To: Mamta Shukla <mamta.shukla@leica-geosystems.com>,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, a.fatoum@pengutronix.de
Cc: bsp-development.geo@leica-geosystems.com
References: <20241028145907.1698960-1-mamta.shukla@leica-geosystems.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20241028145907.1698960-1-mamta.shukla@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/28/24 09:59, Mamta Shukla wrote:
> The ahb reset is deasserted in probe before first register access, while the
> stmmacheth-ocp reset needs to be asserted every time before changing the phy
> mode in Arria10[1].
> 
> Changed in Upstream to "ahb"(331085a423b  arm64: dts: socfpga: change the
> reset-name of "stmmaceth-ocp" to "ahb" ).This change was intended for arm64
> socfpga and it is not applicable to Arria10.
> 
> Further with STMMAC-SELFTEST Driver enabled, ethtool test also FAILS.
> $ ethtool -t eth0
> [  322.946709] socfpga-dwmac ff800000.ethernet eth0: entered promiscuous mode
> [  323.374558] socfpga-dwmac ff800000.ethernet eth0: left promiscuous mode
> The test result is FAIL
> The test extra info:
>   1. MAC Loopback                 0
>   2. PHY Loopback                 -110
>   3. MMC Counters                 -110
>   4. EEE                          -95
>   5. Hash Filter MC               0
>   6. Perfect Filter UC            -110
>   7. MC Filter                    -110
>   8. UC Filter                    0
>   9. Flow Control                 -110
> 10. RSS                          -95
> 11. VLAN Filtering               -95
> 12. VLAN Filtering (perf)        -95
> 13. Double VLAN Filter           -95
> 14. Double VLAN Filter (perf)    -95
> 15. Flexible RX Parser           -95
> 16. SA Insertion (desc)          -95
> 17. SA Replacement (desc)        -95
> 18. SA Insertion (reg)           -95
> 19. SA Replacement (reg)         -95
> 20. VLAN TX Insertion            -95
> 21. SVLAN TX Insertion           -95
> 22. L3 DA Filtering              -95
> 23. L3 SA Filtering              -95
> 24. L4 DA TCP Filtering          -95
> 25. L4 SA TCP Filtering          -95
> 26. L4 DA UDP Filtering          -95
> 27. L4 SA UDP Filtering          -95
> 28. ARP Offload                  -95
> 29. Jumbo Frame                  -110
> 30. Multichannel Jumbo           -95
> 31. Split Header                 -95
> 32. TBS (ETF Scheduler)          -95
> 
> [  324.881327] socfpga-dwmac ff800000.ethernet eth0: Link is Down
> [  327.995360] socfpga-dwmac ff800000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> 
> Link:[1] https://www.intel.com/content/www/us/en/docs/programmable/683711/21-2/functional-description-of-the-emac.html
> Fixes: 331085a423b ("arm64: dts: socfpga: change the reset-name of "stmmaceth-ocp" to "ahb")
> Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
> Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>

Applied, thanks!

Dinh

