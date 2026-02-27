Return-Path: <netdev+bounces-261946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJJZBEngoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:19:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 260E11BBEA5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC21E3051B65
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150A362135;
	Fri, 27 Feb 2026 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="mK+hTkBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8B33D6F8
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216371; cv=none; b=t2MhO66SEugJa48wvjBCf0FQ31PghSGeeoX8rWyhhHnd5SR8vFhC8dSLhMGwUu3aeSkwxfFfxQ3o4xH2WMmd4MAAVru7J/yRNvBIc5OhsdlB8sAT3ZDXWzaJPJDZ1agXfOps03LBd6bc6I5tKQHz2tR1oa0yIkhy0Tv4W69eDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216371; c=relaxed/simple;
	bh=mGb+1TSMkybuSpuyHbKGKf+ZQ+kFQ2uvKGUbF7kSwKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HepHkmwZ4YPT1kEGdjcKBPeqypxt4hRpeukY6eD7JFmBnXtaKrq/gsMDzj21j6bxT5wysvBFKKJzH0Dle5zVRYFTUEXosc3MDAtVoBSWpg72pLYJMlFW8rXiSkM8DNHNVJm1OSeRaXk7JbqvYKReXarNQa77HdlFZJwIdWyRzjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=mK+hTkBq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827390e8a3cso1617617b3a.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772216370; x=1772821170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFmCctcJQlPeTmI+Gs7CSGYlYz1O0SINvV5rOfoGbeA=;
        b=mK+hTkBqC8JhIMOM0PfUIc5355B1yWYuSKDTWgoZdH9GjMYYPTVqncsDA2Zqa9kVhI
         OIzfFLj2UjMMealk03EYG/o/X/AhmETbW3w42rPnXiuQMcv4+VUJlVue+qKADkNVgkAb
         77VowtoYRdK1b7otEMf8zhr3mlXEWzQziBrs1nGk0dlQadCkfuU6PezZ0+ei/lyK9H2B
         +livxJblgMFeGyJOLzO/GCgqMBYwlURT10DrxYByZDBUbbu/nbMbVx4MpEUIS3Zf7Zse
         HqJC/Q2n5ozToeSV7RukamvnlJPTSrZGCHlRsPs3tn0M0Ar/BE3uJJknmEWl3mlVQECM
         +JzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772216370; x=1772821170;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFmCctcJQlPeTmI+Gs7CSGYlYz1O0SINvV5rOfoGbeA=;
        b=cbc4CUzXmAEoBG2PTpZIW4uGLd1omBdBzPa+SXR6r4jPnvoT2V7m6G609DM0u8pZ73
         rqV5uYQ6yshoXSCqjgRbjoxP932LXfGanOH1Sl+nz8YEZQUxD3+owE9tU37g09qDCGbm
         DDBx5O9794hyziXd0Hy5eAXFxIQ0kr1cjSyhLzWiWrrczmoWCgbe7iLXBYBeLYqP7zvg
         MRJFK+pAFCc6GODI3ocQiMBStUXBAJl8qXbNNIqTgBzUl6WY4uP2v3++s5Q7u2SwEjcE
         IcwSNSHuKqRrqiFzrrkbDWqBfYlKQdfGivg3GOtqgMRuFpOO/AxDo8Dvh2FYbYYd1vBu
         evVQ==
X-Gm-Message-State: AOJu0Yyq/a6C00kOKvUdPqWTm/B0ZO2+fhkkZG3XoENXgXgSy4HFxzL3
	0nQgS5BFnOaj0x/WSJwq3g3AMmltjAPbuSmvXDgNzxsOQCTx8WOHKV9HA7tafCJZbUwd0czWjK/
	l9E23QHI=
X-Gm-Gg: ATEYQzzmcQ/sMwnmseiEgEy5uWw1Qsa/yoWmRe3MWY9LfCCaPmQgzkTKO4kqqNRDaf1
	1tXkDpv4g196u87X0O+0dbaIrXcwUT9lDWWQa0VHc++6cgI1/c6g/8KUk/vUMFd566vQsuz4CIF
	AwZ2HOtlFuL9psnuLdun119ZBsEJZ6mOUn/eJ5HGKXbIf1vcdW1P1hHprPtjaMHD9dwWiWwLGBS
	tjtM4aFoQ0htz4FeHYUiaBMOjPlcMU6W/5HAxHtbexbXbA0CMSivBP70xFVEByW3yZuYv7KUbKS
	TNhLkpyGat5uKTODaHkC9evUQ3D+ixEYlYt9BtMg0aV0cGe3NQXagWbA7XegxppTRS9ctYk3g/Q
	G28svcjzD/54028SI+0XAVJM+2ktaEavNEgQ3axSC5EHPHg/gjyMlgyRpXWK1h3Jh09xKrYz+JH
	Xzv8s=
X-Received: by 2002:a05:6a00:2e24:b0:823:5745:cfd8 with SMTP id d2e1a72fcca58-8274dbf36f4mr3566098b3a.32.1772216369583;
        Fri, 27 Feb 2026 10:19:29 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4d93dsm5626142b3a.3.2026.02.27.10.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 10:19:29 -0800 (PST)
Date: Fri, 27 Feb 2026 10:19:28 -0800
From: Joe Damato <joe@dama.to>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v2 2/8] net: ngbe: remove redundant macros
Message-ID: <aaHgMEfX/Ryrzr3k@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20260227073450.23680-1-jiawenwu@trustnetic.com>
 <20260227073450.23680-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227073450.23680-3-jiawenwu@trustnetic.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261946-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trustnetic.com:email,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 260E11BBEA5
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 03:34:44PM +0800, Jiawen Wu wrote:
> NGBE_NCSI_SUP and NGBE_NCSI_MASK are duplicate-defined, they can be
> replaced by the macros defined in libwx. Just remove them.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 ++--
>  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 3 ---
>  2 files changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

