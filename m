Return-Path: <netdev+bounces-199617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878CDAE0FC2
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 00:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7C23BDDC9
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A478425EFB9;
	Thu, 19 Jun 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag+NTp99"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809742459ED
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373542; cv=none; b=WygPShXDL1RZ5xeTVqFdlm+YMHcOEsWEUc7fX/M4zhBvLOeangZn1VjopkJor6b7CwCsZEX61HgBOvna2gYVh+s5eruzFcXtF+krASWEBF+SJHoDJK/TY1UsDvnOPdT/lGlruoX01EcTJmoDzdYovtHq2Ixe8o8XRxLPh4i15Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373542; c=relaxed/simple;
	bh=Utssi7CIdfYr7DKAoHcZxfZN9D4yBNwGqArPV7G273k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNNfZU/R/FgeP/5CvlUoaO1fC8kW2P7066VYVcZqbMrmsJqBwbrDgtbsjijxmzIn8RZbtFeRktpCqPCR3wVaOM5hEGtqZoJtn1H/wgctqZ5+93N2tV4Bvq9qBbHxdbXm52KUiYJ1G36+eG5VHTemYU+apceAzrWY8xbb7oXS+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag+NTp99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D804AC4CEEA;
	Thu, 19 Jun 2025 22:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750373542;
	bh=Utssi7CIdfYr7DKAoHcZxfZN9D4yBNwGqArPV7G273k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ag+NTp996OD047ZWQnyqz127QExL83C6GYJoslLuoHkFOL7Zxvrnu/afsLoRYdheB
	 lOxWiIFejtPxoBjmVSPpoaPDihj9fR/EkmnXIZhriShYQENrsaFVZedVSWdzW8WSHZ
	 mxdZP6fOWlq4IlOi4/Z1/gH6IK/dODKYV1bqVY/nuooidmegQTUIrhAd25wLjUcA30
	 +E5doR3bBUCLbVL1nj3XAtDVCuUjcS/ESJ53dPyvRu4HrqkIZKr1mFFd+/TqDa4o1+
	 OmkDYGUgZd7klTVC2Nqrbsx77rlQbxXVmYikrz6IIgHhY2FQ7CZtkEgTUxfsT0U4+j
	 mr+hTbtrHJETQ==
Date: Thu, 19 Jun 2025 15:52:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ip6_tunnel: enable to change proto of fb
 tunnels
Message-ID: <20250619155220.3577a32a@kernel.org>
In-Reply-To: <20250617160126.1093435-1-nicolas.dichtel@6wind.com>
References: <20250617160126.1093435-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 18:01:25 +0200 Nicolas Dichtel wrote:
> +	if (dev == ip6n->fb_tnl_dev) {
> +		if (!data[IFLA_IPTUN_PROTO]) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Only protocol can be changed for fallback tunnel");
> +			return -EINVAL;
> +		}
> +
> +		ip6_tnl_netlink_parms(data, &p);
> +		ip6_tnl0_update(netdev_priv(ip6n->fb_tnl_dev), &p);
> +		return 0;

Hm, I guess its in line with old school netlink behavior where we'd
just toss unsupported attributes on the floor. But I wonder whether
it'd be better to explicitly reject other attrs?

Shouldn't be too painful with just one allowed:

	if (!data[IFLA_IPTUN_PROTO])
		goto ..

	ip6_tnl_netlink_parms(data, &p);

	data[IFLA_IPTUN_PROTO] = NULL;
	if (memchr_inv(data, 0, sizeof() * ARRAY_SIZE(ip6_tnl_policy)))
		goto ...

	ip6_tnl0_update(netdev_priv(ip6n->fb_tnl_dev), &p);

WDYT?

