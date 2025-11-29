Return-Path: <netdev+bounces-242720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 291ABC9418A
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 16:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E95FA4E1453
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E824221F11;
	Sat, 29 Nov 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GRlB55pK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCBD1C860B;
	Sat, 29 Nov 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764431465; cv=none; b=hyE0pdqqI946Kw7LSgchTeHW4CVdsmClG4IjbXQdND8lWoT6i+eeJXvwDlfj4nBEDtIh7J5gTrYN7gHfkpC06jtKlpaSkRnVIpYuzEBicXbeBjZ/O/boqLGcGfEYdFX8TdqakWY6QZofprdQ9gkIC2PjPfKckWjBR9MGX6MnujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764431465; c=relaxed/simple;
	bh=QaMk8D7ici3vfNhMezhNAAsW5zqZdGqpONPOqEzhjbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oy+WF9gvGg4sxs+Nx/lSsPoFQt1Nmwfni+3zt6QVVqh/e65MFE3yWpSdhVLKXHHbUXnj6gL02Txj6Pe/92IK9C67K/JU65uuV2AEpMXpY0Z7AGoRYKA85eqdqC5P6ZN0Jb/FOWyJk+n3ZuAiyF/3QvfctEYENaboROQ0/I4gZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GRlB55pK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ojSV5qgzcCazDFXfwwggXbxIrOZ22eU9hYFH2DRxIbM=; b=GRlB55pKDk9X1v+QOUypqhZ70e
	IoCcFDIQjYBYowTNsueYkczmwg9JHxMmvYbY3b0lyx+5Prn+v6xBPMjd/OJkyJT1D2wl25DKAu0vd
	6MOAj6LUjyFu125XK8ngZL9ASKUj4XU14w09RwJwzbmaKhwx5UOSDdjSpFHLnI0jJG18=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vPNDl-00FPjr-Jx; Sat, 29 Nov 2025 16:50:49 +0100
Date: Sat, 29 Nov 2025 16:50:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: yt921x: Set
 ageing_time_min/ageing_time_max
Message-ID: <caca980c-e9bb-41a6-9eaf-2c98463fa609@lunn.ch>
References: <20251129042137.3034032-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129042137.3034032-1-mmyangfl@gmail.com>

On Sat, Nov 29, 2025 at 12:21:34PM +0800, David Yang wrote:
> The ageing time is in 5s step, ranging from 1 step to 0xffff steps, so
> add appropriate attributes.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

