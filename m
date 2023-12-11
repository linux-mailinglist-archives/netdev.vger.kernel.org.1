Return-Path: <netdev+bounces-55888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A034A80CB2A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07ED0281B7E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E9C3F8D5;
	Mon, 11 Dec 2023 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loGrpRfr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBB21F60B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666E3C433C7;
	Mon, 11 Dec 2023 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702301897;
	bh=xZvJbRdLjDv9Z+FGBP0lBKVTUgmMNq1+ymUBQji5cCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loGrpRfr8GMP6HhR5AqcM9iGoVgO4b/My4G44kL592Oo063az3JGmjjBoihGk0R74
	 nRozc8esqvKKOZ5a0f4ZETX1tdiE6Dd+/FzoawP7GCQd1xZmAd9TN9lJA9WDb1vzoj
	 T8zZK0RMSw71QjMhHY4HZPtGknrkZfVwA+Y6M6QHgkt8dJmeUR9vGP+Wnu3gKk0djk
	 49Ku/Uum4W1olfCnJBAXaa/bckFaQHyUvhs9riNKswZdvhZKFpwKG0yOc4Es0+ohyP
	 EkQ1ygvHL1tQuUwJL4NaTm6SaTOpZsjIEy9ZJxLJuio1VJz2Yezl331JxEj4m5KEpO
	 LwKvNgdfpJN9Q==
Date: Mon, 11 Dec 2023 13:38:12 +0000
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, daniel@iogearbox.net, dcaratti@redhat.com,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
Message-ID: <20231211133812.GM5817@kernel.org>
References: <20231205205030.3119672-1-victor@mojatatu.com>
 <20231205205030.3119672-3-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205205030.3119672-3-victor@mojatatu.com>

On Tue, Dec 05, 2023 at 05:50:29PM -0300, Victor Nogueira wrote:
> Incrementing on Daniel's patch[1], make tc-related drop reason more
> flexible for remaining qdiscs - that is, all qdiscs aside from clsact.
> In essence, the drop reason will be set by cls_api and act_api in case
> any error occurred in the data path. With that, we can give the user more
> detailed information so that they can distinguish between a policy drop
> or an error drop.
> 
> [1] https://lore.kernel.org/all/20231009092655.22025-1-daniel@iogearbox.net
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


