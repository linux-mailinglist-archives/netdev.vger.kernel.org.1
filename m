Return-Path: <netdev+bounces-22943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105876A232
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 22:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF410281348
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A0B1DDE5;
	Mon, 31 Jul 2023 20:51:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149A318AFF
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 20:51:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7AC1996;
	Mon, 31 Jul 2023 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0rQhfOHno9kOrBF8fBhXP/I9K++I3qDiyVLQoCDK1W4=; b=M5P5CTtU8QVHseBu0j23jZKJQ5
	zdmFeCi+q8wFnS2+KLHSjnJHSd5pnzFickjfzr8jPwi/vCHqAcZ9WCA0mR/QI+0Kjh6XoL08hbzME
	VBoQ7z2I6Dq5QBWWD3rWbO5iIaX+lC0AM/wvJ+GiOSWfF9SPutpolOgNZ/ukNLIzK/aedDEcVPyTh
	B6h6pyyaLRZgV2Xnjk90uOZf4W9KyZ4Eh/0yo+2JjiRxVLIfvbTk5JuH66kGyMozCxgEvJ5Em1xlL
	kXWtKSBK2wPTpBoShax3yAK0g9H7optbF9G7QT4V+AJEEI2MXcMbpAcaMH4qxLMKm3Dc+XsCAUXi2
	4McdhxWA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qQZqi-00HKH5-1O;
	Mon, 31 Jul 2023 20:50:40 +0000
Date: Mon, 31 Jul 2023 13:50:40 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Joel Granados <joel.granados@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Kees Cook <keescook@chromium.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>, mptcp@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>, coreteam@netfilter.org,
	Jan Karcher <jaka@linux.ibm.com>,
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
Message-ID: <ZMgeoDT0t3NeALM0@bombadil.infradead.org>
References: <20230731071728.3493794-1-j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731071728.3493794-1-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 09:17:14AM +0200, Joel Granados wrote:
> Why?

It would be easier to read if the what went before the why.

> This is a preparation patch set that will make it easier for us to apply
> subsequent patches that will remove the sentinel element (last empty element)
> in the ctl_table arrays.
> 
> In itself, it does not remove any sentinels but it is needed to bring all the
> advantages of the removal to fruition which is to help reduce the overall build
> time size of the kernel and run time memory bloat by about ~64 bytes per
> sentinel.

s/sentinel/declared ctl array

Because the you're suggesting we want to remove the sentinel but we
want to help the patch reviewer know that a sentil is required per
declared ctl array.

You can also mention here briefly that this helps ensure that future moves of
sysctl arrays out from kernel/sysctl.c to their own subsystem won't
penalize in enlarging the kernel build size or run time memory consumption.

Thanks for spinning this up again!

  Luis

