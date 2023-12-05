Return-Path: <netdev+bounces-54156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2BA806213
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 23:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BEB1C2114D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0803FE2A;
	Tue,  5 Dec 2023 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opb2j9yl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0789405D5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 22:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D38EC433C9;
	Tue,  5 Dec 2023 22:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701816539;
	bh=Eg1MRsM4u1pVmuZFb5VcWJLj6dDDAgAsouXoh0eyMeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=opb2j9ylBPi6SIRTZ/KZXTri+YUhT9AsmPa6B0QZ4LePoRXUMM6xqELba/NUBGv6y
	 gdWluJzSFCh/9ZtSRXve8feM0ImrgTJF/Badp0wtw5mCszxRkdgBErYj/mMI/XuT7+
	 pu82U2yfXij2yQyeoDSuZsQtUU31bRfJAiGGgCwrl/qkmzVM8Om4pePdj2i41etuGv
	 5cntVLEUoU0waprq+uL04Qb/+iQkWI38xxG/WLWz1FJNaXZgCYn2nIDmE9GP6sm96/
	 EbQXhgySTbezysp42ptX1MrsLkQbirXK3jMepqc5z50Tu2ARyOWmwjCq4Xzgw8LHom
	 5PgPIcYiaeD0Q==
Date: Tue, 5 Dec 2023 14:48:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [pull request][net V3 00/15] mlx5 fixes 2023-12-05
Message-ID: <20231205144857.5b7297ac@kernel.org>
In-Reply-To: <20231205214534.77771-1-saeed@kernel.org>
References: <20231205214534.77771-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Dec 2023 13:45:19 -0800 Saeed Mahameed wrote:
> V2->V3:
>   - Drop commit #8 as requested by Jianbo.
>   - Added two commits from Rahul to fix snprintf return val
> 
> V1->V2:
>   - Drop commit #9 ("net/mlx5e: Forbid devlink reload if IPSec rules are
>     offloaded"), we are working on a better fix
> 
> Please pull and let me know if there is any problem.

Why are you reposting this without waiting 24 hours?

