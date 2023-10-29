Return-Path: <netdev+bounces-45050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F117DAB98
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 08:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BFC281675
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 07:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506D6FD9;
	Sun, 29 Oct 2023 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZarJG/Ja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375F1870
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 07:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC828C433C7;
	Sun, 29 Oct 2023 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698565503;
	bh=fpK7phxmqXOfNRL/sjnA3kyKevskPdeb1zPHt0mP3Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZarJG/JaCmURB6Cy43lfh/qTzvHwbpmsUj9AZrPpFxyBoMC+bqRzIlPByU6vcZ6Jo
	 dQu2EQ43I/iyPJ/48Rps337YNmyTSZ+ixo36Pu+S7AqgaD+d/wtOob+l/CsNbyfTWs
	 T4C/rWYtTaBcNUdS7BG+X0d6saI5W8YYTuq991gvslPp2sS3tZweYuSyRJZF/HOW/R
	 D5xQ634A+9QXTI20bR4AU4bHKw5xCOEo7NSMpI1Eimx6Z+85u1xw4SOrurkFK//UYR
	 +JFPMHzPUFAEYfY3vd2rIl1mdYEkjV1XI0N7dQDsol3W1otNzpj6h1COx6KOkcCGCm
	 NhyVKV7kUUclQ==
Date: Sun, 29 Oct 2023 09:44:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-19
Message-ID: <20231029074458.GF2950466@unreal>
References: <20231021064620.87397-1-saeed@kernel.org>
 <ZTwzWQxcEsziHrjW@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTwzWQxcEsziHrjW@x130>

On Fri, Oct 27, 2023 at 03:02:01PM -0700, Saeed Mahameed wrote:
> On 20 Oct 23:46, Saeed Mahameed wrote:
> > From: Saeed Mahameed <saeedm@nvidia.com>
> > 
> > v1->v2:
> >  - Add missing Fixes tags
> >  - Acked-by: Steffen for the xfrm patches
> > 
> > This series provides ipsec and misc updates for mlx5 driver.
> > For more information please see tag log below.
> > 
> I will drop this series for now and send another one with out the 9 IPsec
> patches until we decide what to do with those.

I think that it is complete an opposite to the discussed.
There is a disagreement between how urgent this series should be merged,
right now to net or to net-next.

We definitely are not discussing to postpone it for next cycle, which
will probably happen as we are in the end of -rc7.

> 
> I will send another series today with mostly cleanup to mlx5 that will
> include part of this series also.
> 

