Return-Path: <netdev+bounces-185356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B75FA99E6A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334875A56D7
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35461D63C6;
	Thu, 24 Apr 2025 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOSKDE3S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94631D5CE5;
	Thu, 24 Apr 2025 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459041; cv=none; b=XlzXzlJoR47Z+HfeeWdvPFkDiOIRD05iQJXKKfX/oG8KtEubU4bJBTJTgWbwleatUmx8ZCQDjj8VG14J+Qs3dROoqFPl81tyOim+Z5Mf3lSGhA1n25V+B/stMimzMZ93G47n4kKLjDgxeEMrcetJgw2OYJQnFgovZ5ZIzZfS6i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459041; c=relaxed/simple;
	bh=+KVEfg3RjWK5fuSRt7HaxfYK4iBkeS8AIzd8wZibX9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dd2+KGRJzuGRrL/sjGlICynKAlGWe/ZbT1YwEcI3v84NJ8WB1xvwy+bAsBbWWFJAExeNphIcSuXipecr7gXDjvIQsR8hMoB0O1p4id+4j47o15gXCDcNhibp5RiwJxlYPDzQNStWTqLEvIi1uuXur7cid9kKdlRy7ogESdU8OZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOSKDE3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B58C4CEE3;
	Thu, 24 Apr 2025 01:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745459041;
	bh=+KVEfg3RjWK5fuSRt7HaxfYK4iBkeS8AIzd8wZibX9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TOSKDE3SAnrsqeUaGgT3Ks4W7XE0StwPFkITNexD0AAtNbolabT3B0GGwRU3NnVQn
	 JKHTZuZLTdBUDk6rHgT2yc4GiALi8xMndraqfwFfUJWSnIGKgz6btgW7Kxp9ewOTRK
	 LmdhfaT5Sl9xtDKberuhnISdZ36nEX2Bd81oof6EUFbc4w72kmyWjswWm9uX6adgrV
	 pg/piQ71n71KEONInuccGOVTOtdXvYyXtqy5LnSjjlSNFdeZkJnjWVgKm7yrRjj+Yj
	 mk3AmwStYKDjoGCYSOBxWIetgfmTTwU5RO16TMhU0GwZE6wLR4xUkPBr7o1KuRYOLU
	 wvvmPK89lfhBQ==
Date: Wed, 23 Apr 2025 18:44:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <20250423184400.31425ecd@kernel.org>
In-Reply-To: <20250422123902.2019685-1-o.rempel@pengutronix.de>
References: <20250422123902.2019685-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 14:38:58 +0200 Oleksij Rempel wrote:
> This patchset addresses two issues in the current net selftest
> framework:
> 
> - Truncated test names: Existing test names are prefixed with an index,
>   reducing the available space within the ETH_GSTRING_LEN limit.  This
>   patch removes the index to allow more descriptive names.
> 
> - Inconsistent checksum behavior: On DSA setups and similar
>   environments, checksum offloading is not always available or
>   appropriate. The previous selftests did not distinguish between software
>   and hardware checksum modes, leading to unreliable results. This
>   patchset introduces explicit csum_mode handling and adds separate tests
>   for both software and hardware checksum validation.

Doesn't apply, presumably because of the fix that's sitting in net?
-- 
pw-bot: cr

