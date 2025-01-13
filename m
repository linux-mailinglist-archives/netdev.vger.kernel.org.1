Return-Path: <netdev+bounces-157892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27144A0C360
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D0E162F8A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274141D514A;
	Mon, 13 Jan 2025 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCXqmAp/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30381D0B8E;
	Mon, 13 Jan 2025 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802910; cv=none; b=i9pF/LgwuD+iVZbaxk4J73QmOxOFu6dhFo9wFHG2sGsgMSespPj5j8nO9eVYJo4vfQF07dOPNrDuVHo8OIqWmgF/zvBZCxb28SxTH8153Tu6BHW4ZJo87Y7zKXm+JmQlW6sp1o1ZZ45SdiuLQ9VGScasYQCiD9lXxRkgfGO558M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802910; c=relaxed/simple;
	bh=d/vrrZJ1Rj5cvhFMT7x8wSnldOnMUjnIQVlF0v9aVmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPK6aDDjuG1lbEd3PP+sR6ZQR+sC+lRVjHqvt34rxuzI3qqKK+mGQRWD4+IjnFJUbsOpvZyZifQUpG9BSR5Pu5spxPzCW4vRfyyg9x2ZnhF84yEtZb/xJ5V18jV8wXyo4yM43HUCnNONMsPoGRz0Gx82JTaMIxM3HykHb+S+OOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCXqmAp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2A0C4CED6;
	Mon, 13 Jan 2025 21:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736802909;
	bh=d/vrrZJ1Rj5cvhFMT7x8wSnldOnMUjnIQVlF0v9aVmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PCXqmAp/GgADfQuDRU2PZU2Vam9624HBwmuXVwnBo/6sTmVW2DkYSIL1a+2qxSXpF
	 osnBebS2bnCgyXGCYqJEz4R9KU92MaIwzqjUWkJ7R92rHec1yMW1hAYueY69kwksq6
	 wOLCqHxwRmJa+N9uFeEmVZiFffSMkBwQ1q9xGDs1HIW3tQsIWc0hSCP4qnEAFBYwlS
	 ZRpstr8zeIlJgaAkaySplVA8sRwkIEjW/nmiXgJFznQ1+c+MwJPJDYUx/Cjbym9+U5
	 Opif4f5K+9siWjqtfZhzNNCL2k559YXE7ijyfmB7A93qWiZWyIN2PXVIm8t0zOlG+k
	 0suTvB9l25idQ==
Date: Mon, 13 Jan 2025 13:15:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Sedlak <daniel@sedlak.dev>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [Question] Generic way to retrieve IRQ number of Tx/Rx queue
Message-ID: <20250113131508.79c8511a@kernel.org>
In-Reply-To: <ca5056ef-0a1a-477c-ac99-d266dea2ff5b@sedlak.dev>
References: <ca5056ef-0a1a-477c-ac99-d266dea2ff5b@sedlak.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 10:07:18 +0100 Daniel Sedlak wrote:
> Hello,
> I am writing an affinity scheduler in the userspace for network cards's 
> Tx/Rx queues. Is there a generic way to retrieve all IRQ numbers for 
> those queues for each interface?
> 
> My goal is to get all Tx/Rx queues for a given interface, get the IRQ 
> number of the individual queues, and set an affinity hint for each 
> queue. I have tried to loop over /proc/interrupts to retrieve all queues 
> for an interface in a hope that the last column would contain the 
> interface name however this does not work since the naming is not 
> unified across drivers. My second attempt was to retrieve all registered 
> interrupts by network interface from 
> /sys/class/net/{interface_name}/device/msi_irqs/, but this attempt was 
> also without luck because some drivers request more IRQs than the number 
> of queues (for example i40e driver).

We do have an API for that
https://docs.kernel.org/next/networking/netlink_spec/netdev.html#napi
but unfortunately the driver needs to support it, and i40e currently
doesn't:

$ git grep --files-with-matches  netif_napi_set_irq 
drivers/net/ethernet/amazon/ena/ena_netdev.c
drivers/net/ethernet/broadcom/bnxt/bnxt.c
drivers/net/ethernet/broadcom/tg3.c
drivers/net/ethernet/google/gve/gve_utils.c
drivers/net/ethernet/intel/e1000/e1000_main.c
drivers/net/ethernet/intel/e1000e/netdev.c
drivers/net/ethernet/intel/ice/ice_lib.c
drivers/net/ethernet/intel/igc/igc_main.c
drivers/net/ethernet/mellanox/mlx4/en_cq.c
drivers/net/ethernet/mellanox/mlx5/core/en_main.c
drivers/net/ethernet/meta/fbnic/fbnic_txrx.c

Should be easy to add. Let me CC the Intel list in case they already
have a relevant change queued for i40e..

