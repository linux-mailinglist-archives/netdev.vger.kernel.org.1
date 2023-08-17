Return-Path: <netdev+bounces-28298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B59577EF22
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 04:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774591C2120C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 02:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C78337F;
	Thu, 17 Aug 2023 02:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F6936A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF4FC433C7;
	Thu, 17 Aug 2023 02:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692239731;
	bh=zIOeh3858fGEdK+Q1WSdpimv6EuLoQVNUwd1qY937oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+VVu4CAfknNrwqjOLW2XYSDYAruMDgoJ0xfqzrNvsZyU+BMA3riBJeLt/hBu15HH
	 ZnZ6KSpLv4Vj1AVbGv6KLNHS4LqZ+KiHI/WmEHgpKxXo7nu0E2nFmLQNCD3ypRXC5U
	 pP6UMFQF8upSKMHp40PjtiKsXrxnjvGpeCkZC1CAAbx5bDprUzXZ8HVFjKQvQuTxH5
	 M4Cqdzh+gwrDEVRlpVlrEi7ImXb2Gxv9aSXn0qkpzo++jSZyacXzFbpB6aiJMIV29z
	 0yJUj2CnIV3LLkfuzrPf7BIstl9mZliSEfNvR3pJqdO7Gl9C5rDQOVvs6aNfBonnTK
	 7nkPiPl7Jr/BA==
Date: Wed, 16 Aug 2023 19:35:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
 p-varis@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload
 in channel mode
Message-ID: <20230816193529.174a57c4@kernel.org>
In-Reply-To: <20230815082105.24549-1-rogerq@kernel.org>
References: <20230815082105.24549-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 11:21:05 +0300 Roger Quadros wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> This patch adds MQPRIO Qdisc offload in full 'channel' mode which allows
> not only setting up pri:tc mapping, but also configuring TX shapers on
> external port FIFOs. The K3 CPSW MQPRIO Qdisc offload is expected to work
> with VLAN/priority tagged packets. Non-tagged packets have to be mapped
> only to TC0.

FTR this got silently merged but I'm reverting it based on Vladimir's
comments.
-- 
pw-bot: cr

