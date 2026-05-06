Return-Path: <netdev+bounces-285062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKJ9IkbC+2mxEQAAu9opvQ
	(envelope-from <netdev+bounces-285062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:35:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F0F4E1429
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ACF2301A502
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70333368975;
	Wed,  6 May 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsTabKNg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F2366DA4;
	Wed,  6 May 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106946; cv=none; b=IYwGYS/tMj/fZ8yf+rRSKF8fQd8UeOcdbIOQrtD6Rdpw1BvpHSE196CZEdEF+xCfZ6xrr6ZNb5sBv3323FhP1w7zdE/xFCcg3a8nAoE0wrxnpxWFqrkVQYJ/o4TDe166xUL+umHZQ5q7mEKgt2O9jMGsq0m9KHS9OKLzJhls6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106946; c=relaxed/simple;
	bh=hz3DyMLXYZmQ+CF5gL15MQqU5AYkOuUceBKveR4ovJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzcBbf7Kiq1KCSR1dc3+jj0AVsifXWyGYMxVzue5kodFkq6p6OzgyEDdkxwDx8fa3epvAj9thkUv8jDAv20GIVdKTqsUjtus+dNajRam3b/i45ND66n1zvtyILBxaeKHxqrBsZZ1kkzoYisS4Zm9sWoUtP5rt+CzQP0M1DHrhsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsTabKNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB534C2BCB0;
	Wed,  6 May 2026 22:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778106946;
	bh=hz3DyMLXYZmQ+CF5gL15MQqU5AYkOuUceBKveR4ovJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dsTabKNgurTICP/yWqT4cvG7jXsDDi5QtUPkeYskwbaIhxRuKH6pGq7n8eNndpIEM
	 KZ6CEtHuXtv6+xs9ZWoAujb3PPtq1F5gFur0EgGQGD3vqCz5ncaqSW3EVvzSzAs+DE
	 C/k3sSNDAV1I71c0z1M0h3vp6cni0QaMa81RN4tZncw7XgMyWw9t+LbDL8EQRs4Oeb
	 yc8iYVSSkEKOv7fCYU9zx/f6NIkmQxnG6PpgerbVgg7ZqAGtAUgaoxuErEMi9NnRSf
	 ioO0XqVJGrfaKucB0sqnC3OQe90AdEfzAFk6Kk/5iGXct2raKmZm087GHufCmzpctP
	 MMi7rFjbENU/g==
Date: Wed, 6 May 2026 15:35:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 06/12] selftests: drv-net: add shaper test for
 duplicate leaves
Message-ID: <20260506153545.2850c295@kernel.org>
In-Reply-To: <aftup9Pe-RnDZVUi@gmail.com>
References: <20260506000628.1501691-1-kuba@kernel.org>
	<20260506000628.1501691-7-kuba@kernel.org>
	<aftup9Pe-RnDZVUi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F2F0F4E1429
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285062-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 6 May 2026 09:40:07 -0700 Breno Leitao wrote:
> > @@ -453,7 +471,10 @@ from lib.py import cmd
> >                    basic_groups,
> >                    qgroups,
> >                    delegation,
> > -                  queue_update], args=(cfg, NetshaperFamily()))
> > +                  queue_update,
> > +                  dup_leaves
> > +                  ],  
> 
> Nit: dup_leaves], on a single line matches the surrounding style and
> avoids the dangling bracket on its own line. Not worth a respin on its
> own.

It was intentional to avoid having to touch the lines when adding more
tests. Now that I think about it again I should probably keep the tests
sorted and add a trailing ,

