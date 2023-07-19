Return-Path: <netdev+bounces-19236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4530375A03F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 22:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387EB1C21026
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 20:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE361BB33;
	Wed, 19 Jul 2023 20:57:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A50C1BB20
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 20:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF328C433C8;
	Wed, 19 Jul 2023 20:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689800227;
	bh=VjXFXrPKoTQJ3a+MJ2EqAjy9uH7Klvczn+67Omtrod4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tZk9ljgUNwsRjB4fpaiPd7O83dDTtLlqM8Tmg0Vu6y285JvBcwtRxxkgJAhEmsVOt
	 6Lmp+GsBxxixosTwjjPzT6GDULByG7suYV+0zVQQb15TCLGryYXTUJXR3g353LDBdt
	 6hPiBQPGyq7cIuQgBTKrUxiTl8CXwkrUcVtL6uNs2AE1CLke/jPEbwxBjFOYXKZFXU
	 Uj/I4v4CyG9i5ypFbCU2/7hQRRy6wq+LSYC7UI7ahWE7uTDedMLhGUC92xDv4R/pCT
	 pjiDuNMkNUX/RzPtZSOmKfGc4cI81pjonkOBI7LRndRUkXkgWUrC30Uz98ApToMTzV
	 wrGGPUmwLDNcw==
Date: Wed, 19 Jul 2023 13:57:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: delete "<< 1U" cargo-culting
Message-ID: <20230719135706.5a46a178@kernel.org>
In-Reply-To: <2ff150de-8997-47bc-a3dd-114c60a7c912@p183>
References: <7b6fdc07-fd7c-48eb-ad17-cc5e436c065b@p183>
	<b3faaa6387edd97c93862cd6838808d051e338e6.camel@redhat.com>
	<2ff150de-8997-47bc-a3dd-114c60a7c912@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jul 2023 14:29:05 +0300 Alexey Dobriyan wrote:
> > Indeed. Still this patch is quite invasive and the net benefit looks
> > quite marginal - if any at all.  
> 
> I have all tree converted, this is just net/ part.
> 
> Net(!) benefit is more readable code.

Please don't argue with the maintainer about subjective stuff.
The noise in the history is not worth this noop patch.

Do compilers warn about this unnecessary type annotation?
If they did, and you were planning to enable such warning kernel-wide -
that'd be the only reason which could make the change worth considering.

