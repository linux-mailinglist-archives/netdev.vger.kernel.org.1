Return-Path: <netdev+bounces-15414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1BE74776E
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 19:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66198280F6D
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAEF6FC4;
	Tue,  4 Jul 2023 17:05:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648563B4
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 17:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F92C433C7;
	Tue,  4 Jul 2023 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688490357;
	bh=URM3onoMud5zmGL1iJsWFhtC70gXcJT0bdgZ5a8t7fw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EHfyX7FfuWKKGbcnaGKbRMO/OpIkDZSx5KloAnmnmYscETqCjrTNkCKjSyahLz3VE
	 sdhabaTzPmEcHMYfjzS6//D2e5mq8Dnc0eKMUD3JgMZARe7ZPzRv0ecQ9PgK/vrkts
	 QXtmu8lpkUTTNlBSlvaOVpTOnXcRIV/bxK6bZIYk7OCuYySHvjM2O+jvnaU8gbQzCL
	 WIp7rmEm06pkF4e1Q/zn+M8O9KOJV2QWXglrkBQ73OJBqrvq54WP1+vGKVhSuhnvlb
	 ccmRBxN08g+ZJbKz7MusWFBum4Q//QjfjfXmH1drZ1GiuUond+5kzLzbqOfghkCZx3
	 zAu+2g79jxONw==
Message-ID: <1f82d68f-c436-077b-e320-4f1d579c70ab@kernel.org>
Date: Tue, 4 Jul 2023 11:05:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] net: Replace strlcpy with strscpy
To: Azeem Shaikh <azeemshaikh38@gmail.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-hardening@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org
References: <20230703175840.3706231-1-azeemshaikh38@gmail.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230703175840.3706231-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/23 11:58 AM, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  include/trace/events/fib.h  |    2 +-
>  include/trace/events/fib6.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



