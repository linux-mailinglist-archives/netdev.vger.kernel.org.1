Return-Path: <netdev+bounces-150271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C49E9B9B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC8F28103C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1FD144D1A;
	Mon,  9 Dec 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACBDMnBz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A141448E3
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761617; cv=none; b=GeSUB1tnpH+dB4cnTvpkOaeLXF++s7h7JEfNPkjNiguB9EfpZeCeuKhARW64iyz2s5aPDKFQ8dNIr8YRwLlanQOKucmlMQfWtKvn5Q3cHd1JovdPG8ErNRu0RPrAxRum9CtImzHAzrMGYwyQHTrL53yOohXprwfS6ltJp5w/i40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761617; c=relaxed/simple;
	bh=kjFrTsU+q1j6f3NIpnZxA6D/FU1RQXLjLXaISq5cvAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjV8BGGgywMkEPJZVhskhYptD8E/XA+m0R417S8/FQXB9A2r8Uk4QHXFyczKObfH8UYXdICr8lifX2BffnCmhtc28tq+TI6xIUIYkHxmDKJ61mjclCJNJ3TBvzeojeYCyi4PtuMe8oylAgr8G8dvlZS4uq3UERh91HLXNAj/DsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACBDMnBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7387C4CEDE;
	Mon,  9 Dec 2024 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733761617;
	bh=kjFrTsU+q1j6f3NIpnZxA6D/FU1RQXLjLXaISq5cvAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ACBDMnBzIEcfJe86TOSsBXg+QJhrgTWencd9ze09v27KYzJgLCWZ15G8JgjgfGJKQ
	 Zu8SEVKJzcHk2w2/fFQ1r9ByKNxAbkTSGHDp4jwhFuZaUkstMJnoSkOgW/EL4wjIL/
	 Dyg2XTdJGIgNtxvuyNbli4mZKVbIWyN03XEHg4RSWAK1slpIhTLVy7V9VAd8Awlas6
	 t43N0Wr5c8yqjpjVUYCIy6PtYeZ/IC2OT9tqG0szC08q4iwUEKdqZc/aLESmayBh8x
	 fzrZO+orPAO31vwcpx0qaxtGRcuVewqPkAf0jwmAgYaHHlB2IprxQKNNaeM4ewfGMv
	 vSkVqsKVMa2cQ==
Message-ID: <688a8d28-fe32-4afd-af0a-5fdbc317e63e@kernel.org>
Date: Mon, 9 Dec 2024 09:26:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Documentation: networking: Add a caveat to
 nexthop_compat_mode sysctl
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, mlxsw@nvidia.com
References: <b575e32399ccacd09079b2a218255164535123bd.1733740749.git.petrm@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <b575e32399ccacd09079b2a218255164535123bd.1733740749.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 4:05 AM, Petr Machata wrote:
> net.ipv4.nexthop_compat_mode was added when nexthop objects were added to
> provide the view of nexthop objects through the usual lens of the route
> UAPI. As nexthop objects evolved, the information provided through this
> lens became incomplete. For example, details of resilient nexthop groups
> are obviously omitted.
> 
> Now that 16-bit nexthop group weights are a thing, the 8-bit UAPI cannot
> convey the >8-bit weight accurately. Instead of inventing workarounds for
> an obsolete interface, just document the expectations of inaccuracy.
> 
> Fixes: b72a6a7ab957 ("net: nexthop: Increase weight to u16")
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


