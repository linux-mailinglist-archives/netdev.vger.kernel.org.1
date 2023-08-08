Return-Path: <netdev+bounces-25242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E167736C1
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 04:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11104281704
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9B397;
	Tue,  8 Aug 2023 02:34:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC21382
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 02:34:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5AD83;
	Mon,  7 Aug 2023 19:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2sy570se2d1y/tNUc5KxUhtFZdHaIMpjXMloRWfAQC8=; b=LFTrjMpESf0K2WDYsgcYshMVZb
	XVav8xxO1YOSh/f7kB16OzY0uBkVxWCZvBuYbhPMnpSryFVcJMA4U85MD7ki5SJW+wKWHz7l/i5Ud
	asF14iLCZhDvbu3bBlUZpGHDWWZShHGraWmRr0zUN9avXuF4GiC3kbqxQlKmcOfQpYDAw17HvvUYa
	g7VEp36XJrjJHaC6TZnT+EHhXr0jTCtQtZf/X0ow7oIwBOlWCyLO9p3mX//iCo46M6JmQGR0Xskpr
	kQ5/2g384H8/rcW5PZkcI/7KwR40BJHcWTCqG1O79Ofbz7S65Cn4CzgMg7znP4sOgksRuXlcNy/uI
	O/5mNnZA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qTCXt-001YkT-2X;
	Tue, 08 Aug 2023 02:34:05 +0000
Date: Mon, 7 Aug 2023 19:34:05 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joel Granados <joel.granados@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Kees Cook <keescook@chromium.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>, mptcp@lists.linux.dev,
	Vasily Gorbik <gor@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
	coreteam@netfilter.org, Jan Karcher <jaka@linux.ibm.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Will Deacon <will@kernel.org>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	bridge@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	Joerg Reuter <jreuter@yaina.de>, Julian Anastasov <ja@ssi.bg>,
	David Ahern <dsahern@kernel.org>, netfilter-devel@vger.kernel.org,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org,
	Karsten Graul <kgraul@linux.ibm.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-sctp@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Ralf Baechle <ralf@linux-mips.org>, Florian Westphal <fw@strlen.de>,
	willy@infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>, linux-rdma@vger.kernel.org,
	Roopa Prabhu <roopa@nvidia.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Simon Horman <horms@verge.net.au>,
	Mat Martineau <martineau@kernel.org>, josh@joshtriplett.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Eric Dumazet <edumazet@google.com>, linux-hams@vger.kernel.org,
	Wenjia Zhang <wenjia@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
	linux-s390@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com, Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v2 00/14] sysctl: Add a size argument to register
 functions in sysctl
Message-ID: <ZNGpnSCkVYAnfSfa@bombadil.infradead.org>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org>
 <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <20230807190914.4ff3eb36@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807190914.4ff3eb36@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 07, 2023 at 07:09:14PM -0700, Jakub Kicinski wrote:
> On Mon, 7 Aug 2023 14:44:11 -0700 Luis Chamberlain wrote:
> > > This is looking great thanks, I've taken the first 7 patches above
> > > to sysctl-next to get more exposure / testing and since we're already
> > > on rc4.  
> > 
> > Ok I havent't heard much more feedback from networking folks
> 
> What did you expect to hear from us?

Just a sanity review would be nice.

> My only comment is to merge the internal prep changes in and then send
> us the networking changes in the next release cycle.

OK we can do that, I can soak them on linux-next from now so to be sure
it gets wider testing. But review on those parts would be nice.

  Luis

