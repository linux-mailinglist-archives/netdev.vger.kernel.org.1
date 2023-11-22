Return-Path: <netdev+bounces-50079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4DC7F48BB
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FA33B21051
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735294BAB5;
	Wed, 22 Nov 2023 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZADMSZDH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570814E62A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 14:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83DCC433C7;
	Wed, 22 Nov 2023 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700662619;
	bh=DiRXFvZ/sXfTK9nEfb5dVQe5fvDK5JwFFmgqnaB4fNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZADMSZDHrznYYEie/pT/wGVanpE6/0d3r6Q7lDnGBoPuyQv23VszFXZMIgfu/axHu
	 S7BTSfhr0jcCQwMip/0zu4DCPDgU2lMbMZ/i6xMmhjd4h5UH2DS2/MsyWEn3f1fWTN
	 h90Psy0woJNErHdlBS9Mnm8md6GAKWwYJsaLOrrntdF43ICTFkdmVR6p48AGUOq2cv
	 5oLHwlrElCSNzlX88MqK+BzhbwGkM02wODYrZvySuoGm9uuZIWhhdqNIAHnslHafTL
	 twwDU785tgIanXaH+9proJ53LxKx4nIiwM9h0siWSi91JMiMRlTKzozVqvJ+Ncbdny
	 DBBV7j04+XVmQ==
Message-ID: <2dd8866a-7633-4185-95c4-0619161b0cca@kernel.org>
Date: Wed, 22 Nov 2023 15:16:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/13] net: page_pool: id the page pools
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-3-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> To give ourselves the flexibility of creating netlink commands
> and ability to refer to page pool instances in uAPIs create
> IDs for page pools.
> 
> Reviewed-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   include/net/page_pool/types.h |  4 ++++
>   net/core/Makefile             |  2 +-
>   net/core/page_pool.c          | 21 +++++++++++++++-----
>   net/core/page_pool_priv.h     |  9 +++++++++
>   net/core/page_pool_user.c     | 36 +++++++++++++++++++++++++++++++++++
>   5 files changed, 66 insertions(+), 6 deletions(-)
>   create mode 100644 net/core/page_pool_priv.h
>   create mode 100644 net/core/page_pool_user.c

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

