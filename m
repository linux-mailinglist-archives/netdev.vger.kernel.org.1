Return-Path: <netdev+bounces-23669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1E576D0FE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DF8280D62
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474BB8826;
	Wed,  2 Aug 2023 15:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376048474
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D92BC433C9;
	Wed,  2 Aug 2023 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690988785;
	bh=I/41F/Ury//qWXD4q/LfL1raiH/NF8FRYEqmCUmTLzg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wig3v8BXI7ub7aEt25u1vwom4iG5hd6FGfhupgNUeVGrUPqY33yUKEeDVn2+pRewu
	 Ms6+5xONlYh5ha0+GLqaiE7g/hScAqyntB69BJSKK3jQK+aJIdyN7lcIKzs6GQMN5L
	 WhuR3tFU5OgyshHR2o78ZZzaaK5M8G71qaub2LE59GnfJttH7m1XtCF1JCy98XVbRZ
	 BJD8QxgZMnu0SLdv3mckdWDVwZkTWkQP/xm37bCQpqAHZeyA3gIToPsYJjVFVBcXOW
	 Z4vSwBehYH0TtFwtqkqejVTm18GiVjKN7yOdHHx33FWU/1ISqxojQdMS9bC1n95+bu
	 tqIb8W9id3m0Q==
Message-ID: <51113187-9601-420d-f58a-bfdbb36c4fe5@kernel.org>
Date: Wed, 2 Aug 2023 09:06:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net 2/6] tcp_metrics: annotate data-races around
 tm->tcpm_stamp
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20230802131500.1478140-1-edumazet@google.com>
 <20230802131500.1478140-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230802131500.1478140-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/23 7:14 AM, Eric Dumazet wrote:
> tm->tcpm_stamp can be read or written locklessly.
> 
> Add needed READ_ONCE()/WRITE_ONCE() to document this.
> 
> Also constify tcpm_check_stamp() dst argument.
> 
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_metrics.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



