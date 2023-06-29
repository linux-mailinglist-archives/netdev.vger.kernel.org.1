Return-Path: <netdev+bounces-14634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DBE742C08
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7221280C9D
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF75134A5;
	Thu, 29 Jun 2023 18:43:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554512B7C
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD0CC433C9;
	Thu, 29 Jun 2023 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688064199;
	bh=JB3yOko/3MZ4NfcJ02y4I5HJqG6ralFIy2cH6mm4B58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hUbaOnhj+FLOhftYP5ssuSKS8yVeU8e7MzEtJciAIkpr4y6XDKdwjmtUSSIwRsXwj
	 iTgyx+hq2WWfuXazpap7YW6qBVjjmB8TkPSR7YXYBseazvx1kq7+I3qpQT04o9QWQL
	 Z1G613NyD0c4gHxyk+/DaGw0DWO9znNCVWxupFgNgP+YCRk/9+fWE+Lbq9BPGs8+LO
	 gs8mP2e4LyygsBlxsyotQOv6Mhfa+2DL96CdqgiSFSAxg+XM746xR2k97iREW+5x+G
	 Ah6qUUyQHUEpWryxB8ujSbv81Og7WAC53zq4icazJjtdbXlSQPgNvdMLO6gwayia8b
	 wh85+DCBj0aQw==
Date: Thu, 29 Jun 2023 11:43:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2023-06-27
Message-ID: <20230629114318.61b46f61@kernel.org>
In-Reply-To: <CABBYNZ+mg1iB_N3-FnVCH8O6j=EAs1BTZjGcG_dwU2oOGk-T+w@mail.gmail.com>
References: <20230627191004.2586540-1-luiz.dentz@gmail.com>
	<20230628193854.6fabbf6d@kernel.org>
	<CABBYNZLBAr72WCysVEFS9hdycYu4JRH2=SiP_SVBh08vukhh4Q@mail.gmail.com>
	<20230629082241.56eefe0b@kernel.org>
	<20230629105941.1f7fed9c@kernel.org>
	<CABBYNZ+mg1iB_N3-FnVCH8O6j=EAs1BTZjGcG_dwU2oOGk-T+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jun 2023 11:34:34 -0700 Luiz Augusto von Dentz wrote:
> > > Nothing to add to that list?
> > > Let me see if I can cherry-pick them cleanly.  
> >
> > I pushed these to net now, hopefully I didn't mess it up :)  
> 
> Great, thanks. I guess I will change the frequency we do pull request
> to net-next going forward, perhaps something doing it
> bi-weekly/monthly would be better to avoid risking missing the merge
> window if that happens to conflict with some event, etc.

Maybe every 3 weeks would be optimal? Basically the week after -rc3,
the week after -rc6 and then a small catch up right before the merge
window if needed? Obviously easier said than done as life tends to 
not align with fixed schedules..

