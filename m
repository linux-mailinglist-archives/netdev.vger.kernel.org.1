Return-Path: <netdev+bounces-44342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA0C7D7994
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA58D281DF8
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129DEA8;
	Thu, 26 Oct 2023 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwG6S4oG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C34C78
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5192AC433C8;
	Thu, 26 Oct 2023 00:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698280652;
	bh=kdPYHlyi8yRFA/DekNTf55CpBXQANDC30hXhpM718dY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pwG6S4oGL1qdFoqWVMVDtlwCeDxC4Cyh28/7Zk5RV1ugKrUGPn1TIzt11W2JXapYN
	 H2YY+qOL8e6h9INEK4PoRq01WDILSk7buM2BcQMxpUuLGg5lNT9O4UodufoRcohywV
	 M6fQGssmjBjkoGRI1PZKk0hL6n6Gl6NQ7g3ve4Ms6CeCmqwj/2HJ26FR33CfLrVst9
	 9ATbzuitHmFrrgw/yWZE+PfZurGoGSOdC+yrktxFEaIiXQf140X8DHBF2xHMV/Xcv/
	 ViZfXQ9Any3fISkzuz8RGp5o1dI1BM6AUGzeuzB2v7vOrMRowE/qJoU71asf29lKuS
	 AmaG6Mzd/Rpcg==
Message-ID: <7ba2e62a-d662-4a7b-990e-ba650bd773e7@kernel.org>
Date: Wed, 25 Oct 2023 18:37:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bareudp: use ports to lookup route
Content-Language: en-US
To: Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Guillaume Nault <gnault@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20231025094441.417464-1-b.galvani@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231025094441.417464-1-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/23 3:44 AM, Beniamino Galvani wrote:
> The source and destination ports should be taken into account when
> determining the route destination; they can affect the result, for
> example in case there are routing rules defined.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



