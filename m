Return-Path: <netdev+bounces-210850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F81B151C3
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2F33A7000
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37AF28DF27;
	Tue, 29 Jul 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlPT85UP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440934CF5;
	Tue, 29 Jul 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808300; cv=none; b=gsUYRTGPsfi5HYXpvsxuTxdpMM2cU1CedzTmqxG876qokUrKBjVvjDiQHRU05G7KpTyYMwUp1k1dD7sV8JkUX76QIKpAawh5EhwpTDtHnrEiyD2aAAFA78JpLrFoCtZwyO5dmOAoNGuR9mepb9WGQXppAe69bD3o9AeB1Z9OOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808300; c=relaxed/simple;
	bh=Hb9smdHf0g56CpF8sBWDOF38RasuaUJ0puvOlmqvOjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er+5L2nDPiY9Fiyz6XYKYSuc1tBDDs2MEzKbk2E5oc2WOJ51C5s6qxdsHFGAfoePLV9ccl2ezr2ZsJPZpdEkM1o4A6bwu3RJ/+VcmO0VeDzgiUNS/uPhW30dlpSEBSi83EZ98OY6u/B+g001MfyVDxyNIiwlgtt2Sr9k5cpgl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlPT85UP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A35EC4CEF5;
	Tue, 29 Jul 2025 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753808296;
	bh=Hb9smdHf0g56CpF8sBWDOF38RasuaUJ0puvOlmqvOjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlPT85UP6HQLETFTi6OtUJx9aRuyZBcfrc4BG0gLSetfvPPGD3huNlBLFo0yL5k22
	 Mtx9Bqa1YmgYyOQeni00rZcMrLD1xMmj+A/AcO7/p2AZGoUM57od4OFqJgUlcbZPy1
	 vwoHTTPkVS1J/e0Wea9moLyTMgW5hPt3gOmatUFpd7vYVdHguB+8uTPSslkTw2M+Nd
	 AQ9lmMqb8djPioT5MzVN22+r099MIJTq6z508uKiDs1wcvKL++f6Yh4T1g5d9/PNTn
	 kMtkM/iz68Sx+YMXAHzvOowhlMKSqVIczcTgLwLbXL7BKChTSMwB2V7Xl1e7J3sn/D
	 v2qe7PZzt4j6A==
Date: Tue, 29 Jul 2025 17:58:10 +0100
From: Simon Horman <horms@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] drivers: net: stmmac: handle start time
 set in the past for flexible PPS
Message-ID: <20250729165810.GG1877762@horms.kernel.org>
References: <20250729-relative_flex_pps-v2-0-3e5f03525c45@foss.st.com>
 <20250729-relative_flex_pps-v2-1-3e5f03525c45@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-relative_flex_pps-v2-1-3e5f03525c45@foss.st.com>

On Tue, Jul 29, 2025 at 04:52:00PM +0200, Gatien Chevallier wrote:
> In case the time arguments used for flexible PPS signal generation are in
> the past, consider the arguments to be a time offset relative to the MAC
> system time.
> 
> This way, past time use case is handled and it avoids the tedious work
> of passing an absolute time value for the flexible PPS signal generation
> while not breaking existing scripts that may rely on this behavior.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 31 ++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 3767ba495e78d210b0529ee1754e5331f2dd0a47..5c712b33851081b5ae1dbf2a0988919ae647a9e2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -10,6 +10,8 @@
>  #include "stmmac.h"
>  #include "stmmac_ptp.h"
>  
> +#define PTP_SAFE_TIME_OFFSET_NS	500000
> +
>  /**
>   * stmmac_adjust_freq
>   *
> @@ -172,6 +174,10 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
>  
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_PEROUT:
> +		struct timespec64 curr_time;
> +		u64 target_ns = 0;
> +		u64 ns = 0;
> +

I think you need to wrap this case in {}, as is already done for the following
case.

Clang 20.1.8 W=1 build warn about the current arrangement as follows.

  .../stmmac_ptp.c:177:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    177 |                 struct timespec64 curr_time;
        |                 ^
  1 warning generated.

GCC 8.5.0 (but not 15.1.0) also flags this problem.

Also, please note:

## Form letter - net-next-closed

The merge window for v6.17 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after 11th August.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: defer

