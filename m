Return-Path: <netdev+bounces-226662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D17EBA3BB0
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6135A625168
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4892ED846;
	Fri, 26 Sep 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWVOWVGy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD51EEE6;
	Fri, 26 Sep 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891524; cv=none; b=elG1MqJYjBXHbtNrO4bJCZj0l4eYN3bZfHutte/ht+yaz3YnX9MdQZmS7JzJLG7LimFtkuL5tWAJPejF6kKqo/hUMIqFaUl4Qn/Ezv9IwBaD68Ul2ndanqwibBCAsM9IGbIiF8qb6htAHl7zNvNNrx3cZzOnDpRjSAyRkEhqFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891524; c=relaxed/simple;
	bh=Ri6ZmMwR7TCJunHo84034C8BgXqTNyOKZdVGuU1M9ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIqymJsQLSR3yFxQfwO9G5Hy6BGPUWNNZl/5mfYT3bginzn8UojHgLYRmMIgIjHug+BVUWtZlDl2Zr3SMqfoFSuWGMBHTMHBMbg5/R7AB+CFZdfKV3+nbiDI+AKx3UsUnRLa4IgL1mggOISR7uYCWgK80r6iCEytILgKywQt/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWVOWVGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD420C4CEF7;
	Fri, 26 Sep 2025 12:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891524;
	bh=Ri6ZmMwR7TCJunHo84034C8BgXqTNyOKZdVGuU1M9ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWVOWVGyi+twdkcoge3kAEj+dQaCpVTiRtw840KCtDs3c/rz0RCLk3dO8TkpscjZn
	 ic8DhBbeS1DcjpiQzB1Cqys1Onev5TxrLBH9ygPN8WzCQa8SgroTER/GWv9e1x9q+0
	 v0Kak4paEaFEws4HwHRwJaxPKB4H80F5LGxBmYcRsPkpjTmAhUz1HMa5Yq4Qq92W8J
	 LvdoKFDbuhu08y2MSDckudYdoBKzpD8er1VXKjaiGdf4U/Eud1KN6H/TU4Id+CJd+K
	 SaahclxiMeE4tU0pWHHHzNPtxpQx/a7hdwDF1ovhbHZ7w+P1TEqYc0ep8a+SAFrzaM
	 EViIE+jLlRgUQ==
Date: Fri, 26 Sep 2025 13:58:39 +0100
From: Simon Horman <horms@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org, sburla@marvell.com, vburru@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, hgani@marvell.com,
	andrew@lunn.ch, srasheed@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [net-next PATCH v2 2/2] octeon_ep_vf: Add support to retrieve
 hardware channel information
Message-ID: <aNaN_4LfjdJWApKy@horms.kernel.org>
References: <20250925125134.22421-1-sedara@marvell.com>
 <20250925125134.22421-3-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925125134.22421-3-sedara@marvell.com>

On Thu, Sep 25, 2025 at 05:51:34AM -0700, Sathesh B Edara wrote:
> This patch introduces support for retrieving hardware channel
> configuration through the ethtool interface.
> 
> Signed-off-by: Sathesh B Edara <sedara@marvell.com>
> ---
> Find V1 here:
> https://lore.kernel.org/netdev/20250923094120.13133-3-sedara@marvell.com/
> 
> V2:
> - Corrected channel counts to combined.

Reviewed-by: Simon Horman <horms@kernel.org>


