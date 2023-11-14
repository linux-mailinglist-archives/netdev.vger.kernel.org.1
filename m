Return-Path: <netdev+bounces-47811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153617EB6FD
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD931F245A1
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D30026AD1;
	Tue, 14 Nov 2023 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mc0NpQ+k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100701C695
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 19:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23C4C433C8;
	Tue, 14 Nov 2023 19:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699991180;
	bh=AfQYtqw1u7wsFVHfP47gHFUSQcLDhEVnJ7hauFQ5jpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mc0NpQ+k08h14Z+307Z/NobOsarsKopdrQl8w2+I4MpTiCEcNYjXvP6yREXScljVb
	 JkI7R0h083vbAQFhHUJ1rFA7aOFR75K573ai3L6di43nJw28N5yjHnZ3PyTotRFffT
	 x55cVIV4A5mFnHMco5xJLDZlMQTzszrRJSJ5334HTv3bpiYus+lEXbkzYvMgnhcgmP
	 Jkrd4GKAeIauZt1H0Md0Zns9hSizsw4cPs6yjY7LOMUfEOtnpz5clcg3Xq0a9wc8tU
	 dexgdm1CTFqOfo62dD0vjPKAWMpCy8SbuE4T9DLmM6s9HorAT2xRJHnZTF1Zxxo8+d
	 wvxGNIu/GGcsg==
Date: Tue, 14 Nov 2023 19:46:16 +0000
From: Simon Horman <horms@kernel.org>
To: Johnathan Mantey <johnathanx.mantey@intel.com>
Cc: netdev@vger.kernel.org, sam@mendozajonas.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] Revert ncsi: Propagate carrier gain/loss events
 to the NCSI controller
Message-ID: <20231114194616.GG74656@kernel.org>
References: <20231113163029.106912-1-johnathanx.mantey@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113163029.106912-1-johnathanx.mantey@intel.com>

On Mon, Nov 13, 2023 at 08:30:29AM -0800, Johnathan Mantey wrote:
> This reverts commit 3780bb29311eccb7a1c9641032a112eed237f7e3.
> 
> The cited commit introduced unwanted behavior.
> 
> The intent for the commit was to be able to detect carrier loss/gain
> for just the NIC connected to the BMC. The unwanted effect is a
> carrier loss for auxiliary paths also causes the BMC to lose
> carrier. The BMC never regains carrier despite the secondary NIC
> regaining a link.
> 
> This change, when merged, needs to be backported to stable kernels.
> 5.4-stable, 5.10-stable, 5.15-stable, 6.1-stable, 6.5-stable
> 
> Fixes: 3780bb29311e ("ncsi: Propagate carrier gain/loss events to the NCSI controller")
> CC: stable@vger.kernel.org
> Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>

Hi Jonathan,

thanks for addressing my feedback on v2.

So far as addressing a regression goes, this looks good to me.
But I do wonder what can be done about the issue that
the cited commit was intended to address: will this patch regress things
on that front?

...

