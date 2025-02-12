Return-Path: <netdev+bounces-165631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC37CA32E01
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B333A79BF
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B3625D52D;
	Wed, 12 Feb 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAI81JV4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89E25C6FE
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383056; cv=none; b=SaGp7IQnXC9hw53HIIiJE62/vsdM0gSN7JuPnESo8q4EsaKlceX4KTv1PEOeHYKMupeHMM6nLELaMTfWO39vWee4YQYpDolqdADBI3Q5fAr3F7svoc2122nH02EEc7xn4CN32biam2EtQAIzf2q4P2iwntdbbZhnUMTDyvWd6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383056; c=relaxed/simple;
	bh=HLk4Vqao0+XjdHo9vDgk54/mnV3gre1cWe9ZRPdW4DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXCcDdFMFVpW+H2ORQA/1GaKQ583FZMDOmRaERfdrmcdJmilHBvluH6F921fMtQZB23W+IL/9hu6p7aXaFzbrz2WAahtX6sQWzqb5Pr8neArMyCkk4CG0xdz0oUpVQER0xeoLcfW76vT1oU0kpoJhmyzNKRunnq7bQzzrcokVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAI81JV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC880C4CEDF;
	Wed, 12 Feb 2025 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739383056;
	bh=HLk4Vqao0+XjdHo9vDgk54/mnV3gre1cWe9ZRPdW4DQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fAI81JV4EQa7iELL2RrPbIOooz8fqSFYRSl2g14fHY9q03QIV0AfvHjBXaS94DuQl
	 Rz0WGLJWU33JhGVGImHvVyYKCzp/36N4az1c8Ag4TJ33dYFeNfA0vqxMYG1kL4obWM
	 5i4K3KDnYMtjMBvIuVU1aR4d284eQQtilqBCFzb02MBu4bfk4HHcKHwpR1HkZz1+/5
	 w5+RxXZMsulwPRGIMhsfuAAuXOcvfPc9EXHlUOWTsyPiX0j4gpGG9QK45TMt/BxqCm
	 hRuLWtpPIolilCOQyZAwUkRPVjR8uKHMiRw0hW+H+b/SRi26m06fNxgHRbsHux19m9
	 vm7Mo8VGe+h9A==
Message-ID: <d27d36be-0a20-4628-b4ee-35e426a80b3e@kernel.org>
Date: Wed, 12 Feb 2025 10:57:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: dropreason: add
 SKB_DROP_REASON_BLACKHOLE
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Paul Ripke <stix@google.com>,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
References: <20250212164323.2183023-1-edumazet@google.com>
 <20250212164323.2183023-2-edumazet@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250212164323.2183023-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 9:43 AM, Eric Dumazet wrote:
> Use this new drop reason from dst_discard_out().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/dropreason-core.h | 5 +++++
>  net/core/dst.c                | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



