Return-Path: <netdev+bounces-69943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF6884D1D7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3532E1F27F31
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F08563C;
	Wed,  7 Feb 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ga+Qv0/Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBE84FB4
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332108; cv=none; b=rKmVm+dzhes7wpGv33gzlACEa+7MQ7Mklvu4d4bthb3tk8X0D4ZcbrC01nj/hC6MvROvKBbI0tlGL+7WqGfpxM358Fml4fXwFQTb2bCPaW16aBE1mGM96Jmnkrsz/vWjv0a1hH47aEubrPYxCmPM/EnvF3Ekbhk449i6nfIzxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332108; c=relaxed/simple;
	bh=cvMmNrsAsXCkSpN8/+Wf2PKLZZ8wrOKhw+G9M/OVfVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEz4bNKrMH2fsjRVNPPr7S2rRMT5z/CZPyfSFsFIQ9Ghb9sAi55VJbfcp+x7kgMv5iGgSyzEvl0dsQxJydvqFCdDIisPI3DOTnGOKzvqApUZWOC+LbWO8C3Do+hbgV9XVw/bpaznBtRwo5d7LbTWGu34UfXkcbK/3CfMQndYzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ga+Qv0/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CC7C433F1;
	Wed,  7 Feb 2024 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707332108;
	bh=cvMmNrsAsXCkSpN8/+Wf2PKLZZ8wrOKhw+G9M/OVfVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ga+Qv0/YSfWfUX6ntazfXsSUWFVbJo9aVeB3J4CJndAWCpU0LbG1aHJFP+lmFLX1D
	 Q83pYbKwzf5HUokQeQ9/Q1Va4PTpz3YpI9s3up2W/+XLhvxw+0uDyBz6s9cd6tzXqk
	 fzz+CzQPkAeZtzp8KA256V7/j1VXKk23F42Qu4v+0hQu/TqZFVRW8zh//5uq83Ja47
	 moh14U0Ls9+n92wggIa4FsFzQZ+qdCFHjBIcEPrgjID3V//93LMWOaF13HTaLNgkIj
	 B3xATYVZqp9FXTdBxun1jSFBKbuOTwcKdPjm8lYkJLVu2hDpCiGzZRaB5/m6PFpM3c
	 omoDX4IhK21RA==
Date: Wed, 7 Feb 2024 10:55:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] The no-kvm CI instances going away
Message-ID: <20240207105507.3761b12e@kernel.org>
In-Reply-To: <c5be3d50-0edb-424b-b592-7c539acd3e3b@kernel.org>
References: <20240205174136.6056d596@kernel.org>
	<c5be3d50-0edb-424b-b592-7c539acd3e3b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 10:45:26 -0700 David Ahern wrote:
> On 2/5/24 6:41 PM, Jakub Kicinski wrote:
> > because cloud computing is expensive I'm shutting down the instances
> > which were running without KVM support. We're left with the KVM-enabled
> > instances only (metal) - one normal and one with debug configs enabled.  
> 
> who is covering the cost of the cloud VMs?

Meta

> Have you considered cheaper alternatives to AWS?

If I'm completely honest it's more a time thing than cost thing.
I have set a budget for the project in internal tooling to 3x
what I expected just the build bot to consume, so it can fit one
large instance without me having to jump thru any hoops.
I will slowly jump thru hoops to get more as time allows,
but I figured the VM instance was a mistake in the first place,
so I can as well just kill it off already. The -dbg runners
are also slow. Or do you see benefit to running without KVM?
Another potential extension is running on ARM.

And yes, it was much cheaper when the builder run in Digital Ocean.

But why do you ask? :) Just to offer cheaper alternatives or do you
happen to have the ability to get a check written to support the
effort? :)

