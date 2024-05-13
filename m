Return-Path: <netdev+bounces-95927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03888C3DAF
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013D01C2110F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0CD148319;
	Mon, 13 May 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8ZBoFkX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232D148311
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590801; cv=none; b=DA+QY+m4S62sRQaGtxgXIehlyDN1MdSjk15lC3+OLiG5qWol2SK6yg05CdvvV0ncTH1LPq1+sZQnSTGdA9f9NooXQZ77iYS8gea2WweOkuw1hZkqhoMwLSEdHQrBZCg8sk7o1C1DD6FpDzCuIR0U8JkTumQUHlnSJqaui9BtMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590801; c=relaxed/simple;
	bh=BrQCzBdbcfstOuGZalF/3Vv3WS/SCJv3GjN4GeyAJfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpJq1sH3k4RRokMA3/vXOHmo0NqOBGfjmNaCbhXPv4/6IYi2Pl6+8TJvCYPrQZ538rR1+egDSnrl+FfKnz7XaM0oO8EE6pR+SgT5PI64bPBWy9aS313TDIESFao0Pn8ExWY2ejroZ4TBLXtLt8g6aR3D9F8qiUzPx5w6EgtU88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8ZBoFkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A08C113CC;
	Mon, 13 May 2024 08:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715590800;
	bh=BrQCzBdbcfstOuGZalF/3Vv3WS/SCJv3GjN4GeyAJfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8ZBoFkXynmDc6ldT2kqiYpJ1rWmXVhOxGUZtsDb2TfWotu0Gq0sOtGPPp6EkhgJI
	 19U0NfA5b+JWtqnVhg7Py3RcUG+Ujv6onyiEp0oXtJE8bXa4gQ0BOpo3MqdAKBgz3H
	 St8ceLK3aABgVmClfoB3lJu+DI74l1L7Z852EtPudjPqup/eut6ne1FV0t0Qy3DsiX
	 MXT6W3XEmrzRKbg+IH3XZPqlPsX+w9Kw9qlAh0pUD8cjNOyHl8xbCqn7evQnkbeZGz
	 aW0MF+GnAsluNTjJa/Amc5DltiQG5Wcj7B6EpvyeNbYVfWL5F87Qo5XYtebnOsoep+
	 7amlzmAG/1/Xg==
Date: Mon, 13 May 2024 09:59:56 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5: Remove unused msix related
 exported APIs
Message-ID: <20240513085956.GD2787@kernel.org>
References: <20240512124306.740898-1-tariqt@nvidia.com>
 <20240512124306.740898-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512124306.740898-4-tariqt@nvidia.com>

On Sun, May 12, 2024 at 03:43:05PM +0300, Tariq Toukan wrote:
> From: Parav Pandit <parav@nvidia.com>
> 
> MSIX irq allocation and free APIs are no longer
> in use. Hence, remove the dead code.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


