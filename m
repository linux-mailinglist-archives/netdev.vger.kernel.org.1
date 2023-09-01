Return-Path: <netdev+bounces-31749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DF678FEB4
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 16:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1268281B3C
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D273BE7C;
	Fri,  1 Sep 2023 14:02:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50C5BE6E
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 14:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1071C433C8;
	Fri,  1 Sep 2023 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693576969;
	bh=t4SzZdVs2dnHCS/o5I1KXsaPgEjxwtxeGGuZ+olqzQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swPLh1Wlha2P2fVbnxYDoGCwAHfJSjPyAm9RfMG5XUhqN0tnDdgKZkHFxFlvt4cSL
	 UjWcc3oRdywcxEpqoDLOnFlnG8c2dhuna+UsMnh8cn2+fiNMadld7P9CMyZYZh6Wjw
	 F/1hYcem5vputXGjP3ZqsM0ZxfWEvItQfEYxeISL7qJox7xmNUczHTmi9XLYpKGmvD
	 pRJqpe8tYZZmX9GZwsZvTVrFWBR5ZkV+UhNF/9elpPKfsHswNgAOMlfYF9v2iGO2ST
	 W9TuwuI4zg5Ai0b4AMzwV2Pge1K7wHhhdeYkX2k/8DeP5eJ81WBP+qELK2OoVUW5kP
	 HAxJlVXoWC4ew==
Date: Fri, 1 Sep 2023 16:02:02 +0200
From: Simon Horman <horms@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: bcmasp: Do not check for 0 return after
 calling platform_get_irq()
Message-ID: <20230901140202.GI140739@kernel.org>
References: <20230901070443.1308314-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901070443.1308314-1-ruanjinjie@huawei.com>

On Fri, Sep 01, 2023 at 03:04:43PM +0800, Jinjie Ruan wrote:
> It is not possible for platform_get_irq() to return 0. And it return
> -EINVAL when the irq = 0 and -ENXIO when the irq can not be found. The
> best practice is to return the err code from platform_get_irq().
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")

Hi Jinjie Ruan,

This seems more like a cleanup than a fix, I think the tag should be dropped.

> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

