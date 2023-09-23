Return-Path: <netdev+bounces-35944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E6D7AC101
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A13B11C20863
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E115E8F;
	Sat, 23 Sep 2023 11:10:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE410A18
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 11:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786CCC433C9;
	Sat, 23 Sep 2023 11:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695467434;
	bh=VlkcOypmZrR7VawQYftIHguoiDQHrQSxjDWYlRjEukk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o7SFacdvd8KWsD5jzP7QBxdmkQqBBGyvoJA+PAyhLLiePoprUmjdIj7Huj3pELzdf
	 QGxJKYt/6kKhrADlzl9TNZSfV4FWZ2ZOSUHuGGLSIiUziTKpYQDDwj94R9Bl46FB7d
	 EvaC3mtgI0pHUde8DpPEylS9ExB5MHSr++ejCBumaAub6MxyGNPwjnfL0DzRuKT2Hd
	 JeDWT7c7gYkrZEsCTiDnmj+/Taaj57SwlgxcwVWAukfGgXFWVAXLfprF2NepbNl0Fl
	 9Nq71TUW/YHQEHaAGOAkHvhGWLPnWuoIPKN7uXimnOn1I5QhygFd3MnFad6J3s8K6I
	 tXybNE2aMgwEQ==
Message-ID: <a493b48a-9b20-2471-8004-ee355059f8f7@kernel.org>
Date: Sat, 23 Sep 2023 13:09:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 3/4] tcp_metrics: do not create an entry from
 tcp_init_metrics()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230922220356.3739090-1-edumazet@google.com>
 <20230922220356.3739090-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230922220356.3739090-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/23 4:03 PM, Eric Dumazet wrote:
> tcp_init_metrics() only wants to get metrics if they were
> previously stored in the cache. Creating an entry is adding
> useless costs, especially when tcp_no_metrics_save is set.
> 
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_metrics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


