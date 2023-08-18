Return-Path: <netdev+bounces-28656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244037802D2
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 02:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546B91C21496
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 00:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1FD38B;
	Fri, 18 Aug 2023 00:58:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F6375
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 00:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38BEC433C7;
	Fri, 18 Aug 2023 00:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692320287;
	bh=0oz9B82jH9mwLzSthdNYcN60G37J9dfdiqWbVCfCujo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HuZD+ZvOGfqmvgkqs3Fmc+ghp0OcCaxOGFUGXhhESK/2SIklE6Vz93YoXBVTYJ0N9
	 uBNXNu/2Jw/lTwFILaY8dMCJ3Mb1kIM94TPgx8R/8im45njSZZV28NNkh8l86OPSAj
	 xxX6+2REuK5rPWXPGrJrGxbqM3vvUi+M47En6VheSJWDz1D+81zCc6j7woTYziw7bP
	 FoDGNG5s6VucQY4gU1psidXIXZtzZlyE4FddOQ5scB7NaFrQKwzLIEacw6zNVNlRP6
	 2uRG6wSYETM5pTBJ5ciwmi6IVgwu2Ky5RfZYZIncjTTTQ/3HM3rtwKwQxcrgtIF6ld
	 sWQbkPqCyJ7pw==
Date: Thu, 17 Aug 2023 17:58:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: heng guo <heng.guo@windriver.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov
 <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 netdev@vger.kernel.org, Filip Pudak <filip.pudak@windriver.com>,
 Richard.Danter@windriver.com
Subject: Re: [NETWORKING] IPSTATS_MIB_OUTOCTETS increment is duplicated in
 SNMP
Message-ID: <20230817175806.5a20d592@kernel.org>
In-Reply-To: <9a10520c-bfa9-2089-7d01-8ce215c48063@windriver.com>
References: <9a10520c-bfa9-2089-7d01-8ce215c48063@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 11:32:43 +0800 heng guo wrote:
> Linux version: 5.10.154
> Platform: ARM nxp-ls1028

Linux development doesn't happen in stable trees.
Can you reproduce this problem on Linus's tree?
If so please rebase the patch and resend it 
(after reading how to submit patches to Linux).

