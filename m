Return-Path: <netdev+bounces-26251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7B3777551
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCAB1C21525
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BF11ED28;
	Thu, 10 Aug 2023 10:03:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861921E51F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4BFC433C8;
	Thu, 10 Aug 2023 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691661808;
	bh=h3BA3I10oH7VW8/1K474QAx0VUkyw0uaaD0W0BPjf+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQuvaB982mwEO7JuDiSs+xIJamzFCo+k9o5sT80t2RT33S8xb6TdKuzeYXv9JiZkj
	 KKnAWfjUKUtFZveI9RrBSzdu69lEH2TOY/SXQzFffAHtAzhTV75CV8vaG13doAsaIP
	 V4X7jEYlglKETikr1QGpZ799l9hfEew87tejhLeLBpEOr2T0okDSBW9cmRzkG4AQ1p
	 /kQJYqYWA91uGUilavbHwngUkuhx84EqdNUg3J5z5Ftl4+IPjD6BGw8tVqybABwTOZ
	 DZCcDVhjYEOjHy50Kdhd4HvJrGKc0EV4iGIcze/wLc5yVC7SheVWJndU8xL51eR/dL
	 CcvM/35+xMb8Q==
Date: Thu, 10 Aug 2023 12:03:22 +0200
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v3 1/1] net: stmmac: xgmac: RX queue routing
 configuration
Message-ID: <ZNS16rhrXq+JUR85@vergenet.net>
References: <20230809020238.1136732-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809020238.1136732-1-0x1207@gmail.com>

On Wed, Aug 09, 2023 at 10:02:38AM +0800, Furong Xu wrote:
> Commit abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
> introduced RX queue routing to DWMAC4 core.
> This patch extend the support to XGMAC2 core.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v3:
>   - Clean unused defines
> 
> Changes in v2:
>   - Convert the shift ops to FIELD_PREP

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

