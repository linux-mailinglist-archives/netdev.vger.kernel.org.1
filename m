Return-Path: <netdev+bounces-21153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989276295F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C1D2817F0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242F63FE0;
	Wed, 26 Jul 2023 03:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872F1846
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EB0C433C7;
	Wed, 26 Jul 2023 03:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690342790;
	bh=/DXkxDc0cjY513B5QGcbSthekDMBSig0Uuz5USmRB9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H157GANRAtY9o9O/MLKKTTbuWpOwR4XmTVaem5NtxNwnkOrUiwqdx6pKbPVRZyxZp
	 XsrhqhKIY1O74VUIwmGYMvKVAa7F/mum5SbnVjk+tZ2dUYbv4brqLThJ0UPAXGhjc4
	 nO1vw4bl4Iv66QnJ4u0WwqG0pd8FueE8M/yzw7B4zWsoHYI1fbR9LYzkXa78PgjWTJ
	 DQVv4aw6MZVD7uzWaIvbUJ/K4ImsCSxC73xWyDRUOXIUKsX1rSQlztJloyiBGiOJ7k
	 N/h7SBzK5mn5cwjYvmMEe9Da0xYHpv5gXt/zbrYdsZGYhFItjoUZKl2NSaVLZrTUkP
	 pK1jE7jQdNRTQ==
Date: Tue, 25 Jul 2023 20:39:48 -0700
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
 kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <20230725203948.4037fee7@kernel.org>
In-Reply-To: <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
	<20230725200606.5264b59c@kernel.org>
	<ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 20:22:53 -0700 Richard Cochran wrote:
> > any opinion on this one?  
> 
> Yeah, I saw it, but I can't get excited about drivers trying to
> correct delays.  I don't think this can be done automatically in a
> reliable way, and so I expect that the few end users who are really
> getting into the microseconds and nanoseconds will calibrate their
> systems end to end, maybe even patching out this driver nonsense in
> their kernels.
> 
> Having said that, I won't stand in the way of such driver stuff.
> After all, who cares about a few microseconds time error one way or
> the other?

I see :)

