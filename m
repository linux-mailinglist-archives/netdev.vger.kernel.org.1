Return-Path: <netdev+bounces-30190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A343786504
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 04:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387E12813D0
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEA017D0;
	Thu, 24 Aug 2023 02:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCE7F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80A4C433C7;
	Thu, 24 Aug 2023 02:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692842547;
	bh=+Z/Rk23XOaIsbchFZPked/PQ2R+6guYd7Mbfpmk4g3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f6DEGgjRetnBO6vyBltoJoIIJJijcXA1iWN2FlrXw9NX9FfD+ZWHM77NrHcCG7/ng
	 oFKWDkdhvC/EzP7FzZMJqVm/ZnTSTKf7H1uMkChLgd4EXVenmvNA9CUNlYqxUzc+uo
	 4PPtuHl5eqUKbtU5VrrjsyCdSl+xVtWW1b9d7Mtfz+g3kzRdLIBsZOACHxeVPLIUqs
	 +WwhXtW7tY4ONROyGnlGBVFTL6L41IAcw1tuz53g5XWGdg8jzioArkfC/W08HnrXnd
	 YhmxsQYH14z6oHAsQjn3wxXmsSYEqesH1XnHjhO7z6xPZ1tywxpy76DY4BrEq99Qkx
	 IZp1fmWdA0NNw==
Date: Wed, 23 Aug 2023 19:02:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com
Subject: Re: [PATCH v13 00/24] nvme-tcp receive offloads
Message-ID: <20230823190225.5688f1ad@kernel.org>
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 15:04:01 +0000 Aurelien Aptel wrote:
> The next iteration of our nvme-tcp receive offload series.
> This submission was rebased on top of net-next, and on top of
> the NVMe-TCP TLS implementation v10.
> https://lore.kernel.org/all/20230816120608.37135-1-hare@suse.de/

Please post as RFC if there are dependencies, we can't apply this,
anyway.

More importantly it took so long to revise this series we had made
significant progress with the netlink infra. I think you should move
out from ethtool into a dedicated family, in a similar fashion to:

https://github.com/kuba-moo/linux/tree/psp

