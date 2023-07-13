Return-Path: <netdev+bounces-17702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607F752C2B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 23:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E70B281F36
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACDA20F8A;
	Thu, 13 Jul 2023 21:33:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42661E536
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80CDC433C8;
	Thu, 13 Jul 2023 21:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689284014;
	bh=f62+zk3mg61VJyk+vVG/K2+LpzgQpWJdCw2pNNF0Vng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XCkQKxTpRmjn7pJt88/43gRB7lyDMT3MaewwuKhy59IsDkSHKNvQ46oIWAAjfGgMB
	 ZMLpla0O1TEfVUsD8HALBDS7CUCKteecClk+nsuoZ180sK8j/WLkqHg0KeIJARXS2N
	 lhmj+PmLAWGkFnP1hY1OiRjcYpHuUqolqzYUB/x6QIp259oa+3ma+UG7WzEN9TboHV
	 zQLOslsyYT4bcBZkxb2ibygQw0EjD+1IXEd+d97f6PPk/zvWn1GdogXVHncEUEQro1
	 2FYRrCOJkwCBF7dBVa8PShm0QRuOROlnNlF6J29Zgc6NnaFKNTpz7mrIGQQ2ojXUGw
	 M7jLOaMjkK2hQ==
Message-ID: <6bfa5087-210e-6c96-3ad0-947ef9480b8d@kernel.org>
Date: Thu, 13 Jul 2023 15:33:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 2/4] ipv4: Constify the sk parameter of
 ip_route_output_*().
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
References: <cover.1689077819.git.gnault@redhat.com>
 <195d71a41fb3e6d2fc36bc843e5909c9240ef163.1689077819.git.gnault@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <195d71a41fb3e6d2fc36bc843e5909c9240ef163.1689077819.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/23 7:06 AM, Guillaume Nault wrote:
> These functions don't need to modify the socket, so let's allow the
> callers to pass a const struct sock *.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  include/net/route.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



