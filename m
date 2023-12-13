Return-Path: <netdev+bounces-57127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC24812341
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2366F1C21260
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B10E77B47;
	Wed, 13 Dec 2023 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4YDMVWu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28277B22;
	Wed, 13 Dec 2023 23:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781C1C433C7;
	Wed, 13 Dec 2023 23:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702510699;
	bh=2ISA+cC2LLV7GFwI/SuSnWSerVWCrNM+D6Zx2ToixF8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=T4YDMVWu4JzqNWJudSyUd98/0dp9Z4FQuX2M2y28NQR9RUns/qY08HDHRGxbNrh/W
	 9we65k/s7WqTYMgk1tbZajzhSPM/0YW5KXw46jKUstdgSKQGPQF/b7vwYJpnVt2MIF
	 jr2usHdv1z3j087A/hUz9ww7dEKABh06sCOHX1MxLN62GW4t5iWXbKENP0nT5F4n79
	 VtemLIr2YCSTbGkwXxggKRB5TGlInFsdc/DIDt0uNPY2eyGtcaTh3NTH6tYa9r+RpG
	 xw518DvoPKqstIrONBKtVc8zWGXXyt7aouoHUQ+kmGyu8c6L5raF40khOg2lC06WP1
	 WPy0p4aPDvWDw==
Date: Wed, 13 Dec 2023 15:38:18 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
    pabeni@redhat.com, donald.hunter@gmail.com, matttbe@kernel.org, 
    dcaratti@redhat.com, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 3/3] netlink: specs: mptcp: rename the MPTCP
 path management(?) spec
In-Reply-To: <20231213232822.2950853-4-kuba@kernel.org>
Message-ID: <03869802-eb14-ed32-e9d7-53b17a74904f@kernel.org>
References: <20231213232822.2950853-1-kuba@kernel.org> <20231213232822.2950853-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 13 Dec 2023, Jakub Kicinski wrote:

> We assume in handful of places that the name of the spec is
> the same as the name of the family. We could fix that but
> it seems like a fair assumption to make. Rename the MPTCP
> spec instead.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: matttbe@kernel.org
> CC: martineau@kernel.org
> CC: dcaratti@redhat.com
> CC: mptcp@lists.linux.dev
> ---
> Documentation/netlink/specs/{mptcp.yaml => mptcp_pm.yaml} | 0
> include/uapi/linux/mptcp_pm.h                             | 2 +-
> net/mptcp/mptcp_pm_gen.c                                  | 2 +-
> net/mptcp/mptcp_pm_gen.h                                  | 2 +-
> 4 files changed, 3 insertions(+), 3 deletions(-)
> rename Documentation/netlink/specs/{mptcp.yaml => mptcp_pm.yaml} (100%)
>

Hi Jakub -

The renaming here is fine. "path management" is the right expansion of 
"pm" in this context, so you can remove the "(?)" from the summary line.


Reviewed-by: Mat Martineau <martineau@kernel.org>

