Return-Path: <netdev+bounces-151716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD269F0AF6
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985ED16248B
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0851DE4C5;
	Fri, 13 Dec 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm3kpjOJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B7B1D9353;
	Fri, 13 Dec 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089316; cv=none; b=WtGHJmvuQhLonOpeuBJJjshs20Hjb0IQqRh6IDvmXPawcmpbaT8+P2X/g0adtHNqK3uecX1GcDbdECjOQ8zcTQgNmcFoosa+TfO2bwSo2+6NuePHCeW4/JXbifat0nUgrMdgvZbl3jyVK5FCtWBf1uE1MeUa70i1YQ3kdpRd9kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089316; c=relaxed/simple;
	bh=eN8rZXOXDHaELFjR0t0A2r2ABEAI7iFbmY+N5Uhtm3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmnJtjGp/JOrofsLL8Uim96FFG3vSgE9vxs6CxLjUvLiVRaWzyPERr2GJoY2eTzrWN24VrfT+o/6Fg4kZQ+u4C3JiBhGMBAmAh1XPUeY7HQyNhnFTP6omWTS5BcezayITnF+X12jWK9KBEN6LejGEaFcbEUZbxi9Laj9GoKwixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm3kpjOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BCAC4CED0;
	Fri, 13 Dec 2024 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734089314;
	bh=eN8rZXOXDHaELFjR0t0A2r2ABEAI7iFbmY+N5Uhtm3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gm3kpjOJ+AcMtgcLn/y89bm8fvRCGXMc4ZpZ0oT9/JvsXICssqe8EWSzTcN2E6j2W
	 xdW9PP5xrWaqy3VQlLJ2AnEiuCU8qfs1IDliVkEFAKt3r6h40sJbxmJZOBdwZOLwhn
	 UYhZDPtqq2ge+25gwpcL0j62PfiDgNxP6d1V5BOSTvgGZtwqtyqCkghJtZ2OKnAumg
	 3RFTjE9bSPqNdRZwQtDq3wzHEtOMNkkk8eWO+ZcmrvyfGzOP2Vhcjy9WuMJAzjJzZr
	 CgQLEcsv2fLgQaCnsByXqQaYpeeVotb5qzXZs31Ee/KdYEi3K4eX3QP0s25N6f40l+
	 WcM6Nm4Yt+hHQ==
Date: Fri, 13 Dec 2024 11:28:29 +0000
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1] net: stmmac: Drop redundant dwxgmac_tc_ops
 variable
Message-ID: <20241213112829.GN2110@kernel.org>
References: <20241212033325.282817-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212033325.282817-1-0x1207@gmail.com>

On Thu, Dec 12, 2024 at 11:33:25AM +0800, Furong Xu wrote:
> dwmac510_tc_ops and dwxgmac_tc_ops are completely identical,
> keep dwmac510_tc_ops to provide better backward compatibility.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


