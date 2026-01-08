Return-Path: <netdev+bounces-248124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DE8D03AB1
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B29F301053B
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34AF248861;
	Thu,  8 Jan 2026 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiih61/M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE4242935
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884851; cv=none; b=IW7c5ZP6mBC4a408AOaVc17FSYp0JXjVPnErbEGC0+KZLNFCjomtOjrDLjh8C8unuXWsO15ei+JQTzMYiW7EJGpkLiZouAoQ7Oj0luFrlLZNCa8/NSedbw1CnAFkAvZMD2aMfqXixlzYH4x0wQrqxksUOcqw43R8wyeaI1zES0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884851; c=relaxed/simple;
	bh=rVjW+7g08CsaF8/U5C2AIau2HipugOJgIASXicUAEIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ao3dKIUbrysNW47oj27sE/fkKehJ5jezA2o0J83W+1JPOXt/diO8+fjjSkamc6ogxNJKrDgROxMDGDzU+qHdP37WvwfodkAtIaMmD7lnU6jZKQvvp0EmkB0dCJByWvn68ytadQhV/IT6WHSLV6tWo1ZjFVyhEoC1goAYGirQsCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiih61/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09CEC116C6;
	Thu,  8 Jan 2026 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767884851;
	bh=rVjW+7g08CsaF8/U5C2AIau2HipugOJgIASXicUAEIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kiih61/M5L1y+N813dg8NelXTuCXe6o9V2dm4tynnomud2ULI9buOkfQBLIOW6yyb
	 U8C9dPSxKS8UbtJDvC0mzCpWxoHklbjg6m5W2MixJdXi9rl3tFQsQJDlZXOMuSo33k
	 PWLwKfMwQlFmM179JxIw/aGXLeZaitKMwA48fhCtyoE9HKj9iHMqFweyTEBXw504bq
	 lnwYxYrpjeM6cEHsdvDZvwGXcaOSz69o9Sknt6tGJiDzCqAU4mrtWTC0BorfuhtSbG
	 r2QfnJ4qKhSdtBFlf3oSw/NACFGU05pst3Am5jHQfPNUITnIt8zg/M3S52gw+v5cPA
	 0fKNyrbGRrcMg==
Date: Thu, 8 Jan 2026 07:07:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Takashi Kozu <takkozu@amazon.com>
Cc: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, Kohei Enju <enjuk@amazon.com>
Subject: Re: [PATCH iwl-next v2 3/3] igb: allow configuring RSS key via
 ethtool set_rxfh
Message-ID: <20260108070729.79575f9c@kernel.org>
In-Reply-To: <20260108052020.84218-8-takkozu@amazon.com>
References: <20260108052020.84218-5-takkozu@amazon.com>
	<20260108052020.84218-8-takkozu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 14:20:15 +0900 Takashi Kozu wrote:
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index da0f550de605..d42b3750f0b1 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4526,7 +4526,8 @@ static void igb_setup_mrqc(struct igb_adapter *adapter)
>  	u32 mrqc, rxcsum;
>  	u32 j, num_rx_queues;
>  
> -	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
> +	if (!adapter->has_user_rss_key)
> +		netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
>  	igb_write_rss_key(adapter);

This is an unusual construct. adapter->rss_key is driver state, does
something wipe it? It's normal to have to write the key into the device
after reset but initializing the driver state is usually done at probe,
just once. Then you don't have to worry whether the state is coming from
random or user.

Note that netdev_rss_key_fill() initializes its state once per boot so
it will not change its 'return' value without reboot.

Last but not least - would you be able to run:

tools/testing/selftests/drivers/net/hw/toeplitz.py
tools/testing/selftests/drivers/net/hw/rss_api.py

against this device? Some more help:
https://github.com/linux-netdev/nipa/wiki/Running-driver-tests

