Return-Path: <netdev+bounces-93900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0E8BD8C8
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 03:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94471F237DF
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394C719E;
	Tue,  7 May 2024 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJkn1dEa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAF138E
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715043994; cv=none; b=Ufr+dfzGTjt3yVjlJeZtiqpiLi47oG382As8VHVnhA/rWT4Uw81fVdbCezZ9yI22u0YeLLtF07m6xaE9zzWAUVAOP9KwvVc2xVsEvt998jWAw3FYiFvBXMv9YOs289auQnWs1oPFZsHwJCGVah9EiLb+Z9FuLWrBfll2cpOyDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715043994; c=relaxed/simple;
	bh=BK4ZvQh84YwO18N6s1HcFmca6DjYoSth4mAw36dNcig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0o1fYKy37+flrdJszWlcjNvNauZko5xvbqQX2z6B7dixmqqzcWkD82IHWyDvHPqVOZT1RERAoQbRNo2/1N235hrF4u4KGkKstXUHlIA276oXIwfhfwGd9XTMqMkzs/rBY8ACxwt+v3UopMavxQ7fW2xmIafeUhz8XhEguqnKAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJkn1dEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431A3C116B1;
	Tue,  7 May 2024 01:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715043993;
	bh=BK4ZvQh84YwO18N6s1HcFmca6DjYoSth4mAw36dNcig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJkn1dEaQ++Qf9tlQz0xFS7Ib9oI0LF5jGv8/Tcc+IiOH4EsXV1FjVH4gCcd+RIns
	 g0/E9ZYiuHDNXdH3iWvH358tr2uv4vs4rtJ34CwCB5zDSz8T0kv15fHC8kGV99jE/l
	 SK9tGv5hNP9VCLtHiU8iMDJyErpJlKsvVEI1mrQnlH44CYCHKLdsXoTQLC2vlK53hn
	 orxTjOyD0NndKTBcCYJqVdVEouGSboXXVEeqX61A+l0gOpYSzh1AZBYkYvF65xRUrB
	 N9LTy1sbG6Qe6GjuI0pjA4xBF0NFsWxAYBRFxUqPaRYmJm4MCntzFyXWkdyQvTcPAF
	 8F4H4+/jtCd/g==
Date: Mon, 6 May 2024 18:06:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Andrew
 Gospodarek <andrew.gospodarek@broadcom.com>, "michael.chan@broadcom.com"
 <michael.chan@broadcom.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, Alexander Duyck
 <alexander.duyck@gmail.com>
Subject: Re: Driver and H/W APIs Workshop at netdevconf
Message-ID: <20240506180632.2bfdc996@kernel.org>
In-Reply-To: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 13:59:31 -0600 David Ahern wrote:
> Suggested topics based on recent netdev threads include
> - devlink - extensions, shortcomings, ...
> - extension to memory pools
> - new APIs for managing queues
> - challenges of netdev / IB co-existence (e.g., driven by AI workloads)
> - fwctl - a proposal for direct firmware access

Memory pools and queue API are more of stack features.
Please leave them out of your fwctl session.

Aren't people who are actually working on those things submitting
talks or hosting better scoped discussions? It appears you haven't 
CCed any of them..

