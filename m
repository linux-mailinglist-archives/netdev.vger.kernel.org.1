Return-Path: <netdev+bounces-45159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8567DB35D
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 07:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E192B20C3E
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 06:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28CBCA77;
	Mon, 30 Oct 2023 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8na+KMB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D95CA58
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 06:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F0CC433C7;
	Mon, 30 Oct 2023 06:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698647590;
	bh=90CZMqFj5cq6KUpthopcf0Xp59H8Wb0WZKgyiAOTR30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L8na+KMBr0gOata9JzQsI8c6eHlewj3V4qaHH3rGmqpkZIkl706hHWmRQNr65Haag
	 ibLsofIzkCO6+s7G1PH8EnrZ+rc6PsCQVFUyIYvC4LedZY9CQT8OrKn3lObbJs8giY
	 gho07mchM/Wq1kS8iyCuLHdmpIIIsHHxFfOzuZg99ThDcju517SDwWRiJuVo2bHZTV
	 tsCjcY9LLY+24Fz+KXci7fVwFNRc3Qp0svdAU8kTIYr4veOvlsb+RHr/S05XPKRGjj
	 /mqP39auEpUcFX+a3LRrFI8hv//ygjlLJm/mFn4+5eFtZ+CRUDDfwj/f3eaP1OYqjN
	 ENQA/gS7KOJ0A==
Date: Sun, 29 Oct 2023 23:33:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com
Subject: Re: [PATCH net-next 00/13] bnxt_en: TX path improvements
Message-ID: <20231029233308.63381083@kernel.org>
In-Reply-To: <20231027232252.36111-1-michael.chan@broadcom.com>
References: <20231027232252.36111-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 16:22:39 -0700 Michael Chan wrote:
> All patches in this patchset are related to improving the TX path.
> There are 2 areas of improvements:
> 
> 1. The TX interrupt logic currently counts the number of TX completions
> to determine the number of TX SKBs to free.  We now change it so that
> the TX completion will now contain the hardware consumer index
> information.  The driver will keep track of the latest hardware
> consumer index from the last TX completion and clean up all TX SKBs
> up to that index.  This scheme aligns better with future chips and
> allows xmit_more code path to be more optimized.
> 
> 2. The current driver logic requires an additional MSIX for each
> additional MQPRIO TX ring.  This scheme uses too many MSIX vectors if
> the user enables a large number of MQPRIO TCs.  We now use a new scheme
> that will use the same MSIX for all the MQPRIO TX rings for each
> ethtool channel.  Each ethtool TX channel can have up to 8 MQPRIO
> TX rings and now they all will share the same MSIX.

## Form letter - net-next-closed

The merge window for v6.7 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Nov 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

