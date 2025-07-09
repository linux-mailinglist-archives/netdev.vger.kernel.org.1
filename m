Return-Path: <netdev+bounces-205314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF5DAFE2D5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7B14E15FB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100E027D779;
	Wed,  9 Jul 2025 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9hEsX5p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34527CCCD
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050259; cv=none; b=cX0dXuyo1dftDddBAjH8RbUVvGYLUa0paDMZlFVDM1YY+YVCTgMss7MU6drXkU8u6CmEBnhoO6C5+ABU4u0BCwT3RFIPdWGMUgrOWS1UELhCU/8f9f18mX9IkfQA8J2zysbscB5pGk/lWT0MuluQz/92/in3KPCVp15+MsSoaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050259; c=relaxed/simple;
	bh=e1GBLsGZ9h0aNlmrFMnBDGEbO2JqvRESaTIALANX5qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+D/CLHPVlOxFACTnomlFUzDKiOk5sVX/B+N2QWAzh202qn219IktYAWVQrqmlrY00CrHXJveb803nu46xtZ5VGq/sBZkulLXjeLcN7g+H1fVawSo762OME0RvqG+LqAgF8m7+V9XF14xJu1vmtI/PXmv9w0r74dVS5ffU70UrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9hEsX5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F100BC4CEEF;
	Wed,  9 Jul 2025 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050259;
	bh=e1GBLsGZ9h0aNlmrFMnBDGEbO2JqvRESaTIALANX5qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9hEsX5pe4Rkg4GZvm2RNKJxXvkUWEZdeEiRb6IwkBVarYGX1o5MEgsSLRt8Nj6G/
	 UMaJHarGZ8nfSXjcoTgbF/bnNpinyA9gHkTu0wnjaLTnv+9NL7/inq238mwHhFhMf+
	 /TuCtslllJAhqkqVY3riugd7BAzDeKjYdHLLnlKIsZqCco05EVRwfU7eS00Kvey+5J
	 iAq6WqS5FRZZ0kJcZh7rvJ2AZ0YxuoFcreIE15kAwDUovplU3cuMXDAS6Ho7cCGTQu
	 8Rkldn+AUHAn6AqrHDmQRbTt2OnFhUuh7N0dZWPtTOwycXJq0IOy1svFHvTPlRGQC+
	 BcGnReyfYRZiw==
Date: Wed, 9 Jul 2025 09:37:34 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Kamal Heib <kheib@redhat.com>
Subject: Re: [PATCH net-next V6 03/13] net/mlx5: Implement devlink
 enable_sriov parameter
Message-ID: <20250709083734.GE452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-4-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-4-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:45PM -0700, Saeed Mahameed wrote:
> From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> 
> Example usage:
>   devlink dev param set pci/0000:01:00.0 name enable_sriov value {true, false} cmode permanent
>   devlink dev reload pci/0000:01:00.0 action fw_activate
>   echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
>   echo 1 >/sys/bus/pci/rescan
>   grep ^ /sys/bus/pci/devices/0000:01:00.0/sriov_*
> 
> Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Tested-by: Kamal Heib <kheib@redhat.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


