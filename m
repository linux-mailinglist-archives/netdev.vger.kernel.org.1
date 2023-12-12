Return-Path: <netdev+bounces-56495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFA980F1FE
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2581B1F216A5
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32197765F;
	Tue, 12 Dec 2023 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExMUzt3O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7047765C;
	Tue, 12 Dec 2023 16:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31FDC433C9;
	Tue, 12 Dec 2023 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702397492;
	bh=V+2nKPrBuelC02/BekW0VYkuAWOX+IxzSFJnsB1wVcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ExMUzt3Owe8bqwyjpoDGLeVYc9rOlo4hO4B/1nqcJ6e4jrMylBZBUjXBtsGXr2amC
	 lmwraX2yRdyvUF+7mEu9H8408FZ2e73gynqzNARoolNUgvIrw07Q4SSyoLGzQjd2vk
	 jXT3tNIxQ0ek1G7DovoCqN7gLHXVcJs4kKcRf9mn3toQAnn6jZ278SSOVCmtCL31u2
	 +DeNFSI6W4GzK7a5xemMyiH+X4/Q4ByrmJgXJ3ZwSkNsX5dZQYsk6DsqvsCOCNo31W
	 VHcvqvbCsW6JkMDmQ5aHQ/u2fJXXdfQ0ClsLFaALX6SaZ452Js9X/w2e0aNhwEVtmY
	 3yU9ZFqFNeFOQ==
Date: Tue, 12 Dec 2023 08:11:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH net-next v2 01/11] tools/net/ynl-gen-rst: Use bullet
 lists for attribute-set entries
Message-ID: <20231212081130.6d5beb88@kernel.org>
In-Reply-To: <m2h6kn8xux.fsf@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211164039.83034-2-donald.hunter@gmail.com>
	<20231211152806.42a5323b@kernel.org>
	<m2h6kn8xux.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 11:27:18 +0000 Donald Hunter wrote:
> Okay, then I think we need to try and improve the formatting. Currently
> h3 and h4 both have font-size: 130% and the attribute headings get
> rendered in bold so they stand out more than the attribute-set headings
> they are under. I suggest:
> 
>  - Removing the bold markup from the attribute headings
>  - Changing h4 to font-size: 110% in sphinx-static/custom.css

SG, but probably as a separate change directed at linux-doc tree?

> That improves things a bit but I feel that the attribute-set headings
> still get a bit lost. Not sure if there is anything we can do about
> that. The devlink spec is a fairly extreme example because it has a lot
> of subset definitions that look especially bleak.

Right.. nobody bothers documenting in the old families.
netdev is probably the example to look at when deciding on what looks
okay, hopefully it's closer to what new/documented families would look
like.

