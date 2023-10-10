Return-Path: <netdev+bounces-39672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD427C049B
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C64281EBD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A7432191;
	Tue, 10 Oct 2023 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="TthprqgE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC33218B
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 19:28:09 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F57AC;
	Tue, 10 Oct 2023 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=69FjPbITmy2sRCCem/htKdGvhrh703nzmiPWrI5DS00=; b=TthprqgEUh/KPhKfPOzit+L+qE
	XrOT5mRHbr1pQq6+p0rNxwcOVDSDReIVxaLaZOQeyHiiK+PlI+wb7gV2k+k2+KklTes/+n6/z8Lhh
	DuPxKu6KHRGCxiCDq60NFsgugpOke8YZzlIpiYWCl0o0XUq/SZ2SPlK37GEYR7cSqtqa6jCac6t5I
	NH7FhUyo6Jmibbp/ZM63TYTkupPpdHyGtDmezV6WQIvCZlF7kcahfqfYxZrCJYj/u5gC1utLDMQmp
	oY9j6Sruo9EFUV1XXtInc1Fj6h0xW4Jbx2wBDW1lgNUgJizRj9DnrMiAuHh6DYTNnoj6/PQUwFeD+
	Z94YCt5Q==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qqIOM-0002CZ-2J;
	Tue, 10 Oct 2023 19:27:42 +0000
Date: Tue, 10 Oct 2023 12:27:34 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	Eric Dumazet <edumazet@google.com>, hch@lst.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: Re: [PATCH net-next v3 2/4] netconsole: Initialize configfs_item for
 default targets
Message-ID: <ZSWlppHwravDLyZN@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com,
	Eric Dumazet <edumazet@google.com>, hch@lst.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org
References: <20231010093751.3878229-1-leitao@debian.org>
 <20231010093751.3878229-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010093751.3878229-3-leitao@debian.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 02:37:49AM -0700, Breno Leitao wrote:
> For netconsole targets allocated during the boot time (passing
> netconsole=... argument), netconsole_target->item is not initialized.
> That is not a problem because it is not used inside configfs.
> 
> An upcoming patch will be using it, thus, initialize the targets with
> the name 'cmdline' plus a counter starting from 0.  This name will match
> entries in the configfs later.
> 
> Suggested-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index d609fb59cf99..3d7002af505d 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -53,6 +53,8 @@ static bool oops_only = false;
>  module_param(oops_only, bool, 0600);
>  MODULE_PARM_DESC(oops_only, "Only log oops messages");
>  
> +#define NETCONSOLE_PARAM_TARGET_NAME "cmdline"

Perhaps `NETCONSOLE_PARAM_TARGET_PREFIX` is better.  Makes it clear this
is not the whole name.

Thanks,
Joel


-- 

"When I am working on a problem I never think about beauty. I
 only think about how to solve the problem. But when I have finished, if
 the solution is not beautiful, I know it is wrong."
         - Buckminster Fuller

			http://www.jlbec.org/
			jlbec@evilplan.org

