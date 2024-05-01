Return-Path: <netdev+bounces-92828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362548B905D
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 22:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBDB1C220E8
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 20:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F38016191B;
	Wed,  1 May 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmjB2rHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B471474B1
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593876; cv=none; b=Gx1Aw7njUcTGkyLALbE10Nm7aJT02dwiPMy4FDVYjhXUCE258BSZdQGcgXM3wJ+BA+cRBZBH2qeTlv6dO1cZS9y+phpeXOBj6dPG/I/bccHCoNWB9kXsVxJPNMI9YQXOS6hZGoXoWzD7lukK/7B50EmaiMeaDkt/3Mq+iAoaOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593876; c=relaxed/simple;
	bh=xPiivzTQCy0vFa9nbWp/sCn9yKhbNnjpl8JXzH4fipU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty/Z7UMhrZgmPNtbdorhB3LvFCjfNXt5IWy7ELgeRrWIBRgCQLZRYNiosl3ssJqwlQh7ILUbwT8KiDgu8RQsOnLwYRH1XqjPEBPAjXAsdjbhchrKnSBPYpMOGuuAIK0N4ozXvyp76m7kLrRTwSlIBR/0sKENn6lOuDGkjWUtEd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmjB2rHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE521C072AA;
	Wed,  1 May 2024 20:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714593876;
	bh=xPiivzTQCy0vFa9nbWp/sCn9yKhbNnjpl8JXzH4fipU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmjB2rHrF5jduqd4XpPAVBlTfMxZEsOhit0hBBzUIWVfAjzd9LFIM3/rHG++z2eZR
	 vL9QeG6vV1khuhWKfj8DhkPlvdIzhuJ9UPCehN9sZwNbhIGf/eLia2og8OueZm3y27
	 ePp6i6b1DXQST5InuTWBMAFosOAUm3itEklfaGf353LiDwoQDhhJD9a8YVBXn26QIb
	 ijqCvrXsSDwWoncUNb161yMqQy2YPScDQhSuDQG47PqXApSSQ0e4hXZuseSKiZSYTu
	 EqxN0jf0AIPVnx8DxF1zt6qTxnbt99gAHtHADFydVU9hl+Upe3H1Ydsa6hzXVeY0R5
	 a16xvjNGUD25A==
Date: Wed, 1 May 2024 21:03:01 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Raju.Rangoju@amd.com,
	Varun Prakash <varun@chelsio.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH net] MAINTAINERS: orphan Chelsio drivers maintained by
 Raju Rangoju
Message-ID: <20240501200301.GK516117@kernel.org>
References: <20240430234127.1358783-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430234127.1358783-1-kuba@kernel.org>

On Tue, Apr 30, 2024 at 04:41:27PM -0700, Jakub Kicinski wrote:
> Raju seems to work at AMD now, and the Chelsio email address
> bounces.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CCing other Chelsio maintainers:
> 
> CC: Varun Prakash <varun@chelsio.com>
> CC: Ayush Sawal <ayush.sawal@chelsio.com>
> CC: Potnuri Bharat Teja <bharat@chelsio.com>
> 
> Please feel free to send your own patch to nominate someone
> else, I'll keep this patch in patchwork until the end of
> the week, and only apply it if there's no patch from you.

Perhaps an entry for Raju in .malmap  is also appropriate?
If so, I'd kindly request that he send a patch.

