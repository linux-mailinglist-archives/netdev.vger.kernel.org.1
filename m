Return-Path: <netdev+bounces-57023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 726048119B1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2F4B20E95
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDDE364AF;
	Wed, 13 Dec 2023 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/lrTRDe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCEB35F10;
	Wed, 13 Dec 2023 16:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2782C433C7;
	Wed, 13 Dec 2023 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702485573;
	bh=rStxgFG6G2j6Xq6v8UkeXPvsBbpOgXGFPUEN/yPoJcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d/lrTRDeyj5P3+GTqMfBYc4hu43U/aN/gXvYWMHynxpfHh+itEQOc9RtDYV93AaPS
	 dBS8JVaeezcP9dYhGjVfFXCUoIPdqqWAudR5lWKOzrAeqMVn82oa9xs+yEkoNDS0tp
	 8D4hius7ZcaZMxcUVjIgMnHDHa/++As930XUTq9ELV1aFXUdjTtZj7tet45snXBx43
	 LKUq7xWMdeQBxc/ucLxGigAbJljIHNb78g6AbmE3Z5/BacenmYsbl97OYLZS07ASif
	 JesS5PamxVVoDhuUiVIwZAIlGKIUFxhV3W9wCahYTRC12LjIHYdXSRU0Sqge0omOrJ
	 TbHqcnEqSt69Q==
Date: Wed, 13 Dec 2023 08:39:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 09/13] doc/netlink: Regenerate netlink .rst
 files if ynl-gen-rst changes
Message-ID: <20231213083931.2235ca18@kernel.org>
In-Reply-To: <m21qbq780z.fsf@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
	<20231212221552.3622-10-donald.hunter@gmail.com>
	<ZXjuEUmXWRLMbj15@gmail.com>
	<m21qbq780z.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 09:42:52 +0000 Donald Hunter wrote:
> Sure, the transitive dependency is sufficient. I tend to add an explicit
> dependency for a script that gets run in a target.
> 
> Happy to remove that change and respin if you prefer?

I can drop patch 9 when applying if that's what you mean.
No need to repost the sub-message support.

