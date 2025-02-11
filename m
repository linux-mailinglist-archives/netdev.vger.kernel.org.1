Return-Path: <netdev+bounces-165313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849DFA31952
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AF83A6503
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 23:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D31F4E30;
	Tue, 11 Feb 2025 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/jF31rN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EABB272910;
	Tue, 11 Feb 2025 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739315745; cv=none; b=oCVVfLf6owDiijGKaL8B7w9DfAWmvoRa9rEYUDy0n0rMKcgudByBuoppCkVQuVdnAvMH+OxFDLIUZfN/B7L4mxbqhCPw7P2yzmC3cggz5OtYW7PkernGZ2VsiHilkY9qfk7mJEh57Qrvklc3VpFPVdC2wlZV29a3mX1nTyvd3zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739315745; c=relaxed/simple;
	bh=CVl2FA/WWjwzToLAnBMMJbHpQWCncBsTbFBAKBEP4eM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tx25DytZ3HrycLAVXM+MSId8knMOpIyPPC6L6vi2VlCrX8pwpKak62+NEAuNvGCMmU6Me4dicQ5yizUNaEeJZQO7F+Dv16SZkIZQa3k8RyBXq5d/BryuPlm0FbrQ7A8v15Ak4K6Q5AiDjphySPn7wEZbvZB2h/vcq+F6pK96Jnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/jF31rN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DDAC4CEDD;
	Tue, 11 Feb 2025 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739315745;
	bh=CVl2FA/WWjwzToLAnBMMJbHpQWCncBsTbFBAKBEP4eM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A/jF31rNOp5YH6O6Miz0n1Ou7QHyB0i920JpxPSVr65o9YUeTWO+LEQx81msyd+T1
	 ynrmjmNkcCQGpL5U/1LyF25GJDU0sMEBYwjEi6+ZojWgjKBmDqr+6ctKM/UCItpKsS
	 Bkrm03OXWmnnlIXrnnFaSb2GReaE9bxdux/BHvUkeOnB9n3VzpPI2PNnKdlNGYRhuz
	 5A31XlJ9B5VA0/LnYr8NCb6Ew3v4GjEpR/yZ9qQp6F/O1+0qNL3I/zHkwIIvDgKD8l
	 Omicv/ehLGqzu4/bZlRA0cRPq/7aygflaF6N0hzZ1IbwwUSRDJsGhMvvvGu4bijTil
	 dF4XjnbV4pvWQ==
Date: Tue, 11 Feb 2025 15:15:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, rdunlap@infradead.org, bagasdotme@gmail.com,
 ahmed.zaki@intel.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] documentation: networking: Add NAPI config
Message-ID: <20250211151543.645d1c57@kernel.org>
In-Reply-To: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
References: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 20:06:03 +0000 Joe Damato wrote:
> Document the existence of persistent per-NAPI configuration space and
> the API that drivers can opt into.
> 
> Update stale documentation which suggested that NAPI IDs cannot be
> queried from userspace.

LG!

Acked-by: Jakub Kicinski <kuba@kernel.org>

