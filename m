Return-Path: <netdev+bounces-31743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3852C78FE9F
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 15:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710901C208C5
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC71DBE60;
	Fri,  1 Sep 2023 13:51:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F7AD32
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 13:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24954C433C8;
	Fri,  1 Sep 2023 13:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693576290;
	bh=NTVw38G2qVPXTuwzrQPq23tuQlyTYtv68+FUj+uvdNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9YeRsK/BowHDpvqPZbhrU0KFCnAQatb8h99a2O7J6GWv1A0iI8M5+T2HC6RFvFxM
	 iZC8RqPp9OTJ4bks15RGbLrwu4Z0xKCFOBk0YEE2FeyhARi7GBXVERfGpmLOj2HcH+
	 Mom8hcjzYQkWlZdoFPbPDL7y2DbGFKbyH22G3B8sWspGUY1cBDi9jkFnVWbS/6+/Gi
	 XJB2L3dLUgUGG9VjQsK9GxVQRdG9uBZB0o/RCKcTXrtuOZCAVOSgliG+DXYaQqbvjU
	 MBR+TP7/ni7jb1J7ptHwbh7DM4ySpITwgPhaw1CRAn5F+uhnVVdEVxpnWGs/sMC/rp
	 B7FSNEKTWlUBQ==
Date: Fri, 1 Sep 2023 15:51:15 +0200
From: Simon Horman <horms@kernel.org>
To: Li kunyu <kunyu@nfschina.com>
Cc: idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ceph-devel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph/ceph_common: =?utf-8?Q?Re?=
 =?utf-8?B?bW92ZSB1bm5lY2Vzc2FyeSDigJgw4oCZ?= values from ret
Message-ID: <20230901135115.GF140739@kernel.org>
References: <20230902185022.3347-1-kunyu@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902185022.3347-1-kunyu@nfschina.com>

On Sun, Sep 03, 2023 at 02:50:22AM +0800, Li kunyu wrote:
> ret is assigned first, so it does not need to initialize the assignment.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

