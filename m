Return-Path: <netdev+bounces-179943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA28A7EF6A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9521680F5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793420B7EF;
	Mon,  7 Apr 2025 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0ZmvjQkV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD01EF39B;
	Mon,  7 Apr 2025 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744058631; cv=none; b=h8yQTw7Kfoh4NtpCy825XZe/lclWKUMCVw/PzQ4Ycaz6/jR1hwx/hzCDMcQcY4DCXVrAn0Jwr4sdpiIoh1kkPAWGJ61hAWxYTB+fGuPmgZvqy5R92dx+If+CWn25rr5q9zNGNbnBwfpwBfrmFMoxdcXDxZKXiWFxDAe1f/HX47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744058631; c=relaxed/simple;
	bh=6EBh2U1Xj5T1DiZG4ZcEokMC3YV0jDfrvas4ybr1kCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJB/h84Edoqf7LlF6nvBIeTLqzn1TQrsZwJzZsanWRNeZlLFchQvb2L4E7xpznp7XaN9bGcV/nJmnzGKcRRDpC+MptgUsjQ8JcgOP7mMMhi7MLG8cHG5+0iTVtkgTVTWgHJNjEbaIkWNXQEVmHG6ZX7eUzGnET/tsHFqwot/gt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0ZmvjQkV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YetF0m4s/Yc5t+Cr7WhKcRQIRuNVoT1QJ5N9WOd4WgM=; b=0ZmvjQkV5qlg+yfme4Qsz/Yndz
	51Y6/G/0kexD56xw1hBYrwyI+3n3MTpyXwquaBETy3quAcb9bR8bE0ahLlXx+AWKcXMxKvZ3+ealD
	uMcN1zdsGJwUbX4OmIBlOeu7rmZKMvZ/T7iF9SBY9FDfc/TvR4XcvwiKZ1q8eok18Rto=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u1tJl-008Its-Sj; Mon, 07 Apr 2025 22:43:41 +0200
Date: Mon, 7 Apr 2025 22:43:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] net: dlink: add support for reporting stats
 via `ethtool -S` and `ip -s -s link show`
Message-ID: <122f35a6-a8b6-446a-a76d-9b761c716dfe@lunn.ch>
References: <20250407134930.124307-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407134930.124307-1-yyyynoom@gmail.com>

> +static const struct dlink_stats stats[] = {
> +	{
> +		.string = "tx_jumbo_frames",
> +		.stat_offset = offsetof(struct netdev_private,
> +					tx_jumbo_frames),
> +		.size = sizeof(u16),
> +		.regs = TxJumboFrames
> +	},
> +	{
> +		.string = "rmon_rx_packets",
> +		.stat_offset = offsetof(struct netdev_private,
> +					rmon_rx_packets),
> +		.size = sizeof(u32),
> +		.regs = EtherStatsPkts
> +	}
> +}, ctrl_stats[] = {
> +	{
> +		.string = "tx_mac_control_frames",

That is an odd way of doing it. It would be better to repeat the
static const struct dlink_stats.

       Andrew

