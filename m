Return-Path: <netdev+bounces-150976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2679EC3BE
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D301A18805C7
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DC01369A8;
	Wed, 11 Dec 2024 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sG4U5aEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FEE11CAF
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 03:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889020; cv=none; b=Lu3HYDX5+OuPbtDYmkT1fpFPJaeLrcWlb5v5OL4moUMc9C2Co4WZQAuzD6RWftGCcE7d91vc7HZ8rman5uB4U+1H4fdXyjVA6EWiasnpDOQltnR+VnNMhz4rM/7tNnFO+fXZ1eJgOvX0hjgRLEZqyAc8jP4ZKuptH+Z1F4tT+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889020; c=relaxed/simple;
	bh=2sIK/C+5K1TJs6tYcZOkIC/emNfx8HbxOM3loAaD7xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Or4EKrYwEjBbbEdCnb/h7FheBcBZoKTJ3DFccL00RMvXLVQntVdYqf/7IrpBVqs0IvAjHIExXximf8r/8Wv/z9V9wrMWuZPXF9WosbaBPnNygq/a0u9QB+EoMR4G9c/4y1hDhe0aAahTbqSY0i7G9X8QD0Kr3bri8DDdE9HFmbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sG4U5aEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E597C4CED2;
	Wed, 11 Dec 2024 03:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733889019;
	bh=2sIK/C+5K1TJs6tYcZOkIC/emNfx8HbxOM3loAaD7xQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sG4U5aEi7MdDlUktQlESSZQ5H+v+eSjfTZ2TiS92p1N+kGuvqUmY/xWMX1OSW1cUM
	 NBacq+3byb80LqFOXPORQpOZAQ5kMx4A4ERUCgUhaBsBV8geDQ0SXqSqwUfleEhVlM
	 MHLAnbLpmrm5l8hSZhK1XewWfhT5DTreFr+BJi6eEBsdi8AmLdyemnvMBN2qMiOBda
	 cxKe3im7fo8kOM9iTYz3tlH+Vk5QhiGeleFJvO1+MafX8R5nr3xNkz9jzo8665ltpo
	 18dyGmjZscOjXccFPWVQZnwycTQHPbEG5r/TKN1oiRINohCNmV4exYJWhV5T4IGtIt
	 lDqwM1yv3s94g==
Message-ID: <b0d8d826-db71-4f8b-b3a4-51b19853fdfe@kernel.org>
Date: Tue, 10 Dec 2024 20:50:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] ipv6: mcast: reduce ipv6_chk_mcast_addr()
 indentation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20241210183352.86530-1-edumazet@google.com>
 <20241210183352.86530-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241210183352.86530-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 11:33 AM, Eric Dumazet wrote:
> Add a label and two gotos to shorten lines by two tabulations,
> to ease code review of following patches.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/mcast.c | 42 ++++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



