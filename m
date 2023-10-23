Return-Path: <netdev+bounces-43367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FF67D2BD8
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922FC281419
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C71079B;
	Mon, 23 Oct 2023 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxnFg/Nw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F67101D3
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C1CC433C7;
	Mon, 23 Oct 2023 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698047385;
	bh=Z7625dXSwNAIWJbpV0miy7cQjxCDQhBKrpEH6/RCiGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxnFg/NwZYy5E8q3I1ENeLf2kNwEL2cxWcPPRytCSFoiDj7IP3kC/gyn9uCFjgXJp
	 mxBekediY3Y+zUv6LXj+tz6Vv0riljHZxEQVA4bnKE5MDq0QH1Sd3j3zk5UIbdPJCO
	 xtTPvMWhjaY+sEkf1k8dP07Yv+frHdKcpGmebn87j3/30MBOb8p0TpU8UHWa+ckq2Q
	 qGP59GFdjyMmehFz0ZZUL5AjW1LQx9Vdb5qCuxpGJ62wdqFnUZ/oSnHR2wcVduFLuI
	 cf3nk9+bTSdo6Ztrwejj6nJ75QdMaGhRfk1RPSk8guZwHEdB7gJzOt/rnLcC8dwnVL
	 3Y0RCOB7kv/bA==
Date: Mon, 23 Oct 2023 08:49:40 +0100
From: Simon Horman <horms@kernel.org>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shakeel Butt <shakeelb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] sock: Doc behaviors for pressure heurisitics
Message-ID: <20231023074940.GU2100445@kernel.org>
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
 <20231019120026.42215-2-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019120026.42215-2-wuyun.abel@bytedance.com>

On Thu, Oct 19, 2023 at 08:00:25PM +0800, Abel Wu wrote:
> There are now two accounting infrastructures for skmem, while the
> heuristics in __sk_mem_raise_allocated() were actually introduced
> before memcg was born.
> 
> Add some comments to clarify whether they can be applied to both
> infrastructures or not.
> 
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


