Return-Path: <netdev+bounces-211824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52577B1BCDB
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 00:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD103ADD63
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926E29B22D;
	Tue,  5 Aug 2025 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz2TlXox"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52EE29B205
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754434551; cv=none; b=WUP8FsYIBQ6b7+P3h1bn54nteHRbFzAQDgyg/bKZwQSoOKliNerCuBCJNLvCCQKr/I1gEKG4f9oZX3wHeMgtlNw8jjE7o9sKtpBGmY8zXX0+3+KD4Hflrc8Fbe7bl4hKoPANx6IIOoLnPyRxciKNOPY6AKr1uX5f7NRUkr6T7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754434551; c=relaxed/simple;
	bh=RlUsvQ/Llq5Fl7ttub6wcHVhYvkQdpaoa6I7TUC4vCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEqaa657nFZQdaeU34E5E6uc7cxhWZjUU6ObCM3sVPUNAPMpZEHzNStW0QSZCbceSzv5OwFaaboaHhGPK/nIl3F7nanehrDsWLweY5harWynMCturCVe3rwjI/oVvxFehNYtf6Hc+Wa+KMKf0jFQ0N6C0/fPBdRGegRmaj2wlIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz2TlXox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB8DC4CEF0;
	Tue,  5 Aug 2025 22:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754434551;
	bh=RlUsvQ/Llq5Fl7ttub6wcHVhYvkQdpaoa6I7TUC4vCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kz2TlXox2xlCpeaViniyaAIJOAcPEHAbLB3kAYinik9KcjaFyt7WGZd5MuFUQhf9Z
	 VKc2mod3Em+v+qEItp2OOkl/7QvhlEa6m9e6i8QDwdUe6dyUxpEYXTV84ovJZMmpOx
	 HG/GzcGlgSykjKW1Is94jPbIcphiiuCRP3LLdOqZZ25qopi+xl2GO2J2mqLDnOimCt
	 V7byL1CecEaOV2/5B8weIbsV97x2tnJAU4jxKzwz34DrvfcwuA2lpcbuhtO6iz4usq
	 yJKcrL7fZjAc7f0gyoSsJTa0ZgQCaDUztv+1bAEweNDZnFyz8ci5oIB68MoPKL13vx
	 DTsAdN5ksZI7w==
Date: Tue, 5 Aug 2025 15:55:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dennis Chen <dechen@redhat.com>
Cc: netdev@vger.kernel.org, dchen27@ncsu.edu, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 petrm@nvidia.com
Subject: Re: [PATCH net-next 0/3] netdevsim: Add support for ethtool stats
 and add
Message-ID: <20250805155550.3ed93078@kernel.org>
In-Reply-To: <20250805213356.3348348-1-dechen@redhat.com>
References: <20250805213356.3348348-1-dechen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Aug 2025 17:33:53 -0400 Dennis Chen wrote:
> This series adds support for querying standard interface stats and
> driver-specific stats with ethtool -S. This allows hardware-independent
> testing of ethtool stats reporting. Driver-specific stats are incremented
> every 100ms once enabled through a debugfs toggle.
> 
> Also adds a selftest for ethtool -S for netdevsim.
> 
> The implementation of mock stats is heavily based on the mock L3 stats 
> support added by commit 1a6d7ae7d63c45("netdevsim: Introduce support for
> L3 offload xstats").
> 
> Note: Further replies will come from my school email address,
> dchen27@ncsu.edu, as I will soon lose access to my Red Hat email.

The tests for netdevsim must test something meaningful in the kernel.
This submission really looks like you need it to test some user space
code.
-- 
pw-bot: reject

