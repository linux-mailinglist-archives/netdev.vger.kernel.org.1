Return-Path: <netdev+bounces-202015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF31AEBF22
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793273A5E8C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74EC2EBBBE;
	Fri, 27 Jun 2025 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEV/8wo2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AAA1B6CE4;
	Fri, 27 Jun 2025 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751049535; cv=none; b=GABJdllIki9LLVH+MjME6BPQ6ARWDEmyAarxzqONitX5KEu8Mfcpn6RXPaEv8QToviPGnJuOcrswAvs3u7uUMugy5j5RQLoKB2lu9bKKMY2FT82T2an+xAu9apE/sxIaDMFxHjPp23lj+h4KNZ9S/htzDKKIt2WZv4oyDKrLXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751049535; c=relaxed/simple;
	bh=VnqZelj4Ukr4SaF3OtPT4U3Us1g/zsRN0nXdF3GfeWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiNhaC4qrXyg1VHODmpzxv2Q5cf1WhofdJANFj/4LQ535JCpKbIBsnskQNcYJrW13rO8aCmrHCB+PFMUkFlD9coYtwkaE4tDV3rT+Tnqec/1ISSuq+Us75ucG62nJx80TaZaNNyT1dGsqQ56B0NvFwPhdEEVEcwAIxl4DtsCAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEV/8wo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C1FC4CEE3;
	Fri, 27 Jun 2025 18:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751049535;
	bh=VnqZelj4Ukr4SaF3OtPT4U3Us1g/zsRN0nXdF3GfeWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kEV/8wo2LdWCdIqRCR2d8AxXs4lQkvVClWJHIxD1YHiYczA2u5CsBWVvFkPBTOKzJ
	 3CSqhjdTqJ5vHUninKabrD5S8Q9EYk6qZxKsovBZUzZ941KnZycVZkyvOPUzx+zcVC
	 OwbJBLeCNxqEamSz38gB//rVBT2mUMu0fLXEwD1B7bUQhBO07GLVgefANbzCKBAXU5
	 55BunHFgz/DW9bhCYvMCJoG1dcHT0Z3vK00e6wphUSZcJ5ubisjdPoUmbQoaZ93K7D
	 rRb0sqmQKq6Ev/HsulrvaJYqgIerHKy/2+pyGlg+/61r4Bnm+hlkSjXKEWxmzU7sW7
	 rPC8NvultlBIQ==
Date: Fri, 27 Jun 2025 11:38:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Subject: Re: [PATCH net-next v3 3/3] selftests: net: add netpoll basic
 functionality test
Message-ID: <20250627113854.04c13ace@kernel.org>
In-Reply-To: <20250627-netpoll_test-v3-3-575bd200c8a9@debian.org>
References: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
	<20250627-netpoll_test-v3-3-575bd200c8a9@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 10:03:11 -0700 Breno Leitao wrote:
> +    raise KsftSkipEx("netpoll_poll_dev() was not called. Skipping test")

As discussed offline SKIPing is not an option for SW tests.
-- 
pw-bot: cr

