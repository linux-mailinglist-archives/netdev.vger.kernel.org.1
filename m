Return-Path: <netdev+bounces-217333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42FEB3857B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651CF16B7BA
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CA521D58B;
	Wed, 27 Aug 2025 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhuZA/Kh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B521D3EA
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306362; cv=none; b=qFgKRPKntacbJMwiYHhGFC0yBd7jM/gV4s+dltV3rl1sLlLNRIgH1awa/UCxGGcxHn/uyJ3a6gFWxNk/Tt6aQZz4+dK3NF+zD8cP35ZDQhChuPcLMBhZUQNa/ReTs8GLBtwb5BDsklOyo+qXj5uE147PjuRXUSnr1xzqPmgZQGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306362; c=relaxed/simple;
	bh=LdS+lL7MfejfS+DoWxZqw8D3D//2/5A5Vkp3/URwqOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hC+L/yaObLes31FrC87wsAA3RGMUyJCrl6zTvka60yEoDAVTfimph64Mv8n3LuLLUatAmHOD5ulKb+mgeq0QyXVhCLueo3q27/+88gAQoXR0LvZQDpf/n3u5J9tHNrv9ioI9BmFgnhu53uHuQYia+mEyf/CyT2orXdqE0AzsGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhuZA/Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1C7C4CEF5;
	Wed, 27 Aug 2025 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756306361;
	bh=LdS+lL7MfejfS+DoWxZqw8D3D//2/5A5Vkp3/URwqOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uhuZA/KhslsNboKJ/4In+0+Ej7TjOu00KUEd9jSxM+0gZbZnkpftj50V/Xq7wM+wG
	 QsX0jFpLUMx6e9cMxXhOI3+7D64NRjUZoWMpL8YAhNiTZ1vrIHyfrRb+CYZANOUAhi
	 5OHYadFuE+lITxG5PjYyt42KcrgCT1LROT5D8kctIZ3E9hDnzl7kKaGRN3WHQM9gsW
	 5yIfQ4iEchjSZyPbWDU+c91EXCuiil2ELbshd2nGMFKOHBzQjzrkGMJl+2++APndv+
	 U7uiJeaaXcxLMmS3W3GdKDA4dfwHOX+CRkm0dwPmmBgo8s4LNAJL9flBJBT8P98VBj
	 0g9erCkQAVk2g==
Message-ID: <84cc436e-91c3-42e8-9eff-04935ab970fb@kernel.org>
Date: Wed, 27 Aug 2025 08:52:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] inet: ping: remove ping_hash()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250827120503.3299990-1-edumazet@google.com>
 <20250827120503.3299990-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250827120503.3299990-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 6:05 AM, Eric Dumazet wrote:
> There is no point in keeping ping_hash().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/ping.c | 10 ----------
>  net/ipv6/ping.c |  1 -
>  2 files changed, 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



