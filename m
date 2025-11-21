Return-Path: <netdev+bounces-240641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1367C77291
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 04:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF80C4E66C0
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D792E54BB;
	Fri, 21 Nov 2025 03:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzhFCHiK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A62248AE
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695485; cv=none; b=G53Pa8rMacHovENE/dg/svPiC0jFlujxSHZAqFYVcnBA0fjQL+mVKpYuRiladiihIp74G5N44OyRbUh6DJ4ktZNRpUjT6WSTwTy+QaNVmLC2MHtfZL8N7NHp/F3fbGJPfccNqUZp+vzN3QNj3QRz4GnnvDVncS4w/UajQ8xQYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695485; c=relaxed/simple;
	bh=2QfvV8bh3wMkQrI99FiERJOgsEbkSpA7LMfOjXIizH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxYdjb6/cHMypPagrDaIi4QnCz44LV52RHiM9xM3OcdG7rDsjpBTFnx9gAxF3LKv5AZlGG6fpN7wZ7zYzLqF3uJwo2zll8mpZ3YIdXa6lEFonD4gwHvvO6cjnfUa3oLDYfiFvVisGCW/HDIVY3VF4R+/k6WKdAfkmdqrlnPZw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzhFCHiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5EBC4CEF1;
	Fri, 21 Nov 2025 03:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763695485;
	bh=2QfvV8bh3wMkQrI99FiERJOgsEbkSpA7LMfOjXIizH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RzhFCHiKpH7YI/093TMX9V1UyzAGj+U/dDdRw1sRybZr7v9pKIWqA8Lr2BWxgHMAH
	 ikFPXAjobkgQ+gXfIOT9hsGHkTRMMkBQ7irjcdACnrfnd1QjOfEqIK4lDEdzo9dmrX
	 0ruLin7xPz/KwR9xzOAADl+WED9TceQg10SW+tOlJzIBEwASY9qp4vY/1BjlZ9e+Le
	 K0dPlcg3B3AfP6hsVB5kyguEVoXKDfIfK3KDIoae2s7yZBbwTzDsZvWYvwXY1jzIpF
	 nEo1oN4FZHl/FKFNbSgO/TQhe2n9155RrmTYQ/LSvTs4aCVinHfk4kJiNlfJpSlJxQ
	 0+zcVV8Oqcvng==
Date: Thu, 20 Nov 2025 19:24:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v1 6/7] selftests/net: add LOCAL_PREFIX_V{4,6}
 env to HW selftests
Message-ID: <20251120192443.21bd30d1@kernel.org>
In-Reply-To: <20251120033016.3809474-7-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
	<20251120033016.3809474-7-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 19:30:15 -0800 David Wei wrote:
> +LOCAL_PREFIX_V6, LOCAL_PREFIX_V6
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I suppose one of these was supposed to say 4?

> +Local IP prefix that is publicly routable. Devices assigned with an address
> +using this prefix can directly receive packets from a remote.

How about this:

Local IP prefix/subnet which can be used to allocate extra IP addresses
(for network name spaces behind macvlan, veth, netkit devices).
DUT must be reachable using these addresses from the endpoint.

