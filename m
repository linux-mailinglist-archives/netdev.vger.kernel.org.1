Return-Path: <netdev+bounces-20083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA2D75D8D0
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 03:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDD21C21831
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 01:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC4163A5;
	Sat, 22 Jul 2023 01:47:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8B613D
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 01:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36361C433CA;
	Sat, 22 Jul 2023 01:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689990464;
	bh=JCySkRfFBvQY+9+dWRT1CeABgGc8fdS9oje6fYqhUC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r0qpG+rkHXBP83M9xNInEzcNzvuKSJn846IdxCzBlnL6vgABYDEZNtXe51bE8C/Vi
	 WZDcUfVxIBNNOQno8avk/gqQrmZldpRR5PEbgd5tukvSuxz72wj7VTfA9xsWcDBn9/
	 CnCzPeV9HKHDnGOResj/xaGXsg2RWA1HKMOA4fDw6Q9YlQ709A6MsrbOsJFbcXlTA3
	 P16zIMfAb2sDP0UUQ92gaRwLrwGu6O60j4tR7Xvxr3A0NUvk49XZNOFvmdK172jK/z
	 3mnHDHGm+QG3ueNZhuwXCr9kyKyDpQ9s+oVxJz+sPyUTWVJAInSMhPV1K5qa56giEr
	 xs9Kxk+6ueTZQ==
Date: Fri, 21 Jul 2023 18:47:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 mkubecek@suse.cz, lorenzo@kernel.org
Subject: Re: [PATCH net-next 1/2] net: store netdevs in an xarray
Message-ID: <20230721184743.7b602698@kernel.org>
In-Reply-To: <20230722014237.4078962-2-kuba@kernel.org>
References: <20230722014237.4078962-1-kuba@kernel.org>
	<20230722014237.4078962-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 18:42:36 -0700 Jakub Kicinski wrote:
>  #devs | hash |  xa  | delta
>     2  | 18.3 | 20.1 | + 9.8%
>    16  | 18.3 | 20.1 | + 9.5%
>    64  | 18.3 | 26.3 | +43.8%
>   128  | 20.4 | 26.3 | +28.6%
>   256  | 20.0 | 26.4 | +32.1%
>  1024  | 26.6 | 26.7 | + 0.2%
>  8192  |541.3 | 33.5 | -93.8%
          ^^^^^^ ^^^^^^
I failed to clarify these columns are msecs of runtime.

