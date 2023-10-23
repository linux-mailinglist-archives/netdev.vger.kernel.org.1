Return-Path: <netdev+bounces-43364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BA47D2B49
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81A82813F4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4FF101D9;
	Mon, 23 Oct 2023 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Q9Ow7oaj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DzJUHB8A"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D612570
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:28:01 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF010C7;
	Mon, 23 Oct 2023 00:27:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 7D4A63200902;
	Mon, 23 Oct 2023 03:27:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 23 Oct 2023 03:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698046071; x=1698132471; bh=Y+
	wypWLyKPvzQcBs6mJy6il4rEIozWzd7v6BEQHv4G0=; b=Q9Ow7oajQkFUaifCx7
	nHmVYAn73+zB0Dc8m4Ymd+JtwlLEc6JJq/WZJwilonvqxqib94aHKb5zkD+SBIdq
	+n/IJc2dRrTLAMTi6a2l26nOBTUPQb1GA1ApwcI5QC/bESOhQwUw66Qn0/PhIDdm
	sDsXJDWGD6d/XLfVbq7o61wJ/KM4VSnUxWIYPeGWjBR8dXoLIHyPySaN5wRJRTvs
	YvHq7WH52GxoYhVtkqCeiHfGhn44ZXJqvSfiNSYtOOW1tX9I+/Z04gAhJUvJ7e3x
	ku9iUyXP/eEWmHpReREsBclpoj4ccIXtWoHieq7oIzw89SU9EUkiqDPsXKhaDwC5
	EimQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698046071; x=1698132471; bh=Y+wypWLyKPvzQ
	cBs6mJy6il4rEIozWzd7v6BEQHv4G0=; b=DzJUHB8AwagwcDqRIz/2CVASvV3Hg
	94YSgbywpr7TqDnvkbntPThx5Bve85xUuYgMp2dN0QyDwxek9dKax2DVfDhddTQq
	MsPZNBfqYSRLj1XzJpTKua1itanKmMJsRcGbOaEmngtk9SJFPd5ieT+gjH9oOQfg
	wpAyfsZGhaJlkUOD1+e1vaQnBkoCIDpiojtIO4rlAlfjevGxdrouP9kaMWIZtrlx
	vFoybK7hLG1TbY8npAdoHFvfyGpEvzbrDLBGF1ef6QpOf+fJ18UMji/5pMXosJAG
	ggMH0K+nufH1Vno6D2IqrNzjyjhYY6uSsnzX/uuYwSIV5kpSHyVuM1Frw==
X-ME-Sender: <xms:diA2ZSQlyuH80c2Qa2PBlpGJEU1D41hPM5ZAoRWhdQwU631SBd2ZBQ>
    <xme:diA2ZXxEln3kgHV-inXfAAfzPVH6PEVEo9XqSA9VVTdwk1TiQcjrTsvP1X-RyOkfw
    qp2yGpetS7urg>
X-ME-Received: <xmr:diA2Zf3oMhyG09EiJZR7eSoWfwYSdrWYkKzvVeE8FJN9UlWzDfTUMvzdbQB9mImUhAAZxtF4SMY1qSEWvjRzEgtZuS4mZ-TqRwbkDrqPbZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeehgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:diA2ZeDtHzPMYz1V6-0U52bobMSAisV_03MOU1n_VGeVt8tR5_pOZg>
    <xmx:diA2ZbhMEztJg-r3Aj-qzGszyztUYjuzVeT7ioOQbZ9ZGpRLcaUehw>
    <xmx:diA2ZaqWq0jt6BKHsQz6SnCmChAq4KTkoEcL8kJtsRmTAi4SLPv2lQ>
    <xmx:dyA2ZaQoI9s7r91G1dZ1Pv6HI3pEaRxgm9dtOutp1WdzPpRPUI7bkw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 03:27:49 -0400 (EDT)
Date: Mon, 23 Oct 2023 09:27:47 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>,
	Benjamin Poirier <benjamin.poirier@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: linux-next: manual merge of the staging tree with the net-next
 tree
Message-ID: <2023102338-repaying-golf-a200@gregkh>
References: <20231023144720.231873f1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023144720.231873f1@canb.auug.org.au>

On Mon, Oct 23, 2023 at 02:47:20PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/qlge/qlge_devlink.c
> 
> between commit:
> 
>   3465915e9985 ("staging: qlge: devlink health: use retained error fmsg API")
> 
> from the net-next tree and commit:
> 
>   875be090928d ("staging: qlge: Retire the driver")
> 
> from the staging tree.
> 
> I fixed it up (I just deleted the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Wonderful, thanks for deleting the file.

greg k-h

