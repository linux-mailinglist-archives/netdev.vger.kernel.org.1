Return-Path: <netdev+bounces-44343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADE87D79AF
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA05B2119C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13259EA8;
	Thu, 26 Oct 2023 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1MjkTh5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA472370
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8921C433C7;
	Thu, 26 Oct 2023 00:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698280870;
	bh=5ybkNAaDd9PU5F3vuCk77y9Z+ZmSR6dYrdjOw6p4Ns4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=W1MjkTh5gHwecFPgeFzsshfEw8s2pxvqlmNRzHedc64Xat6X0feC0e8LmEuxNedAH
	 cpp/kozVDBNEN9yryzuPxgGp/zqZGzP8oURuXXVQIKnFyprfE8Ht+SIE3PQ76XMUHo
	 xXUc9MjwMHRZZ1DoXARBLB6pg6FGm32yI1EOcTo2zGImfGTqAa68TQObLas3hBQCPX
	 kvuhSIS6KRyH4c78b4sJUn0/dmq63DO/7Gn0rhM+H+p6qFHhpn5bpbONmL+t9rZsFu
	 hMwcehNJ3fMN665+xaGLIWStjHVbR5BSeKWCfp4SYHT87n5SdzHAPrTjSi3VzNK1mq
	 cDwlE2CqqQQEQ==
Message-ID: <13d597c6-996d-42f2-a835-cb060bd65533@kernel.org>
Date: Wed, 25 Oct 2023 18:41:09 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] net: ipv6/addrconf: clamp preferred_lft
 to the maximum allowed
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 jbohac@suse.cz, benoit.boissinot@ens-lyon.org, davem@davemloft.net,
 hideaki.yoshifuji@miraclelinux.com, pabeni@redhat.com, kuba@kernel.org
References: <20231024212312.299370-1-alexhenrie24@gmail.com>
 <20231024212312.299370-2-alexhenrie24@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231024212312.299370-2-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 3:23 PM, Alex Henrie wrote:
> Without this patch, there is nothing to stop the preferred lifetime of a
> temporary address from being greater than its valid lifetime. If that
> was the case, the valid lifetime was effectively ignored.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  net/ipv6/addrconf.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


