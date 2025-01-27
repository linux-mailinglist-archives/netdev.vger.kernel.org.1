Return-Path: <netdev+bounces-161192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5C6A1DD3F
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F40316582F
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713915746E;
	Mon, 27 Jan 2025 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqJEF2un"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002286340
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738008968; cv=none; b=I5gSJP5vcaW0fi0z2zb5yIZofvLtvz0WxPeCiQIpaBc7CuS+FZ/qnLazhJNNxpHmKxPK2B5njToGYwS/bZLX9cXbyGsC6cFwr8mu6e6fx2yRe+aDSvZjM34/XowPZ3PWiOr7e8xSGjqn9HtoRSHI/EfZOxB7zZCBcgLblAz19E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738008968; c=relaxed/simple;
	bh=RTBWZ/XEPWJJRDVJ0w6t5mTugzzX/R5a8E3oMcvDy0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrkBO6sYOmJSlUZ3/6d3s60iD221QorggTxWwVUUWZVJzgQxbMhC612vxEXoO9X86KK6I1rM+9MD3st65zFheS6MnMyMXwfwNY/1hE1nION9iyfBcZDkR3nzAVzyLXlcYcAdLWYmfkq53HSxFKXBmIiPoL9AkItwq7h1fMS/4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqJEF2un; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CCDC4CED2;
	Mon, 27 Jan 2025 20:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738008967;
	bh=RTBWZ/XEPWJJRDVJ0w6t5mTugzzX/R5a8E3oMcvDy0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iqJEF2unHyTdSGwMKM5oyEQ/aIPQ/USb4jTyJCwAUoZ7TawAdnb4A4Fr/QGS4TbjS
	 kv+6ajJqMNhJKT/WZ5oW+lzMai/aYgtfiBkFiwxo2rr7Ah95paV1j/Dpp+eq8c3bq/
	 OOdr8myPoPEVMn+mwkpP5UGo1n7Q1W/yfUyI5tT+mhxKvbXzzXL7r2AIWReMAqqxT4
	 COekvfXB/KHwqMfRb3ar/2A0aA5mZxoWYdPl5kdKVnGKEcCl3O19B08WYzX9WI1IF8
	 Kd1o2x4Kys0wvxiFcGmnR4UFSR1Gvq5U1mz93RyOxJZpln9CgD31pIg4vVK+vJaRem
	 7QYrQiHj7XA1g==
Date: Mon, 27 Jan 2025 12:16:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mkubecek@suse.cz>, <matt@traverse.com.au>,
 <daniel.zahka@gmail.com>, <amcohen@nvidia.com>,
 <nbu-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Message-ID: <20250127121606.0c9ace12@kernel.org>
In-Reply-To: <20250126115635.801935-10-danieller@nvidia.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-10-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jan 2025 13:56:30 +0200 Danielle Ratson wrote:
> +		open_json_object("extended_identifier");
> +		print_int(PRINT_JSON, "value", "0x%02x",
> +			  map->page_00h[SFF8636_EXT_ID_OFFSET]);

Hm, why hex here?
Priority for JSON output is to make it easy to handle in code,
rather than easy to read. Hex strings need extra manual decoding, no?

BTW thanks for pushing this work forward!

