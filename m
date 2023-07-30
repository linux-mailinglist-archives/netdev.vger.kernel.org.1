Return-Path: <netdev+bounces-22650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BA57686C7
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 19:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDD41C2095D
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 17:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C30914F63;
	Sun, 30 Jul 2023 17:36:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B13D78
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 17:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3787AC433C8;
	Sun, 30 Jul 2023 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690738569;
	bh=7/RMvvZZ9pn9dgxF0AMTjJduZ/wUal5j5NPsWKqFDZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdvis+HXEgJbCSEe9NF6o6koxYgwI4OT+oJeEKCLEyGK+ou1v9o1tr1o43xtaS0vI
	 o1ot7Sx2ZLvI+0xz4DPXGvujmqZpaIgnDZlrVUmFKZqCxqoZ4t+DhDrm4ALbn+7h79
	 oomoPGVllAGJKIv0c0QLuM3JWEfdU+nAvcE16Rhp/xT3af/VVVNuziH9voZTLAIdcy
	 mnU0UjvMjArpaWUBtsuMLVaVH/3rgkvLE5yAAdb+1ekMnVjKoE66bgWH0s6k/zuWAJ
	 FPVJ9Tq6PllPYIqugIU1yzQW+B8VOtfBK61sRRCmbiqLtsUT7aGNE8h4xHxEdxAWcP
	 Mmx+CwPapQA+Q==
Date: Sun, 30 Jul 2023 19:36:05 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Remove unused function declarations
Message-ID: <ZMafhd5Wvichtco2@kernel.org>
References: <20230729122327.12668-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729122327.12668-1-yuehaibing@huawei.com>

On Sat, Jul 29, 2023 at 08:23:27PM +0800, Yue Haibing wrote:
> commit 3cec055c5695 ("rxrpc: Don't hold a ref for connection workqueue")
> left behind these declarations.

It may bot be important, but the while above commit seems for
rxrpc_put_client_conn, perhaps for rxrpc_accept_incoming_calls it should
be:

248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")

Patch looks otherwise fine by me.

Reviewed-by: Simon Horman <horms@kernel.org>

