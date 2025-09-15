Return-Path: <netdev+bounces-223168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DBAB58156
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186E43BD5F1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55261227EB9;
	Mon, 15 Sep 2025 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbWswycK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B6B21B9DB
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951633; cv=none; b=T11AOZ/mvFxw6w2O0hr38UnXzuUlO4OGIYg52Qs50pdphWIi9pZbZdulxqruKJFQ7WcmRre7+7jHNpRMP+qDbPlb4cBbUiyhDgJE8hzixsMANrDL9wvEzHLK1Mgjwifo9Je2HGeUeLWfpkBjDMrDAep/MbAsNGYzjAttvzpoEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951633; c=relaxed/simple;
	bh=aDjSYVwlJXMpB1J23PpMAoOwdXwCK50lMOnKl0NSbg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUZkJpmxbBJVieD88kC/2UQ8ehAxBRO+Afsg8sy0L5Nmgd/BNVqYqwJHnkESzNDY0AbeuDJuyrzK+iqmviCvDWcHPe28Svtp/lvOEJSJxUE6WjNjzUr33EgkNqdFh0iCPAwfb7/NPbOiIk1W+QmQifuZOZKgHKHY+La2kOQ+5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbWswycK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0412C4CEF1;
	Mon, 15 Sep 2025 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951633;
	bh=aDjSYVwlJXMpB1J23PpMAoOwdXwCK50lMOnKl0NSbg0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RbWswycKdTla2Xa/QmbqI1J2iKIitSQk09cRYEZdHGV38YhFqM1zzesyg1/SZgijq
	 +NYRRoKMsbEjSyqi2vZ1TqMBB2Xb3oix3+W6QrhGPXbgXikLW0Y/ogebz9UZLUFmnU
	 XMTMYLz+94hciciKQTq4tz5dEhEODPn6BF4LEagCW5J/3hNSJdp9sAmpYCA0i5ruQa
	 b77bye5xO/Q7iH9DbUbFf0Ahq/hdLjHB8hNrP3JHhPmOMpfOuv/HAq6a40yIg5mxU6
	 C9gEbPfayL7XXVtQGZtKysHw2+zuwaJ1sWZE5Mg6E6j/DR/P6xsM6LVMx29lX6dos4
	 UR6RWwGEoKyDA==
Message-ID: <c283c797-7426-49d4-96a8-daf446a94b36@kernel.org>
Date: Mon, 15 Sep 2025 09:53:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: ipv4: convert ip_rcv_options to drop
 reasons
Content-Language: en-US
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org
References: <20250915091958.15382-1-atenart@kernel.org>
 <20250915091958.15382-4-atenart@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250915091958.15382-4-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 3:19 AM, Antoine Tenart wrote:
> This converts the only path not returning drop reasons in
> ip_rcv_finish_core.
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>  net/ipv4/ip_input.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


