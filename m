Return-Path: <netdev+bounces-184391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A4A952DA
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 16:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB71173AE0
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D181919F116;
	Mon, 21 Apr 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvMoanFE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB2519CC36;
	Mon, 21 Apr 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745246009; cv=none; b=TmMQJaUfziUQ9IlKR2O8/x4zqnTGQ8qMmEIuc7u7Wi57zKzKXxwbKv4rpYYiVJlrMi1/ppOJHZ1gwl4TLYGZr/dZmhGVEaYlRb5yrnqKVgudj5uwrLOVRoPUHG5mXlBqeOrv6UcsQlDduHFrnC9f3BFQadFRydMRw9HiOKx/2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745246009; c=relaxed/simple;
	bh=vL4Lwnt4PWMzLDjYnXC1f60A4r77Rx3QtZwEy7r7Byk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9WEcyFRIni1XDinFHUjYIhgmYn8DT0gXyh8BEZXx1mAZU/Z20aJ+K/Ek/Kgro8wxgFJTs07hSd7RiNZ2Ys82ahMzArejMoKcxK3Q3YQb9ly0Z3LqPR8rd+zGmSYyJIIUMhmKWQ6kZY/AP9PlEkOKEQQjyRv4J7EpfYx+jzETo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvMoanFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46708C4CEE4;
	Mon, 21 Apr 2025 14:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745246009;
	bh=vL4Lwnt4PWMzLDjYnXC1f60A4r77Rx3QtZwEy7r7Byk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvMoanFEeg0yUe6jokPAsxU4uDOlQB2CFZwGcl9iuWcBQimxBgc/uTalAmsi58UAY
	 pp2EQZqtxj/9Z62qm+zA8V1Xw37Cf5d4VdIGdhuVlIRrISmILpLVSz+0/BX7eV1CJK
	 0Jotew+gIgDU/nJNfydzV2qj989lzWRJ0VnhLfZ5At+RtHoDOkamy+02zgWCRDn+GN
	 r42nxnCT8Vt4Cy4gNMRVj028Jtlmvs/zOkJ5Eyo5KshdvNxvxciKeMsDfBmoxVHUdY
	 AIGmLIvaEg9ZaF/pWX6ZuI1AJMq9ibUUPaWgMDlPHmi7n1buICzGdpE4kDng+7vPXp
	 gFr0GR62sNQIg==
Date: Mon, 21 Apr 2025 15:33:25 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v1 1/4] net: selftests: drop test index from
 net_selftest_get_strings()
Message-ID: <20250421143325.GM2789685@horms.kernel.org>
References: <20250416161439.2922994-1-o.rempel@pengutronix.de>
 <20250416161439.2922994-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416161439.2922994-2-o.rempel@pengutronix.de>

On Wed, Apr 16, 2025 at 06:14:36PM +0200, Oleksij Rempel wrote:
> The test index is redundant and reduces available space for test names,
> which are already limited to ETH_GSTRING_LEN (32 bytes). Removing the
> index improves readability in tools like `ethtool -t`, especially when
> longer test names are used.
> 
> Before this change:
>   3. PHY internal loopback, enab
>   7. PHY internal loopback, disa
> 
> After this change:
>   PHY internal loopback, enable
>   PHY internal loopback, disable
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


