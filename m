Return-Path: <netdev+bounces-40647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3B37C81F8
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49501281EF8
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF910A22;
	Fri, 13 Oct 2023 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4MivpCe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21510A17
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C37C433C8;
	Fri, 13 Oct 2023 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697189177;
	bh=E9/0n9LD/3cTgp1J3dMrzLvgcdHdGIWkLFZiOEzQPe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4MivpCeIlf5lPj5gu87Vx6jggV0nhy+otJc08N5cogxnNrWLh2fZz60tA4fE+nzb
	 NojezG0O4S76IxeOpzQvWS7XTej8HHXZDlAD48TCogl58KWFBZAh6xSnTMTxNpZ07T
	 l3wdwWSTBx/AWenQP6TL4SFqge12GHcXeegxRxYbEvLotsrEpWIv3rnqbXwMGehwpz
	 LsrhuEWijiCcLpngvCw/fxMIpbZh+l66av3hrv64HY+Xnyk1zapl2onqQKWGLbKV0r
	 ChitxTpt6s9z/LXg2UHt5CtZ68tzY9YrPi2cJYZTadzNaOMp1vCaJWHGJmyXJaoVoq
	 Y7eqpxl9ZehHg==
Date: Fri, 13 Oct 2023 11:26:12 +0200
From: Simon Horman <horms@kernel.org>
To: George Guo <guodongtai@kylinos.cn>
Cc: fw@strlen.de, coreteam@netfilter.org, davem@davemloft.net,
	dongtai.guo@linux.dev, edumazet@google.com, kadlec@netfilter.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	pabeni@redhat.com, pablo@netfilter.org
Subject: Re: [PATCH v2] netfilter: cleanup struct nft_table
Message-ID: <20231013092612.GA29570@kernel.org>
References: <20231007105335.GB20662@breakpoint.cc>
 <20231009025548.3522409-1-guodongtai@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009025548.3522409-1-guodongtai@kylinos.cn>

On Mon, Oct 09, 2023 at 10:55:48AM +0800, George Guo wrote:
> Add comments for nlpid, family, udlen and udata in struct nft_table, and
> afinfo is no longer a member of struct nft_table, so remove the comment
> for it.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Thanks,

I checked that the fields of the structure now match the kernel doc
for struct nft_table.

I might have mentioned kernel doc, or similar in the subject,
but I don't think there is a need to respin because of that.

As a follow-up, you may want to consider addressing
other kernel doc problems in the same file.
The following command may be helpful there.

  ./scripts/kernel-doc -none include/net/netfilter/nf_tables.h

Reviewed-by: Simon Horman <horms@kernel.org>

