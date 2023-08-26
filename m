Return-Path: <netdev+bounces-30841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349878932B
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 03:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B560B1C2101C
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 01:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BBB37F;
	Sat, 26 Aug 2023 01:50:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5937FD
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 01:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F0CC433C8;
	Sat, 26 Aug 2023 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693014658;
	bh=T8134DBtc6QVe+JLnbNIFkvgc1ywDwi/8qUoC5fSQAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hbYyEM61f06vCUWvSAxuPp1dgBhyKsIh08v4+1nPRIuqHonoIgkjeZE7fc71YYYlM
	 wH9zijy3RpGKHNE9BNFBZNAokTIyOguo51y86hzYIv8vHzSeEqApPO077vXbkmnKB2
	 j0cbo1IcI+IZZM7ymm+RWNWRKRWJXHz8y9bE6yXTF8DNDARn19BRcaRJMAwSsJ5Exa
	 A+/fIjzb+J+L3ARSxr1yKIR2FOOkt4PNRUsa/66ze5gjGNzLD5dLZY1bqCU4EcM+8A
	 vMdOaV83HjpifSQTXgsPxkH2Qnsxrrk8g4xPR/iAwQ7cJIJ506h0lD/9fZjtoqFpeU
	 q9pFRPTw7DOXA==
Date: Fri, 25 Aug 2023 18:50:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <horms@kernel.org>
Subject: Re: [net PATCH V4 0/3] Fix PFC related issues
Message-ID: <20230825185056.393131aa@kernel.org>
In-Reply-To: <20230824081032.436432-1-sumang@marvell.com>
References: <20230824081032.436432-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Aug 2023 13:40:29 +0530 Suman Ghosh wrote:
> This patchset fixes multiple PFC related issues related to Octeon.
> 
> Patch #1: octeontx2-pf: Fix PFC TX scheduler free
> 
> Patch #2: octeontx2-af: CN10KB: fix PFC configuration
> 
> Patch #3: octeonxt2-pf: Fix backpressure config for multiple PFC
> priorities to work simultaneously

Minor note for the future, if you don't mind.
Please add the prefix to the subject of the series as well
(octeonxt2: ...), that way it's clear what the driver is
in all the places which use the subject of the cover letter
to identify the series.

