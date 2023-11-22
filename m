Return-Path: <netdev+bounces-50160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8640D7F4BDE
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B204B20EAF
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B2E5786E;
	Wed, 22 Nov 2023 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQwhUQjk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041A5786B
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 16:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE574C433C7;
	Wed, 22 Nov 2023 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700668984;
	bh=1XZX8WLf9+mAqhjDETdXLYQZIphQDQL11/rRly7ybI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oQwhUQjk/qz8/gW6FnSHV3LK0WzinwvD4NUPao5GklDQjsgRDv6P8pOp14tdafe0a
	 1k76q/+GrF1EPjMwIe6ShmYIT4669hUie8I+XeHt9JiEurwZ2hgcKJk8Hl+1UqfAvo
	 vtMjuES7bS/H+rrJZUavcFnOwHX2HPQxuyxoKQlQOzXXhr89/P87Ztca+J7T2vzXLU
	 liysQ8xFyozGZV8pUgf+7ot1R+hb9a58VwHqgi3zRbEMb6juxqvbNhHozN+WKufWtt
	 pQML6f5snugUU4Bnv2AvavXn6fDBK8D1FJ0yg6Jdr4D4umUNDsY26lyF5YjEvH6Ggi
	 PJudHvHVkizWw==
Date: Wed, 22 Nov 2023 08:03:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Subject: Re: [PATCH net-next v3 09/13] net: page_pool: report amount of
 memory held by page pools
Message-ID: <20231122080302.35ec94a0@kernel.org>
In-Reply-To: <CANn89i+YXf=Qnjw5HVSwTm3ySj-CK15-k14D2G_uFgmrBD7mXA@mail.gmail.com>
References: <20231122034420.1158898-1-kuba@kernel.org>
	<20231122034420.1158898-10-kuba@kernel.org>
	<CANn89i+YXf=Qnjw5HVSwTm3ySj-CK15-k14D2G_uFgmrBD7mXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 11:16:48 +0100 Eric Dumazet wrote:
> > +      -
> > +        name: inflight-mem
> > +        type: uint  
> 
> 4GB limit seems small, should not we make this 64bit right away ?

Yes, uint is my magic auto-sized integer which can be either 32b or 64b
depending on the value. See commit 374d345d9b5e and 7d4caf54d2e.

