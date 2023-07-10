Return-Path: <netdev+bounces-16610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE1C74DFEE
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BD6281322
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90622156D5;
	Mon, 10 Jul 2023 21:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84467154B2
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:00:29 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8CA12E;
	Mon, 10 Jul 2023 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XVuZJr2L/nTkTfBb6L5D8j3Q2F8XbvWij/gq2kKoLBM=; b=on7EgpPfmWiU5rOK0lqC5DHyiR
	Kuzpe/w/WV4xQMg3jRtWnNyfj05MkFSEQ1rFgw+zPvBtg4k317TyNTeTbE7kNb8bA2RKGtwyHkNue
	Vzrjm34JFivKT7bh65pAnf78uDBKK10MpdCewCpYflzpIrT+4NoKAA3X/5HMDIyxJt1g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qIxzS-000z4K-GN; Mon, 10 Jul 2023 23:00:14 +0200
Date: Mon, 10 Jul 2023 23:00:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
	alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
	bhupesh.sharma@linaro.org, vkoul@kernel.org,
	linux-arm-msm@vger.kernel.org, simon.horman@corigine.com
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: dwmac-qcom-ethqos: Log more
 errors in probe
Message-ID: <766e0771-ab13-4f1e-ba4b-2584934d16c0@lunn.ch>
References: <20230710201636.200412-1-ahalaney@redhat.com>
 <20230710201636.200412-4-ahalaney@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710201636.200412-4-ahalaney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 03:06:39PM -0500, Andrew Halaney wrote:
> These are useful to see when debugging a probe failure.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

