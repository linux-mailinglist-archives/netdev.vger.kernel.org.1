Return-Path: <netdev+bounces-35742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B87AADB3
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 338361F224BB
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5085D18022;
	Fri, 22 Sep 2023 09:21:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6014F6F
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26684C433C9;
	Fri, 22 Sep 2023 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695374461;
	bh=FjPhN6i5lI0cC5cDbAlNjqvB+J5Zmihtz1gx9fX7IO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gi52uqSF3zSmY9VnWK1Jt14RJ/0It6ReB/mBCSFaFF5RMNtMVN5+nnSZQPu1w3VWb
	 Jw/sK9ELJwYQwVQFEXaUKVUbAOOSEUobHboaU+CVnfUTECcEtfkcF1+r8BPpfueMs5
	 hUbmpzYF3zuPPbczfZi6kg6L5I06HPt0NzDy1chNqHUr0OU16oySz5+h7l66ZOhb53
	 B6lgN5Yqfv67NPDRyhhQz8+oMkUIh6FUFBjTXpBcweMx/QApxXDis0N2fuubYaHdd1
	 PdiUIuY/ytWD7WxAttXcrrwnm2C1dO+Dg2Pbs13u2A2DDElZmNKcRrwA0l6NmIEzgz
	 6APduN6UAdzTQ==
Date: Fri, 22 Sep 2023 10:20:54 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com
Subject: Re: [net-next PatchV3] octeontx2-pf: Tc flower offload support for
 MPLS
Message-ID: <20230922092054.GU224399@kernel.org>
References: <20230921085055.7258-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921085055.7258-1-hkelam@marvell.com>

On Thu, Sep 21, 2023 at 02:20:55PM +0530, Hariprasad Kelam wrote:
> This patch extends flower offload support for MPLS protocol.
> Due to hardware limitation, currently driver supports lse
> depth up to 4.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


