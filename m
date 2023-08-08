Return-Path: <netdev+bounces-25228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D69C77363C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 04:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCE31C20E15
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D93C39F;
	Tue,  8 Aug 2023 02:09:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3406437E;
	Tue,  8 Aug 2023 02:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFA9C433C7;
	Tue,  8 Aug 2023 02:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691460558;
	bh=K3rT1tMnJnj38jr/g9b0xYkr68We3HjPQOUUOlFXffQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kfyzdKVH4OgGOyi5OtD6F24v25o2XDZ5m6SvveMEOszRKEfZZ9SylUaGPkfodN407
	 7/mPqRmYpPbp2dPcTKlrEIJC1Zv5LRh+2JzB18DxJOynATxXwotatsdvn/NN5ZyIbh
	 xI+yzS42slBVvOmIzuzIZ6xOpvVg9Aci3OwoLZalL/uth32GZhSMU/Wd7rI2yT3/O0
	 8Adq7sCyzqTTK9WNmXggxjvLnQQRycaDNcLAjqz5Xumgx4CBBdd3EH6PcwJH0/qRJv
	 JwU8b8s4wpS/lSbZzxiGwrvY+tzvlO3JN8W9VVJoIsZYauX65nm8kTPwSMSOK7oodS
	 bvwbazvAzKZwg==
Date: Mon, 7 Aug 2023 19:09:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Joel Granados <joel.granados@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Iurii Zaikin <yzaikin@google.com>, Jozsef
 Kadlecsik <kadlec@netfilter.org>, Sven Schnelle <svens@linux.ibm.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, Kees Cook <keescook@chromium.org>, "D.
 Wythe" <alibuda@linux.alibaba.com>, mptcp@lists.linux.dev, Vasily Gorbik
 <gor@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
 coreteam@netfilter.org, Jan Karcher <jaka@linux.ibm.com>, Alexander Aring
 <alex.aring@gmail.com>, Will Deacon <will@kernel.org>, Stefan Schmidt
 <stefan@datenfreihafen.org>, Matthieu Baerts
 <matthieu.baerts@tessares.net>, bridge@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, Joerg Reuter <jreuter@yaina.de>,
 Julian Anastasov <ja@ssi.bg>, David Ahern <dsahern@kernel.org>,
 netfilter-devel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, Santosh Shilimkar
 <santosh.shilimkar@oracle.com>, linux-wpan@vger.kernel.org,
 lvs-devel@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, linux-sctp@vger.kernel.org, Tony Lu
 <tonylu@linux.alibaba.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Ralf
 Baechle <ralf@linux-mips.org>, Florian Westphal <fw@strlen.de>,
 willy@infradead.org, Heiko Carstens <hca@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-rdma@vger.kernel.org, Roopa Prabhu
 <roopa@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Simon
 Horman <horms@verge.net.au>, Mat Martineau <martineau@kernel.org>,
 josh@joshtriplett.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Dumazet <edumazet@google.com>, linux-hams@vger.kernel.org, Wenjia
 Zhang <wenjia@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
 linux-s390@vger.kernel.org, Xin Long <lucien.xin@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
 rds-devel@oss.oracle.com, Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v2 00/14] sysctl: Add a size argument to register
 functions in sysctl
Message-ID: <20230807190914.4ff3eb36@kernel.org>
In-Reply-To: <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
References: <20230731071728.3493794-1-j.granados@samsung.com>
	<ZMgpck0rjqHR74sl@bombadil.infradead.org>
	<ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Aug 2023 14:44:11 -0700 Luis Chamberlain wrote:
> > This is looking great thanks, I've taken the first 7 patches above
> > to sysctl-next to get more exposure / testing and since we're already
> > on rc4.  
> 
> Ok I havent't heard much more feedback from networking folks

What did you expect to hear from us?

My only comment is to merge the internal prep changes in and then send
us the networking changes in the next release cycle.

