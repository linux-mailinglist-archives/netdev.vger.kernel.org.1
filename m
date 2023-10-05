Return-Path: <netdev+bounces-38151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624487B9938
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8A2221C2090F
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9F9366;
	Thu,  5 Oct 2023 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx6J4VHv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0F87F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED51C433C7;
	Thu,  5 Oct 2023 00:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696465459;
	bh=HpCZw2Arqycf40EghdUOj7S4+nrc06wVy+hX4rrLYvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kx6J4VHva/cRiqw4+O2m7oBu1dWgiiDhUqrPZUGRNJyAmyVlr+egQnWhpl4iq1Z48
	 gCZiQuyreTmUFbdE1bQlbtNq2pcfQnpNIcqMTJy+maaFzAzHMQxz/gMYZJr99tY1fs
	 WGKpDQuaKzXpA7GsbD9kaxAsVLfLPKifWRBTQ0QL8dAMoAhHgzMgOXft+Nobpa2rX9
	 zeHLMtOhWNO8EM2LAzdsUv0r6vNTvwR+97HIqZZVivgufZc+TDjB1cuhYaNRD7F/kn
	 iD83o/k1FZ8uIm3ScUrXC69cGyuk491oNNHwyv5cpKQN3zsO5QbvugsJCglxb+/Fpv
	 dK2LE9GBnpUAw==
Date: Wed, 4 Oct 2023 17:24:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver
 Updates 2023-10-02 (i40e, iavf)
Message-ID: <20231004172418.30f9c6b0@kernel.org>
In-Reply-To: <20231004172228.211ad344@kernel.org>
References: <20231002185034.1575127-1-anthony.l.nguyen@intel.com>
	<20231004172228.211ad344@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Oct 2023 17:22:28 -0700 Jakub Kicinski wrote:
> On Mon,  2 Oct 2023 11:50:31 -0700 Tony Nguyen wrote:
> > The following are changes since commit 436e5f758d6fbc2c5903d59f2cf9bb753ec77d9e:
> >   Merge branch 'mlxsw-next'
> > and are available in the git repository at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE
> > 
> > Christophe JAILLET (1):
> >   iavf: Avoid a memory allocation in iavf_print_link_message()  
> 
> I don't see this one on the branch, I'll apply from the list..

Actually, I see that there was some discussion on the patch recently.
I'll let you sort this out and repost, maybe it's intentional :)

