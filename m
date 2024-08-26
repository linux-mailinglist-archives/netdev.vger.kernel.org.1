Return-Path: <netdev+bounces-121967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1DD95F6A1
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2EF1C21A2A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E31194131;
	Mon, 26 Aug 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN6AzQiu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3C1865E7;
	Mon, 26 Aug 2024 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689938; cv=none; b=Q1Vivi+SI8QPTFPIgee0Yp2VwJQZtRhFYI+PuGJwRXL0ruVoBC+cpAAmQ2CWcDw6+uPCwFntWKBL6fEgSr6sag42AMAKbAMJpw9xTMSpKZ3My4YUywmQD4Wp9cNoSkrcYwhNQWR09lC5jsb+ymprnufcdOPZNteu+HjdCtJMw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689938; c=relaxed/simple;
	bh=CuRZPNcAg/KhTuJ7w3AXF0CuthcPOrzqmzpzn6hzOYE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/VLFYXBZpw8R6NwYB94qP+M5FO7cXUCG0zQVxVQjWmOYjxRw2oVDfnJajRbKbVITNua5yTPvzCNSxugv50uVxHzEP+z3DBeZ6qoSmkQRdCFLwmZ9sfvGjJHK73/eQULDlJtWOLLVidI7+nhMsXolsbOjxa1d+ba5pRMVUIryGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN6AzQiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D78C52FC1;
	Mon, 26 Aug 2024 16:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724689938;
	bh=CuRZPNcAg/KhTuJ7w3AXF0CuthcPOrzqmzpzn6hzOYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eN6AzQiuMdLSoW/3F9+Kzt5KSH89VVoAwGX8FyZ0s9dQfScSoCdW3p0Xn/z8dpAVH
	 3zTCHs0lY+KUT9ieqQ+V5lVCTwZNHuE87P+5RQTD1qXNI7ckI0ERu3Ytkgy0GD5tYh
	 4W5ITXd3z+qbQ4B32jqfAQTouEfv9iPddJR1PgwIuoiw3hZ4PACH4yyn0a5JtxA3Ge
	 VnlOro3CtNRo5cVHH+mUcPPU/fyHyc7+vAWEv21ZXFl3zG5uWnoYsVszOoCluHNlHM
	 +Uw7QDpT7EQefBEYOqmU0inTJmdwtZ3aJfIFHV63ui9cxUDQ4KIm9A2iPfzO3baTGQ
	 2MLkypeCd6nuQ==
Date: Mon, 26 Aug 2024 09:32:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] phy: open_alliance_helpers: Add defines
 for link quality metrics
Message-ID: <20240826093217.3e076b5c@kernel.org>
In-Reply-To: <20240822115939.1387015-2-o.rempel@pengutronix.de>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
	<20240822115939.1387015-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 13:59:37 +0200 Oleksij Rempel wrote:
> Introduce a set of defines for link quality (LQ) related metrics in the
> Open Alliance helpers. These metrics include:
> 
> - `oa_lq_lfl_esd_event_count`: Number of ESD events detected by the Link
>   Failures and Losses (LFL).
> - `oa_lq_link_training_time`: Time required to establish a link.
> - `oa_lq_remote_receiver_time`: Time required until the remote receiver
>   signals that it is locked.
> - `oa_lq_local_receiver_time`: Time required until the local receiver is
>   locked.
> - `oa_lq_lfl_link_loss_count`: Number of link losses.
> - `oa_lq_lfl_link_failure_count`: Number of link failures that do not
>   cause a link loss.
> 
> These standardized defines will be used by PHY drivers to report these
> statistics.

If these are defined by a standard why not report them as structured
data? Like we report ethtool_eth_mac_stats, ethtool_eth_ctrl_stats,
ethtool_rmon_stats etc.?

