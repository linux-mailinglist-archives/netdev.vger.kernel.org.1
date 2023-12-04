Return-Path: <netdev+bounces-53603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901F9803E0E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08421C209A3
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979130F8D;
	Mon,  4 Dec 2023 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFTCFd9Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE42E847
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 19:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C9BC433C8;
	Mon,  4 Dec 2023 19:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701716794;
	bh=uYS9kHXH5AlsD/GOAW97auDQUluu3tWNnU6N4o8x+qY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OFTCFd9QeWLveVtY2PpT4gKqLLh8t9bgUshTTFrI00WUzOb4FKlfqswxyM09NQgZa
	 iVVpZN5eDQpqpqxWpaHnFTnBnkfbzjeV71IZAIS/Y8Rfr0R+h2+3MwigzcJ1bx5ven
	 pXRqOujBWabektgOs0izJQXCu5jZlV2wT7wLOQiYHbRIfuD/EGsoGog1OElDga1fGi
	 sXI4jhVD0OHuHXry7FuB4i5M3GpJWg+rHEVNBt7uL69o7Rd8G2/G8zJB8aLPX/Tl6U
	 STrfzOfT16iE7e4qZgGxCnyMVvIil3zs3Qb5/hQOGmR2ofB1Q5qNkrga0Alqoa2bb6
	 KNfbULps6j87g==
Date: Mon, 4 Dec 2023 11:06:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Neal Cardwell <ncardwell@google.com>
Cc: patchwork-bot+netdevbpf@kernel.org, "David S. Miller"
 <davem@davemloft.net>, Coco Li <lixiaoyan@google.com>, edumazet@google.com,
 mubashirq@google.com, pabeni@redhat.com, andrew@lunn.ch, corbet@lwn.net,
 dsahern@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 wwchao@google.com, weiwan@google.com, pnemavat@google.com
Subject: Re: [PATCH v8 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
Message-ID: <20231204110632.7f8cb41f@kernel.org>
In-Reply-To: <CADVnQymKa65a7O=YHqbjm3042+HusyP2t0m_ocf6RXkaRTwjnw@mail.gmail.com>
References: <20231129072756.3684495-1-lixiaoyan@google.com>
	<170155622408.27182.16031150060782175153.git-patchwork-notify@kernel.org>
	<CADVnQymKa65a7O=YHqbjm3042+HusyP2t0m_ocf6RXkaRTwjnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Dec 2023 17:36:10 -0500 Neal Cardwell wrote:
> Both from this email and the git logs it looks like the last two
> commits didn't make it in?  Is that intentional? :-)

Trying to apply them now - it looks like there's a conflict.
Coco - could you respin just the last two?

