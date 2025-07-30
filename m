Return-Path: <netdev+bounces-210915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4452B1570B
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 03:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A3718A6AC1
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 01:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7F384D13;
	Wed, 30 Jul 2025 01:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeHkGuqt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6E2E36E0
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 01:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840109; cv=none; b=Nr7AfIOkRS7WY2P6BBmSw/qMcptQsMb3IzWyiA+jz150r2vbhE40yxuQ1ZIlnsLuLddxfozQdAYXueYaVKuoQn3b2tTnjcG31kYWBAG/jhCKC2Ii3MNOWy+rwJAQEXlNObg5zvgGrQFuvUKsA9GNALn2B5VO+EaBKUXFabNaxjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840109; c=relaxed/simple;
	bh=R0O1R8cXydICqqdNBVk/rdRcDMNGqh6mqZTpCe+SkWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htSDSv23eetfMdSaNIWJY032gTP5hegs0EJy8b/t5JzfVYiqcE/5eKnvjveKVMV/2rKTm8WlKpbTWdGRMaNGHCnjXkS84jNEaf5iK6fpIXFrcPOFQgOKu9D+jdlx1Bh3EXNfd5c9PgiBzu4hNn3by2o15vt72EAonj9x3LeTZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeHkGuqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F907C4CEEF;
	Wed, 30 Jul 2025 01:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753840108;
	bh=R0O1R8cXydICqqdNBVk/rdRcDMNGqh6mqZTpCe+SkWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EeHkGuqt0wXx73Xwn/fXbNw4MqsMslS6tgKrDxEs27yY6Zrk2RF+eQBVu3+bM8HQY
	 wQ8/EmteZVCAAn2EJTkitHbLjzVJyxo1iackP/xFnG4vNg7FhuCTc8olcyNj0kvevC
	 toyeXgp4L9EP+ApucBucTp6taVLLFq4f3l/uoPOyvOWRtlWXVsCHC3tGlxru0vspPM
	 32xiQlW/vN4/ztBXlMVEKAXxxKXvw65LPCLGlB+nY9SdAg5SPaffL/ueT6QVLyTZ6Y
	 Tb3NQj17JpO+tNCQI2SdL+EC4NUFPHo7owRi6459CKdakRxCrxI29b8Zz3hWbyu0Qy
	 ZifnF6kpXHCaQ==
Date: Tue, 29 Jul 2025 18:48:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, <intel-wired-lan@lists.osuosl.org>, Donald
 Hunter <donald.hunter@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
Message-ID: <20250729184827.039406f3@kernel.org>
In-Reply-To: <20250729102354.771859-1-vadfed@meta.com>
References: <20250729102354.771859-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 03:23:54 -0700 Vadim Fedorenko wrote:
>  /**
>   * struct ethtool_fec_stats - statistics for IEEE 802.3 FEC
> @@ -524,6 +535,7 @@ struct ethtool_fec_stats {
>  		u64 total;
>  		u64 lanes[ETHTOOL_MAX_LANES];
>  	} corrected_blocks, uncorrectable_blocks, corrected_bits;
> +	u64 hist[ETHTOOL_FEC_HIST_MAX];
>  };

Some devices may want these per lane, let's make sure uAPI supports it.

