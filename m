Return-Path: <netdev+bounces-16703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FACF74E75A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0277C1C20B59
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C3B3D6A;
	Tue, 11 Jul 2023 06:31:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB963E
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA75C433C8;
	Tue, 11 Jul 2023 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689057090;
	bh=qu1pd3b272tPo8ITAHMdIXv+6whUB9sDBn0ZFcwWQkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brPXcBjoP+slwSVt0HXm6purXk9H9Ym82SraRQtgIczKBKhPyGcO1FqMKMCU4AkuA
	 tYmJjh8RhHZub5hKpB4g2jLRO2MDbGD8ql5nl3EOamC0/Pc96x16+aqOrilbW6Tv/S
	 XNz8Be2FtWMAOlLbT+Zm6kCVXNjmiNgDj7GrgznglK0pELVE0BpnaVy1ty7rUJoadT
	 kCFVEYjxfYsdgX088XjIXR7EueoKXX7MStYFINNKqXHvFzyg8/gEG1ti029LqtPm/7
	 xgx3QHPPa2kVwSKq6eVsDe6SU+Fzt0/vSs7MBp/BzNYlzxEtobfLdR94sbNwMsXGDU
	 FVzgXH5D6KcwA==
Date: Sun, 9 Jul 2023 12:35:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] octeontx2-pf: Add additional check for MCAM rules
Message-ID: <20230709093505.GB7619@unreal>
References: <20230706173723.2226030-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706173723.2226030-1-sumang@marvell.com>

On Thu, Jul 06, 2023 at 11:07:23PM +0530, Suman Ghosh wrote:
> Due to hardware limitation, MCAM drop rule with
> ether_type == 802.1Q and vlan_id == 0 is not supported. Hence rejecting
> such rules.
> 
> Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> Changes since v3:
> - moved assignment of vlan_etype before the if check

And what were changes in previous versions?

Also you should write the target net or net-next in the patch subject.

Thanks

