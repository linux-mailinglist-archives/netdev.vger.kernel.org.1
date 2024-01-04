Return-Path: <netdev+bounces-61684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 148AA8249F8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 22:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41A5283890
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 21:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D6528E0C;
	Thu,  4 Jan 2024 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/bT9sLR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2F2C698;
	Thu,  4 Jan 2024 21:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62690C433C7;
	Thu,  4 Jan 2024 21:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704402204;
	bh=VYIWFMQXc4f6IJ8Qr+i+pBSV952/XD0wvFSjHipdn3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M/bT9sLRJLS0xe1V3HiTbSI0b0L0PHFjosjdIGnJJ5Ad99j0SRpLcuioRxn4XI5l2
	 LOWF9fSDdwJfUrSZJfIRdJEl2CZtJWk2KDk22Ceknq+HwFrO7p3kXpImWwAnxUe/1a
	 z7lDCsRZNqOU24oky7uAjgbTqysCz3n/W/4YhUuYo6ucVNfqXX2lphyXte088XGLbQ
	 L5WTXykI+pjMByoffawVJFty3q4lJrE206L2q7BxPU9EfWTqNzik2dzOiLnvMc8EQI
	 UyQ08gjUdLjUzP9VVYWTc2bum85u3byPAaVIMJXjIaBnWCDytX25rB4WMpSBRexdeU
	 ND5jy56e/b/hA==
Date: Thu, 4 Jan 2024 13:03:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, hgani@marvell.com, vimleshk@marvell.com,
 sedara@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
 pabeni@redhat.com, horms@kernel.org, wizhao@redhat.com, kheib@redhat.com,
 konguyen@redhat.com
Subject: Re: [PATCH net-next v2 0/8] add octeon_ep_vf driver
Message-ID: <20240104130323.016675ed@kernel.org>
In-Reply-To: <170420582986.19051.12786293440170247050.git-patchwork-notify@kernel.org>
References: <20231223134000.2906144-1-srasheed@marvell.com>
	<170420582986.19051.12786293440170247050.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jan 2024 14:30:29 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
>   - [net-next,v2,1/8] octeon_ep_vf: Add driver framework and device initialization
>     https://git.kernel.org/netdev/net-next/c/ebdc193b2ce2
>   - [net-next,v2,2/8] octeon_ep_vf: add hardware configuration APIs
>     https://git.kernel.org/netdev/net-next/c/5f8c64c2344c
>   - [net-next,v2,3/8] octeon_ep_vf: add VF-PF mailbox communication.
>     https://git.kernel.org/netdev/net-next/c/db468f92c3b9
>   - [net-next,v2,4/8] octeon_ep_vf: add Tx/Rx ring resource setup and cleanup
>     https://git.kernel.org/netdev/net-next/c/6ca7b5486ebd
>   - [net-next,v2,5/8] octeon_ep_vf: add support for ndo ops
>     https://git.kernel.org/netdev/net-next/c/8f8d322bc47c
>   - [net-next,v2,6/8] octeon_ep_vf: add Tx/Rx processing and interrupt support
>     https://git.kernel.org/netdev/net-next/c/77cef1e02104
>   - [net-next,v2,7/8] octeon_ep_vf: add ethtool support
>     https://git.kernel.org/netdev/net-next/c/50648968b3e3
>   - [net-next,v2,8/8] octeon_ep_vf: update MAINTAINERS
>     https://git.kernel.org/netdev/net-next/c/c902ba322cfd

Reverted.

