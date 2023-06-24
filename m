Return-Path: <netdev+bounces-13738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23E573CCB1
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF071C20945
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 20:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22403882F;
	Sat, 24 Jun 2023 20:47:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D43C10
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 20:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7FBC433C8;
	Sat, 24 Jun 2023 20:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687639625;
	bh=/B/CgsHvmqew30rPSVDP9OK+g5wneyDQWB0DATDcLuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WRp1ta77xC/PyOsD/3mb4EGmJTd7ENsfQb8x4dGoVGt/W2UnNhAumNsGdjqeWFw7N
	 eH4/mBE3NZrMf4sArf3UL/xrxwuy8ffz10Dp/WfcfkHOogJzOO/KYx4cHpM7F+ke4N
	 y0YcmcXpvg1Y4lzKMcajims6p5vnqRFf07p2jHcr+u9A9UZDauK0DBcaVTd2D4L7Eu
	 C78+b/SQfl2s3YIdX+qbjDNFLZW0GNzFVM2CTV6iJBSzVVKsL0ORDDf8ljYTWlqWbq
	 JQV7EVK3vaCVsbIH4Ll2YO14pYkwBNIHxkiJVRqiZmku3FSeVsrP4mTOKk3tYSdUM3
	 LlUTO1hamZKeA==
Date: Sat, 24 Jun 2023 13:47:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>
Subject: Re: [net-next 14/15] net/mlx5: Light probe local SFs
Message-ID: <20230624134703.10ec915f@kernel.org>
In-Reply-To: <ZJa4YPtXaLOJigVM@nanopsycho>
References: <20230613190552.4e0cdbbf@kernel.org>
	<ZIrtHZ2wrb3ZdZcB@nanopsycho>
	<20230615093701.20d0ad1b@kernel.org>
	<ZItMUwiRD8mAmEz1@nanopsycho>
	<20230615123325.421ec9aa@kernel.org>
	<ZJL3u/6Pg7R2Qy94@nanopsycho>
	<ZJPsTVKUj/hCUozU@nanopsycho>
	<20230622093523.18993f44@kernel.org>
	<ZJVlbmR9bJknznPM@nanopsycho>
	<20230623082108.7a4973cc@kernel.org>
	<ZJa4YPtXaLOJigVM@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Jun 2023 11:33:20 +0200 Jiri Pirko wrote:
> >of the SF after all, right? Probably best to find another way...  
> 
> Well, yeah. The mac/hw_addr is quite convenient. It's there and
> I believe that any device could work with that. Having some kind of
> "extra cookie" would require to implement that in FW, which makes things
> more complicated.

"Let's piggyback on something else in the uAPI because I don't want 
to extend FW" is not an argument which can be taken seriously.

