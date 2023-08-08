Return-Path: <netdev+bounces-25600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE245774E1A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EB21C20FE9
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634DA18038;
	Tue,  8 Aug 2023 22:15:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E214F91
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552F0C433C7;
	Tue,  8 Aug 2023 22:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691532934;
	bh=hlPqlxQlzDRRFtRMjpUQOwGvFZHg26ls07TFrTzOkS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oR74k4cd44FBGrLFr9vZeD3tpDrOcq+PEeiPlDZFqLMwYXY2AHmKyOznht5KNXzt0
	 SXUfqZ3ACCn4/lfvCrMebxupp8pVFwgmpAn16mbTkk4HHh0aeXOfBBrftQys9qNave
	 zvCjvum6C7AI3j0PNTibQpt72FedazM+qREJQ7VQS7zsbwX6pFyWmwm7n3r7wEJE2l
	 fTrAtA1hNMDOuSHQhGKYjaqf7bmGj+TeDQIyW4KZpG8TfUwfjKdIjIJtdFx3yAJq9q
	 LP3zxxfCBvCARxPGWzDExD0atbc5xGS6ZY5iXNGd2p6/i2mYDL9rEXVdTEC91HktgC
	 M5X/Vr8bQCpsQ==
Date: Tue, 8 Aug 2023 15:15:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
 <jerinj@marvell.com>
Subject: Re: [net PATCH 2/3] octeontx2-pf: Fix PFC TX scheduler free
Message-ID: <20230808151533.3085f5f6@kernel.org>
In-Reply-To: <20230808112708.3179218-3-sumang@marvell.com>
References: <20230808112708.3179218-1-sumang@marvell.com>
	<20230808112708.3179218-3-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Aug 2023 16:57:07 +0530 Suman Ghosh wrote:
> +	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
> +		otx2_txschq_free_one(pfvf, lvl,
> +				     pfvf->pfc_schq_list[lvl][prio]);


ERROR: modpost: "otx2_txschq_free_one" [drivers/net/ethernet/marvell/octeontx2/nic/rvu_nicvf.ko] undefined!
-- 
pw-bot: cr

