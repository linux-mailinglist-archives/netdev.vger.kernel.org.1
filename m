Return-Path: <netdev+bounces-43160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5097D7D19CE
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D97E1C21040
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA1662D;
	Sat, 21 Oct 2023 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGVGdz8e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A4C626;
	Sat, 21 Oct 2023 00:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AAFC433C8;
	Sat, 21 Oct 2023 00:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697846858;
	bh=jTrk/Gafm+KJRKpyzTt3v8OHqLErcuKfqpcSbk76V8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vGVGdz8e43uV7R9ReOWlRBWvZ/wKZjDH63CXscVta7XkrF0cna+6PgPR+mZcn/oNY
	 ISmxMTVY7NZAKrVavmowWG+SR/QPdYimd9mOJHWjSSY1a74gyH0OHk9Wo8URVj2wtI
	 c1NT5jB0wbw64oGkfogxhXRP6XGe0YENctYcY6tg4IOvOTYyybpwTe7Fj4gsi2om/p
	 wt7bflk0KrCKMrMkc14Dn04MG4M7irw7SFebvdk2s0h8+iqwntxGkfSriV8eqrxsqj
	 atbY/Yd3ph/ab4y03YrU+8QILz8J1mRrQUH7LzsWFXNwDUh2sXHHImeSW4WBaHvQi8
	 WeDLscDffY8Ig==
Date: Fri, 20 Oct 2023 17:07:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller
 <deller@gmx.de>, Ian Kent <raven@themaw.net>, Sven Joachim
 <svenjoac@gmx.de>, Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>,
 Sumitra Sharma <sumitraartsy@gmail.com>, Ricardo Lopes
 <ricardoapl.dev@gmail.com>, Dan Carpenter <error27@gmail.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-staging@lists.linux.dev, Manish Chopra <manishc@marvell.com>, Coiby
 Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH 0/2] staging: qlge: Remove qlge
Message-ID: <20231020170737.1036eae9@kernel.org>
In-Reply-To: <20231020124457.312449-1-benjamin.poirier@gmail.com>
References: <20231020124457.312449-1-benjamin.poirier@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 08:44:55 -0400 Benjamin Poirier wrote:
> Remove the qlge driver from staging. The TODO file is first updated to
> reflect the current status, in case the removal is later reverted.

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

