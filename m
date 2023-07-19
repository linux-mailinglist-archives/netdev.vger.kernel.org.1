Return-Path: <netdev+bounces-18795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95442758A90
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20781C20EE7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918615C1;
	Wed, 19 Jul 2023 01:01:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D8ECA;
	Wed, 19 Jul 2023 01:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C750AC433C7;
	Wed, 19 Jul 2023 01:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689728510;
	bh=DErPakduFqhgq+XgSW/ZrwNOszO28tTHkZXEYy5pKSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=owbr9Ll38m9telfzm+Q+UeIGv0gZ+QJBwa+XOR/u3k/zDw3jyTdT12TSkk8Nv9vbm
	 1L86mr3GPnXaV0zf20IU2MZmEGMa10XbA7MuKNwRwcSukUfm4R6LLmn48puNGKGz2R
	 NUiWOom2OsnEU/v1r40sroRLsDDtNdZ3gTi6yS4BwsmdB2O5fw3uyoCkzJReuu4sw+
	 dGbbt+sRIqE5U+u98C9yKylCnrloFczRmCFDKcknY8euiE5hJSobXs7HvyulGvDFb5
	 8iOOA3iJ4NYJa0+6xt3Os7VZRXBB8ykzMIdC8YxkCbLKJsVeL6h7j3q4NG0nIVaYRo
	 PYwSGTYEhV+FQ==
Date: Tue, 18 Jul 2023 18:01:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net-next v5 0/2] net: stmmac: improve driver statistics
Message-ID: <20230718180148.4fe125d9@kernel.org>
In-Reply-To: <20230717160630.1892-1-jszhang@kernel.org>
References: <20230717160630.1892-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 00:06:28 +0800 Jisheng Zhang wrote:
> improve the stmmac driver statistics:
> 
> 1. don't clear network driver statistics in .ndo_close() and
> .ndo_open() cycle
> 2. avoid some network driver statistics overflow on 32 bit platforms
> 3. use per-queue statistics where necessary to remove frequent
> cacheline ping pongs.
> 
> NOTE: v1 and v2 are back ported from an internal LTS tree, I made
> some mistakes when backporting and squashing. Now, net-next + v3
> has been well tested with 'ethtool -s' and 'ip -s link show'.

Giuseppe, please take a look.

