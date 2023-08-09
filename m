Return-Path: <netdev+bounces-25929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C030776317
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBC41C2128C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35819BC6;
	Wed,  9 Aug 2023 14:54:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749DC372
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7262FC433C8;
	Wed,  9 Aug 2023 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691592844;
	bh=rQJJnX95ajeAM6wBPnt7GZ/zoWYaUGL41xN81TH/qxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSfe8kKwDJSxCx15NQHRvoPAObeHDlDoyZzBXtrSbcrK+DG/woP9BsgKN7J048cL/
	 iw9Kq2lKh/4YHo2dGfv+qk60ID9PQWEVNaK6UWfKv0g1Lpei/83JojPNg3NGnbDiSN
	 wiZWHO0k7KpoBIodPO6QnBQ+eFepunEiVnWqtAoZ7RI8zNMrnIYpgbTxtJo3DgauNs
	 J5eHmNFP2jYjq02Te5FZpbycRdpG8LyA/l7km2wv17JzOZPu1OVJ2BWyD+qvLSgmwu
	 dr/eZUIvjHg+dyIndQDmPq5pbMFiXpqwLeon5JpPOQfiqoWpHk1cVUL762URo3BZHo
	 0ftCKBHo7Bvhg==
Date: Wed, 9 Aug 2023 16:54:00 +0200
From: Simon Horman <horms@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: jdmason@kudzu.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ethernet: s2io: Use ether_addr_to_u64() to
 convert ethernet address
Message-ID: <ZNOoiGEKsadJIFbU@vergenet.net>
References: <20230808113849.4033657-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808113849.4033657-1-lizetao1@huawei.com>

On Tue, Aug 08, 2023 at 07:38:49PM +0800, Li Zetao wrote:
> Use ether_addr_to_u64() to convert an Ethernet address into a u64 value,
> instead of directly calculating, as this is exactly what
> this function does.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


