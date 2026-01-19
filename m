Return-Path: <netdev+bounces-251192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A86A0D3B31E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45D3430131CA
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA12526E6E8;
	Mon, 19 Jan 2026 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnVLjNiT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47F31352A
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841998; cv=none; b=Xf7aBdhETx/hRPjqgTGCA1tlJfKlQ41dpypq166kNk7uLHAJ8sRZEfbUCXIe4ZJYC/rSeiSGIkm3IDkm3NLuYz6TBRqZaTElwJx3NLuUbBNNupTDhWtvebDiebBdhgcC8YhDulUSintCraTes0JW+FBC6q0EvRUPR2rwKnGf/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841998; c=relaxed/simple;
	bh=FtAJLs5K+tkaZN2nivJXSO+M2Dqx7b72bwOoEmS8hVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6B4pNB/GpfN/MbHjVGCWRv3A2HVsE3Wo7J9s2xJ/JcpjzS1VFjLt6oJTfndbfVbo9UYikCReiS5I1vHl6JhPUTw5VNJWhS7ZaF7eEyN4e3sr4e6UTRIKOtAZvH22bhZJoCKkLfPJ1YUuwZ08tAN60wgaPnb1S+y22LZqDmWxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnVLjNiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3C9C19424;
	Mon, 19 Jan 2026 16:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768841998;
	bh=FtAJLs5K+tkaZN2nivJXSO+M2Dqx7b72bwOoEmS8hVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnVLjNiTpdK7G2p16f05yMvnnBQqkaH30IBmePClziLRca+yrTd+Q7VgQELRv9YYI
	 J+ze/4qRcaPCqq5M1HU2c+7fvAEuoj3J7DjFWqUzpsxcpoF+B1HHhozRx/WFiy4h12
	 BBk9oYI3Ou4BFUOw0xmhb7A/wV0A6rAVaFNQKlR6+kpdci0OqyJwqteOd/1vuRGc18
	 F4taXpDPWrdb9gldjXIg4wsrYFofE1PLDyiyc3moPExVZ5MQzv4zHAuQJN95txb8Nh
	 ZHhtLPrzzrBRT65I0YaxYxBiDB8VxGtzCQlf9TqDCqdmTbYzzOiF0OxbHfm80sCvQ+
	 mb6+qGdE3rX3Q==
Date: Mon, 19 Jan 2026 16:59:54 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 0/8] ipv6: more data-race annotations
Message-ID: <aW5jCqCrS6rWO6in@horms.kernel.org>
References: <20260115094141.3124990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115094141.3124990-1-edumazet@google.com>

On Thu, Jan 15, 2026 at 09:41:33AM +0000, Eric Dumazet wrote:
> Inspired by one unrelated syzbot report.
> 
> This series adds missing (and boring) data-race annotations in IPv6.
> 
> Only the first patch adds sysctl_ipv6_flowlabel group
> to speedup ip6_make_flowlabel() a bit.

Thanks Eric,

This all looks good to me.
And thanks for including the const updates.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

