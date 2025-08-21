Return-Path: <netdev+bounces-215704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7237B2FF5A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEA51C2276D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E63101DA;
	Thu, 21 Aug 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LATWJIkN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6930EF9C
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790932; cv=none; b=ooNSbq+eC267x4CzaYgc+iHg/i1eio595L+gItOevmfv9FE3AE/mTbWJRKvziVfJExmsTeQT93C6QaSvB6a26/pmcdSTVu4CZ0+C/Cri7O2p7PqMTqG4qX09qrVr+oxCXIgPJDFZmnMx0vIW9pOYfCF/YrI6H3fvc3ScDNagRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790932; c=relaxed/simple;
	bh=vMa7qjJ1dOo6u5AYMF3/xGeA4LnRSFu6peF98IgaBck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZvuZ99vBqcsFlQ++9mDlBqiHhjkqLqigQha8MtTF32r6NBYJc4E3ZPOxMnoptsGRMv8/Lvfiei7sThdEBvZepmeHb87pKq1yIcnT5hM6UVWiEj43hkEewQXyplkRJFR/KH6ILfv5AYUOooN2i7xl20EekZMmvSqURSovFT8Xik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LATWJIkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6EFC4CEED;
	Thu, 21 Aug 2025 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790932;
	bh=vMa7qjJ1dOo6u5AYMF3/xGeA4LnRSFu6peF98IgaBck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LATWJIkNvIL/WL2X8wNh6Gc+lXsuZY4FygVvEWwuYNSIOGwbb8aYZ/VzojH3yBvRG
	 C64ADKWwvNSfUInB+BD7vvYFL7ieWB4Ie2iPpXQCBGQXCSmaJ+uiTb4CitGZW/Amy/
	 L1m5hM7X+3Mn4mYC2BIago4rJRuE72K6XZGDylfjDPXceJbeJq99oC2URTMi3bMmX3
	 +SGkCfpip3bO366awo92v6lMeaMIFCFeOTPcX19iHU0wYtn+vUOyrH/JLGRcIL3Hxr
	 yh8UqVX1mIPFr70Rg8E6jZ7W0MXJ7bZUHACVGO6D6G0S8lp/stlCz9AIe+Dn2D/wey
	 y/6NnXpRHBrAw==
Date: Thu, 21 Aug 2025 08:42:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, michael.chan@broadcom.com, tariqt@nvidia.com,
 dtatulea@nvidia.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 alexanderduyck@fb.com, sdf@fomichev.me, davem@davemloft.net
Subject: Re: [PATCH net-next 00/15] eth: fbnic: support queue API and
 zero-copy Rx
Message-ID: <20250821084210.73635a08@kernel.org>
In-Reply-To: <CAHS8izMHOzC2MUqZWgcQksLkTW_D7MJ4mndozA4pyfwAPzw0vQ@mail.gmail.com>
References: <20250820025704.166248-1-kuba@kernel.org>
	<5bba5969-36f4-4a0a-8c03-aea16e2a40de@redhat.com>
	<20250821072832.0758c118@kernel.org>
	<CAMArcTW7jTEE1QyCga5mpt+PLb1PDAozNSOwn8D7VwNYBp+xTg@mail.gmail.com>
	<20250821080332.7282db12@kernel.org>
	<CAHS8izMHOzC2MUqZWgcQksLkTW_D7MJ4mndozA4pyfwAPzw0vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 08:22:27 -0700 Mina Almasry wrote:
> > > Apologies for the delayed action.
> > > I would appreciate it if you could address this issue.  
> >
> > Will do, thanks!
> >
> > Let me apply the first patch of this series, and the rest has to wait
> > until I fix the devmem test, I guess.  
> 
> I'll take a look.
> 
> ...although I happen to be running into a random machine capacity
> issue at the moment. I hope to resolve that sometime this week and
> look into this.

Hm, would it be useful for you to have access to fbnic-capable QEMU?
Having a reasonably advanced driver on QEMU is a major productivity
boost for me. But I suppose you already have a SW backend for GVE, 
so it's more of a development flow thing? IOW you don't just run stuff
on your laptop anyway?

