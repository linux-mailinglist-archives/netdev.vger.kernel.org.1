Return-Path: <netdev+bounces-267645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G7JEv6ltGlvrgAAu9opvQ
	(envelope-from <netdev+bounces-267645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:04:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C828AD0F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25EB632075E8
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B065D33985;
	Sat, 14 Mar 2026 00:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="IfMjK7uf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECAB19CC0C
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446469; cv=none; b=RvJOoAdgzfWxqQeY7p3ga1JDETnuL2CAQrDBgX43OWkprV5Yl4ebSSUsayYXMGiGo/H6xta9ARpmamCjh+QlTU7nNxtF6gEw+n9473dPwgxpgPj5+pDFd0Pankv9qjbwpV2bT2PMgrtPe9qxb1FmI6qYpus3UqHDd7S5Eewl9pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446469; c=relaxed/simple;
	bh=cs6t7X7CRK8Svud40jTvRkJsFctHRu5gwJsDJpMYvLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOV22dOU1UyMcHRPgFgjc7qDJkWIpouUIqadQvOP/txxI6mNY3iCc7RSNNaMMBzxOIMs1+L9h4+y81kLi4/oUv65jZlI4MaWO7SICUrYNl1Rx/emTN3vuc+eQvKtaa6CCSOVN8QDdHer1EirB0nxh+95zors/QJfQ6J1Sfwt8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=IfMjK7uf; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a1f549e7eso1283758a91.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773446468; x=1774051268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXbhoLYlxQyyo7Nw6ZYoN5BQZLWF6NXpzKSnh7TUmkA=;
        b=IfMjK7uf2QXpButcCVHR3aQYiCKacYe5OE3hyUm2aL5X2pXs/W03iLB7Fi6UkCkpYR
         gHhGImnppJEJJx79MfqxJfXWpYBQ5r+ee3QWZ/ar26FeB4pO74nB2hsB/+eprXhyOizm
         KI2foTHffWDe1n1MAiUQkAIL7LmR3Q3D255afysOezp3XkOemCU59D0G/qIloLo79kJ9
         /cvsYnJbFSICmgySDNEGIq8TYkYE9lYW5YcuTIxZHEi1mp279IGnaQNTR21qNI6kHtZ2
         t4XOWJosIxtvWMMxd5mNqIXQRZU/3AZDQK905hq+GJXrgPQAyRy74Z65cQSyJihC/z+8
         hJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446468; x=1774051268;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXbhoLYlxQyyo7Nw6ZYoN5BQZLWF6NXpzKSnh7TUmkA=;
        b=ptTspuwrNwzMKvXtRM4onLzTTMIt4UybE1DRNd/2+1XNdrD4FLaAn70UomKkIUlHgw
         T7sg4gJPcsqzme3dFDhjXYUaFMSwUEddDzF0iJEJkvXRIbXDgVX2Hw6kUSOWfWs624qy
         PacyvK84BoLGvRzdSPqA+VZ4LMECFo10Tu3CqWH3ppLFXwEatxnTFeCE9gxBwjwLGyY1
         /m2iCUtOsxpGgBLuvHxPgkR3dqazubYGMPmoA7/TlkaDIpbhU9sUZw8AFmFH2IE4JyhH
         d+40LMHqFCjonVeURwHT4gLwphH2SDeifhE+9dD4eqyWwQ/7/3Pp8096LbTesgPhDnc/
         S/YA==
X-Forwarded-Encrypted: i=1; AJvYcCWu6b6cb5oVTGQkngeo32nSNxyci99F2YK96nIBbhV3ZPD0pi9EjwJSLlEloizp/v5uSG9KJ/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysbpdmf4y9wYLDze7M+r237fa7n+rELROZ5XgBi6Bh/lxYRFYy
	ZWtxmh+Lmh3Z5LzpfS3pLRCErzLZknxr5DjDkj9PekCDBdkHOiQ4te3sKy/kUITP4XVx9Ct7vbj
	Bmy2gM9A=
X-Gm-Gg: ATEYQzxlbpmCHK7dxY2dNotM5IC6BXuJtMK9VMCWpfqSDongeR+y4N9suBWhowskmyq
	4LRsLYISc+IXU3mji3BPMPPBd2pf5agIWGwdfD9o2fEkSSjDcR/XSY6dsqlIW8ls3381shvvg/h
	ll653Sb6pXR4lccNVyNcbz9OHFoIlMfm3HcdbMYDIdCHGYnAXI638f09s2vUufxbMmL6/g9N6ts
	tRkqx6SxhPktjT8iy77BS+GU2NBSUytFpYzjnMB352/0nulhX2i+KwjCQvxy8XpIqT1EUwHk4XC
	68hHXyStCnGW1B8bsBfD5EHxUAM1/xe8PnH9ZvhYbzgvtSWmnxx8nEiC5GeCK7eiH4AfSR2ULqN
	gFIbe5tmt7Ly/Mp73FATLTt8wwWwemnnVfuFCCqW5tlzHgyeZSXl/PD/6Y3sDEmdhrm9YuLQlDy
	5MLunp
X-Received: by 2002:a17:90b:380f:b0:359:f7d2:a1f6 with SMTP id 98e67ed59e1d1-35a21c7676dmr4837429a91.0.1773446467734;
        Fri, 13 Mar 2026 17:01:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a23d9f29fsm3630876a91.10.2026.03.13.17.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:01:07 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:01:06 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/6] bnxt_en: Move bnxt_rss_ext_op into header
Message-ID: <abSlQrYQcY2zWJy7@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260313223029.454755-1-carges@cloudflare.com>
 <20260313223029.454755-4-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313223029.454755-4-carges@cloudflare.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267645-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,cloudflare.com:email,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: A25C828AD0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 05:27:33PM -0500, Chris J Arges wrote:
> This allows bnxt_rss_ext_op to be used by other functions. In addition this
> modifies the rxcmp argument to be const since the function only reads from
> this structure.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 -----------------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

