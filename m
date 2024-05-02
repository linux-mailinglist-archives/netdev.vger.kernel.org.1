Return-Path: <netdev+bounces-93053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4B48B9D8D
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3EFB240DD
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E8415CD67;
	Thu,  2 May 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDRqRR3g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29160BB6;
	Thu,  2 May 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663983; cv=none; b=IrM5qH0FTWMAnRWS3rguLAxFpfcBIihOX8b8tZko93yM4Vt7eVm1gZBe3rJg+loSwlFIRL1cOjTq7LDXuYCMjdX3+cNV/bSdaDNQNm0F3zKCI1vPP5PCMAc/sFL2OzsiKQRNNB4Z9TWnSyRpNLr9/0SaXxE2RSeCfkkYEKAnZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663983; c=relaxed/simple;
	bh=SvNzYWg3OB5ebgmGMgm2DEaegoTfAOnWVlSvK2s21aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoKAuZyb5/Y9479xnYNQMbD2SMhbv2bjd1WvcYOEvybR1Ml71jej8JOibJsE+Ybr43Egquhu32BsaKCkDrnPu3dmGCImJ9LumpDO6nG2lR/m6JZPGTUbPnYI+w3ouLUQtRTzlPMr+gp925HwYis48axzz5tDxHATku2YxsmEWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDRqRR3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AA5C4AF1A;
	Thu,  2 May 2024 15:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714663983;
	bh=SvNzYWg3OB5ebgmGMgm2DEaegoTfAOnWVlSvK2s21aI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uDRqRR3gScKRxMoDcvr+YmMF/0orUpek1P1sqT8dVA0QGY4/18k6gqz1X/vQdx0aa
	 aMRLLPllAC0dwX+7gcACn7qzZ5OBbd93874vqvcNcF0a3hB7Ocgup0+i+mLzG1mDIL
	 +cSX3zVvIuEZcFCXniViMMi6REpEQod5s46EwOL5o8WOAj/OQph/sP/VnAWLDPmHw8
	 +oE1BUyRsUFohDnBIj6q53Ivi8Y921blydky3K1ZzspN77S5QzSw9OaOrtAgi1EsxS
	 7URymTtCk+23TzT5ZVW5FPZlNdVGWik4BeWGTH6p/IbfewSXNPQGAStj+16K7juJmO
	 Pc/PN1QzcYePQ==
Message-ID: <73950ad5-c93d-4f0f-8055-91d483fe5894@kernel.org>
Date: Thu, 2 May 2024 09:33:02 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next v5 5/6] net: create tcp_gro_header_pull helper
 function
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
References: <20240502084450.44009-1-nbd@nbd.name>
 <20240502084450.44009-6-nbd@nbd.name>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240502084450.44009-6-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 2:44 AM, Felix Fietkau wrote:
> Pull the code out of tcp_gro_receive in order to access the tcp header
> from tcp4/6_gro_receive.
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  include/net/tcp.h        |  4 ++-
>  net/ipv4/tcp_offload.c   | 55 +++++++++++++++++++++++++---------------
>  net/ipv6/tcpv6_offload.c | 18 +++++++++----
>  3 files changed, 50 insertions(+), 27 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



