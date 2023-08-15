Return-Path: <netdev+bounces-27820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C0F77D5E9
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 00:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8793C1C20D76
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 22:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02993198AA;
	Tue, 15 Aug 2023 22:27:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5217ACA
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 22:27:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D881BFF;
	Tue, 15 Aug 2023 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aFm90R+tDTFvDBLdwRCYQE4Y41kg8AEvvcWG6AcDlHc=; b=m+Hvj3w2nGUh/z5FvuS2WaFvCP
	E9VTMTriBBsaYE1DW7gg45cfxPOHyZo+qnJy5YDlRNwx/8IEd6QSy1kFsWmCaI6Ayn2U1e18uzlwr
	1+Iy9qd60pMllaFg/MtWE7G1QlLCx82ZCCAIzB8O5VbfxRwp9DMOrRwt9Ca10lMltY10Km8PtNXu/
	L6WobTanJRf/8tEi6GPMdzrRmGdH4Dw9KByfrbTqLo06X3hWeNkANUIM+i1BPRo1BIMLMC8dpsrXD
	Hz59LovBcm5X+3VH7+EtsxrFP7ARkSjVCRHEyC2IZkI52jv17UdFdX7UcYwBUjCHLaKBVrUaPumbs
	W9PGgB4A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qW2VM-002iR6-1x;
	Tue, 15 Aug 2023 22:27:12 +0000
Date: Tue, 15 Aug 2023 15:27:12 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Joel Granados <joel.granados@gmail.com>
Cc: rds-devel@oss.oracle.com, "David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>, willy@infradead.org,
	Jan Karcher <jaka@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@verge.net.au>,
	Tony Lu <tonylu@linux.alibaba.com>, linux-wpan@vger.kernel.org,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	mptcp@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Will Deacon <will@kernel.org>, Julian Anastasov <ja@ssi.bg>,
	netfilter-devel@vger.kernel.org, Joerg Reuter <jreuter@yaina.de>,
	linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-sctp@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-hams@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
	coreteam@netfilter.org, Ralf Baechle <ralf@linux-mips.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>, keescook@chromium.org,
	Roopa Prabhu <roopa@nvidia.com>, David Ahern <dsahern@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Wenjia Zhang <wenjia@linux.ibm.com>, josh@joshtriplett.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>, lvs-devel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	bridge@lists.linux-foundation.org,
	Karsten Graul <kgraul@linux.ibm.com>,
	Mat Martineau <martineau@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v3 00/14] sysctl: Add a size argument to register
 functions in sysctl
Message-ID: <ZNv7wOmUPpCUFnHA@bombadil.infradead.org>
References: <20230809105006.1198165-1-j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809105006.1198165-1-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 12:49:52PM +0200, Joel Granados wrote:
> What?
> These commits set things up so we can start removing the sentinel elements.
> They modify sysctl and net_sysctl internals so that registering a ctl_table
> that contains a sentinel gives the same result as passing a table_size
> calculated from the ctl_table array without a sentinel. We accomplish this by
> introducing a table_size argument in the same place where procname is checked
> for NULL. The idea is for it to keep stopping when it hits ->procname == NULL,
> while the sentinel is still present. And when the sentinel is removed, it will
> stop on the table_size (thx to jani.nikula@linux.intel.com for the discussion
> that led to this). This allows us to remove sentinels from one (or several)
> files at a time.
> 
> These commits are part of a bigger set containing the removal of ctl_table sentinel
> (https://github.com/Joelgranados/linux/tree/tag/sysctl_remove_empty_elem_V3).
> The idea is to make the review process easier by chunking the 65+ commits into
> manageable pieces.

Thanks, I've dropped the old set and merged this updated one onto sysctl-next.

  Luis

