Return-Path: <netdev+bounces-30753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4AF788E2F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 20:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF421C20EC5
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115918048;
	Fri, 25 Aug 2023 18:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28118003
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640FFC433C7;
	Fri, 25 Aug 2023 18:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692986527;
	bh=Z8/p6jdYhLhN7qSwwsCH2vmc8kBxtzCwuJWP9hrCynw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1tt1tRlVym9NiFysPOJ8OoK+R3A+lnRWID+aXQYmXJ11t4i0Hs6cqOiQ2vbdtVIU
	 nSMvpyXCgDyeisx55OzfoipqCc5QJFQB2cCg5nArvGJ2XC8cD8UP0BdEg1Krl+NjPd
	 sddiDD7chKmF30diIJST1Tg0Lu9Y1AICUlIKpb9IgluoILExErUbWTdNbqS8nYnpJK
	 gQuAE3yCf+pvOLmU/aBNI9ICD7OUIrBvWVN2sOM8AakWrGdwLmLZtB+nIMWL3poUzG
	 F2A6c2P/CDfNH0iTW/U7+vQYd3rwYr6LvBtmm6d50eOwqwv7cdw0iG4wWcrDMc4VnR
	 8Gp0vSiCcUf9w==
Date: Fri, 25 Aug 2023 11:02:05 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net/mlx5: Use PTR_ERR_OR_ZERO() to simplify code
Message-ID: <ZOjsnUu+MMBazNan@x130>
References: <20230822062312.3982963-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230822062312.3982963-1-ruanjinjie@huawei.com>

On 22 Aug 14:23, Jinjie Ruan wrote:
>Return PTR_ERR_OR_ZERO() instead of return 0 or PTR_ERR() to
>simplify code.
>
>Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Applied to net-next-mlx5


