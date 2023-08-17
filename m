Return-Path: <netdev+bounces-28522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B267377FB30
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C11D282068
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B55A15AC4;
	Thu, 17 Aug 2023 15:53:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894971549E
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282D8C433C7;
	Thu, 17 Aug 2023 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692287595;
	bh=GI7bsJEXllKrx04dcqP4aAQbJejYQRK+vrqF+j3kz2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AxuV6tErwgyi8sPCCLm58zhxU877tvhj+jq+WWyXMzzT2g/Fqcqoz5REAQQdr0fPq
	 WUdyNHwncnCzDz64b0J19R1lk6T3HrsE3tpEt8D7Oj+qIch7l+7bbM8OEMPHobCIPF
	 jMzn+PoKlcg2z0XNQuVqkJtysGBAUH9mBy9t9FjrcWx0qgqxLSndFXcHY1fa+JuiIU
	 tg0CFwnO//Ddkt4LzR0z2SSlN3NlLnXvscOgPQKvCJc03fODY8378SRss3+NIPf9uV
	 2GtmI9yucV1IeFa/DSSAKVvV9KkOpF3dMqATGrLNOc9AIYytT+GVXYnLtB3CzWf5r2
	 ZQ82e505w/sdw==
Date: Thu, 17 Aug 2023 08:53:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <20230817085314.1c8b567f@kernel.org>
In-Reply-To: <20230815143756.106623-2-justinlai0215@realtek.com>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
	<20230815143756.106623-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 22:37:55 +0800 Justin Lai wrote:
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 2696 +++++++++++++++++
>  5 files changed, 3127 insertions(+)

Please try to make this patch smaller, usually breaking out ethtool
operations and any offloads to separate patches does the trick.
Keep in mind the driver must be operational after each patch.

