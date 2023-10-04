Return-Path: <netdev+bounces-38086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A377B8E86
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 08F9B281745
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864AF2374E;
	Wed,  4 Oct 2023 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj61GGKA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137922EED
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 21:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB4BC433C8;
	Wed,  4 Oct 2023 21:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696453973;
	bh=UMkpK8hBnhmZu6SDCnn6+NldPVpXde3GUYG3ar+O4pA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qj61GGKAoLT8aQBhpkE8fQcl8WRuwzwUwJhClfjpCgKfNNb8mr8kRzzH0etrJC/Rq
	 4rc2WQEpWlvtffsq83jsTASvbJp5x8TV2tgMymVxvn/18vUn7Vnq082VOoMG9834Vt
	 nfPlOVSMmoVlSrxr0A0Wox7b3MuHsYum/BpvJPphv0k6FyLg8GDQIRJiNnM7VXxTvo
	 M8BSgH1cmX4XnYvllRfczK9nFVOkrJfR3aJOnk9JDfM2BSpR6AVt1CAh/PnbbzbkIG
	 hozI2fgP7ivkjyzdYPMr+nm42glxiHu6RR1kuqpG+h/MPq6LL3L4UFU78Aq0+hPU46
	 CZVQ3W1QUwa9g==
Date: Wed, 4 Oct 2023 14:12:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <richardcochran@gmail.com>,
 <lcherian@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
 <sbhatta@marvell.com>
Subject: Re: [net PATCH] octeontx2-af: Enable hardware timestamping for VFs
Message-ID: <20231004141252.49812e65@kernel.org>
In-Reply-To: <20230929071621.853570-1-saikrishnag@marvell.com>
References: <20230929071621.853570-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Sep 2023 12:46:21 +0530 Sai Krishna wrote:
> Subject: [net PATCH] octeontx2-af: Enable hardware timestamping for VFs
> Date: Fri, 29 Sep 2023 12:46:21 +0530
> X-Mailer: git-send-email 2.25.1
> 
> Currently for VFs, mailbox returns error when hardware timestamping enable
> is requested. This patch fixes this issue.
> 
> Fixes: 421572175ba5 ("octeontx2-af: Support to enable/disable HW timestamping")

If it never worked for VFs but worked for PFs - it's not really a fix.
New functionality enablement is -next material, even if the fact that 
it was previously disable was unintentional.
-- 
pw-bot: cr

