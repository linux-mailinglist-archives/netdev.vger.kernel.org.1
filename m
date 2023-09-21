Return-Path: <netdev+bounces-35581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827CC7A9CD3
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909E328465B
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F31168AB;
	Thu, 21 Sep 2023 19:23:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB016416
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69931C433C7;
	Thu, 21 Sep 2023 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695324201;
	bh=vZT6WRoAk8w7e0iZBAHvTnw5zmZ2VYKypxsRP3HK6w4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=abOWE55/ULlP//ihlff3eUDHfViIWl25+KRUMGg9DPrOGsoRlsLMnmvxgPFXeGKIO
	 4VdwgSn72yJvDQeqIY8gvKms9pYJrREjw3cM1m155kl8+5JdMav7+JjX+EXHuUIcug
	 22zgXcp4Tc7HA/3B2Pv3cCfXmumsGmk+ymDbB8OSgGtB102+4a6r6IiE0tInk449Gx
	 jGCd7cc6Xhhoe9sMkKbfQFOx7BFOseLZa+e2fn6N13PeWQU1iwN/DquXR6prnNUg8T
	 kIcDgyrxjOQeTlSXagOriMtupq2Ln3YBS7mtCm3xxzvFVMOGlugZ2FboN7AJA3GR/l
	 GxIyaL99XpaSw==
Message-ID: <6f53ebec-d3c8-8db2-7597-4d5a444a1786@kernel.org>
Date: Thu, 21 Sep 2023 13:23:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 7/8] inet: lockless IP_PKTOPTIONS implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230921133021.1995349-1-edumazet@google.com>
 <20230921133021.1995349-8-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230921133021.1995349-8-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 7:30 AM, Eric Dumazet wrote:
> Current implementation is already lockless, because the socket
> lock is released before reading socket fields.
> 
> Add missing READ_ONCE() annotations.
> 
> Note that corresponding WRITE_ONCE() are needed, the order
> of the patches do not really matter.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/ip_sockglue.c | 76 ++++++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 39 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



