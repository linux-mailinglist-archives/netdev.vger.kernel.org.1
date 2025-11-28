Return-Path: <netdev+bounces-242496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB12C90B6F
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 04:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CC93A23E3
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAA42C0261;
	Fri, 28 Nov 2025 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/3Rtf4y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946502BF3E2;
	Fri, 28 Nov 2025 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764299617; cv=none; b=PIu/olY9lR7DuuTA3vrsCc/T5KzE9OOPDxEm2EgEIakN66Fp2eiCazDQC9J+xd0IZ6kQy0PpbaTP5iIyh9uc51LfsqlXiYmCEyMQrETv9/Lcf+CdUQyT4z1geJPnQyAM4F69MuGSYHtezaUcVQpBft5U5RrMwHcb4CxKazHqPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764299617; c=relaxed/simple;
	bh=VWT+KruTuAaHKKBf6wFU/AdhLivLe/XN9V/AfK8648Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SelvY6HzzPlvvtXLT1lkNDtolzpo5jALlZbgYKOUJDAjWB/vQzcun8kV+Vph0AzmRpDoT+FzzZQPKAElaknS/JBMndY5R6rJgKOh9cqIMBjdtT309lNrLPoyUg5HUoqkecb+GTKF9j12VmVnpJ8vv3vVexFmpETwnJddI7NcrWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/3Rtf4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93807C4CEF8;
	Fri, 28 Nov 2025 03:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764299617;
	bh=VWT+KruTuAaHKKBf6wFU/AdhLivLe/XN9V/AfK8648Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W/3Rtf4yp/90uDQz3q+sG4aHhgZ4nQG9cqMu10R24Ixed0qd9OSnE8VQbMMxLYPyi
	 AgmRm01rKDwjq6dlIheo65MHCyT5yJG1wraOxflTdSB4dsHrJOrrR0HdjucucDaWM3
	 qFw12q4OGZV4KrQwJx52JzwLwNDWULBm8sKc5fZWsgh11RmysL2GYLHtZLU5AQYPfj
	 t8cCGHzkdzEqoBLLtvczHmSMEl9b1bjglD8hDFxKGdYb5/oChTyB9J1N1ByByEQwnZ
	 xSL/poESqPwmHCqN2JrvM4ec9mESd3W7UkbWdmSU5Bxrj3VOu6mKYAlUoqm8J4BTCR
	 oaTze7ocHPgFw==
Date: Thu, 27 Nov 2025 19:13:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [v3, net-next 10/12] bng_en: Add initial support for ethtool
 stats display
Message-ID: <20251127191335.60097c86@kernel.org>
In-Reply-To: <20251126194931.455830-11-bhargava.marreddy@broadcom.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
	<20251126194931.455830-11-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 01:19:29 +0530 Bhargava Marreddy wrote:
> +static const char * const bnge_ring_rx_stats_str[] = {
> +	"rx_ucast_packets",
> +	"rx_mcast_packets",
> +	"rx_bcast_packets",
> +	"rx_discards",
> +	"rx_errors",
> +	"rx_ucast_bytes",
> +	"rx_mcast_bytes",
> +	"rx_bcast_bytes",
> +};
> +
> +static const char * const bnge_ring_tx_stats_str[] = {
> +	"tx_ucast_packets",
> +	"tx_mcast_packets",
> +	"tx_bcast_packets",
> +	"tx_errors",
> +	"tx_discards",
> +	"tx_ucast_bytes",
> +	"tx_mcast_bytes",
> +	"tx_bcast_bytes",
> +};
> +
> +static const char * const bnge_ring_tpa_stats_str[] = {
> +	"tpa_packets",
> +	"tpa_bytes",
> +	"tpa_events",
> +	"tpa_aborts",
> +};
> +
> +static const char * const bnge_ring_tpa2_stats_str[] = {
> +	"rx_tpa_eligible_pkt",
> +	"rx_tpa_eligible_bytes",
> +	"rx_tpa_pkt",
> +	"rx_tpa_bytes",
> +	"rx_tpa_errors",
> +	"rx_tpa_events",
> +};
> +
> +static const char * const bnge_rx_sw_stats_str[] = {
> +	"rx_l4_csum_errors",
> +	"rx_resets",
> +	"rx_buf_errors",
> +};

We do not allow duplicating standard stats in ethtool -S any more.

