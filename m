Return-Path: <netdev+bounces-226024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E9FB9AEC4
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0803AD3E1
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E808F313E0A;
	Wed, 24 Sep 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ4YvxSS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0624312827;
	Wed, 24 Sep 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732813; cv=none; b=qToulnOXbwmzGPpOmfefyCdM5mBD2aEi6HzHkk/sI1mLNvUeEvUorqVW3QVE2HCK23yisoAOQvfXop/EDukf6DXNOuDaGb+lGGgkVK/RIiLxIp2EOuI6aXWRcNklGLsEka9mYyuFgQ0ResIXpTf/RN9sWKvgmkHvsvs4VXUV+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732813; c=relaxed/simple;
	bh=wfAcjh4nNROArfhXdLrl3ZX9bussCymWA6kJCmoKSgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOio9q6H4yZfdFSixDR5WRj6gu01Ljusah58DBbvZvqf5tBFItlRM5WsmuwTTwdistBGBKvTDCcuZ4GQqSdjjSI2XXfRqYYoBWo0b8Nj9YKlthGzCc8zfHabXlz1yK6GvWsaf7mmSA/G8M6txRpiXMNuDStHvMcT+tcPyL2I44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ4YvxSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE7DC4CEE7;
	Wed, 24 Sep 2025 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758732813;
	bh=wfAcjh4nNROArfhXdLrl3ZX9bussCymWA6kJCmoKSgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJ4YvxSS8H7eMfM8PahFK1WqjyNxpalU/yFgbinycvfAbx4t9G9wSJUEtQRgQrmd+
	 9xJlhyP6cYtm9mwTOjNU2oAP6e+yFI+6kPVBf/cj2/Sxr2W3Rh8v7q2ihHrl6qnWXy
	 J+0RFfrU/U0dVerzUmzTYuoDAUjlsGF/euPRl+oMfdAVAEi5GrZlj318kp3qX2CH+r
	 3thSomhc/yP3wNNmWPgPQ6/tDJ+bWCjwZTWklmL/YIR751205LnpNKKzTaWsSAUMNi
	 Jj+3bMKh32pUunjnNZyh6PrZgrbj8CXrqPGcsxfE1697pUGCnMbSE89zLOQzfvT8Kv
	 jx9umyKC+tBNw==
Date: Wed, 24 Sep 2025 17:53:28 +0100
From: Simon Horman <horms@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org, sburla@marvell.com, vburru@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, hgani@marvell.com,
	andrew@lunn.ch, srasheed@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [net-next PATCH v1 2/2 RESEND] octeon_ep_vf: Add support to
 retrieve hardware channel information
Message-ID: <20250924165328.GP836419@horms.kernel.org>
References: <20250923094120.13133-1-sedara@marvell.com>
 <20250923094120.13133-3-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923094120.13133-3-sedara@marvell.com>

On Tue, Sep 23, 2025 at 02:41:19AM -0700, Sathesh B Edara wrote:
> This patch introduces support for retrieving hardware channel
> configuration through the ethtool interface.
> 
> Signed-off-by: Sathesh B Edara <sedara@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


