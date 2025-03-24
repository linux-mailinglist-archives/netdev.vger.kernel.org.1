Return-Path: <netdev+bounces-177080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A14A6DC34
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DF1188EF22
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3700125E81C;
	Mon, 24 Mar 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAHXGi5C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E92AD14;
	Mon, 24 Mar 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824567; cv=none; b=dw+CO53bvyqRU2svkJ+gwZ7OPYVpnXvDHikpYCjdwZM1ovljKk5HA+HOF3IxwPk6drFB9tZpXwdDS00c1mhqD4bfT7V6wFgslu8xw63BEFazSeMO195wlC7SCWNT1JJaHRvQpX5FQpKD8M+HiYH9ZXAC4y7kDsGFWO7KEp58wbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824567; c=relaxed/simple;
	bh=Bk+llUkPLzsHMJNfH7OsrFnkGNMUvHDNZlJwjw0gq1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIjKgQE6LABXe6Jl+iIX+9KkAmpNkFEeMxd3wr0rfPlK0YIf1bfl+ph/KXzHAT2iI53w9w0cUiTlsLI3558lRGW9wT70rvUHI5U7SOFutmOh4eLq+CNQdUmwUF3mgXIbld4b73R12NAdRU2bwPaXsIfmrhKD39sFB327RsjzP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAHXGi5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10F2C4CEDD;
	Mon, 24 Mar 2025 13:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742824565;
	bh=Bk+llUkPLzsHMJNfH7OsrFnkGNMUvHDNZlJwjw0gq1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UAHXGi5CBznaEVgugAZORdfUHpOhmPsS+egkBQHiadtlXum/621kVBU9q3EytGFF4
	 x9icbiTw/JbGk5TQzopb5e1RIi6jlRMyhFZSkozWNnrZ3dYaKcpU48S2QblKlc03aE
	 E2rUrZ8eoieGgZ/QdlT87HrsKxJHx0IwK3HzH/qHkk6k2V94Kl4hGeAhI4MuV5Ddb/
	 SWvq4hmsh7iJFfx7R3HhOgg/o3fAo2wkJF8IY8RUvYYA/F1p9dMTMtXp/EdClHnQ02
	 ordkrLiKgqsNUx8A+kMDC8IIiAWUPntQ8vt1BL/DZQ1J/Jmhzcj4L4sJkuftogE4lR
	 dFW/L0mpE2wtw==
Date: Mon, 24 Mar 2025 06:55:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jesper Dangaard
 Brouer <hawk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, "Toke =?UTF-8?B?SMO4aWxhbmQt?=
 =?UTF-8?B?SsO4cmdlbnNlbg==?=" <toke@toke.dk>
Subject: Re: [PATCH RFC net-next v1] page_pool: import Jesper's page_pool
 benchmark
Message-ID: <20250324065558.6b8854f1@kernel.org>
In-Reply-To: <20250309084118.3080950-1-almasrymina@google.com>
References: <20250309084118.3080950-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Mar 2025 08:41:18 +0000 Mina Almasry wrote:
>  lib/Kconfig                        |   2 +
>  lib/Makefile                       |   2 +
>  lib/bench/Kconfig                  |   4 +
>  lib/bench/Makefile                 |   3 +
>  lib/bench/bench_page_pool_simple.c | 328 ++++++++++++++++++++++
>  lib/bench/time_bench.c             | 426 +++++++++++++++++++++++++++++
>  lib/bench/time_bench.h             | 259 ++++++++++++++++++

Why not in tools/testing? I thought selftest infra supported modules.

