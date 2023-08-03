Return-Path: <netdev+bounces-23864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9D476DE49
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868A3281F86
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1093620F6;
	Thu,  3 Aug 2023 02:34:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F25383
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF536C433C8;
	Thu,  3 Aug 2023 02:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691030066;
	bh=TXkKpjfBwJUHSuaXgx+HvSYPxUQ+cDXkq2stWTEAw5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ACpiTaosOIA/uOtQYQbbbCUFsDWeT1t5/XPEnyu0iBK5JC0o5OiG1smC0IjXPmSp/
	 xhbgfcDjg+oGnNHD7r2d4wXxEssiJswaU1nJxj+PUJH46lkElC+v7eE7Z7X834BR1g
	 4ST0pl0hOBO5wveq4hl7Pb5lo5l7s+yIaxKGO8PeGr8gE3A4Q5J4dst4YJEl2RHim/
	 k7kgTnls6Sq+xLU1wbteOl+ufq0m6h6PNBw2dKXQng4h3oo9c8Zr3HrRdElABBdGKz
	 UN51faaciF40+3XDeaz8Qj/VgjN236JcrkRCu05nY+PPzL70DehZrRL35ARgWFdTg9
	 9K6Cbzb+1dOUw==
Date: Wed, 2 Aug 2023 19:34:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
 <jerinj@marvell.com>, <simon.horman@corigine.com>,
 <jesse.brandeburg@intel.com>
Subject: Re: [net-next PATCH V4 0/2] octeontx2-af: TC flower offload changes
Message-ID: <20230802193424.79377f40@kernel.org>
In-Reply-To: <20230801153657.2875497-1-sumang@marvell.com>
References: <20230801153657.2875497-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 21:06:55 +0530 Suman Ghosh wrote:
> This patchset includes minor code restructuring related to TC
> flower offload for outer vlan and adding support for TC inner
> vlan offload.
> 
> Patch #1 Code restructure to handle TC flower outer vlan offload
> 
> Patch #2 Add TC flower offload support for inner vlan
> 
> Suman Ghosh (2):
>   octeontx2-af: Code restructure to handle TC outer VLAN offload
>   octeontx2-af: TC flower offload support for inner VLAN
> 
> v4 changes:
> 	Resolved conflicts with 'main' branch

Still does not apply.

After you git format-patch the patches check out net-next/main
and git am /path/to/patches..
-- 
pw-bot: cr

