Return-Path: <netdev+bounces-27725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA02077D032
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7C81C20DE9
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF484134CC;
	Tue, 15 Aug 2023 16:33:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F0EDE
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 16:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9F9C433C8;
	Tue, 15 Aug 2023 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692117219;
	bh=HTEKO3O/9AEtqHC53Vj0RwQR1sZ22pEW1qEk0DeFlEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvTWAnAbdz9ejoYeBWZn/sM+wT+zurHBU6HIEOyK2hFvh8J5XwCOTyqBrwjPAVBCM
	 bce04paoJXPb9QfUDNVlOgGSAbHmDsdk8vcXckq4dNQHil5TOBwtei+eZoqRiHUomg
	 SGdHg4KbilgsikI8j5ID2H8jYwf8hmldkwGmqJrWFnw+h+1NOAt7e25khKxHHdT/7J
	 j6B+upVh4GgiNOC/4dyJW1fjv56oXjTkPy5yicalOC0Okl18+EG1LiI1g4kh7V57eo
	 S0/9C+AWe2jO9j1UKRE8S+dmFRYj4VwrjMD2p1rLtBlKcGZEgldjVZ1BXsyAOcL5Gi
	 1v/vlD/xrsmCQ==
Date: Tue, 15 Aug 2023 18:33:35 +0200
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com
Subject: Re: [PATCH net-next 06/12] bnxt_en: Add tx_resets ring counter
Message-ID: <ZNuo36BEgyhMlkPe@vergenet.net>
References: <20230815045658.80494-1-michael.chan@broadcom.com>
 <20230815045658.80494-7-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815045658.80494-7-michael.chan@broadcom.com>

On Mon, Aug 14, 2023 at 09:56:52PM -0700, Michael Chan wrote:
> Add a new tx_resets ring counter.  This counter will be saved as
> tx_total_resets across any reset.  Since we currently do a full reset
> in bnxt_sched_reset_txr(), the per ring counter will always be cleared
> during reset.  Only the tx_total_resets count will be meaningful and we
> only dispaly this under ethtool -S.

nit: dispaly -> display

> 
> Link: https://lore.kernel.org/netdev/CACKFLimD-bKmJ1tGZOLYRjWzEwxkri-Mw7iFme1x2Dr0twdCeg@mail.gmail.com/
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

...


