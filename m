Return-Path: <netdev+bounces-44045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B45A7D5ECD
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA93B21092
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E8A47375;
	Tue, 24 Oct 2023 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6vQ9kpX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5171749D;
	Tue, 24 Oct 2023 23:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286A1C433C8;
	Tue, 24 Oct 2023 23:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698191377;
	bh=ktqMxtSml1bYSvEdP8Q21TZv4gTwVBRwz46Upz0r3d8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t6vQ9kpXYf9gCM6iFLZQpUTbVVQFaNXjisc7Jsb1Rnxx2qki9XFvKkcybJwtUV3FZ
	 atlyY5pX3AOA8Hm8GbRNBPVWtfPA12r2h8HaP9tZqgRgw0t/2sT84L9oZ3QPjJ/SW8
	 ZDMmkp4OGav6r80Ivm9raUHZUryHfnUamvmygNSbvZGhNvqCmycGTkI8Bl1FfchhlL
	 9opoBPUfosF9xAdT94uELGU22U5BtiwlpM/Wcybqo3CSB7DV/qg+TjPG/I4hrcE+uD
	 zWwooCldxSh3yV3o4rO5CxZqqZumoy/B+5tJMcPrHKiJiumhewTSgL8zsoLwjGWcye
	 6Mpxu1GypSdpQ==
Date: Tue, 24 Oct 2023 16:49:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Davide Caratti <dcaratti@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Matthieu Baerts <matttbe@kernel.org>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] uapi: mptcp: use header file generated
 from YAML spec
Message-ID: <20231024164936.41ae6f3c@kernel.org>
In-Reply-To: <a29b6917-d578-35c4-978d-d57a3bccd63f@kernel.org>
References: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
	<20231023-send-net-next-20231023-1-v2-5-16b1f701f900@kernel.org>
	<20231024125956.341ef4ef@kernel.org>
	<a29b6917-d578-35c4-978d-d57a3bccd63f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 16:30:27 -0700 (PDT) Mat Martineau wrote:
> I'm not sure if you're offering to add the feature or are asking us (well, 
> Davide) to implement it :)

Either way is fine, Davide seems to have tackled the extensions in patches 
1 and 2, so he may want to do it himself. Otherwise I'm more than happy
to type and send the patch :)

Let's make sure we update documentation, tho, in this case:
Documentation/userspace-api/netlink/c-code-gen.rst

