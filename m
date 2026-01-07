Return-Path: <netdev+bounces-247847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA6CFF261
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8DE6300AB1A
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A737A498;
	Wed,  7 Jan 2026 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KkDZ8RX9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530634D93A
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807596; cv=none; b=s/IzBsWdHv3AIEkPo3X/h9LG90o7DwehYZhrJJUzNlmyuG4NH7TPLKGIt3SI2CWEjwS7B+e8YVpyaGWYxjqpeRP3nOTLI02aGQwsiUsZOf8lsGOhHhJ43Zy0BLbGhRHCexwqlsYFSt0FosUHTme6X9ugPW0teFlxGuja/reGzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807596; c=relaxed/simple;
	bh=+J2NbLhi+d+Vp2uX/cX9GarvqK3mnsXrNT2yhEFJces=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4R7ntlZGCAtz5S+QC5ROrsWXF79H4ne0dG3wEkxpmI4Mt25VvhG6UFoSh+b6J6x9pBT9PC8Tg5wgDfY21MdeHoOvcH4UqEGKhbU/dOvXJaPVR/KBBRy6lmVo2mTEKU5xgEO/LaFK+mDOjXVktTSvfFJiBxku8EtYtIklSdufsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KkDZ8RX9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SXJhIoAvaC6V+/xAsy+5UDKdPB5d+f5XP/MvXhBlhec=; b=KkDZ8RX9+teCG3Vnkc/vkOHaW0
	0/wlBiZ30+TSNe1HEwb9o7I9v0Oe4gJrR0wupv2uSIqSgTWes8v5xoPuroqm28GWgMz7YUv65HhVi
	TP2xVQQqTZpFl+nU19F5AzpVDuPXb3GvYL45a0rve/RlIoV+4ycqVFVoZ/Mh5/luE/ao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdXVf-001px4-PI; Wed, 07 Jan 2026 18:39:51 +0100
Date: Wed, 7 Jan 2026 18:39:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: usb: smsc95xx: use phy_do_ioctl_running
 function
Message-ID: <81cb219e-dbdf-4220-a49b-5c1b96eee3a7@lunn.ch>
References: <20260107065749.21800-1-enelsonmoore@gmail.com>
 <20260107065749.21800-2-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107065749.21800-2-enelsonmoore@gmail.com>

On Tue, Jan 06, 2026 at 10:57:49PM -0800, Ethan Nelson-Moore wrote:
> The smsc95xx_ioctl function behaves identically to the
> phy_do_ioctl_running function. Remove it and use the
> phy_do_ioctl_running function directly instead.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

