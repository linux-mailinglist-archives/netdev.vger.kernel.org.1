Return-Path: <netdev+bounces-232609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C25EC0719D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7334A1B81397
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E258322C99;
	Fri, 24 Oct 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C25tWL8s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A75289340;
	Fri, 24 Oct 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321159; cv=none; b=NkACyqA7VvJ7C/6Rmwg+NUMO5Mzdn8K2yWSeQLdOqQHZXDR2zUaOq//UGIc9ByM6yPl2W04KxxDi3tv29ZZZzEi5S15xZG9NwvP6gu0+JOhbLKDrEOg3cFEIbzK9AUTC2hcK1PaJy9hO8B3WF2pQK7a3DwZrfvW6wxPLDhdusOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321159; c=relaxed/simple;
	bh=EasIsdul3hK96kw5dNYavpFbf3KHAIl4PmdqMLK95ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9OBGHjqVY4t2iZi9sSd5CMtp+eM7DLs2GM/MA1/F3g95uzCBiDd3QbjVFSyQE/KGV/cuzbnTtJO5POyT2swus2mJ0IAn0joCpfTAqF2eA0A2I+E6bY9y6DSTBcDM6Z8RmBco25tSQL6uC84Gl+laKGlvOOQ7wWZQxX17tYorwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C25tWL8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F452C4CEF1;
	Fri, 24 Oct 2025 15:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761321159;
	bh=EasIsdul3hK96kw5dNYavpFbf3KHAIl4PmdqMLK95ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C25tWL8sCyev2m35cwgb29ICIPC0wAOzANasXYJ+hjODalwKx7j41LrjNt+C0Cv2l
	 PNRffrFVJwBF28ZC13nyjCZZ71a7AnbPb1Jj61E3l6EoBvjcnQHDdJkXqSNzb5lrg5
	 iCvV5Md/gEw1tyccJv4ntR8xBeWQemm5v+vszbVCQNJ7Lqn1ob/wQ1h6H8VXrlJGBM
	 6Fg2ZCyPmpNUjj0MTKzbh+Q07mQsGLoQyJe3brwvhUB8rSokUU860yzW/OLvYT8RVX
	 H5IAIglX3pPTTX1WglzfZWZt815tsdlcI2A+d6LxZYZh5x6y0wpkF8p7vYZglJd+1S
	 2jd7jUcmFYv/Q==
Date: Fri, 24 Oct 2025 16:52:34 +0100
From: Simon Horman <horms@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: yt921x: Add STP/MST support
Message-ID: <aPugwiMrKqlDW4c1@horms.kernel.org>
References: <20251024033237.1336249-1-mmyangfl@gmail.com>
 <20251024033237.1336249-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024033237.1336249-2-mmyangfl@gmail.com>

On Fri, Oct 24, 2025 at 11:32:27AM +0800, David Yang wrote:

...

> +static int
> +yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
> +			 const struct switchdev_vlan_msti *msti)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	u64 mask64;
> +	u64 ctrl64;
> +	int res;
> +
> +	if (!msti->vid)
> +		return -EINVAL;
> +	if (msti->msti <= 0 || msti->msti >= YT921X_MSTI_NUM)
> +		return -EINVAL;
> +
> +	mask64 = YT921X_VLAN_CTRL_STP_ID_M;

Hi David,

YT921X_VLAN_CTRL_STP_ID_M is defined as follows in yt931x.h

#define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)

This creates an unsigned long mask. However, on 32bit systems,
unsigned long is only 32 bits wide. So this will result in
a build error on such systems.

In order to avoid this I think the declaration of YT921X_VLAN_CTRL_STP_ID_M
should be updated to use GENMASK_ULL. This is also likely true
for other, as yet unused, #defines in yt931x.h.


> +	ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(msti->vid),
> +				       mask64, ctrl64);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}

...

-- 
pw-bot: changes-requested

