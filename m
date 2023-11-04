Return-Path: <netdev+bounces-46063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0FB7E10A3
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 19:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09DF2814CD
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32301F600;
	Sat,  4 Nov 2023 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDHq0az/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4216747B
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 18:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8265CC433C8;
	Sat,  4 Nov 2023 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699123448;
	bh=FRSsNlZJRtAZ5520gkXj+6trkOaEEcULj4EvVUaXbtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDHq0az/yX80JwqXHI8tYIp+m+fW2NYTgUpXtHrcwZba/KC6xJd83u2uUma6pVdtG
	 6DYZpO1MYHy9Fbo7RIbTcofNQBWjCnzr0EzUsHM0fdbY1FabSs6jvJpIvuEFdXVhTd
	 nZaA4pDpaDzATLCBoj1901PK/9qDmml+8NiTqoK/qyPJxMhenTFHYI+waU1xIe4RFV
	 Ej0b9zDf7Yvtn98DY53by0bDKoFwKkG00Krj0IZPp0dGD16Ubdu6PKGWKH1ppLfhYw
	 Wm5PGgkpjbpnZsio+i6x3wjT8buqaTvSYR1cewxGpCM8vMb+MhYQFPP3HOtoB8mmse
	 7KZaldMFlQAmg==
Date: Sat, 4 Nov 2023 14:43:31 -0400
From: Simon Horman <horms@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
	Nishanth Menon <nm@ti.com>,
	"Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: Re: [PATCH] net: ti: icssg-prueth: Add missing icss_iep_put to error
 path
Message-ID: <20231104184331.GP891380@kernel.org>
References: <0b21ba4e-5c47-4625-a9ec-e45e54ba9229@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b21ba4e-5c47-4625-a9ec-e45e54ba9229@siemens.com>

On Thu, Nov 02, 2023 at 05:03:30PM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Analogously to prueth_remove.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Hi Jan,

I am a little unclear if this patch addresses a user-visible bug, or
is adding a new feature.


If it is fixing a bug then it should be targeted at the net tree.
It should apply cleanly there, and the tree should be noted in the subject.

  Subject: [PATCH net] ...

Also, if it is a bug fix, it should have a fixes tag, indicating the
revision(s) where the problem was introduced. This to assist in backporting
fixes. In this case perhaps the following is appropriate:


On the other hand, if this is a new feature, then it should be targeted
at net-next:

  Subject: [PATCH net-next] ...

And in that case the following applies.


In either case, I think it would be good to expand the commit message.
It should explain why this change is being made.


## Form letter - net-next-closed

The merge window for v6.7 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after November 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: cr

