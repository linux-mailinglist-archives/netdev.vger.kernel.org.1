Return-Path: <netdev+bounces-41388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5F7CACCC
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E8BB20D4F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF0328E0B;
	Mon, 16 Oct 2023 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwE77uyM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B46262A1;
	Mon, 16 Oct 2023 15:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2663CC433C9;
	Mon, 16 Oct 2023 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697468523;
	bh=J5b7wIkmNDZePcl6689bb1lqUj0fI6CrDKw3d6N9cNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nwE77uyMYSNbphoXAWn6ygCBN9Q7OQRXv+tz+SPnRISF379jWyUQyfomoc1+mxW+P
	 NIZnRfAqC7tevyg0mOTjTv782qCPLA07+i1UgcSqJvOt9JSMVDjEwOCv2uPKAtxvmY
	 vJRzQTj1EvdV5oQGdwUkT8mhnpJyD3Rl0m935hTPR6wFmLES/JXnhJs7MscEZtAaY9
	 0bf7k93jUqoAJ/4bVq0BMXTEeIzsc46z1jqTcU7Ymq752JZSgaQ6nsayyXx0/2P7fB
	 0qNmHFNfzp6Vtb6D7TS/cXVLLYFRvR0M0fDeIgPzfPK3YyK862ibFTE6AgjLW3C3Bc
	 34jwcmi6xdGYw==
Date: Mon, 16 Oct 2023 08:02:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <corbet@lwn.net>, <jesse.brandeburg@intel.com>,
 <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <andrew@lunn.ch>,
 <horms@kernel.org>, <mkubecek@suse.cz>, <linux-doc@vger.kernel.org>,
 Wojciech Drewek <wojciech.drewek@intel.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v3 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
Message-ID: <20231016080202.0d755ef3@kernel.org>
In-Reply-To: <cf6c824a-be09-4b6c-b2a2-fb870e9f0c37@intel.com>
References: <20231010200437.9794-1-ahmed.zaki@intel.com>
	<20231010200437.9794-2-ahmed.zaki@intel.com>
	<CAF=yD-+=3=MqqsHESPsgD0yCQSCA9qBe1mB1OVhSYuB_GhZK6g@mail.gmail.com>
	<8d205051-d04c-42ff-a2c5-98fcd8545ecb@intel.com>
	<CAF=yD-J=6atRuyhx+a9dvYkr3_Ydzqwwp0Pd1HkFsgNzzk01DQ@mail.gmail.com>
	<cf6c824a-be09-4b6c-b2a2-fb870e9f0c37@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Oct 2023 06:19:54 -0600 Ahmed Zaki wrote:
> >> +#define        RXH_SYMMETRIC_XOR       (1 << 30)
> >> +#define        RXH_DISCARD             (1 << 31)
> >>
> >> Are these indentation changes intentional?
> >>
> >>
> >> Yes, for alignment ("RXH_SYMMETRIC_XOR" is too long).  
> > 
> > I think it's preferable to not touch other lines. Among others, that
> > messes up git blame. But it's subjective. Follow your preference if no
> > one else chimes in.  
> 
> Jakub,
> 
> Sorry for late reply, I was off for few days.
> 
> I'd like to keep this version, I don't see any other comments that needs 
> to be addressed. Can you accept this or need a v4/rebase ?

I think you should add a comment above the define explaining what
"symmetric-xor" is. Is this correct?

/* XOR corresponding source and destination fields, both copies 
 * of the XOR'ed fields are fed into the RSS and RXHASH calculation.
 */

