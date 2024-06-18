Return-Path: <netdev+bounces-104420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE16090C740
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F4AB24A07
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21911AF680;
	Tue, 18 Jun 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8nh1Toq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCE1AED5C;
	Tue, 18 Jun 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699924; cv=none; b=ZnvMuLLZVwgw73pWY+XHkHntTge441Me91UTYpGb+pi9WOj8G6kbZmL5Xzf+gOPP1gV3872c4q+Ymc2hUMo17XkbKq+58L31WXdRzPDlDCbHEaskez5fR2XOZQpfrx3NK7TUMW54YE/gyZxXKxvDm7inetg4kCp6CSS/V8dEvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699924; c=relaxed/simple;
	bh=lhKn/iZcd+W6zpv9cuUEp7iHIwGV3stG6432eKxVRKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbmPBISgK6tDL6Kg3GefsH6O/1okkVfWlS0n1URElQO6kfr+l3Ok9+paYDL7tGOnjy6lNe8eQsLOm1ohvAccp8i2GVvaMl2ezwWEPnaM4oYfwsjmCm4Oq4xvck23iqiQXab2gZfVmQ1Uc1y+KA1/kYzRhDEwJsEfmVkU39JcHfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8nh1Toq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F439C3277B;
	Tue, 18 Jun 2024 08:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718699924;
	bh=lhKn/iZcd+W6zpv9cuUEp7iHIwGV3stG6432eKxVRKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8nh1ToqCAzLq0p+OLEM+9UGuEGu9/8SYhHz/FOiimJHoQWTjlvubZx5uzanlNlWM
	 M1Y9Ppv7KjB/EsOIv/7ATTV0xQnwkKiL1Vo+4J2AlzQqbJihcgLMA3YXN5/E5J1rhb
	 yKvpZWCIDtp1xBjeoFXV5Jreji8UfGUj0a0zOdAyZZWJD7Xz21+hXu4OrC3HwUh45Y
	 ql+zZ0j92G7y1fcgF+t6a7kRuxAQGYxARpG9o6aqr+rGp9RGx0NtPsJU3wGS8NMp04
	 bnRwv9g78xzwv4EBRweP/tXdXzoi4rqTcONxavuMia55nnPukX3sMTxSXm8UCWWs6t
	 zLBnclV47dplw==
Date: Tue, 18 Jun 2024 09:38:39 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v5 05/10] octeontx2-af: Add packet path between
 representor and VF
Message-ID: <20240618083839.GE8447@kernel.org>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-6-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611162213.22213-6-gakula@marvell.com>

On Tue, Jun 11, 2024 at 09:52:08PM +0530, Geetha sowjanya wrote:
> Current HW, do not support in-built switch which will forward pkts
> between representee and representor. When representor is put under
> a bridge and pkts needs to be sent to representee, then pkts from
> representor are sent on a HW internal loopback channel, which again
> will be punted to ingress pkt parser. Now the rules that this patch
> installs are the MCAM filters/rules which will match against these
> pkts and forward them to representee.
> The rules that this patch installs are for basic
> representor <=> representee path similar to Tun/TAP between VM and
> Host.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c

...

> +void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
> +{
> +	struct rvu_switch *rswitch = &rvu->rswitch;
> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	u32 max = rswitch->used_entries;
> +	int blkaddr;
> +	u16 entry;
> +
> +	if (!rswitch->used_entries)
> +		return;
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +
> +	if (blkaddr < 0)
> +		return;
> +
> +	rvu_switch_enable_lbk_link(rvu, pcifunc, ena);
> +	mutex_lock(&mcam->lock);
> +	for (entry = 0; entry < max; entry++) {
> +		if (rswitch->entry2pcifunc[entry] == pcifunc)
> +			npc_enable_mcam_entry(rvu, mcam, blkaddr, entry, ena);
> +	}
> +	mutex_unlock(&mcam->lock);
> +}
> +
> +int rvu_rep_pf_init(struct rvu *rvu)
> +{
> +	u16 pcifunc = rvu->rep_pcifunc;
> +	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);

nit: It would be nice to maintain reverse xmas tree order - longest line to
     shortest - for local variable declarations in this file.

     Here, I think that could be (completely untested!):

	u16 pcifunc = rvu->rep_pcifunc;
	struct rvu_pfvf *pfvf;

	pfvf = rvu_get_pfvf(rvu, pcifunc);

     Edward Cree's tool is useful here:
     https://github.com/ecree-solarflare/xmastree

> +
> +	set_bit(NIXLF_INITIALIZED, &pfvf->flags);
> +	rvu_switch_enable_lbk_link(rvu, pcifunc, true);
> +	rvu_rep_rx_vlan_cfg(rvu, pcifunc);
> +	return 0;
> +}

...

