Return-Path: <netdev+bounces-277062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBHiNcjQ12mrTAgAu9opvQ
	(envelope-from <netdev+bounces-277062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:16:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B263CD844
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D98943006B6F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7682C3DEAE6;
	Thu,  9 Apr 2026 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvpF/C7E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D53DEAD5
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751366; cv=none; b=dJAVcj0CoEAjuN9uAx2kmfTpylnMfVAqzsohunqNVvI3CSbmL+Ou51lW9f+dcF0/GRUTR1fbcztz3pBbGvUxQBQ0tzsYMXDsRE1OZsl6Uv3vs70Mzl13Mi21zi7MflLjNa7F/5Scr+xTNnlbZHYgA7/O+mBYGA62cGDi86rWhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751366; c=relaxed/simple;
	bh=Oumki9zWNDQlo4sxMbmCizLF8bgRDh3ABn6y358OUoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6m0afN8yhkrZG/HwaTyezgJxCcdoCXOCCRjB9j3o6dDnVCQ4/tRrn9ELU93YpzyK2wP9ESEIMbW8vwwtwc6+z9fly+IbC2djG6OOlwh0qNiXLGfR4Bjut2VuDKvlYXpffZYpYEU2cop9/f46Q1nMeLXKqCPMnDQbZZJJkBp1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvpF/C7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94C0C4CEF7;
	Thu,  9 Apr 2026 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775751365;
	bh=Oumki9zWNDQlo4sxMbmCizLF8bgRDh3ABn6y358OUoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HvpF/C7ELLnu99U4oQSXbd7wEADnGuhVvHSEoJxzFoiFMCyuKCcj5LWeTd51ULu5C
	 xMXe67YH4nSSWKnML6txl0OtP0oFdYnMQXsb1XZEfGuLAYDu6TLhVZ+qMaKK7Zl4hL
	 uRmylBEFmA0nNd6Ybfptd0aq5Vou/92aPQ9P8Od6YKZU9qAhMj2EjtV/rG6yVd1Sws
	 siQxfRf3GhnjwzayGHN90JztZ3DOJR/5xS3QzxOaZy73ODg2kvUXVgizvVr9v2N/Cv
	 yZBi3yF5P5Qb4hITgeb41FdqVT0wodl3vOoxtAtekVNnLvzzWOAEkogOQLGsesMJvv
	 dK7w7jtcl5LsQ==
Date: Thu, 9 Apr 2026 09:16:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>, Jes Sorensen <jes@trained-monkey.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v40 0/8] eea: Add basic driver framework for
 Alibaba Elastic Ethernet Adaptor
Message-ID: <20260409091603.46d84c91@kernel.org>
In-Reply-To: <20260409122130.129416-1-xuanzhuo@linux.alibaba.com>
References: <20260409122130.129416-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277062-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.alibaba.com,linux.dev,mucse.com,trained-monkey.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78B263CD844
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  9 Apr 2026 20:21:22 +0800 Xuan Zhuo wrote:
> Subject: [PATCH net-next v40 0/8] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor

I asked you to post not more than 2 versions a week:

https://lore.kernel.org/all/20260316195252.7fa24729@kernel.org/

This is the 5th posting since last Saturday.
I don't want to see any more posting of this driver until after the
merge window. If you violate a direct ask like that 1 more time you
will get temporarily banned. 

And of course this posting is getting discarded.
-- 
pw-bot: defer

