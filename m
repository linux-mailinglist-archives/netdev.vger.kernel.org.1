Return-Path: <netdev+bounces-53201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCDA8019EA
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 509ECB20C55
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D6917D1;
	Sat,  2 Dec 2023 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrYjLigY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161083D87;
	Sat,  2 Dec 2023 02:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C3AC433C8;
	Sat,  2 Dec 2023 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701483016;
	bh=K7Db/4NUyp/6vuf56jtpAsVSySRroBhJfpHB2jTtD6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jrYjLigY5S3W7B5OHAGp3wlz1MrHjuJbSeRW8X+Lnvulbv8UpocH+7poHd6qnMzaC
	 rNbcURJJF1cgz4/G6nDDNQFI17XvUdiRp2L0yriksh1//o+mf1e/jIDHV/63ng63Vp
	 eE6R8eisf/gAXKtoNXAFrUUeuDa6RUlWXkzPuHGgnIBmtgX/Yzk46LGKt2iK0VyYSC
	 vDl2oYKB88Z9bdHeVqqsHiHOpZouCedylmKtGjujn6Xaqqd+ws3gFmKMr0LTEVliBs
	 N+D8wgbeaC6omWK3Ut9hjQFa94VBMBxQgGEUZc6b6rrvgr1ecKi3JDF7GBK5x3uDUy
	 8L7P5FMPP4wBA==
Date: Fri, 1 Dec 2023 18:10:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 5/6] doc/netlink/specs: add sub-message type
 to rt_link family
Message-ID: <20231201181014.0955104a@kernel.org>
In-Reply-To: <20231130214959.27377-6-donald.hunter@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-6-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 21:49:57 +0000 Donald Hunter wrote:
>        -
>          name: slave-data
> -        type: binary
> -        # kind specific nest
> +        type: binary # kind specific nest

Just to be clear - we can define sub-message for this nest, too, right?

Not sure if it's worth moving the comment in the commit, it's just
noise..

