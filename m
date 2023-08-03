Return-Path: <netdev+bounces-24033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E276E8AA
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E18282140
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1445718C01;
	Thu,  3 Aug 2023 12:44:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0AF182C8
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 12:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30983C433C7;
	Thu,  3 Aug 2023 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691066668;
	bh=Qa08Sovz6o8T3mM+xjYv01SqyLaMJRW6NaTElrl6PfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oh3qfx+eWUdmbRQx49bfsbR/o7LqbWqXNTbtquu2W2PTq+LUqRfXYsD/qhhyaQ4Ny
	 xVDd/cG9qA6G/RH7sByktRpHoZCykx0QRO4qUtr1eedajfHQ8Lpm9Gs8IosWf45MLq
	 ZDPdnEtvA2LJEm912WRZ9mCEqyUqaIg4j/ARQnrJol+G6yimoLIRwf+WKwQa6eTFsD
	 9RHTCBLIEBHwoD8gfF5rs/uCB6q7ipLSAMQ/4gli89qFLHKThrwJsJ3sJ5LIPP3o10
	 4Bnwip49mkijbemjIa0ziZDmMZ/dvC7XphG1tBtgOV2M/RoMwD59IH1aUM+PfsANGU
	 hde+OpfcTH6Xg==
Date: Thu, 3 Aug 2023 14:44:24 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: vlan: update wrong comments
Message-ID: <ZMuhKP/KoIAgU1/r@kernel.org>
References: <20230803071426.2012024-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803071426.2012024-1-edumazet@google.com>

On Thu, Aug 03, 2023 at 07:14:26AM +0000, Eric Dumazet wrote:
> vlan_insert_tag() and friends do not allocate a new skb.
> However they might allocate a new skb->head.
> Update their comments to better describe their behavior.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


