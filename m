Return-Path: <netdev+bounces-68305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB51846766
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 06:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C46B290C3D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 05:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB826F9EB;
	Fri,  2 Feb 2024 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzT/8+bk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6265A17BB7
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850164; cv=none; b=aWCZFBvvKgvq0sZtjg6vactL8x469kyEUfKcJmAEenQ+/Ahe0My/NjZxaY9WgvSpLFqN0ErGCkRDuaDzAygN81xjuopNPu1FF1qcn6JDxFEBbikTBoDK0W45lG9qlV5905r59EtRlNxhoyOo0B53P6P2A3KrXI/KzXxgYLdqv50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850164; c=relaxed/simple;
	bh=wrvbKV4hppg5rwHminbNi0DWPjCPRkEr539pGnXT3ts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5C3c0O5Jpr00r5zYqP5jmlaumqh1Ilfmb/H3an/Mszrbak5ZLGrxBK3fM4pM5L1BcbBVVwXLTIOjl4RsrjscNUvEaNqwl2uPAFepnLvV47rRYN4dz0RnAzMw36k09moCWZv+tKFom470ybKk7zDwqUJ+yRi8B3L/Zj+Cc4wme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzT/8+bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12701C433C7;
	Fri,  2 Feb 2024 05:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706850163;
	bh=wrvbKV4hppg5rwHminbNi0DWPjCPRkEr539pGnXT3ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NzT/8+bkRJRDWHRBYZdif7s8RV2XDb3omy2ZUg0TsNn+rkDWb8TtidFhpP/zSbYzJ
	 ND9BKVoTQ2/aJit6dvxptMC1Pj+k5ikz4Z/WQVoNj4CIDybEiDeQ52NoIsOoPIuye/
	 Zv0fyus9SBR5o8AmYoCQ+0wBn6bnSSvdlUHQ8S27XzbxQgR38qVHLYcAvlD1Mx3mBm
	 JzEjRDbg9PMyKx7hVfxAHmddNTNbN75qWUBTm7hA+bVHs5Ml6InLJaRRPmc1cBnaPC
	 FCa6uK0LoLYOJicqr2s/5LBCsUaRkOsBDqwMgGppeTWG7AP5VyJBg69U9dYoe6kqqV
	 RWHhBJuQ7aGPw==
Date: Thu, 1 Feb 2024 21:02:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2024-01-26
Message-ID: <20240201210239.0bf80713@kernel.org>
In-Reply-To: <20240201073158.22103-1-saeed@kernel.org>
References: <20240201073158.22103-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 23:31:43 -0800 Saeed Mahameed wrote:
> v1->v2:
>  - Fix large stack buffer usage in patch #13

The warning is still there on 32b build:

drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1044:1: warning: the frame size of 1052 bytes is larger than 1024 bytes [-Wframe-larger-than=]
 1044 | }
      | ^

Something gets inlined? Perhaps noinline_for_stack can fence it off?

