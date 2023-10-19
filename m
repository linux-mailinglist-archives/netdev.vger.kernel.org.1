Return-Path: <netdev+bounces-42825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BC27D0417
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 23:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B17F1F22EE3
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5263DFFE;
	Thu, 19 Oct 2023 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="to2UauIl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DDE3DFE5
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 21:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F187CC433C7;
	Thu, 19 Oct 2023 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697751605;
	bh=x8GN6NCbu6Jk2mBeilh7gQpV1V166ITF8wV8WZ8Ek0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=to2UauIl3D3hwG5RmRnkrOS1DYL9XFSGhy7AnbJaHCXWB1KffB7tMJGcltBXZrPX/
	 SHMTWHuFFaofvz6bf3vJdB4IeeiQxmo6X8zAS23BT8h6gUAVWiNKvR33JNhlLkwYM+
	 ggxco2EUInTehFsFfMqBACGYg25QC1ZCogOlH+ia56BF4SMuN9OwCq9Ibkec22r68g
	 CsA43XYVJiaJb3RJnH2PR3mqScVUDo6B3NPaSk39dEMnQ2ertwr1BKYuy2/Vl9YHtp
	 GabfRHHgXvBtGKTkWBPyxaz4KiuMID8YUgSztQAuFkdHSFymoCP4enVoq3aGk9fPt/
	 +DfOeIAXj8LJg==
Date: Thu, 19 Oct 2023 14:40:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, David Miller
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Kalle Valo
 <kvalo@kernel.org>, Networking <netdev@vger.kernel.org>, Wireless 
 <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List 
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List 
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the wireless
 tree
Message-ID: <20231019144004.0f5b2533@kernel.org>
In-Reply-To: <987ecad0840a9d15bd844184ea595aff1f3b9c0c.camel@sipsolutions.net>
References: <20231012113648.46eea5ec@canb.auug.org.au>
	<987ecad0840a9d15bd844184ea595aff1f3b9c0c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 10:10:10 +0200 Johannes Berg wrote:
> > I fixed it up (I just used the latter, there may be more needed)  
> 
> Just using net-next/wireless-next is fine, I actually noticed the issue
> while I was merging the trees to fix the previous conflicts here.

Resolved the conflict in 041c3466f39d, could you double check?
Also, there's another direct return without freeing the key in
ieee80211_key_link(), is that one okay ?

