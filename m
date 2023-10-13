Return-Path: <netdev+bounces-40736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3DA7C88D2
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E392F1F212BD
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DCE1BDC8;
	Fri, 13 Oct 2023 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzoAOWaR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF019BB2
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C564C433C8;
	Fri, 13 Oct 2023 15:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697211522;
	bh=lVnd1G0BacgAj5hg/niS/IrsOZDEG8FKK2/F3/5ctjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzoAOWaRK2AJhRD1gIPgUsyoKp18HiPtgGvYc8ueGj5iyieVvth8Z2imW0lv6Lde2
	 nXBvADKYObTTkCnn+tVNA2XzyUzJfX+/WyEohwtUB9sSi9BPJZlWIWALflkblVPQFr
	 vYmfPbs54+336BbPs7m0e1fcy6C/Susc+Rl4xVVGSbK1JmJgtsjmPuJ5+sP5KI8dfG
	 6WSECSRW4hHHmKxZNUZIGmzERbMB7Jo0JFvzEub6vWnICQ2VK4nD+fvJaUsxlHXfPI
	 85X4P5YvnqEYCOvCbTpCjabaGttaM6d7OrE2q427NWUS38c6CrU4HEF6+NUKpuBxZp
	 EPRL8GFxi1Fbw==
Date: Fri, 13 Oct 2023 17:38:38 +0200
From: Simon Horman <horms@kernel.org>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] appletalk: remove special handling code for ipddp
Message-ID: <20231013153838.GN29570@kernel.org>
References: <20231012063443.22368-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012063443.22368-1-lukas.bulwahn@gmail.com>

On Thu, Oct 12, 2023 at 08:34:43AM +0200, Lukas Bulwahn wrote:
> After commit 1dab47139e61 ("appletalk: remove ipddp driver") removes the
> config IPDDP, there is some minor code clean-up possible in the appletalk
> network layer.
> 
> Remove some code in appletalk layer after the ipddp driver is gone.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks,

CONFIG_IPDDP is gone so this code doesn't do anything.

Reviewed-by: Simon Horman <horms@kernel.org>

As a further follow-up should we consider dropping CONFIG_IPDDP*
from various defconfigs it appears in?

