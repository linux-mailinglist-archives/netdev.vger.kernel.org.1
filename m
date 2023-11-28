Return-Path: <netdev+bounces-51527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FFF7FB026
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32EF281C87
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 02:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCA120F6;
	Tue, 28 Nov 2023 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMVgunLF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2A1C3F
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544C3C433C8;
	Tue, 28 Nov 2023 02:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701138989;
	bh=TruzQA9ijzCU2zbGyD+46E6KCqwiAtln/j7kJsrBg60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FMVgunLF50RfIrm4BQGh0C4bVb3RhvFRHFQrt4D03iDtf5X5GyL//dZYTMBQmFG7p
	 fNzWJ7YjTKGySwxGga95AsL51D3lkxykZ2ClpWEWGDNk78LZ718AciXBcPzWlcxh/X
	 qqrqbFprC4vO8rPtRGZN76pPihUn6VfFviLA7MjR4kbh5vB45Pzv+K9lVTCRFWT5ZW
	 3J+wR3reWEp2ZAQ9yV3JqfEHsBiegKa2EInyYjhX0n7v/wQWXxgp7XtIhv+2EOKq4p
	 qravmIgd9HrhTRJkEx0HcAp0LrJrUuzzRzNCJ/qbi208Yii+eJKb6QUTQSeKfjJKLB
	 uoJL8fyfkapAw==
Date: Mon, 27 Nov 2023 18:36:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <horms@kernel.org>, <naveenm@marvell.com>
Subject: Re: [net PATCH] octeontx2-pf: Fix updation of adaptive interrupt
 coalescing
Message-ID: <20231127183627.0bd5677a@kernel.org>
In-Reply-To: <20231127052811.3779132-1-sumang@marvell.com>
References: <20231127052811.3779132-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 10:58:11 +0530 Suman Ghosh wrote:
> The current adaptive interrupt coalescing code updates only rx
> packet stats for dim algorithm. This patch fixes that and also updates
> tx packet stats which will be useful when there is only tx traffic.

Doesn't sound like a fix, more of net-next material.

> Also moved configuring hardware adaptive interrupt setting to
> driver dim callback.

Also this should be a separate patch.
-- 
pw-bot: cr

