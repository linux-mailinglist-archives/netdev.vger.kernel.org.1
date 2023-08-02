Return-Path: <netdev+bounces-23764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C62A76D744
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 20:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD4F281988
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 18:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4500CDDBD;
	Wed,  2 Aug 2023 18:55:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFE100C2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 18:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECBEC433C7;
	Wed,  2 Aug 2023 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691002527;
	bh=L3K5t5tBAySBe1mUMWIWhYodRvT3mit3mkedC0sIpDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F1VRdMVAIjZcgesY1p2xbVWEMdQJ9Xvxl0GaYdMORf9mvb2Nh0iRoSWIy15tzteva
	 kX5p7mZLSCDPSWWPLBWtjrit3ZIT6Dy1z8Zs+Uw1s+LSUZ0Lm0p4GbonYv5yy3DvgW
	 YGZqrLUM1Gzg4/RY7T6QjHPtWXg8HYFhTm5tgRpfitSf2exEqMe5C614f8mszc8LY8
	 D6qyFHsbOUuN7e4DCyFVeCQ2t4GGrt9O6TjFV3XZhHKPc4qjYdpNEjHIXx5Kfo1lmS
	 C4pqA8saAq+iJ4OlsR2h+3i34WydF4XyRq3sfpV/MPdgFUQP3+xDfasXY9NYatwq2E
	 vQUWiyzfBuZEQ==
Date: Wed, 2 Aug 2023 11:55:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Maxim Krasnyansky <maxk@qti.qualcomm.com>, Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH net] MAINTAINERS: update TUN/TAP maintainers
Message-ID: <20230802115526.7d2d7c4d@kernel.org>
In-Reply-To: <64caa3a09cbbb_2c6331294a6@willemb.c.googlers.com.notmuch>
References: <20230802182843.4193099-1-kuba@kernel.org>
	<64caa3a09cbbb_2c6331294a6@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Aug 2023 14:42:40 -0400 Willem de Bruijn wrote:
> >  W:	http://vtun.sourceforge.net/tun  
> 
> Should we drop this URL too?

No preference here. I checked that it's online so I saw no obvious
reason to delete it right away. It may also be a good idea to read
thru the in-tree docs and check that they still make sense.
I'd rather leave those kind of cleanups to the new maintainers :)

