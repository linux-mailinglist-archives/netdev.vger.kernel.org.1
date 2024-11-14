Return-Path: <netdev+bounces-144631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F49C7F76
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F59EB223B1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94671BA53;
	Thu, 14 Nov 2024 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocx6n6hn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70597A95C
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545207; cv=none; b=rjL4Eia4BIWesGTK8wW16JeIlhmtstxCxbYIO6N3gD7BBk0ubg68VJ15zfWPeTcVRDQw+DG1HUlJ9RPukriecLN7FhfT/fGpXkYou0OjOJlHAs7s8tUjIXUylbEGaNREMD9xQPl7MNC0bpLU6CVnqSACFWafnyIZ+7YWx5qdEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545207; c=relaxed/simple;
	bh=J5/D3+OdehOwSYXlmVpR9LTcHG+iwq+VRrUAh3nkTic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NornsREsT19n3gjwWeo1oQ54YNainGNGIJibJ9Z9pQlCwAm+CRZAGwXff/umhU4mwdyfCdQKBELQMQI/1TJ1KMLP5U8GjNp1luZwjGVoZC3b4EcdWYpzMviWP8CVPcDCkrziJMdi9A8tCARlcPhB+qLqiKQPFlXJJMtqQiuwGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocx6n6hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE15C4CEC3;
	Thu, 14 Nov 2024 00:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731545207;
	bh=J5/D3+OdehOwSYXlmVpR9LTcHG+iwq+VRrUAh3nkTic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ocx6n6hn25JjJ35Q/R7PTWdAGUNYPml2T0/nDBuSpbOUSry1xcZt79GnfvUEU4Ehc
	 EWp49Uv+l8AqqPZ1wI0oJgliYb1mkZ58RqtgJ/iVEuqS3xEyJjrRs7KlHTVPPirui7
	 eN6X5sKeCGpmyJRU5WmomO7KOgUSP+de32XsPnFWRpRv29ZyL0riREwrvNUSdXoT4S
	 Ro+65KUnzIs0DRYlv+zkRz0+GuZerV6KDARBOIaGqay3QRVgrkviyC5doEPJOsH0+9
	 67wQMo8lFgvuMvNKhHrnCinjDefhzI23AOq8gUKueYuZfLG3EyGAamiSf8kNYN+iPs
	 O+5tPKgCO6xKw==
Date: Wed, 13 Nov 2024 16:46:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, Daniel Xu <dxu@dxuuu.xyz>,
 davem@davemloft.net, mkubecek@suse.cz, martin.lau@linux.dev,
 netdev@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context
 action explicit
Message-ID: <20241113164645.65b79819@kernel.org>
In-Reply-To: <20241113164635.3b02c8b3@kernel.org>
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
	<ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
	<Zy516d25BMTUWEo4@LQ3V64L9R2>
	<58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>
	<20241109094209.7e2e63db@kernel.org>
	<7fd1c60a-3514-a880-6f63-7b6dfdc20de4@gmail.com>
	<20241112072434.71dc5236@kernel.org>
	<07e69b19-36c2-ece4-734f-e2189b950cab@gmail.com>
	<20241113164635.3b02c8b3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 16:46:35 -0800 Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 03:30:05 +0000 Edward Cree wrote:
> > On 12/11/2024 15:24, Jakub Kicinski wrote:  
> > > Hm, interesting idea...
> > > Practically speaking I think it introduces complexity and I'm not sure
> > > anyone will actually benefit (IOW why would anyone want to keep /
> > > create context for inactive queues?).    
> > 
> > Conceivably to save re-configuring them next time they increase the
> >  queues again?  But I suppose anyone doing that kind of complicated
> >  demand-flexible tuning will be using some kind of userland software
> >  that can automate that.
> > Anyway I don't have a dog in this fight as sfc doesn't support ethtool
> >  set-channels.  (Which will make it difficult for me to test this; had
> >  I better extend netdevsim to support RSS & rxnfc?)  
> 
> Good question on the netdevsim. Adding the callbacks seems fine.
> But making it actually do RSS and nfc on packets to make the HW tests
> pass would be more of a lift. So I think you'd have to add a separate
> test under drivers/net/netdevsim for this. Is that your thinking?

s/your/you're/

