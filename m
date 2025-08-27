Return-Path: <netdev+bounces-217109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95AB3762F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD5018891C3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36F1A3166;
	Wed, 27 Aug 2025 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1rU7h6U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201E199935;
	Wed, 27 Aug 2025 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255499; cv=none; b=Y9LZsrOpWaqRpAee4Z8mdoDqzCxSqUDniFBVjgfgQpc0K6OpYjmk5vWIk6dQa2uloPUtZz8sW4ON7McnDPcvcQhavBY1XJjTkBH1ITMu5LgpEBxNenUhbLex29FZoGws21XHqsG5enIKis1UBNendCamgJOn81ELRTU/ZInb8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255499; c=relaxed/simple;
	bh=1a1QyaQ+7+wzkpm0y3qzf5fO9WxfJkJUH6TZ9QXdduE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txzgiiXpyvhtP1A9WgOaG6qMO3ed+kWyKQDOIjHy1KepTd+SQsm5AxmffykKRtBGe4hIvd+Y9Fmmdk2rl36q0zdwXAF/jOV1KIL246pZCgd4peSUJMQSXL0zN9I7n0iKgXIcv4DhgbZFtUyUwrpdvFMae/zebvd7EvwwTDEc8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1rU7h6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C039C4CEF1;
	Wed, 27 Aug 2025 00:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756255498;
	bh=1a1QyaQ+7+wzkpm0y3qzf5fO9WxfJkJUH6TZ9QXdduE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G1rU7h6Utv85yzx9gTx4Xnkjq5U1KntwRpjEjms6EOiQULHohBOKRJs1pdj+RLRjf
	 38ntPWejC4le7t29vbOMqi3EVv5v2JV5+6oNFNrY61YG6Ye/475ro0FGHi1e/sXTrU
	 law9IhNOCx8lVfrQVCx1kqN32pPQJFc8GyO4ucHjmLOBalCIIEJXYmryIwshFN13VY
	 9rAWrk70Sjvg9BM7UVdLKGD8euNxR5rSfryE7NVU1ttVoJyIqSWthakTHoMJtae5Kd
	 zLy22z2pp3KvdnVCq9/O1PAqx+5wwS1XEHHnYBrBTeI/HmVgSG09c2XKsiqf/GWfKr
	 BXWBoHK2XwNwg==
Date: Tue, 26 Aug 2025 17:44:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <corbet@lwn.net>, <andrew@lunn.ch>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] docs: networking: clarify expectation of
 persistent stats
Message-ID: <20250826174457.56705b46@kernel.org>
In-Reply-To: <20250825134755.3468861-1-naveenm@marvell.com>
References: <20250825134755.3468861-1-naveenm@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 19:17:55 +0530 Naveen Mamindlapalli wrote:
> -Statistics must persist across routine operations like bringing the interface
> -down and up.
> +Statistics are expected to persist across routine operations like bringing the

Please don't weaken the requirement. The requirements is what it is.

> +interface down and up. This includes both standard interface statistics and
> +driver-defined statistics reported via `ethtool -S`.

Rest of the paragraph looks good, but I think the preferred form of
quotations is double back ticks? Most of this doc doesn't comply but
let's stick to double when adding new stuff.

> +However, this behavior is not always strictly followed, and some drivers do
> +reset these counters to zero when the device is closed and reopened. This can
> +lead to misinterpretation of network behavior by monitoring tools, such as
> +SNMP, that expect monotonically increasing counters.
> +
> +Driver authors are expected to preserve statistics across interface down/up
> +cycles to ensure consistent reporting and better integration with monitoring
> +tools that consume these statistics.

This feels like too many words. How about:

Note that the following legacy drivers do not comply with this requirement
and cannot be fixed without breaking existing users:
 - driver1
 - driver2
 ...
-- 
pw-bot: cr

