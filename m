Return-Path: <netdev+bounces-38063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFFC7B8DC2
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CE690281C4B
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31831224D4;
	Wed,  4 Oct 2023 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="kbYSa7TK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F721A16
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 20:00:09 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3182DAD;
	Wed,  4 Oct 2023 13:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3UgUbzqswLEhIYLsMeLmJBtIHWsl9lF0pUcedalU9Rw=; b=kbYSa7TKEcTi7K3IrRBh2nEBXy
	Tob4nvzqSaB8CpDYrQe17wCHZI+LbZCqUp/bCxtyMYJdDa6QbhHFIxPZ29YlkiAtqcRVCnnIR6BG6
	JZA9tt/5h1YjOHAbHo9j5maK4iYXeSzaMqt0Za2XVUi2aU2rZ1WzrAv1M8+GBqwxfgLjtjjHXxz6P
	Wr32lVeyU6m8UrSsRDBmziqA0LgfZYR/nMO46tj8FjLMzLAM18Zrf52zLpp1EihV4VMi1ndRxihid
	2i9pEzQHIE2onxiMM834Ndmg5LY3KguTyNhxrJM3baUUdciH/LJIXE/RzempEn0niQHCOIv77NztR
	8el9VzFg==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qo827-00Fp2x-0U;
	Wed, 04 Oct 2023 19:59:47 +0000
Date: Wed, 4 Oct 2023 12:59:38 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	Eric Dumazet <edumazet@google.com>, hch@lst.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: Re: [PATCH 1/3] netconsole: Initialize configfs_item for default
 targets
Message-ID: <ZR3EKnepIOKlVGgZ@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com,
	Eric Dumazet <edumazet@google.com>, hch@lst.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org
References: <20231002155349.2032826-1-leitao@debian.org>
 <20231002155349.2032826-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002155349.2032826-2-leitao@debian.org>
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

On Mon, Oct 02, 2023 at 08:53:47AM -0700, Breno Leitao wrote:
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 3111e1648592..b68456054a0c 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -53,6 +53,8 @@ static bool oops_only = false;
>  module_param(oops_only, bool, 0600);
>  MODULE_PARM_DESC(oops_only, "Only log oops messages");
>  
> +#define DEFAULT_TARGET_NAME "cmdline"
> +

I'm not sure `DEFAULT` is the right terminology here.  e.g. it's not a
default for dynamic targets, etc.  Perhaps `BOOT_TARGET_NAME` or
`NETCONSOLE_PARAM_TARGET_NAME`?

Joel

-- 

"Friends may come and go, but enemies accumulate." 
        - Thomas Jones

			http://www.jlbec.org/
			jlbec@evilplan.org

