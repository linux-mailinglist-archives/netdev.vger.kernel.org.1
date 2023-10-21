Return-Path: <netdev+bounces-43213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B027D1C48
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BA91C20F91
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C76D532;
	Sat, 21 Oct 2023 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XQUfqk2X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E73653;
	Sat, 21 Oct 2023 09:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFA6C433C7;
	Sat, 21 Oct 2023 09:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697881990;
	bh=mrT5GpV3SwVBG0NEQcFncjHx8JIGzumjfarKK3/zPpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQUfqk2XyDiusR+W6lW+Q18MRIBKR7ypUhuiYan+uDqIp52Vim3U2kkhAuYCMYjgp
	 sErTKBDjrPw6IdDBjRJd6VvOhuaOW+fbsNUU0y8LbnaaSj7Mxm4Yd4BKzsGMDsEm3X
	 +XggNO9HVx+GdUm4H0k9ZmJPD4F5BGib5CN/ndDs=
Date: Sat, 21 Oct 2023 11:53:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Ian Kent <raven@themaw.net>,
	Sven Joachim <svenjoac@gmx.de>,
	Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>,
	Sumitra Sharma <sumitraartsy@gmail.com>,
	Ricardo Lopes <ricardoapl.dev@gmail.com>,
	Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-staging@lists.linux.dev,
	Manish Chopra <manishc@marvell.com>, Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH 0/2] staging: qlge: Remove qlge
Message-ID: <2023102158-unison-depth-0db6@gregkh>
References: <20231020124457.312449-1-benjamin.poirier@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020124457.312449-1-benjamin.poirier@gmail.com>

On Fri, Oct 20, 2023 at 08:44:55AM -0400, Benjamin Poirier wrote:
> Remove the qlge driver from staging. The TODO file is first updated to
> reflect the current status, in case the removal is later reverted.

Thanks for this, now applied!

greg k-h

