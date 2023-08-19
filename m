Return-Path: <netdev+bounces-29034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044387816E3
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA06B281E33
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D19A4D;
	Sat, 19 Aug 2023 02:55:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35063C
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944C5C433C8;
	Sat, 19 Aug 2023 02:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692413704;
	bh=T0OEcaiXZGHv+gurkmjsNE1gYQoi2rtlDMmAdRUuJtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=df7h7Enha6M0Qi2T7wJsuVfeNMDvrE0k1gTgMXV4BM1X7BR4Kbe+KfTcobq89ZySU
	 YrRP/P4Eh11PVzxfqXctS4ySYwIrFv4ATSliDxOtJ+DFs7FJoEKd0dFj5fIf71q1lv
	 Kb4J+fwJr6WbNrZqIImhjUByBurLEybGAVt+vCU1zZmRdHWs3wgL+EYmAgDRX0Xdls
	 zvH65dNc5f9In0sgBJ38JgYKWk5eh6+1klUwXQiEXgLNF70/MXcVf8Fdcb8NF+7yce
	 AtPMApB1Icr2NP3U1klBHp5qUX2IaZSu3Kzx8csaIId4LLDU2d02DsAvyAa+0l6/VB
	 alp2m1u5YxRCQ==
Date: Fri, 18 Aug 2023 19:55:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>
Subject: Re: [net-next 14/15] net/mlx5: Convert PCI error values to generic
 errnos
Message-ID: <20230818195502.22b416b3@kernel.org>
In-Reply-To: <20230818152853.54a07be1@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
	<20230816210049.54733-15-saeed@kernel.org>
	<20230818152853.54a07be1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 15:28:53 -0700 Jakub Kicinski wrote:
> LMK if you want me to apply from the list and skip 14.

-110

