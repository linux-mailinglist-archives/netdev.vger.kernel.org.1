Return-Path: <netdev+bounces-25725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F9177547B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04359281A19
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD46D63B9;
	Wed,  9 Aug 2023 07:54:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7F654
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:54:18 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7EA173A;
	Wed,  9 Aug 2023 00:54:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 4985F5C0120;
	Wed,  9 Aug 2023 03:54:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 09 Aug 2023 03:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1691567657; x=1691654057; bh=52
	YpBI7Zd/RbEZj+xJYnJaKHk3vZ1CerWjYIvZGmtqY=; b=Pc87tZQ+Nu3WykEhh7
	zKZWWB1BLYPnn/HyTYNqjOfJDtNAEZp/jWPuaJwXUgLZynpeGaVshmRHqYl2PJuL
	ts1Yg/0cI35LL7RJ95x8Yl6SnBd6q32s8QByuvbvuimNe1idsfx82G553XnZECVO
	TNDJWwTTMR2K2CJypWp8+eJcqt2YvR3qvT3mUcugiZSYDXLNg7uAueAm5il9bcRw
	B4RT1OTPc4+/1Zuh9rAlYFEt7AdukTnrAnx4ZMJWjdKII+tjbH9xvt8YZG7oQLlP
	f2M4yGqciqYM4Cu7YMMa7bt43igqc4ejRru8v0peui3iuCFyCy7y6S4SeTu/c160
	H0lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691567657; x=1691654057; bh=52YpBI7Zd/RbE
	Zj+xJYnJaKHk3vZ1CerWjYIvZGmtqY=; b=mek0K1ofVCJuwzfvL5iwpuP2NEz0G
	tI3EG+AsIkFDFaLqo9PQnNWtYqEgXZsxH3Tbs4PD3Ytsbu9GrnIMG/So3P4egHaB
	i+xsBvjhw7lnl/oozxuktqNDheN+715AWHGU6U8g+ukMgAld1kL+Kvl0ucc6auCY
	2XX0EuHagwUHn8E1B3oBmdAdHDnpET6387JwAQXOSGlKWv9XYyDywzszIs7KSv92
	JHFnZAaWJIXP7z+H7xj/Ngr20tzB6eCzG0EF1xV5V7GMiNwy1NVmFlGfu/VGVgJV
	LOzvHZ5DYtgFL0Y3fEiIWM4/UjDy+1YE+y/h2onTnF2YWeokjU1HozuqA==
X-ME-Sender: <xms:KEbTZIYoeBhL23nyHCGmt0eNSzPaHaqlsUEfROz7l2uIy9X81Pv13w>
    <xme:KEbTZDbBDzceHe8kYx2-CEbDj9Lgs3q7oXZ9zt2oB8QrgAqwam-35vtMWD60IExPi
    ZpRUZZQ2wio3A>
X-ME-Received: <xmr:KEbTZC8gdIL_aa0EOvq84wUt2E2WS7O0cYWggwNasJunVlmoyqJTHS7GoG0l6JXqvjiSic2jXmIA3nxY3te75T-34iNDfqFijYSeKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:KEbTZCpak5LcR39cxYR8LX-_l_vS_p-msBC4zuDPE3yAnOOQH1Rtmw>
    <xmx:KEbTZDrkupJO6x0Vpy0cQhRskmLKxOI-XUwzIDmnVKh7sGSYn6GVGg>
    <xmx:KEbTZATl_ZQMrYY1a0T7Jjqj-QSENnSmWubcpNJD2a2Xp9uke2NtVA>
    <xmx:KUbTZOAklyKxaqOWvqwHVzQXvlynJbUois8SAagDQU0dPiQ03Y1XzA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Aug 2023 03:54:16 -0400 (EDT)
Date: Wed, 9 Aug 2023 09:54:14 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the net-next tree
Message-ID: <2023080901-scabbed-trailside-3996@gregkh>
References: <20230809133723.2ebeddd7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809133723.2ebeddd7@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 01:37:23PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tty tree got a conflict in:
> 
>   arch/powerpc/sysdev/fsl_soc.c
> 
> between commit:
> 
>   62e106c802c5 ("net: fs_enet: Remove stale prototypes from fsl_soc.c")
> 
> from the net-next tree and commit:
> 
>   80a8f487b9ba ("serial: cpm_uart: Remove stale prototype in powerpc/fsl_soc.c")
> 
> from the tty tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Fix looks good to me, thanks!

greg k-h

