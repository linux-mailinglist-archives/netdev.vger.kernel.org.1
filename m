Return-Path: <netdev+bounces-70164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DFA84DE4F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2879285524
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B866DD07;
	Thu,  8 Feb 2024 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1liQjQe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53A6BFC2
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388172; cv=none; b=Ct6wiV0QWaoU/cB4PZyY2TXPL/93SGRIDFzWv3zgb+AJVon9ALLtdAn/RYAibKEbwj4WRbkNZEKWjP8rA7WftgRuGENwxND78erAsVHpq1/ocQqCXlz2kOVBsLSE5rlilwl2ZS7svw8XokPhJrLCaRTtwziQZ/5UWxXLknxqVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388172; c=relaxed/simple;
	bh=jxjZgXb3IrQHtgbs6zcMhpISlFS/CPJ4UYEsUZVJJcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVt58lEDPt0m5dFAbX54NOZCW+7jH8WjROVFhf5Ge99X5XzPFvxgkZj8EmnxWugVwgyeUohwd3s2IBlNAxLExBTrQHhXPfm93iUYp4OqPTmry4nbWit72SMgwASpzAnxod7HxWuBb8gGjTwzH/tI2lS761HLZdU3iwDiaIobN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1liQjQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35EBC433C7;
	Thu,  8 Feb 2024 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707388171;
	bh=jxjZgXb3IrQHtgbs6zcMhpISlFS/CPJ4UYEsUZVJJcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1liQjQeHGLtoPMjPeNHroxCmM83KozB7ygz2sZgjn0LGOvTOyOKztlQ0nrmZ9lwo
	 SrHKXkXyiY4Uv8Kau5bKGq2GA9o6dDNi7cbm+8RVWntbdEsNG6Hm4XNP9WLLwlDmA3
	 1aFvI/2TcrPcvQTJQ4o/ngFJ33Z0vFwklj2RS0vhF8QI860LPuXWOcubf6uxgXsMtk
	 3wvetd4OOWmgL64Q8TgXkpqu7/98JVLf92FTcLZH1ArTgp+aJ8ezMMQAft0pQXP7Sq
	 FoNXbg4iQLF1ZfIvJjm8Mkn4V+wkaG3kE+WS5cHqAPeRemgWmIAvxhpynSkQbSWXko
	 qdYKzH8QpYOgg==
Date: Thu, 8 Feb 2024 10:29:27 +0000
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 1/2] net: dsa: remove "inline" from
 dsa_user_netpoll_send_skb()
Message-ID: <20240208102927.GD1435458@kernel.org>
References: <20240206112927.4134375-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206112927.4134375-1-vladimir.oltean@nxp.com>

On Tue, Feb 06, 2024 at 01:29:26PM +0200, Vladimir Oltean wrote:
> The convention is to not use "inline" functions in C files, and let the
> compiler decide whether to inline or not.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


