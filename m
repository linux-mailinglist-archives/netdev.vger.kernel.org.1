Return-Path: <netdev+bounces-171473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223A2A4D11B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 02:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D596174A62
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA1B13AA27;
	Tue,  4 Mar 2025 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFVt0QW1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6CE1754B
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052491; cv=none; b=oum1Uz0sFQf5olwSm94+gXtH20SbT/MKD1eiE89bx1w/UDAD7YsxE46qEqSF2V8dwkab9jGalwULxfeROYnstil2FXSh3gzerBUcGVtk4wDiNa2mZrv68y7lOGzKcicDKy44FGpB4G5itGJcfo6kbQB2o8jsZFNN6UvxXeLxXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052491; c=relaxed/simple;
	bh=eoGMKuTePYgJiMNXbW2BGEOHceJX21C9DGs3hiavH08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0GOuFfDryUr28i3GYJD1uRg2fi724lMA0pUO8eQGlBbTHDk+9NS3I6ZYV7XjSPgWRpBa14ODXwvMZFPUKtx6xRq5lx6ihn/ip2jj4m56zs9NGQelfvqVGMG3h+vOKihW0qdJRNUV4pu5ejk7BbrXgGB7WLlDXcPF17sM5n7cdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFVt0QW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FC4C4CEE4;
	Tue,  4 Mar 2025 01:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741052490;
	bh=eoGMKuTePYgJiMNXbW2BGEOHceJX21C9DGs3hiavH08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mFVt0QW1EOsqkiSd1PckVa5GFWcz410sI9HrvplCbEusApEd7YWYq5+rW54mDwq/U
	 tFw58q87zyWvuXvEMNrAs0pcD31pijeSSz3iMsA/QYEZw6UlZzIOKGBQK0OHsnDV+h
	 b2dU0f34P88Z6C6lqVmwYBQPe7nz8dIt8HaS3LgGWmMb7kilVzjhcpDDIud1iv53LJ
	 hAMBd9ue20s38eX0T4ieWeHb653OflIUub8sKbZyFl9XX8TbZO7ZFzGx9IIGQ3lDBq
	 PHke5PfV6zuYOk/vLnNxhfM1uAocJ4hN8hY83XRuGxnJL0exGOyMjHFbonrPz2oNvp
	 5H+ygufRDG84Q==
Date: Mon, 3 Mar 2025 17:41:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v9 6/8] net: selftests: Support selftest sets
Message-ID: <20250303174129.21aa5f88@kernel.org>
In-Reply-To: <20250227203138.60420-7-gerhard@engleder-embedded.com>
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
	<20250227203138.60420-7-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 21:31:36 +0100 Gerhard Engleder wrote:
> +/**
> + * enum net_selftest - selftest set ID
> + * @NET_SELFTEST_LOOPBACK_CARRIER: Loopback tests based on carrier speed

why are these "tests based on carrier speed"?
these tests use default parameters AFAICT, I'm not seeing the relevance
of carrier.. Maybe you can explain.

> + */
> +enum net_selftest {
> +	NET_SELFTEST_LOOPBACK_CARRIER = 0,
> +};

> diff --git a/net/core/selftests.c b/net/core/selftests.c
> index e99ae983fca9..ec9bb149a378 100644
> --- a/net/core/selftests.c
> +++ b/net/core/selftests.c
> @@ -14,6 +14,10 @@
>  #include <net/tcp.h>
>  #include <net/udp.h>
>  
> +struct net_test_ctx {
> +	u8 next_id;
> +};
> +
>  struct net_packet_attrs {
>  	const unsigned char *src;
>  	const unsigned char *dst;
> @@ -44,14 +48,13 @@ struct netsfhdr {
>  	u8 id;
>  } __packed;
>  
> -static u8 net_test_next_id;

The removal of the global state seems loosely connected to the rest,
the global state is okay because we hold RTNL across, AFAIU, which
will still be true for tests varying speed. Not using global state
is a worthwhile cleanup IMO, but I think you should split this patch 
in 2.

