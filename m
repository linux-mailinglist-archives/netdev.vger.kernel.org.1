Return-Path: <netdev+bounces-109826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A992A09B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4DF1C21000
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A2577F2F;
	Mon,  8 Jul 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgncijKj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020E3B791
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720436308; cv=none; b=qUoTwlGfooj6jlvgMotKYgzlxWkcjqq4deLat9KKqomgcYsBpPA48ap4wLpfaHiZUDFklFfvBZ06vXKdan1fYYOQTrcPWurpIiCGJw70tj4bMI1GkHo2C9AU/vvObTuFFuDOFlA7ahxYMuFVjybL6L0z1b1iHv6lY10Bhiw7kNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720436308; c=relaxed/simple;
	bh=52+bBGuD9nKCHm6QsqQ/pE/mBBSRYE/1qlckqcjpAQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvKPn9i9hpLnVDq34iRNDZxUjzZs757EOPScjkoh+B6OpF7qdZ0uHduoEJzrKX3zB1FxaQBIPLb0eZZ8MkURMFPqvUEY9tCwwTnvj5sJJO0UzT6Fd80hPvKrTu+1xT5c5AFrZ7mto8ls1v8MiMWNt9drlPLzxrQ94TlIOaIcYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgncijKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8032C116B1;
	Mon,  8 Jul 2024 10:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720436307;
	bh=52+bBGuD9nKCHm6QsqQ/pE/mBBSRYE/1qlckqcjpAQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgncijKjBI5JPhIuXuXa8pgEYbVDz+unUKAdyEVE87SgIMEboI6lGISsuvKPNWcXw
	 t5sebANZy1bMjNhwaC8JshcwbMxR5DCcdpbTx7+fn1B7C798wRPQnqtqF8jG8Z9hOr
	 l4xX5pgA2QywrHWlY71TZf3mMMZVoJPwgRk/dgF2gNum0CXz1SfymBjmyjzH+vgAF0
	 6+tr8wlnDB2DPKeshcQUiMmipSYqfwgvZ3rxsEaIS9ZgdMshGEH+Da3hah/1viWMvo
	 6lVonWATb41JGC20Mx1aajmfr3dxQ2tZ8duJx+R4b7SLD3O+/5D7DuG2ZxZ7Zn0OU+
	 UWwu4Eupx8xJg==
Date: Mon, 8 Jul 2024 11:58:23 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next V2 00/10] mlx5 misc patches 2023-07-08
Message-ID: <20240708105823.GL1481495@kernel.org>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708080025.1593555-1-tariqt@nvidia.com>

On Mon, Jul 08, 2024 at 11:00:15AM +0300, Tariq Toukan wrote:
> Hi,
> 
> This patchset contains features and small enhancements from the team to
> the mlx5 core and Eth drivers.
> 
> In patches 1-4, Dan completes the max_num_eqs logic of the SF.
> 
> Patches 5-7 by Rahul and Carolina add PTM (Precision Time Measurement)
> support to driver. PTM is a PCI extended capability introduced by
> PCI-SIG for providing an accurate read of the device clock offset
> without being impacted by asymmetric bus transfer rates.
> 
> Patches 8-10 are misc fixes and cleanups.
> 
> Series generated against:
> commit 390b14b5e9f6 ("dt-bindings: net: Define properties at top-level")
> 
> Regards,
> Tariq
> 
> V2:
> - Fixed compilation issue on !X86 archs.

Thanks, I have confirmed compilation on ARM and arm64.

...

