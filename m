Return-Path: <netdev+bounces-183419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA27A909DA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443D65A2800
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CAF21ABA5;
	Wed, 16 Apr 2025 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxD59oZ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C4214235;
	Wed, 16 Apr 2025 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823927; cv=none; b=VyUWgJjLHNCvZ0uQgTuMW8U9JzdtSbODJHHkhKdUokct8Hx96xiGYZADdDRKSmoKvr5kqHum39TmWLF1xoKx1uz8Pm1U9o0IkuhWCwJT9C6pD/vGafJYbNhurGn3LTaLppp8MPdFHHyZzyr/zl5cSd2iX4hHq3LPazpa/fR74ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823927; c=relaxed/simple;
	bh=9MQh3AOoA0oE/0Z2B1pufk6yZ8xSJmvuw0JGAClA4bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOgCZ9om4P9Ya6NGWuoKK0bYel1n0u2rWbfYSC5U89AgOt6irhFpru+xtsCkopsKM+snCO192tcb3E4TZmfax0GJccw71xRshz0tEHrvRJdS8sZvdzG+Pw/6xongJZt4BsZ59lqCm2fQsnO9ZyU2fgEYpv5QJTsksfd6ysQVm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxD59oZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1991CC4CEE2;
	Wed, 16 Apr 2025 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744823926;
	bh=9MQh3AOoA0oE/0Z2B1pufk6yZ8xSJmvuw0JGAClA4bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxD59oZ+KlAlm6zYX7FrCbWon0VaVF1RZ4T1DzIb46zt5iDwDb7PnI10Q3AKwf0Tg
	 IBKNEAbGNLZDIsgkWmJ9Ysb9SmLv9w24F9CqwvovIhrSlemFphrBy7mleVo7o3YZrE
	 FUOXGh6Jo+A/vyQigHwSlzhaw5kNbZJdOm3HDxZyyf4H3R2OYol6q3OoDv9YXtilRB
	 AQVjhjOwM1J4PpICYuPGq87NHVZqCC/VcwKsoJt/fD+u0EUPqPCbIUovpMRkOkCGN2
	 F2M0CJioQcq4uXH4+yJprqEoRWNUoTylKJhik+u7kDkvqHGAtdgzFt+rJgYsUhDj0Z
	 /LWab7Bfc3n3w==
Date: Wed, 16 Apr 2025 18:18:42 +0100
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH net-next v2 2/3] net: pktgen: fix code style (WARNING:
 please, no space before tabs)
Message-ID: <20250416171842.GW395307@horms.kernel.org>
References: <20250415112916.113455-1-ps.report@gmx.net>
 <20250415112916.113455-3-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415112916.113455-3-ps.report@gmx.net>

On Tue, Apr 15, 2025 at 01:29:15PM +0200, Peter Seiderer wrote:
> Fix checkpatch code style warnings:
> 
>   WARNING: please, no space before tabs
>   #230: FILE: net/core/pktgen.c:230:
>   +#define M_NETIF_RECEIVE ^I1^I/* Inject packets into stack */$
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


