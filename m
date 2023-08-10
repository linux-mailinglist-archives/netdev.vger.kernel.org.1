Return-Path: <netdev+bounces-26501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1328777F80
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34ADE1C2143C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B321507;
	Thu, 10 Aug 2023 17:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86F20FBF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D40C433C7;
	Thu, 10 Aug 2023 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691689599;
	bh=EaDu9prGGj8Xp/56cS7AZW0QRKuH6aHT2nEEK5LKgzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IM4wgmqSeXt/2KIS6PsYUllfZ6QXqbNM6KZWJr7oYG8GHY2/9ijox4yBlguCl0MCx
	 VvD9Qc7isyg2L1M40rfQ6sElgnIz5Ei/+UyO9gA7sHCdPKtLtOieqKu0UOPBYSYQH7
	 RJufBxiIp8IlcOvf/LIAyBQreab88AMKK75YNfajf3CdH5lpPwxdiXv2bnrc9M/Slh
	 BC4VQWcx3jR7f6xpSO9S8TsyLDP6ktxPvjWy1fLRf9KzV2Ss6irvd/4x6l5JWACvJF
	 y1UCrWv4l4u8i16Yh5v3aD3aEazIzxPfZBmdKQ2U2utQc29XU+OPwgs9G/CCge7Rm3
	 D00i2jkulOE9A==
Date: Thu, 10 Aug 2023 10:46:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net 0/5] Netfilter fixes for net
Message-ID: <20230810104638.746e46f1@kernel.org>
In-Reply-To: <20230810070830.24064-1-pablo@netfilter.org>
References: <20230810070830.24064-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

We've got some new kdoc warnings here:

net/netfilter/nft_set_pipapo.c:1557: warning: Function parameter or member '_set' not described in 'pipapo_gc'
net/netfilter/nft_set_pipapo.c:1557: warning: Excess function parameter 'set' description in 'pipapo_gc'
include/net/netfilter/nf_tables.h:577: warning: Function parameter or member 'dead' not described in 'nft_set'

Don't think Linus will care enough to complain but it'd be good to get
those cleaned up.

