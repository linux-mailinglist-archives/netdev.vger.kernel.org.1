Return-Path: <netdev+bounces-14619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F75742B07
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C881C20B08
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAAD13AD7;
	Thu, 29 Jun 2023 17:06:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED813AC3
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 17:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C2AC433C0;
	Thu, 29 Jun 2023 17:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688058401;
	bh=snyLsXHVhbxKXmXIpWLRNYYMnAJeU7sVB5JSeB+DrS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eU9MBbQ6pFaX4UtoGXg8D3oGSWg/xo6SYHzJH+Ucnv2yJQW19cnnrN/ZbvJ23CKeJ
	 8R5P855h/17RbJnwyLFiHE84xkxCooGl6r7OGHwm8TMdFoA0CaYbXKZG7BG7fUM/AV
	 gZgXoih6qQlA9se4M1PAnjlrBF/Kd5OfF8oROf1UKSUL7+DvZYk/jtc7QXRhhCKY2Y
	 vw3kq9wL2j2bXI/BJmHkkZxcNFEirC0uvJRzS02ZZqjI093R17cy3NczCK+eNAlXXV
	 5EX5THE32sAIH4ufXljJBCGP/NafhCxV9f4B9zCcCH4GrqrB4oM+t2SA2wxQS6KOs2
	 T9QcHXxtP/8Bw==
Date: Thu, 29 Jun 2023 10:06:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, Ajay Sharma <sharmaajay@microsoft.com>, Dexuan Cui
 <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Long Li <longli@microsoft.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Message-ID: <20230629100639.140925ab@kernel.org>
In-Reply-To: <PH7PR21MB3116276E09BFD0950FB0FB49CA25A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
	<36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
	<PH7PR21MB3116276E09BFD0950FB0FB49CA25A@PH7PR21MB3116.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jun 2023 16:53:42 +0000 Haiyang Zhang wrote:
> This web page shows the net-next is "open":
> http://vger.kernel.org/~davem/net-next.html
> 
> Is this still the right place to check net-next status?

We're working on fixing it. Unfortunately it's a private page and most
of the netdev maintainers don't have access to changing it :(

