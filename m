Return-Path: <netdev+bounces-23670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA6B76D106
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2278B1C2105F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15A5882D;
	Wed,  2 Aug 2023 15:07:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45F68495
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A4CC433C8;
	Wed,  2 Aug 2023 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690988835;
	bh=sy5scNt02nRi7tnm8CcUhJdwrGTwAM7REa5vQDIuPfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G5DZLPZ9vY0vKyJUi+gWnDQmzJMRltemtE8UEjZhF55+NL2J6SzeEC9CKMFn/k8Vw
	 GscFE6VI72lqQaAkAG/jRa/WenFuoEQ16RlZphq3IUbqtD6X7bnLrQAY7NAvzP32rI
	 MpaGrocx3LNMJ7mryq2cAmwNK0b1DG8jGgRNr0zpALCjMi81yPS1MgbVc04XM5Ugyx
	 TC7EgNoe5eSSLmeAA6BUtQuMuSOuWqa8MFSaxJsXj8NRwtPUJvaxI3w+73dfd5HzK7
	 nkXTBncY3oohwncZpw6tTy8GmmWJZaF48+gm5lsXA04wmbQjU2gst5ZV3lKGs1rhqb
	 CQii3w50d0jjw==
Message-ID: <974c4142-2633-0359-d30f-8f755d78bd0e@kernel.org>
Date: Wed, 2 Aug 2023 09:07:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net 3/6] tcp_metrics: annotate data-races around
 tm->tcpm_lock
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20230802131500.1478140-1-edumazet@google.com>
 <20230802131500.1478140-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230802131500.1478140-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/23 7:14 AM, Eric Dumazet wrote:
> tm->tcpm_lock can be read or written locklessly.
> 
> Add needed READ_ONCE()/WRITE_ONCE() to document this.
> 
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_metrics.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



