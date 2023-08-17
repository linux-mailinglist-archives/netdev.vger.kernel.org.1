Return-Path: <netdev+bounces-28308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 341D877EF7D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 05:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1445D1C21255
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ACB638;
	Thu, 17 Aug 2023 03:23:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143F36A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006D8C433C8;
	Thu, 17 Aug 2023 03:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692242585;
	bh=motGxfP4bqSwuFIw+rYV9iQWqzGVHQQKBPlsZd6+Xno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GPniTWFFe/nAWz3sgL8atQXMVLkZ9UxArUq+jeBR06GpFh3UTFxtrZ/6R7GlL/Hb0
	 L/3v3+sK0/5zi57bDqMUPFWb97PbQo8aETgNv1okVqF7AVMKlQJ7pUld01N2lpEIWg
	 iy4sMKaAqL1yMy5OoltbCFJ9zzb+HbF+MYNda0a/LJrEyv380GEb2KbhjMoLpeJimW
	 2dt4wZICpAHkeTY9pR0X8pynnTu9mKl0dPsZJc5K1o50kgL7ok9b6ktK+00x/ATGU+
	 K0UadHqpLDv0A2WTMsLUP3c7hc/Tj3t4FHZo038BMHhKa8C9dlFjzkNe55IcBqmGXg
	 jUXpSWt3I9obg==
Date: Wed, 16 Aug 2023 20:23:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/11] pull request (net): ipsec 2023-08-15
Message-ID: <20230816202304.4a05369d@kernel.org>
In-Reply-To: <20230815095310.3310160-1-steffen.klassert@secunet.com>
References: <20230815095310.3310160-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 11:52:59 +0200 Steffen Klassert wrote:
> ipsec-2023-08-15

Looks merged, 5fc43ce03b in net, thanks!

