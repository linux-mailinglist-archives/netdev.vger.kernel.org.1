Return-Path: <netdev+bounces-23673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEADA76D127
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9679C281E18
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715568BF3;
	Wed,  2 Aug 2023 15:12:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C88839
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8902AC433C7;
	Wed,  2 Aug 2023 15:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690989145;
	bh=baImNuXh2Th1Ry7XVYdyxYTkOMKeRa6JNkDyiuAbN+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J2rQI7BaseCeZloC2Lilf9Cj7o/A1pK5FZKVIhux1VcFovGc2TGpd6bLf5LQIGA+o
	 DWUtTsLrScdwHCShugV0eG1+odRhy+zAFz98HWcXJIeCDB64EQU8yWmoFh9uAZltsP
	 mkN4u81u82vrQ22nePeY8lsxQnbwrUBn/pKGG22wsrRpicN+C1Ts1rSxpkBekhuCzQ
	 R5A3NAx3bAvE0+Zn5eMYW9LYbeuBPiQ3MZ3bSquku89JKKJFgXJ9OMj+CnnQ+f7j4v
	 DNM3rqQM5lOP7k3PosUiGs4SBM1X+Uy1BAMUgMwIGNY/WvlX1dhYuL70riSYCz7H+W
	 b1468KTy7gqWQ==
Message-ID: <82c025b3-f3b7-cfd7-6bab-a246238129b6@kernel.org>
Date: Wed, 2 Aug 2023 09:12:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net 5/6] tcp_metrics: annotate data-races around
 tm->tcpm_net
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20230802131500.1478140-1-edumazet@google.com>
 <20230802131500.1478140-6-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230802131500.1478140-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/23 7:14 AM, Eric Dumazet wrote:
> tm->tcpm_net can be read or written locklessly.
> 
> Instead of changing write_pnet() and read_pnet() and potentially
> hurt performance, add the needed READ_ONCE()/WRITE_ONCE()
> in tm_net() and tcpm_new().
> 
> Fixes: 849e8a0ca8d5 ("tcp_metrics: Add a field tcpm_net and verify it matches on lookup")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_metrics.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



