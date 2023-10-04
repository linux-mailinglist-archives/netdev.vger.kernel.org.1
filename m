Return-Path: <netdev+bounces-38002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CC67B8513
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 024F41C20506
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58B41BDFF;
	Wed,  4 Oct 2023 16:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8CC1BDE3;
	Wed,  4 Oct 2023 16:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BA5C433C9;
	Wed,  4 Oct 2023 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696436775;
	bh=qcglxAxRgYQIz8E0bCy+wEqQLr5U4t9luHiOQaUV2Fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jxa2ZLLsxGRvLwcvTQldZ96adZlICmJQJRLEB/ssJiEoxmM9MPQTVgiIQ3XkDC7fM
	 bdogyPB07dsycbtlyP2aSNKv6SPPCpDh9joLzDX0roO/N1X+uFhAFmbVoW6mpAf3qx
	 lVNe3tqlHYazhWBRPb641wMYKdzKEOgrLArUd7/fPhLs6VplRj54mSUps/tOf9KoXO
	 0b2qnNSzPrqwl+tLXEuyhDgPH94MxcRn0W/pk/BLl985bNouApvERtFuaSgnqGOriS
	 OuwBw5rcjYuoZ5+6Z2EkEHNSeIC3GKPDFMGFknU4z0Fx/sv5cNZHBttoIDdgrKtKlE
	 CYTTNiuLLXwNw==
Date: Wed, 4 Oct 2023 09:26:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Rohan G Thomas <rohan.g.thomas@intel.com>, "David S . Miller"
 <davem@davemloft.net>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts
 handling
Message-ID: <20231004092613.07cb393f@kernel.org>
In-Reply-To: <vwdy5d3xirgioeac3mo7ditkfxevwmwmweput3xziq6tafa3zl@vtxddkiv2tux>
References: <20230923031031.21434-1-rohan.g.thomas@intel.com>
	<xwcwjtyy5yx6pruoa3vmssnjzkbeahmfyym4e5lrq2efcwwiym@2upf4ko4mah5>
	<20231002135551.020f180c@kernel.org>
	<vwdy5d3xirgioeac3mo7ditkfxevwmwmweput3xziq6tafa3zl@vtxddkiv2tux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Oct 2023 14:12:15 +0300 Serge Semin wrote:
> If I didn't miss some details after that we'll have a common EST
> module utilized for both DW QoS Eth and DW XGMAC IP-cores.

So the question now is whether we want Rohan to do this conversion
_first_, in DW QoS 5, and then add xgmac part. Or the patch should
go in as is and you'll follow up with the conversion?

