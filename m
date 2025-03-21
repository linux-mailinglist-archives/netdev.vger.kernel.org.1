Return-Path: <netdev+bounces-176691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0452AA6B5ED
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 09:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B12A189A9ED
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB621EB9F9;
	Fri, 21 Mar 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw6sUsIB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571441A841F
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545049; cv=none; b=OhwLna9oD0PBfPDxsNtJhrJWFgK1sDXHXZefo8ZaSLNIzBJFOKKvfkLmu4GRK+T6u8TMESHNHUCwym3Kf1sbVXdC8RISC68JB15hcbvtsyXW+YXbD1j+3UwzrDGshbVfZxPQK9F0s/1qFUvItzf7CpXuyDufZRE5Dsx9Y0Tend4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545049; c=relaxed/simple;
	bh=2rVnxVsQOwt2QeuQYEo/4KLupcq3x1q8qASeJ46Mf4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOfw2POphrUYkuStWPVWYTZFHh2kZ4f8DYyFrjA31uRdyCu6X35v2qYnAfBeqOespGMImZM0/u2qlgdQZ5D7JnEGdybxDCrsXVyc0tIxZ4g4ZL38BU9ICUSIjV/Kzso3HT+hbYHdCNnKIQlZjFhXxJxsbH8XcAAvqZTgiy6OFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw6sUsIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7A9C4CEE8;
	Fri, 21 Mar 2025 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742545048;
	bh=2rVnxVsQOwt2QeuQYEo/4KLupcq3x1q8qASeJ46Mf4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nw6sUsIBc/0uxERvLhFN80DHt9f6VZtKRoxAp5wmnEkPlOJSxs9M2nrBke6skDeLZ
	 UOKw01wyxnvrLRHZVFs3w7CRE+71J+/V7iY+djpc1DCfeDyd12MZX2g8uF14L68RL5
	 SNOJ6uyTz7226nVYIoN8lPiiEcFuUEOnruvv8cmfm1AqBeWmSJbgjRbjoRl6PWgEae
	 cYzDicgE0bMVy69q/2+UU06EHUWcZF40Lkx9IVuEfSElyxDyWTNSLUOfeKUmB1nK52
	 tFG8koXF7iafxqEXqsoG0A19JrWAvIBv6zEaj+3jKvzjk75Sy9JYXStsF+S/DISzCM
	 fQPiAfsVVo9GA==
Date: Fri, 21 Mar 2025 08:17:24 +0000
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net 2/3] net: dsa: sja1105: reject other RX filters than
 HWTSTAMP_FILTER_PTP_V2_L2_EVENT
Message-ID: <20250321081724.GN892515@horms.kernel.org>
References: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
 <20250318115716.2124395-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318115716.2124395-3-vladimir.oltean@nxp.com>

On Tue, Mar 18, 2025 at 01:57:15PM +0200, Vladimir Oltean wrote:
> This is all that we can support timestamping, so we shouldn't accept
> anything else. Also see sja1105_hwtstamp_get().
> 
> To avoid erroring out in an inconsistent state, operate on copies of
> priv->hwts_rx_en and priv->hwts_tx_en, and write them back when nothing
> else can fail anymore.
> 
> Fixes: a602afd200f5 ("net: dsa: sja1105: Expose PTP timestamping ioctls to userspace")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


