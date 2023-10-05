Return-Path: <netdev+bounces-38276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA037B9E6C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 38EE4B20517
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE9428DA1;
	Thu,  5 Oct 2023 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0UghGfv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4B2770A;
	Thu,  5 Oct 2023 14:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FA9C433B7;
	Thu,  5 Oct 2023 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696514739;
	bh=uEs+c2evdAN1gGRELIzgOPEmlANziGZN9NaBywOLzVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q0UghGfvomUGJjKVgB7EPISuwTzykstgzqZoQQoyr1v4jQFCR2YiSIB2j4OvDki4Y
	 DykfvZLOqqbKJsswerJN1NM8sWOTOKX7ppC9EVGJXh9kT745ExQgPZPu2v7NM48vYA
	 bTDW5iMCXK/+i3lYYCA9KwS1U6hlunEHWLralA412S2zKG3KpYjoKgphJDRBmlUxnP
	 ZwimK57Z2PrNOXkSErMA1MGAG80jh6aIHOfq64IsKTAPPjOPYOtat6/eCI3KHtYbr1
	 oPXp5YVb0/1sZqrFlYetYso8MY+qeIX7enuC+TK2J94fUe8XMHBHpq8C4gWSb5owmI
	 W90baIp4KOXAw==
Date: Thu, 5 Oct 2023 07:05:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: alexandre.torgue@foss.st.com, andriy.shevchenko@linux.intel.com,
 davem@davemloft.net, devicetree@vger.kernel.org, edumazet@google.com,
 fancer.lancer@gmail.com, joabreu@synopsys.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts
 handling
Message-ID: <20231005070538.0826bf9d@kernel.org>
In-Reply-To: <20231005121441.22916-1-rohan.g.thomas@intel.com>
References: <20231004092613.07cb393f@kernel.org>
	<20231005121441.22916-1-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Oct 2023 20:14:41 +0800 Rohan G Thomas wrote:
> > So the question now is whether we want Rohan to do this conversion _first_,
> > in DW QoS 5, and then add xgmac part. Or the patch should go in as is and
> > you'll follow up with the conversion?  
> 
> If agreed, this commit can go in. I can submit another patch with the
> refactoring suggested by Serge.

Did you miss the emphasis I put on the word "first" in my reply?
Cleanup first, nobody will be keeping track whether your fulfilled 
your promises or not :|

