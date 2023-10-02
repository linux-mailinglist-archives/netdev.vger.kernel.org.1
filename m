Return-Path: <netdev+bounces-37364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D27B4FF7
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7EE6F281784
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B0D53F;
	Mon,  2 Oct 2023 10:16:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63EEAC5
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5421FC433C8;
	Mon,  2 Oct 2023 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696241784;
	bh=Zp1fUQdvvDOBn2zC04x0dm4q+E+VpLrN7Vzr5lIB0F4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Midz3GQE/+bTWncFNRiewuFy1y+nRs0kSgUdvSA4XWlS/09Qu45v/gb1i005N0cPh
	 rXwF7Oe0TnNvp4jLr8oo+MjsOOoPCqhzbj/OJ4y9/2murYaOOD8NoOqcRMgQEAZmmU
	 xvUBTl0MUGrtgu5mplBZPpk+DaQibzza4hCFSr7bFLrrAtjR22ByCCERGPb4DxLUvI
	 YkPB89+gv64FHQOCiDoMROyDqUONytht3mmvA2saKayiCGqbO+fpcHvHjaP9yvMBG4
	 3084LKsoDEDxdHDv+6XOWtsCztDia7huFEYcCEmS/MCOVOILzwJHSlFAcPfWRZ2CdC
	 03auPIhXKKWqg==
From: Leon Romanovsky <leon@kernel.org>
To: eperezma@redhat.com, gal@nvidia.com,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
Subject: Re: (subset) [PATCH vhost v2 00/16] vdpa: Add support for vq
 descriptor mappings
Message-Id: <169624178143.78680.3290011186914893676.b4-ty@kernel.org>
Date: Mon, 02 Oct 2023 13:16:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Thu, 28 Sep 2023 19:45:11 +0300, Dragos Tatulea wrote:
> This patch series adds support for vq descriptor table mappings which
> are used to improve vdpa live migration downtime. The improvement comes
> from using smaller mappings which take less time to create and destroy
> in hw.
> 
> The first part adds the vdpa core changes from Si-Wei [0].
> 
> [...]

Applied, thanks!

[01/16] vdpa/mlx5: Expose descriptor group mkey hw capability
        https://git.kernel.org/rdma/rdma/c/d424348b060d87

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

