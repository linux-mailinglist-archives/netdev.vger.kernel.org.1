Return-Path: <netdev+bounces-40742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 861897C891B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1872F282BCD
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6821BDED;
	Fri, 13 Oct 2023 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbhGZ/jM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE121BDEA
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668FDC433C8;
	Fri, 13 Oct 2023 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697212184;
	bh=rL5Fm1PuaW8VrEFnpvxPh1+LUIYB9ldBEMINcVZ90yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EbhGZ/jMIp/K3p6Ir5ISnKZ5s+LJvSaOIFL2iIvuk3dhLrIW4EurbsZG10SNH/hw0
	 EV/I1P0vVvP2gn4KwxY8xr6GxSQooVciFLa/FelH+Yqn8zAMxcF/uTERVoix4szTeu
	 BQ/mbnq1UJVRBPbUrdjPItWplu1R3l0Nbm4Id5rI2bZrRNgTz815WWC7VBMQIvbwO/
	 tDcbmSRqT3+hwMllZ134tx8vE1JdjQBiz6CQL0qcHBP1d9w4aqvRdwmC4db/01c3vn
	 NiRs4PwUjy+Hp5ZkzKywuuUnwM0PBW8Nl8/pqReM1Z/Yxib57HxgrOgfIkStKYxwHn
	 ali4KPt0+Nscg==
Date: Fri, 13 Oct 2023 08:49:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com
Subject: Re: [PATCH v16 00/20] nvme-tcp receive offloads
Message-ID: <20231013084942.4ddc2b90@kernel.org>
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Sep 2023 15:09:34 +0000 Aurelien Aptel wrote:
> The next iteration of our nvme-tcp receive offload series.
> This submission was rebased on top of net-next.
> 
> Previous submission (v15):
> https://lore.kernel.org/netdev/d761c2de-fea3-cbd0-ced8-cee91a670552@grimberg.me/T/
> 
> The changes are also available through git:
> Repo: https://github.com/aaptel/linux.git branch nvme-rx-offload-v16
> Web: https://github.com/aaptel/linux/tree/nvme-rx-offload-v16
> 
> The NVMe-TCP offload was presented in netdev 0x16 (video available):
> - https://netdevconf.info/0x16/session.html?NVMeTCP-Offload-%E2%80%93-Implementation-and-Performance-Gains
> - https://youtu.be/W74TR-SNgi4

FTR you need an explicit Ack from Eric on the TCP and skb parts.

