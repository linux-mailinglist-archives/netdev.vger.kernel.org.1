Return-Path: <netdev+bounces-62923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47598829DE4
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 16:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564F71C21F96
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD364BABE;
	Wed, 10 Jan 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suH6Rm5U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDE44CE0E
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 15:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6D1C433F1;
	Wed, 10 Jan 2024 15:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704901576;
	bh=9jq1ti59PakqR17CR9lBc8A7ggG9avG55PHFer2cDkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=suH6Rm5ULGS5LKyR+X8X6aop+E2JqcWvYiMPbyIEjIIgkiZ42VSOUbobRxVczsTlm
	 c816OLTCEoZRrDfIuvs9qRBLlqVRyXcaGRTBstZc5aIaNg+V2+sTtStvqPiaHT3Qqe
	 6FtCKkyP7TJWwxXIyy9eoTPyG8A8uOzIijUhFcyjOivkCskJl/jTQswfMhSbqsICsT
	 U7bTUDwQr4zUF0QjlkBwRDhGBDGT5CAfqDAe16RK8d8SlVH3izbo0YFpvG3dXqygic
	 As9PoQ4VK0ehQ99VaN9AD8NILdCoIVrruH5kw5FQM/1P1FJY7ZRvuxN+N4F4WDr1Bm
	 8Ip35KTW2b72A==
Date: Wed, 10 Jan 2024 15:46:11 +0000
From: Simon Horman <horms@kernel.org>
To: John Crispin <john@phrozen.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH net 1/7] MAINTAINERS: eth: mtk: move John to CREDITS
Message-ID: <20240110154611.GI9296@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
 <20240109164517.3063131-2-kuba@kernel.org>
 <20240110144851.GC9296@kernel.org>
 <fc232f99-ab04-406e-9f76-b328b2339d31@phrozen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc232f99-ab04-406e-9f76-b328b2339d31@phrozen.org>

On Wed, Jan 10, 2024 at 04:34:51PM +0100, John Crispin wrote:
> 
> On 10.01.24 15:48, Simon Horman wrote:
> > On Tue, Jan 09, 2024 at 08:45:11AM -0800, Jakub Kicinski wrote:
> > > John is still active in other bits of the kernel but not much
> > > on the MediaTek ethernet switch side. Our scripts report:
> > > 
> > > Subsystem MEDIATEK ETHERNET DRIVER
> > >    Changes 81 / 384 (21%)
> > >    Last activity: 2023-12-21
> > >    Felix Fietkau <nbd@nbd.name>:
> > >      Author c6d96df9fa2c 2023-05-02 00:00:00 42
> > >      Tags c6d96df9fa2c 2023-05-02 00:00:00 48
> > >    John Crispin <john@phrozen.org>:
> > >    Sean Wang <sean.wang@mediatek.com>:
> > >      Author 880c2d4b2fdf 2019-06-03 00:00:00 5
> > >      Tags a5d75538295b 2020-04-07 00:00:00 7
> > >    Mark Lee <Mark-MC.Lee@mediatek.com>:
> > >      Author 8d66a8183d0c 2019-11-14 00:00:00 4
> > >      Tags 8d66a8183d0c 2019-11-14 00:00:00 4
> > >    Lorenzo Bianconi <lorenzo@kernel.org>:
> > >      Author 7cb8cd4daacf 2023-12-21 00:00:00 98
> > >      Tags 7cb8cd4daacf 2023-12-21 00:00:00 112
> > >    Top reviewers:
> > >      [18]: horms@kernel.org
> > >      [15]: leonro@nvidia.com
> > >      [8]: rmk+kernel@armlinux.org.uk
> > >    INACTIVE MAINTAINER John Crispin <john@phrozen.org>
> > > 
> > > Signed-off-by: John Crispin <john@phrozen.org>
> > I am curious, did John sign off on this?
> 
> I did indeed. gave Jakub the SoB when he asked but sending the this patch.

Thanks, got it :)

> 
> for correctness here it is again
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> 
> > 
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Other than the above, this looks good to me.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>

