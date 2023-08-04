Return-Path: <netdev+bounces-24560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC34E7709A8
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756D02825BE
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7C61DA21;
	Fri,  4 Aug 2023 20:24:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD591BF1E
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 20:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F6CC433C8;
	Fri,  4 Aug 2023 20:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691180645;
	bh=MN8Ir5pH3svELvRVWkYhOhFDhYH6jPowbfYlT+skAZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z+rNfBjRljT7BMNl9BeMpg8gSzG3afyNJqmBduhCOJwxMpuy34xi6jV8JJMzBm9LU
	 R0ipkW8j6NebYUUIKABm+F/z6K0oen0SxgruY7Ggn1D/WcCxxk8qoywCH8ohaFAdJ+
	 UfW/osKhfAAvFuX29JvqaaPXfDXbyDbc+hMdXiQ/SbEsKHnFNNtHtJrbtR5aGShTxK
	 0GjSFGj3zrZGbh2tyQWFITLE+BziTFWKWpmTYNPeSmX275VbB7yOaCueqqXmFEv5F9
	 Tp8tbkuX7WkILnMpu3iDdkIY5f1A8RLOPIH9wbhU5FBT5O3/yFRFWlH4ukVsMx/uIi
	 NjJLtQ7lN6RSg==
Date: Fri, 4 Aug 2023 13:24:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Johannes Zink <j.zink@pengutronix.de>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>,
 patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, Kurt Kanzenbach <kurt@linutronix.de>, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH v3 0/2] net: stmmac: correct MAC propagation delay
Message-ID: <20230804132403.4d9209de@kernel.org>
In-Reply-To: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
References: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Aug 2023 17:44:28 +0200 Johannes Zink wrote:
> ---

Richard? Sure would be nice to have an official ack from you on this
one so I don't have to revert it again ;)

