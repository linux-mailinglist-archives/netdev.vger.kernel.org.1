Return-Path: <netdev+bounces-29136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FF3781ACC
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 20:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD3B1C2092F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7442319BC7;
	Sat, 19 Aug 2023 18:59:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4917724
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 18:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32ADC433C8;
	Sat, 19 Aug 2023 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692471548;
	bh=muSsZQXeH5W5ZWIQQGcJYHD2XdcfeOyxVM9kY1wr7f8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i74yyXCF1RpoTfnu1exjW2hK1HDtKw2oAVHRpVll+Mt2HqVxOFnXWkki5CEEZFNcb
	 2gOurktbrZNr16tNwNkzOM2rd40R2TfPCei7W3ZewL6qgYUI3cSUL4y8i8fiaVHcQm
	 i/8i5QlbHq+2OOh3cagGRp2QU+QkTKfN0FNz2c+fFxqAjEagqnJeJjJS0/kJffU0XU
	 JHd4jdq4eSU7dh4PY8I7ZNvIsLRiq328kzObyS5l47RPqXhyZ8Z7xU7a0NDO60Ram+
	 khhDhMrwPC+aOzNJ6JlzrpQMl14uzaikCMDbV3w7dOcKGRhSfMh6wToV3rrs+M38i9
	 0wqRsPMeYRA5Q==
Date: Sat, 19 Aug 2023 20:59:01 +0200
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: Check more MAC HW features
 for XGMAC Core 3.20
Message-ID: <ZOEQ9TYM/FX8UPr6@vergenet.net>
References: <20230819105440.226892-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819105440.226892-1-0x1207@gmail.com>

On Sat, Aug 19, 2023 at 06:54:40PM +0800, Furong Xu wrote:
> 1. XGMAC Core does not have hash_filter definition, it uses
> vlhash(VLAN Hash Filtering) instead, skip hash_filter when XGMAC.
> 2. Show exact size of Hash Table instead of raw register value.
> 3. Show full description of safety features defined by Synopsys Databook.
> 4. When safety feature is configured with no parity, or ECC only,
> keep FSM Parity Checking disabled.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v2:
>   - Rebase patch on net-next. Thanks Simon :)

Likewise, thanks.

Reviewed-by: Simon Horman <horms@kernel.org>

