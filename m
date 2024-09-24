Return-Path: <netdev+bounces-129548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FCD98463C
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A96F5B226C3
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F4F1A4F1A;
	Tue, 24 Sep 2024 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFRhQMk2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390ED481B7
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182431; cv=none; b=UzuS2gg2fVS4K98ehlmNbyaokUadU3LWsrl0iKFqS5bYguA/EoTa48BJftzVPhE0p8E6UQ/Los6uvnJqWaAuWqoZYkQkTYM9TUbSIp4g2PmMWkuOmpRJY2PWGKCN1rEboyQzvpgpS7jXOB26+r7K5oC8u+MdoIGo+Y1l3J6NNb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182431; c=relaxed/simple;
	bh=5G1NI5JfcMZ6i8HOuLZdFIUeZeX1FM2opIZNZi68UeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKRC9DswGV76vdV5LQQunaV1Bo4J85GnI2nvRHWAww39de/+iym1BMYVsWgLQYkeulcJZANaui5XMlmTYdNljchWXRdCM8mOjV27T9fN3Mwr2iB+HJDF+fki3zMQjN70toVcjVyT7BhUmuYc4FtP6XiUtW9IJBktvWCDKPE2u64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFRhQMk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DB6C4CEC6;
	Tue, 24 Sep 2024 12:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727182430;
	bh=5G1NI5JfcMZ6i8HOuLZdFIUeZeX1FM2opIZNZi68UeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFRhQMk27B81zbfnhIwdrfMhQQhpmrJYttaMRsx9a6hlGT6uXHzCHODbs0PvAGshz
	 pJRDPynmIiM3Ns1Y8iRDuALfPqzYDxfn1+Rf3GUpDrMWRi3PvGE/NK905XESCNT0Lf
	 40Hbhoaq/z0iqqgdOs1fdOZKXDdc30iQI7JBxiD4mdgFk8pfkAeNyyzXj2hNx3XTcm
	 94di6mpjhz0eUDjbifnM+hXzRwWbEZFJAjzb/UUQIAEGqTxkJmj5QDeZi25blTTNnX
	 8l3U3s2+6Ji0zuUOMTsOQi5PsZq5BkCVVJfK/Hn8KWPGigJtKVrdDZ2HBifvLlXHHv
	 EdEJAs38HW5dw==
Date: Tue, 24 Sep 2024 13:53:47 +0100
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: Switch back to struct
 platform_driver::remove()
Message-ID: <20240924125347.GI4029621@kernel.org>
References: <20240923162202.34386-2-u.kleine-koenig@baylibre.com>
 <20240924072937.GE4029621@kernel.org>
 <3y5dni2ey2hnzie4evmklqcu4uhr72fr64m47uwzo7nnhbqzsz@7igypikspxpm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3y5dni2ey2hnzie4evmklqcu4uhr72fr64m47uwzo7nnhbqzsz@7igypikspxpm>

On Tue, Sep 24, 2024 at 09:48:53AM +0200, Uwe Kleine-König wrote:
> Hello Simon,
> 
> On Tue, Sep 24, 2024 at 08:29:37AM +0100, Simon Horman wrote:
> > On Mon, Sep 23, 2024 at 06:22:01PM +0200, Uwe Kleine-König wrote:
> > > I converted all drivers below drivers/net/ethernet in a single patch. If
> > > you want it split, just tell me (per vendor? per driver?). Also note I
> > > didn't add all the maintainers of the individual drivers to Cc: to not
> > > trigger sending restrictions and spam filters.
> > 
> > I think that given that the changes to each file are very simple,
> > and the number of files changed, a single, or small number of patches
> > make sense. Because the overhead of managing per-driver patches,
> > which I would ordinarily prefer, seems too large.
> 
> full ack.
> 
> > However, touching so many files does lead to a substantial risk of
> > conflicts. And indeed, the patch does not currently apply cleanly
> > to net-next (although it can trivially be made to do so). Perhaps
> > the maintainers can handle that, but I would suggest reposting in
> > a form that does apply cleanly so that automations can run.
> 
> I based it on plain next in the expectation that this matches the
> network tree well enough. I agree that the conflicts are not hard to
> resolve, but it's totally ok for me if only the parts of the patch are
> taken that apply without problems. I expect that I'll have to go through
> more than one subsystem a second time anyhow because new drivers pop up
> using the old idioms.
> 
> Also note that git can handle the changes just fine if you use
> 3-way merging:
> 
> 	uwe@taurus:~/gsrc/linux$ git checkout net-next/main 
> 	HEAD is now at 151ac45348af net: sparx5: Fix invalid timestamps
> 
> 	uwe@taurus:~/gsrc/linux$ b4 am -3 https://lore.kernel.org/all/20240923162202.34386-2-u.kleine-koenig@baylibre.com/
> 	Grabbing thread from lore.kernel.org/all/20240923162202.34386-2-u.kleine-koenig@baylibre.com/t.mbox.gz
> 	Analyzing 3 messages in the thread
> 	Analyzing 0 code-review messages
> 	Checking attestation on all messages, may take a moment...
> 	---
> 	  ✓ [PATCH] net: ethernet: Switch back to struct platform_driver::remove()
> 	    + Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com> (✓ DKIM/gmail.com)
> 	  ---
> 	  ✓ Signed: openpgp/u.kleine-koenig@baylibre.com
> 	  ✓ Signed: DKIM/baylibre-com.20230601.gappssmtp.com (From: u.kleine-koenig@baylibre.com)
> 	---
> 	Total patches: 1
> 	Preared a fake commit range for 3-way merge (77e0c079ace8..198dd8fb7661)
> 	---
> 	 Link: https://lore.kernel.org/r/20240923162202.34386-2-u.kleine-koenig@baylibre.com
> 	 Base: using specified base-commit ef545bc03a65438cabe87beb1b9a15b0ffcb6ace
> 	       git checkout -b 20240923_u_kleine_koenig_baylibre_com ef545bc03a65438cabe87beb1b9a15b0ffcb6ace
> 	       git am -3 ./20240923_u_kleine_koenig_net_ethernet_switch_back_to_struct_platform_driver_remove.mbx
> 
> 	uwe@taurus:~/gsrc/linux$ git am -3 ./20240923_u_kleine_koenig_net_ethernet_switch_back_to_struct_platform_driver_remove.mbx
> 	Applying: net: ethernet: Switch back to struct platform_driver::remove()
> 	Using index info to reconstruct a base tree...
> 	M	drivers/net/ethernet/cirrus/ep93xx_eth.c
> 	M	drivers/net/ethernet/marvell/mvmdio.c
> 	M	drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> 	Falling back to patching base and 3-way merge...
> 	Auto-merging drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> 	Auto-merging drivers/net/ethernet/marvell/mvmdio.c
> 	Auto-merging drivers/net/ethernet/cirrus/ep93xx_eth.c

Understood, I agree the conflicts can trivially be resolved.
But as things stand the CI stopped when it couldn't apply
the patchset. And, IMHO, that is not the best.

> 
> > Which brings me to to a separate, process issue: net-next is currently
> > closed for the v6.12 merge window. It should reopen once v6.12-rc1 has
> > been released. And patches for net-next should be posted after it
> > has reopened, with the caveat that RFC patches may be posted any time.
> 
> This was a concious choice. Because of the big amount of drivers touched
> I thought to post early to have a chance to get the patch applied before
> the gates are opened for other patches was a reasonable (but I admit
> selfish) idea.

Understood, I hesitated with my response assuming that was the case.

> Anyhow, I can repost once the merge window closes.

I think that would be best.



