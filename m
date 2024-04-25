Return-Path: <netdev+bounces-91462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FD18B2A77
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 23:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258821C21135
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99BE1552EE;
	Thu, 25 Apr 2024 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+PVkQO2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B290115380E;
	Thu, 25 Apr 2024 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079459; cv=none; b=o3cqD1scaWEqbNaS4XTlFW7Cv+60D3DLC4lEvKOAjmkBziQvmeJIk7qVxA/r7jwL8tTdKrtM7ZsY9yPmiAn9S16ekcUJAb+Te5guenwSwCPNPEmccdLu79/2o3uFodYBOhutNbCWVDxp7T4yDmrz1scwuuKaIG+S+zQQeqec6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079459; c=relaxed/simple;
	bh=Ipj03lL2Oj2jhT2WiwUngHBKrANss2VUC/t4IcKtBFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLJ1DlJ3RHEvAEwAVtmfagN+6iTIW7cdiff/jTVrwUokGzDrK35Z/RyrkI98v4dC3RCyOilXd/eL64pRTSPCEqNT4C8TM8kYHRVC8BqGel1OnvUrGVVbaNqUAN2TDyaHC+N3o2Nuewi8BuWpJq3tS1AmWDo6oCX4QPUVZ21JyxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+PVkQO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027D4C113CC;
	Thu, 25 Apr 2024 21:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714079459;
	bh=Ipj03lL2Oj2jhT2WiwUngHBKrANss2VUC/t4IcKtBFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O+PVkQO2IfAKd0JOZqchdhYvqWQ521ebvr7vCsn+d5KN42NaEkPkFtk4EfYGAR0v5
	 zFvZCmx7noj1ZnMznPPNL5haf4QsMnMpkSE6wMEhYfSJSsXOIBe86Z6iN46pKpOVk/
	 JJKYVVbRVOpbRs6yd8lQQWYS2a/CIcWAJa8xzioP8kry42RBwkfLh+izxtW77BUX2K
	 u/Hjv4ZrOzqHNhQasDv26VthA75qvSilxJAhVxwpcQX/+qucLjQ6eb8qwPqWmWcg9E
	 FiBXiFJessnUqvcCHRag3/nmFvq4iSfPJ4K2AhmJgHJvhLNRN7KyFu4s3wReNcq1Cb
	 ThcX8tAeWjXMg==
Date: Thu, 25 Apr 2024 14:10:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] Differentiating "Supported" and "Maintained" drivers on
 something other than $$$
Message-ID: <20240425141057.58fe225d@kernel.org>
In-Reply-To: <0673a490-cebc-4b24-b231-95ecd15b5a41@lunn.ch>
References: <20240425114200.3effe773@kernel.org>
	<0673a490-cebc-4b24-b231-95ecd15b5a41@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 22:22:28 +0200 Andrew Lunn wrote:
> > The new guidance will take effect starting with Linux v6.12. This means
> > that any new driver merged for v6.12 (i.e. merged into net-next during
> > v6.11 release cycle) will need to come with running CI to be considered
> > Supported. During the v6.12 merge window all Ethernet drivers under
> > Supported status without CI will be updated to the Maintained status.  
> 
> Do we have any drivers which today fulfil the Supported requirements?
> Any which are close?

We only started adding tests this month, so not really no ;)
But v6.12 is 5 months out, hopefully that's enough time to put
a machine in a DMZ and write a python script?

I was actually looking at SBCs with multiple NIC ports over the
weekend to start running these tests myself, but I stopped myself.
I don't scale :(

As I said the Supported status itself doesn't have much _practical_
meaning, so hopefully there isn't much downside to trying to nudge
people. If we get one company to run the CI, that's good enough in
my book. If someone is actually currently using the status as leverage 
to make their employer let them work upstream on NIC drivers - putting
more requirements in place would be a concern (LMK on or off list!)

