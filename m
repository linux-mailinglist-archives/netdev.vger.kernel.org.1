Return-Path: <netdev+bounces-172634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE2A5596C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416773A3D74
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64CF26D5B6;
	Thu,  6 Mar 2025 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNWGv+um"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0A279342
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299085; cv=none; b=otWHGBrE+57P1tpk7xpciMcPy1HGFpmxunF177JzeS4o5Z9+aiwA+s+Bhg4Ez+VdPdYdqzjffuWRohCgwPAVtp0x5NDKZURzLkqUIbttAEh2y7tsUJ8jZ1VfNSTTWp1a2i1N7ekNOgouPXPVsi8YC2D7ER/1kQ4CwpJsdANPp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299085; c=relaxed/simple;
	bh=i7fFmoZZrsJt3saVH3YP5PA6fjGJ4AbLjNVZWBrQWhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FirZhn18Kj4xW9wJZro+UK5RAP1l9porKKkt7CiRNphH9uuATGLiKoz2/iUA4o6ql/igYVkKoFzzW4iZDfmIAhY8cct+9wR/25FZ7zraTjpjJHgyLCHAdekoP5bpHaKNcfSWbgXAPNOz1k8eQACbRk/8UAOQ1okfSL8LoohqBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNWGv+um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5934EC4CEE0;
	Thu,  6 Mar 2025 22:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741299085;
	bh=i7fFmoZZrsJt3saVH3YP5PA6fjGJ4AbLjNVZWBrQWhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNWGv+umffTKdgHQdDdhJ/rjrHmk3gxrMtzRoAQstGF7yjrJiiubHPKdJYllqRSM+
	 huzCP6p4eQtZpbBDDh/v4srBLcKODvZh7X7ibbgY+Eg41RXKFAInm6SpVuTggOkvx3
	 FUZvZ6ci+O/ZbLQL7B7hKeuSs13Na6MZhXgyuJNvlDMVO/f4QMfwx3+Tk3/wb7WYO8
	 3PGtVTkRRLWV1Pz4yp7+CLc4r5nGXPbTYqbWWigIlr4cSOaEJIAZWUUWrn0oY9nVfX
	 QfRn+N22lwA3I5fZwDBLyXYfr3tDDhXUdw+vZnLGRiBlvvYCj3cQ9wbU8C0BjBXluo
	 xZfwV9Isd44Aw==
Date: Thu, 6 Mar 2025 14:11:24 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <Z8odjMEMTtJKhtal@x130>
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
 <Z8n4ZNtnHgF1GB8Z@x130>
 <20250306114535.21ad08d2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250306114535.21ad08d2@kernel.org>

On 06 Mar 11:45, Jakub Kicinski wrote:
>On Thu, 6 Mar 2025 11:32:52 -0800 Saeed Mahameed wrote:
>> I thought it was 48h
>
>Always happy to hear your thoughts Saeed. When you have a sec, could
>you do the math between the following two dates for me, and tell me
>if it's less or more than 48 hours.

I was talking about the 24h expectation, it is too tight.
48hr was always the expectation in netdev mailing list, let's keep it that
way, If any of the driver maintainers is late to respond then they will
have to take it to own queue.

>
>Date: Mon,  3 Mar 2025 14:32:00 +0100
>Date: Wed,  5 Mar 2025 20:55:15 +0200
>

Sure I wasn't arguing about what happened here, I agree with the policy,
I just didn't understand where the 24hr thing came from, it is 48h.

>Thank you!

