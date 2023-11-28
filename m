Return-Path: <netdev+bounces-51533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B207FB04C
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 04:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268D9B212CE
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB963BB;
	Tue, 28 Nov 2023 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGS5RBhh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F863B4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 03:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E42C433CA;
	Tue, 28 Nov 2023 03:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701140543;
	bh=jjjxMjmEbU3Pkl9GYKm1Qg0uq2791T4WlUMI7FS8u0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KGS5RBhhvx2O298BY1FJCYbxlmRZfbtr1cJKj1PFJxuKzWSFPlNde1pKOFYQEDFR/
	 j6umy5bIzl068wZBopv30maHFqAoIM6qRYEl6rksm4adz4/huIMhCtJ/la4a6luiwY
	 rZfoHIxXZTKMoAqLkOoRVNNI1BXDbvuwdfxg9KZlOaFHdOmNpHCcEE2P55jO3XzwkF
	 0OrwJXvA6GNzPf/KoNjNoKR7JLPbKbjOsUZJbJmeLncR7pFyqvUA9IIWW9t8fHbvlx
	 trKDmy/RR/lHYWSmIgsJdJrYeu+b1+N7qEZI9Za8UF5w08qV69ntDdvJYjOADIzhmC
	 /EcZGRzgi+eNQ==
Date: Mon, 27 Nov 2023 19:02:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: Check return value of nix_get_nixlf
 before using nixlf
Message-ID: <20231127190222.293afaec@kernel.org>
In-Reply-To: <1700930098-5483-1-git-send-email-sbhatta@marvell.com>
References: <1700930098-5483-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 22:04:58 +0530 Subbaraya Sundeep wrote:
> If a NIXLF is not attached to a PF/VF device then
> nix_get_nixlf function fails and returns proper error
> code. But npc_get_default_entry_action does not check it
> and uses garbage value in subsequent calls. Fix this
> by cheking the return value of nix_get_nixlf.
> 
> Fixes: 967db3529eca ("octeontx2-af: add support for multicast/promisc packet replication feature")

You need to run the patch thru scripts/get_maintainer,
here you missed CCing Naveen, who authored 967db3529eca.
Also lcherian@marvell.com and jerinj@marvell.com
LMK if these people are no longer at marvell, I can add their
addresses to our ignore list.

Same goes for the pauseparam patch, you'll need to repost the two.
-- 
pw-bot: cr

