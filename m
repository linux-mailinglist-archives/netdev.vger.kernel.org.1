Return-Path: <netdev+bounces-86312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B10189E60B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0901C21F3F
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87B0158DB0;
	Tue,  9 Apr 2024 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw7NZB0g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3212F381
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704915; cv=none; b=OlN4iAl39MoQ/K718B9GEyYooTMfUa3StwXqu/pUyjtJKpVdAsG9jSTMeuOEfHPHKLvsCwu4XaZ+RF8fMzapeMRi2afytftLUEhf42dsbLChYdXcU0lRtlgC5h6tYoHeRwHvzcmLisXvuxI2Msgjy8G4x5uSGaEjgx4Zc2OSo9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704915; c=relaxed/simple;
	bh=pmnhYkKStO3URbxSM3T7QdWAB6NsrZ/26hHzX1Y0Fwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=av+nBZ9sUfgunuGu4Z15V+e9PTrZz2yppYhjFhqIDIGVmpJ+S0ZCr+0yIyMEEtPpoZGb7q8wOJPspwdXgCCsetDmjpgMZTkOKrzvYRK2l50GNNYk2ag+c4Q7+SetGkPPKbgZkvfoUV2Cab83T3cbax35rNjWUvxEocPF6+mgKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw7NZB0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9252C433C7;
	Tue,  9 Apr 2024 23:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712704915;
	bh=pmnhYkKStO3URbxSM3T7QdWAB6NsrZ/26hHzX1Y0Fwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dw7NZB0gxzQ8LH6e/hNkSFPiGsEevZPMGF5d+wGG6l6EvKLtT1zdnL5Li8Bvut8jB
	 DPkVNocV+ZKSRBUVd4vYzXX4GgT71gfrXmUIABynaGMCWvkE+QcwZet50WOxAAPH77
	 WNlDJSx9hF0VDDyFZNOKCwx2l5iTGe5R4ifZPS8VOYcGCAVH2afrwQ04ptRhpOAKy3
	 V864GsOrYj3C4LuigPYPYbITgz5/BJYIHgnTAlJ9SojgYNNSaUG2aKi2izynrY8Pmp
	 +EOdJbjJB88IuoZ2yHc9yxC+nbgRG+TtXkKEBk8rUL+3zzkc4Sh0abA6dg9RjS08eA
	 OODQ79XWDGxeA==
Date: Tue, 9 Apr 2024 16:21:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, hawk@kernel.org, sridhar.samudrala@intel.com
Subject: Re: [net-next,RFC PATCH 0/5] Configuring NAPI instance for a queue
Message-ID: <20240409162153.5ac9845c@kernel.org>
In-Reply-To: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
References: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Apr 2024 13:09:28 -0700 Amritha Nambiar wrote:
> $ ./cli.py --spec netdev.yaml --do queue-set  --json='{"ifindex": 12, "id": 0, "type": 0, "napi-id": 595}'
> {'id': 0, 'ifindex': 12, 'napi-id': 595, 'type': 'rx'}

NAPI ID is not stable. What happens if you set the ID, bring the
device down and up again? I think we need to make NAPI IDs stable.

What happens if you change the channel count? Do we lose the config?
We try never to lose explicit user config. I think for simplicity
we should store the config in the core / common code.

How does the user know whether queue <> NAPI association is based
on driver defaults or explicit configuration? I think I mentioned
this in earlier discussions but the configuration may need to be
detached from the existing objects (for one thing they may not exist 
at all when the device is down).

Last but not least your driver patch implements the start/stop steps
of the "queue API" I think we should pull that out into the core.

Also the tests now exist - take a look at the sample one in
tools/testing/selftests/drivers/net/stats.py
Would be great to have all future netdev family extensions accompanied
by tests which can run both on real HW and netdevsim.

