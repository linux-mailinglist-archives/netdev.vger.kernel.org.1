Return-Path: <netdev+bounces-66766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B387B840938
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47261C2295B
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F0C152E0F;
	Mon, 29 Jan 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMAp+We5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF3152E03;
	Mon, 29 Jan 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540458; cv=none; b=bIzm2Vz/eo8AoA/SoRiBXVB/7e+w7IHbECIMUfYhE1rjaBJnnc5RLJ+mbcPq6gZrHj37912sZ9gwA7on/A9lu8pY+3Mvqx4XCdn1yno1YZA2x434FBKcVGlP+mIXb0F/X3M27j+QN4DlpEpkuc73JRrlHw/261eksLLwpHwqp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540458; c=relaxed/simple;
	bh=vbwB+RmUHd0dIgAVZRrgq4WWZLfSjswbir8qSTldHPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bm7zq93oc1jHg0XmRx61boSmXpykCNtWQ+BQ5QV7bGPzly/RaCnWHZ/FTXWNOEQdl4USak2MXUE8754Xe6s3iq3NxY/KJCgdrZHEr8QJBonw7ZOH9oe6F37LlHY8EXRR/NbIKEGW6WP+qcsEnxgdJsY9RhkOhOf/7wdoTJQwsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMAp+We5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0389FC433C7;
	Mon, 29 Jan 2024 15:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706540458;
	bh=vbwB+RmUHd0dIgAVZRrgq4WWZLfSjswbir8qSTldHPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LMAp+We5qt2Kc6tTeIzXWbvt9bVArZPszPN8PxazHVxx5vJKnI7gBpFguDpKbTI/S
	 J33OgHRg4YgyxfCr4sM696jPpI9Qyhv3ZUQXc2UzoB1DunVi+oVfYC6iSSE72Vtqjz
	 As4gUjZiynN9oHqQ0k0paKJTqAy6cAB8OkMkRe/HKZpecOhV3oLJbc5kDctalu5OGa
	 jvBpClyeym3pEzMddA+PNzY8OGitIzluOsojxI+HNtJ/JXRG5jexniMVAnu1uMmHo8
	 MI6nOZSGH1uevEV9Ga1wxuC45GJ4SwfSoYKwV999gXZPfD1L/+zy3q0fjLMYTYaCC+
	 XrpiRRbvI7NuA==
Date: Mon, 29 Jan 2024 07:00:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240129070057.62d3f18d@kernel.org>
In-Reply-To: <ZbeeKFke4bQ_NCFd@shredder>
References: <20240122091612.3f1a3e3d@kernel.org>
	<ZbedgjUqh8cGGcs3@shredder>
	<ZbeeKFke4bQ_NCFd@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 14:46:32 +0200 Ido Schimmel wrote:
> On Mon, Jan 29, 2024 at 02:43:49PM +0200, Ido Schimmel wrote:
> > On Mon, Jan 22, 2024 at 09:16:12AM -0800, Jakub Kicinski wrote:  
> > > If you authored any net or drivers/net selftests, please look around
> > > and see if they are passing. If not - send patches or LMK what I need
> > > to do to make them pass on the runner.. Make sure to scroll down to 
> > > the "Not reporting to patchwork" section.  
> 
> Forgot to mention: Thanks a lot for setting this up!

Finger crossed that it ends up being useful :)

> > selftests-net/test-bridge-neigh-suppress-sh should be fixed by:
> > 
> > dnf install ndisc6
> > 
> > selftests-net/test-bridge-backup-port-sh should be fixed by:
> > 
> > https://lore.kernel.org/netdev/20240129123703.1857843-1-idosch@nvidia.com/
> > 
> > selftests-net/drop-monitor-tests-sh should be fixed by:
> > 
> > dnf install dropwatch  

Installed both (from source) just in time for the
net-next-2024-01-29--15-00 run.. let's see.

