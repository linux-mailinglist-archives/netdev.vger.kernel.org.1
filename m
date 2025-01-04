Return-Path: <netdev+bounces-155186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44763A01621
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 18:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F287A3A3334
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A2313BC35;
	Sat,  4 Jan 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RLlfAv1P"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F22136E28
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736012120; cv=none; b=uIgdJz2tfqG/WjZE62/Z88Bl9XI99K4mt3CuoBfFwJDGUU5/ZKBCqFY4U2xsGzn/5xl0QVeU5g5utXEpReSR2EgtlN9n+lb4nDkXJf0q54LIXJadJnvcqCrFc+6Yv5mIBAgP6pIklmEsZGJB0i/uURSuCJE77YokeFQdAuOOwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736012120; c=relaxed/simple;
	bh=P9HxXI8BLFXri6aAsjQfrSwir92BIKmKLWAw+Vxs2vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtU4dJl/aGrxa94JsSPJxfY9FKD/kooK4IfHlYeAQ/Oi9hsKVFnKOKkOPieFWa+HcooqMMmf3Gh6qVtxCvnmyR0smdFzltrSJ7Ex6n3LfGvq4Wh1tcFwlb7ZqnqyqM4DWWvFXFOnskQYd2N+z2V1jE/i1r0RKMSQ9w7Egh5DHvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RLlfAv1P; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BUD7WfagatcxmAgwX6UmSkPhaYa6WGGZIgGzxLKss1E=; b=RLlfAv1PjRyPmsOWMwHTgcugw+
	/BhFnQPVT7rjgyb1ZyrsN9DO4T5JKn6XQWaYJu1cABMP2SII39fy0hO1RJgYV0hAK52WV8s+hpsi/
	K0ErJIF++WP/pVbyFaXqnFlpWFcXihhx4SPYFFnjMZqJJAoSscEiGX0mFCTG3Bblp5sc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tU83G-001N8Y-2F; Sat, 04 Jan 2025 18:35:06 +0100
Date: Sat, 4 Jan 2025 18:35:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Muhammad Nuzaihan <zaihan@unrealasia.net>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Loic Poulain <loic.poulain@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] dev: Add NMEA port for MHI WWAN device.
 (mhi0_NMEA)
Message-ID: <c8817188-00d0-410b-bfc0-c89fb4784b84@lunn.ch>
References: <PVOKPS.9BTDD92U5KK72@unrealasia.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PVOKPS.9BTDD92U5KK72@unrealasia.net>

On Sun, Jan 05, 2025 at 12:38:13AM +0800, Muhammad Nuzaihan wrote:
> Based on the earlier v2 and v1 patches. This patch is a cleanup from v2.
> 
> Removed unnecessary code added to "iosm" and "AT IOCTL" which is not
> relevant.
> 
> Tested this change on a new kernel and module built and now device NMEA
> (mhi0_NMEA) statements are available through /dev/wwan0nmea0 port on bootup.
> 
> Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin <zaihan@unrealasia.net>
> ---
> v3:
> - Rebased to net-next main branch
> - Removed earlier patches that added unnecessary iosm (unrelated) and AT
> IOCTL code.
> v2: https://lore.kernel.org/netdev/5LHFPS.G3DNPFBCDKCL2@unrealasia.net/
> v1: https://lore.kernel.org/netdev/R8AFPS.THYVK2DKSEE83@unrealasia.net/
> ---
> 
> drivers/net/wwan/mhi_wwan_ctrl.c | 1 +
> drivers/net/wwan/wwan_core.c | 4 ++++
> include/linux/wwan.h | 2 ++
> 3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c
> b/drivers/net/wwan/mhi_wwan_ctrl.c
> index e9f979d2d851..e13c0b078175 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
> @@ -263,6 +263,7 @@ static const struct mhi_device_id
> mhi_wwan_ctrl_match_table[] = {
>        { .chan = "QMI", .driver_data = WWAN_PORT_QMI },
>        { .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },
>        { .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
> +	{ .chan = "NMEA", .driver_data = WWAN_PORT_NMEA },

The indentation is all messed up in this patch. It looks like a tab to
space conversion has happened somewhere?

Did you use git send-email?

    Andrew

---
pw-bot: cr

