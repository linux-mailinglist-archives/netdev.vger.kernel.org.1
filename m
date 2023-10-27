Return-Path: <netdev+bounces-44647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432437D8E08
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 07:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3501C20EEA
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 05:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1D95249;
	Fri, 27 Oct 2023 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWnvWoxu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2042F3E
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C01C433C7;
	Fri, 27 Oct 2023 05:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698383820;
	bh=/NiCdPoSGMAg8lGrz7v2O2qlsTD5Woo3HpCfh0YCSJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZWnvWoxuohXfcWVjKwccjZN3lp1zIIPDVd3E5xy1G2eVPj+glFMUKNXuZ526g7UlW
	 zgp8MBMLMPeDek8p9XUNyFWsU5h8fzllbYxapWR8vbcyreFa6psn6+L+FYD5LNza86
	 gi6LB3w0P9Z/FJBRM/bTIA7F2I1XH8j4JYwM3o78ihaYBgA4wz/+GzzQqfx+RS8uTJ
	 YpCp745bnvscr5Bc2q0dGqQ5R7c2EN7OjJWe/u++Ay4IHt87r1lGv38LQUO+Mt87g/
	 FGCNplrJxLNttKklPVZjABzWbLnltSqHB7+B3uzzufoLul0z0knlszag+3fnRZaZdx
	 PlOUJTAaOh87w==
Date: Thu, 26 Oct 2023 22:16:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 davem@davemloft.net
Subject: Re: [PATCH net-next 0/6] Intel Wired LAN Driver Updates for
 2023-10-25 (ice)
Message-ID: <20231026221659.3c93b286@kernel.org>
In-Reply-To: <169838345052.10513.926800877011870802.git-patchwork-notify@kernel.org>
References: <20231025214157.1222758-1-jacob.e.keller@intel.com>
	<169838345052.10513.926800877011870802.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Some disturbance in the force:

On Fri, 27 Oct 2023 05:10:50 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
>   - [net-next,1/6] ice: Add E830 device IDs, MAC type and registers

ba1124f58afd

>   - [net-next,2/6] ice: Add 200G speed/phy type use
>     https://git.kernel.org/netdev/net-next/c/24407a01e57c
>   - [net-next,3/6] ice: Add ice_get_link_status_datalen
>     https://git.kernel.org/netdev/net-next/c/2777d24ec6d1
>   - [net-next,4/6] ice: Add support for E830 DDP package segment

3cbdb0343022

>   - [net-next,5/6] ice: Remove redundant zeroing of the fields.
>     https://git.kernel.org/netdev/net-next/c/f8ab08c0b769
>   - [net-next,6/6] ice: Hook up 4 E830 devices by adding their IDs
>     https://git.kernel.org/netdev/net-next/c/ba20ecb1d1bb

