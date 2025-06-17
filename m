Return-Path: <netdev+bounces-198538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A2ADC988
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772BB3B3DD3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2FC2DBF6D;
	Tue, 17 Jun 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD8UDqn0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A72DBF62
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750160248; cv=none; b=byxBdpCxtW96e9faSMitmUXkZsDgsf+dI0xf1eO8WaFsnJ0A+Q893lkaLt/VOsmaLW4eu+FY3lAQOgSYJvg/zjEepWOwf+Taazamt4pLC6DzgD3qmWdE5GCW1NHWpMAp0j5sN/L/nXDmaBf/nxqS//OwfWBt85hPyV2Pt1onDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750160248; c=relaxed/simple;
	bh=8RJFIUC2tMx9nt+R9N0Jk3jWquCSa9yujdQPU32gLYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoQDicOaOhxV85A57gnTmjGTgjnHBCrSRdSeWq9fIIE+7XEctGJlOl4UOYdg/P5sKhcjJkdzaRO7cnDoLQTnHnOHAjpWnieWETIhNxlPIy7kG3adU+ui6wt+A/JQBkHIMstI8mJ7JIcauu4hBt7UhwvBT8GHxAa0yghpUEl47WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD8UDqn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2C4C4CEE3;
	Tue, 17 Jun 2025 11:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750160248;
	bh=8RJFIUC2tMx9nt+R9N0Jk3jWquCSa9yujdQPU32gLYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XD8UDqn06QgYiIRI3S4oiSt3f/Mb8DENQ6Ht5XncmINVpCm429NhJiy1goYwbbRUL
	 Q/aLIaLPgO2A8mvIuCwCGXWBA79W8CTZIfG5nAtA0APCn9cOmDl2SmHr/k6JRHVgPK
	 F/MPtZOVO2cliKub5XQJ/aNJqn8hUsDRrOjMzSCgpzuXN/0zFl+MagztohwYW5rHDh
	 oTCHsyA+ZBzGn/PFjBol8+RATPtutNQTf+iHqqjABfkYJffHIFKPt0DtSbYUG5XO36
	 8N1aV7lby2rihGxBXvMvVCsHW99cRGRtuCT5WtgOgaojMgx2odISX4rdrSPCTtYUL6
	 8tufMQ/AelaSQ==
Date: Tue, 17 Jun 2025 12:37:24 +0100
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next v1] net/mlx4e: Don't redefine IB_MTU_XXX enum
Message-ID: <20250617113724.GJ5000@horms.kernel.org>
References: <382c91ee506e7f1f3c1801957df6b28963484b7d.1750147222.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382c91ee506e7f1f3c1801957df6b28963484b7d.1750147222.git.leon@kernel.org>

On Tue, Jun 17, 2025 at 11:06:30AM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Rely on existing IB_MTU_XXX definitions which exist in ib_verbs.h.
> 
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v1:
>  * Change target from net to be net-next
>  * Rewrote commit message
>  * Removed Fixes line
> v0: https://lore.kernel.org/all/aca9b2c482b4bea91e3750b15b2b00a33ee0265a.1750062150.git.leon@kernel.org

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


