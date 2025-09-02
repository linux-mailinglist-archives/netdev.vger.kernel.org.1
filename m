Return-Path: <netdev+bounces-218977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C0B3F266
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 04:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C136C188C266
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 02:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54982D663B;
	Tue,  2 Sep 2025 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3Y5YKIc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A05935948;
	Tue,  2 Sep 2025 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780672; cv=none; b=UaB7nqR1W0nC7IVtQSQ+dCYxMzKXeEbCEZI9AR0a9G2DAu0V132Syrv7da24UYoN6YsAfahS4AvGcvUL8WSL9SiNDUEcjD3a+NEsnI1RfL/UfJPYAOgVcuBtuezoa5QcaP4qyohFprjsXy3LqEus9vQ7Ba93W48Tw/Uj4wKzcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780672; c=relaxed/simple;
	bh=fLAXJGMl2dvLA7hGHnovF2vNy8l1F0y2hmXpciTIBwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isxno+wD8scesAiNxyhkpdA2b0ck0yVqI8ZQ+9wGKhhM2FVIGXT8WocwLwLfWMjyvYgTD+cymGF/+56G3iEo52L6gqrD4jszupa2ZSRkW5P4E/r2rTX5q4IYmYLGblYMT+NnjPWmoLhVwq7TpzrLxWqTKMsOgg+rudIEcueCf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3Y5YKIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939ECC4CEF0;
	Tue,  2 Sep 2025 02:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780672;
	bh=fLAXJGMl2dvLA7hGHnovF2vNy8l1F0y2hmXpciTIBwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a3Y5YKIcZlZjw/bnB+2t6Fl4wd876rZ4xZGEs/DJUPAcvgrUWIQw1QF1dmQd17dZW
	 LGomt2CJRQzee92bzm7qHmPY+WIiCKWl8x0r9d+x+koJf7cwsseYM3z2WpSUo7Bhsb
	 zLYdRYaY6D0ISfOpjG0GYjOz0uPEwqWlUPETQvzd5M7nUu7/wRdVwaC9cMt5br34u4
	 xSpqE4bkU6iM4r65YEZwIkbomGWkB3oxTtIoc9TRp3Bc4IzM2w6TeS3DUIw3o0Y0yq
	 Jcsd5Lc87t50QZdEB5cGBMipFCn25L2cv78cpRU7PE0HQTB3yHtG49uc9MkXUZGRra
	 Z1mQ/rrEZP+4w==
Message-ID: <d65be352-e164-4f5a-b1ee-022eb8199316@kernel.org>
Date: Mon, 1 Sep 2025 20:37:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] selftests: traceroute: Return correct value
 on failure
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, paul@paul-moore.com,
 petrm@nvidia.com, linux-security-module@vger.kernel.org
References: <20250901083027.183468-1-idosch@nvidia.com>
 <20250901083027.183468-5-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250901083027.183468-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:30 AM, Ido Schimmel wrote:
> The test always returns success even if some tests were modified to
> fail. Fix by converting the test to use the appropriate library
> functions instead of using its own functions.
> 
> Before:
> 
>  # ./traceroute.sh
>  TEST: IPV6 traceroute                                               [FAIL]
>  TEST: IPV4 traceroute                                               [ OK ]
> 
>  Tests passed:   1
>  Tests failed:   1
>  $ echo $?
>  0
> 
> After:
> 
>  # ./traceroute.sh
>  TEST: IPv6 traceroute                                               [FAIL]
>          traceroute6 did not return 2000:102::2
>  TEST: IPv4 traceroute                                               [ OK ]
>  $ echo $?
>  1
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/traceroute.sh | 38 ++++++-----------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



