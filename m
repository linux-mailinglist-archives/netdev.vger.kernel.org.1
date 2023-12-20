Return-Path: <netdev+bounces-59255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD3F81A168
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522FE1F22E56
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5EE3D3BF;
	Wed, 20 Dec 2023 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XekfXU1G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ACA3D3B6
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 14:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F189C433C9;
	Wed, 20 Dec 2023 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703083708;
	bh=Trz3QAelxUhAp/y5t1VvqmTZc2a72LB1mn2CJG25vfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XekfXU1GLh+nUSz3Dt/+m92jTBDmVWGPlf0ShesFnOKkNGKaMDbeH4xT5FFbujVQD
	 c6BLa3h571blY0Ankbhic44LNpMhDsB2v33wRwp9yh5/KD2T3QTEyD8RPoJBtArws0
	 VofgPC+3iGO07KEXjSGMJBa6YhU0VwlTaV81FAjtb0bvF77dZxzhyetjVSdj8dUgv+
	 1Vy9bg/mvkAd8UO3ypCwi0ft9a9iM7tn/B/vM96ZMcvZ0PLv1zD0h/7nZcBxFU0KeA
	 vfSLHHQ95QxVWn12LbUB4/3r8t60LCpJ8BQ6jXmjJ1AvJGlgXPHd18hZGYoHy/gQG4
	 AUga9pPa+Oncg==
Date: Wed, 20 Dec 2023 15:48:22 +0100
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/8] dpaa2-switch: do not clear any
 interrupts automatically
Message-ID: <20231220144822.GJ882741@kernel.org>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
 <20231219115933.1480290-6-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219115933.1480290-6-ioana.ciornei@nxp.com>

On Tue, Dec 19, 2023 at 01:59:30PM +0200, Ioana Ciornei wrote:
> The DPSW object has multiple event sources multiplexed over the same
> IRQ. The driver has the capability to configure only some of these
> events to trigger the IRQ.
> 
> The dpsw_get_irq_status() can clear events automatically based on the
> value stored in the 'status' variable passed to it. We don't want that
> to happen because we could get into a situation when we are clearing
> more events than we actually handled.
> 
> Just resort to manually clearing the events that we handled. Also, since
> status is not used on the out path we remove its initialization to zero.
> 
> This change does not have a user-visible effect because the dpaa2-switch
> driver enables and handles all the DPSW events which exist at the
> moment.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v3:
> - mention that the change does not have a user visible impact
> Changes in v2:
> - add a bit more info in the commit message

Thanks for these updates too.

Reviewed-by: Simon Horman <horms@kernel.org>

