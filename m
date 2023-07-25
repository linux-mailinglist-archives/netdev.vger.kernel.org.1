Return-Path: <netdev+bounces-20862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA678761994
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0901C20D22
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3391F196;
	Tue, 25 Jul 2023 13:17:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577228C0A
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13533C433C8;
	Tue, 25 Jul 2023 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690291018;
	bh=wTq9aJany5yjpdd0XLYjO+5VA2pHCAqzsIDwD4D7Tzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vrc2w/MOFCxfwEVcTz5LpaEIOZTb6pOPHrPlbZ8QSGc0qA0PH12mbHgIDf8i+f8h7
	 yIZUqOFq9VxzqoV9PkecXkF6/8ziN8rxG7cgmO4bH0rmLlJD9WdoNcNCmQN4345Kod
	 nT7uohbx50CXmzRAjrPTBBJ79f3QMmN0vSGA0y0w/8Nu3QMdGtSZyqN8YizJ0xwnK0
	 TQTV7b6uGOSyiOjcC8CK9a+ZwglukqsHdR9iUFmjZMKH6BfLZ2WLIolyasimcwjYV+
	 zbyct9avI2DD3GSJlPS/8Ef21EH0qWrp+cbZsQXqbfvVKn0gW99xIeBfF2BAFqlToZ
	 mMid6bu508OpQ==
Date: Tue, 25 Jul 2023 16:16:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>,
	Ilia Lin <quic_ilial@quicinc.com>
Subject: Re: [PATCH net-next 4/4] xfrm: Support UDP encapsulation in packet
 offload mode
Message-ID: <20230725131654.GQ11388@unreal>
References: <cover.1689757619.git.leon@kernel.org>
 <051ea7f99b08e90bedb429123bf5e0a1ae0b0757.1689757619.git.leon@kernel.org>
 <20230724152256.32812a67@kernel.org>
 <ZL8xjo40TSPxnvLD@gauss3.secunet.de>
 <62e3bfa752f679a1e0520c4276e936e5a9c5e83f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e3bfa752f679a1e0520c4276e936e5a9c5e83f.camel@redhat.com>

On Tue, Jul 25, 2023 at 03:14:51PM +0200, Paolo Abeni wrote:
> On Tue, 2023-07-25 at 04:21 +0200, Steffen Klassert wrote:
> > On Mon, Jul 24, 2023 at 03:22:56PM -0700, Jakub Kicinski wrote:
> > > On Wed, 19 Jul 2023 12:26:56 +0300 Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > Since mlx5 supports UDP encapsulation in packet offload, change the XFRM
> > > > core to allow users to configure it.
> > > > 
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Steffen, any opinion on this one? Would you like to take the whole series?
> > 
> > The xfrm changes are quite trivial compared to the driver changes.
> > So it will likely create less conflicts if you take it directly.
> > 
> > In case you want to do that:
> > 
> > Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> Sounds good to me! I'm reviving the series in PW and applying it.

Thanks a lot.

> 
> Thanks,
> 
> Paolo
> 

