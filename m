Return-Path: <netdev+bounces-178741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24055A78A44
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2711651E6
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C642356A7;
	Wed,  2 Apr 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOtnba23"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED3231A57
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743583479; cv=none; b=uRs1eMz18QNv5lzyppNc4TJHsHL1XN+wLR1YWcxaxrfxShSTGuD7txKbLOqutRlGBI36s7A4EGvzMUCaMi8zZFd8V6coR3znI6ipvz48LdTBVV/z0llL25F+pU5vgQ8QBIoYU8Xhs+lqtXoemgjgEYjZLOOaLbaB+VZ84r5ZLxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743583479; c=relaxed/simple;
	bh=KvDqUYfEbkG7FBvQEjTcdGDOcKrbTsyRE+m9Ramdl2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2IC5LhpqJYTcdpavW9X/ZLXA48xGz+ZDARae+aPwAXC5YP5A8gUSTjX/yTGQ/+RPNDQ23nfWMvBqu2+JdLwcEO9eQr0gqQfes/UaFBEPMNeVoYjGIH9lMLcpxEtBtOgULEIaBitu6HyNn2QPwgAzpGDe00FTdlXYz9lAKvPYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOtnba23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1C9C4CEDD;
	Wed,  2 Apr 2025 08:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743583478;
	bh=KvDqUYfEbkG7FBvQEjTcdGDOcKrbTsyRE+m9Ramdl2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOtnba23t4jsv3gl0G1rGOpljk1PeH+8nMsDmQzjPdAQlc6ikStG9ElTQjd7qN73F
	 Y12+nMS1HhO9bQeWY2wimb4f5f4kFaLdGq2FL+bg+KdjaqZv7c8kkqkazTcPwkcnhg
	 G5LDXsy721Cc5oGfnzEI89Zx06+IdsWVET6M+nxuPsJfrbWgDTD8L7CDkXHthiKKej
	 CzQp7YiIhNcVXS8/QQBxNWdHbF18zFIcu2+ztrqBGEGJsSxaDWuUjrmPwblg3BVrrm
	 g8WbKkIOrRzCOotrxYXmM171W1WuvtpdgrjCrzFXgMU0eEIiiKzC3F90MOgmLmHuXm
	 v7HTPsyyaNlww==
Date: Wed, 2 Apr 2025 09:44:34 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v4] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Message-ID: <20250402084434.GF214849@horms.kernel.org>
References: <20250401-airoha-validate-egress-gdm-port-v4-1-c7315d33ce10@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-airoha-validate-egress-gdm-port-v4-1-c7315d33ce10@kernel.org>

On Tue, Apr 01, 2025 at 11:42:30AM +0200, Lorenzo Bianconi wrote:
> Dev pointer in airoha_ppe_foe_entry_prepare routine is not strictly
> a device allocated by airoha_eth driver since it is an egress device
> and the flowtable can contain even wlan, pppoe or vlan devices. E.g:
> 
> flowtable ft {
>         hook ingress priority filter
>         devices = { eth1, lan1, lan2, lan3, lan4, wlan0 }
>         flags offload                               ^
>                                                     |
>                      "not allocated by airoha_eth" --
> }
> 
> In this case airoha_get_dsa_port() will just return the original device
> pointer and we can't assume netdev priv pointer points to an
> airoha_gdm_port struct.
> Fix the issue validating egress gdm port in airoha_ppe_foe_entry_prepare
> routine before accessing net_device priv pointer.
> 
> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v4:
> - Return bool in airoha_is_valid_gdm_port() instead of int
> - Link to v3: https://lore.kernel.org/r/20250331-airoha-validate-egress-gdm-port-v3-1-c14e6ba9733a@kernel.org

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

