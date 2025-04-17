Return-Path: <netdev+bounces-183565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0FEA91100
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E16189E5BE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D21185B4C;
	Thu, 17 Apr 2025 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q75iYqvm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55079288B1
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744852108; cv=none; b=sf7QkPc9aC4Q/pIKTS0jwrhmeoV6f1n+p+RrNhv7ZezXbhKv1DzC/kQ7ZGI7Bsmtnh//WZ2F7/UUqRIzfWR/hUGd7+SWUMcwNwk3I5CJVkuhV2lgtD/xZYbfbJE359CWIZD2CHbZTJHb9UpbO+m+XsMlbiLWlD1qG6EGQTSH7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744852108; c=relaxed/simple;
	bh=YeVMvrOkQy2UJ5BeYFzRVUso37abJDW9c7svH93M+54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlOb6mPpcspYWxSFgmdDuhQKVnDcegjLjh2JH0adATpIwaMjh9mWP9Qg4FB6KrFPD8bT5/+GsL/S6NysDXF57eQf0VgzikqSovDPaqBSvU/oLE70hHPJchT/rrFU3fOaE1arihrdfaRKjRdWjx8UNjF7GTuVqoxudqYv+tcxlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q75iYqvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D267C4CEE2;
	Thu, 17 Apr 2025 01:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744852107;
	bh=YeVMvrOkQy2UJ5BeYFzRVUso37abJDW9c7svH93M+54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q75iYqvm3IHdjbT4fVZy5NURPbmUJtgmZfq5AdpbMQ7NGWXOm0DzlEy1MYYJ11Ex+
	 KFOCyRqHWLPiQUuXGKj5q02OPPenlIAGjUYX6HsM2H63nEfzq57elDqXlQ9eYCL+e6
	 jGCN7MZdzSlJM9py70CLfgIVrJ/vk2gjpY3qOyu+j/X7zFx01pHnlyuhgLEBtKQ1gR
	 F2ezWbkh3ky9D9/DrAYVL5POVtWJMLzJLtYlFJPNDAoriML1vf0yXs8AHrYxN2jGOk
	 6a4wkUWoEqoG74NMrH0DYJR8jonYhjpfLi385Cw9JkP6Dm/8VxwakZ+Q+w7hSV1psx
	 VbAg0KCb6faug==
Date: Wed, 16 Apr 2025 18:08:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V2 01/14] devlink: define enum for attr types
 of dynamic attributes
Message-ID: <20250416180826.6d536702@kernel.org>
In-Reply-To: <20250414195959.1375031-2-saeed@kernel.org>
References: <20250414195959.1375031-1-saeed@kernel.org>
	<20250414195959.1375031-2-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 12:59:46 -0700 Saeed Mahameed wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Devlink param and health reporter fmsg use attributes with dynamic type
> which is determined according to a different type. Currently used values
> are NLA_*. The problem is, they are not part of UAPI. They may change
> which would cause a break.
> 
> To make this future safe, introduce a enum that shadows NLA_* values in
> it and is part of UAPI.
> 
> Also, this allows to possibly carry types that are unrelated to NLA_*
> values.

I don't think you need to expose this in C. I had to solve this
problem for rtnl because we nested dpll attrs in link info. Please see:

https://github.com/kuba-moo/linux/commit/6faf7a638d0a5ded688a22a1337f56470dca85a3

and look at the change for dpll here (sorry IDK how to link to a line :S)

https://github.com/kuba-moo/linux/commit/00c8764ebb12f925b6f1daedd5e08e6fac478bfd

With that you can add the decode info to the YAML spec for Python et al.
but there's no need do duplicate the values. Right now this patch
generates a bunch of "missing kdoc" warnings.

Ima start sending those changes after the net -> net-next merge,
some of the prep had to go to net :(

