Return-Path: <netdev+bounces-17315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6077512A8
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CAF281823
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F5CEAF4;
	Wed, 12 Jul 2023 21:31:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213EFE568
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482DFC433C7;
	Wed, 12 Jul 2023 21:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689197491;
	bh=g6kPIL4LCoQUHNeV9eXv2hIHMy3/xuBWDvTBuzux4CM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o4eUW5bDY674WXsroq750qA8F1XkxUKFeic+6TOj3uilDBhQ4UdOhzbcdbTw4m7Gu
	 +v8rnRA5GeGqtBYXRIyOpeYzd0FNa3AgQZkUw08UGXuLZ5qSJwMqcfSY+mQ0oO/2XP
	 mDyuGeftL2nuBAgyGPQ+eYMR5sgnfthGXSQIZa3f4T21BYb7c0FWhIxmX2rB4pn1AW
	 Hb7BAlLzj7qSWgiHX6Bc94i2O/mvg4K7K/62TgCG3D8bgrGVxYaRC08gxEurkeoJXo
	 5wx1QzXsOCErRMPiGKyE/HXlVxch3pgx6ENPPcRzHRJDjoa1Ntob21DUlRSFQu/GWs
	 /A4aY6CM93jEw==
Date: Wed, 12 Jul 2023 14:31:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc: Suman Ghosh <sumang@marvell.com>, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] octeontx2-pf: Install TC filter rules in
 hardware based on priority
Message-ID: <20230712143130.483d1449@kernel.org>
In-Reply-To: <CA+sq2CdCw1OT_ChVg_95ALzPX-1LWyiHUSsThor7O3J7Jm3Nmw@mail.gmail.com>
References: <20230712184011.2409691-1-sumang@marvell.com>
	<CA+sq2CdCw1OT_ChVg_95ALzPX-1LWyiHUSsThor7O3J7Jm3Nmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 00:46:49 +0530 Sunil Kovvuri wrote:
> net-next is not yet open, please check the status here
> http://vger.kernel.org/~davem/net-next.html

A bit of a change in process, sorry for the confusion.
The vger server was giving us grief so we switched the link to:

https://patchwork.hopto.org/net-next.html

We updated the docs but it will probably take a couple more weeks
before they are rendered online.

