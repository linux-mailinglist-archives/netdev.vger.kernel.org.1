Return-Path: <netdev+bounces-40963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A707C932D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 09:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180F8B20BFB
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 07:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268EF53B1;
	Sat, 14 Oct 2023 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8PPVnun"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060BA539E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 07:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6B1C433C8;
	Sat, 14 Oct 2023 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697268135;
	bh=1Mn3itnZ++kLmHTllHIv3u1PhkC+lhf7TcPUsCNOnQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8PPVnunTR5XP3yBL2B/MF92o2F2m05v7i68U9+6gy+VCthVJIYMylBMJ3z1XW1m8
	 RfPPg6MLSbIBSw0xQ9G0x7gmLizGKW1k1MsPmVIG4x2Jfj6W2ezdvmsQlw73LoK1HS
	 ngTK6qub2ePbrR+sj2cfvvVIo0n/5c7LdHX0B/H1s5cYulJ80nyyVsKN3sJdHX/Prz
	 vqiHcT4z+mfajmG88Wu+0YnTxoydsncl9yPQhZ594esvsNXHL61qCX9If89Ty0lrxW
	 pdc+Pzins8HQ96uR6BNmj3n3kjNo+ge981HvvtGX9usc7v2oO8oMXXgwCDoirK70VJ
	 IFhgUDResLLdg==
Date: Sat, 14 Oct 2023 09:22:12 +0200
From: Simon Horman <horms@kernel.org>
To: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: net: wwan: wwan_core.c: resolved spelling
 mistake
Message-ID: <20231014072212.GT29570@kernel.org>
References: <20231013042304.7881-1-m.muzzammilashraf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013042304.7881-1-m.muzzammilashraf@gmail.com>

On Fri, Oct 13, 2023 at 09:23:04AM +0500, Muhammad Muzammil wrote:
> resolved typing mistake from devce to device
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> 

As mentioned elsewhere, the "changes" text below is usually
placed below the scissors ("---").

I'm unsure if a v3 is warranted to address this.

> changes since v1:
> 	- resolved another typing mistake from concurent to
> 	  concurrent
> ---
>  drivers/net/wwan/wwan_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I confirm this corrects the two spelling errors flagged by codespell
in this file.

Reviewed-by: Simon Horman <horms@kernel.org>

