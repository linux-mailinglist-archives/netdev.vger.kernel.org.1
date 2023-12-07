Return-Path: <netdev+bounces-54709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62EF807EC8
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 03:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6A71C211FB
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 02:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56D937B;
	Thu,  7 Dec 2023 02:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwOMospX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0A41841
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 02:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D28CC433C7;
	Thu,  7 Dec 2023 02:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701916911;
	bh=BeHE0QdWR8/FQuhrEj1uuErFlFKRg64vU30T82U02Wg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qwOMospX8lPCK+vkDtRMwxgYnDVtemHyBwnXpSPjz09GP3JE1rDjTd1NsgFRjZX9t
	 DqcLQxh9Y0Ts/8A9MOo/ATq7CsESvd43/mMvQic+1j/kknwupidbFfMWlxFjPKwbaA
	 ufe4xRYIy2AZqadwt1Bt4vwCw6nhNyc5D1rhJGnSIaCj/CakEd6Ni3wKCPjmM5OARB
	 ingVlYgj6f5cAFuBGwFw/Ynmf+KYMdHUsN0qKFdeuEdjVy1cH8y/IZRpT2+JfAn0Dl
	 amsQNpiOCIMdEp9izoQM+5t2KcdtUNOBHstGUAhuEuTaJO6lWnThTsKspcb6HqtYBn
	 3p+nKpWSbCfmQ==
Date: Wed, 6 Dec 2023 18:41:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [pull request][net V3 00/15] mlx5 fixes 2023-12-05
Message-ID: <20231206184150.64bf029e@kernel.org>
In-Reply-To: <ZXDgZV84L-oZDHr2@x130>
References: <20231205214534.77771-1-saeed@kernel.org>
	<20231205144857.5b7297ac@kernel.org>
	<ZXDgZV84L-oZDHr2@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Dec 2023 12:58:13 -0800 Saeed Mahameed wrote:
> V1 is more than a week old.
> V2->V3 which you have an issue with, has no change other than removing
> 1 patch and adding 2 more patches that were already reviewed on the list
> for more than a week as well.
> 
> This is a PR of patches that were already reviewed on the list for way
> more than 24hours.

The same rules for everybody. Please don't repost within 24h,
unless someone of import tells you to.

> Anyway, do you want me to RESEND ?

I guess that'd be counter-productive. I'll revive it tomorrow,
no need for a resend.
-- 
pv-bot: 24h

