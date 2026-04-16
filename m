Return-Path: <netdev+bounces-279107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNJhL4Im4WkBpgAAu9opvQ
	(envelope-from <netdev+bounces-279107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:12:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA714139DF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C91EF3064E81
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBE63314D9;
	Thu, 16 Apr 2026 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="vBVdP4Zx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CA2D46B3
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363054; cv=none; b=cjjXIhv2JRyyBvxayqg6OnJ2agchjAqAblu0Qxq312B4ugnicdCZN+/wqZ6QQy9tjZaQtJXEbRZPpYWrkPx9hATs236erthBZYZhUGZR/ko7M6vD83TOKaGQeEUbHLbl+C5UGHTIsQZscJQv641Km5wMz+3JtWHFcrhenyGNxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363054; c=relaxed/simple;
	bh=IVoVLkYURr2VVYZf7DoUyg5nEr8ZQuJ5h7W+SIOATYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMOGCY+Db9sy8UvWZHQw4Wv+3+2vzmhj6QJtTyhnYsR9c78gZoHJRVMAKmKeeq1kbdRCeOo8c9m+vhWhokcxjM5Z/VjEM9zTM4Em4LpCe5D6B0n7/z6K3/V0XmczKAaVZQis2F1R2qLt2D0RLZZiiz1X31TueD3L7gLpS4wvPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=vBVdP4Zx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso39572595ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1776363053; x=1776967853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YL1VZb94MOlbPm2mO4ff3eoT52AolKZxJhbwThzPtps=;
        b=vBVdP4Zxjakdxug5dB6aY7CDc+o26A+LMPOhLsBD9TKW7i3HOscV2MRPn23pHyi61K
         jepXSYV3HNZb7+20FTi5rCPimHtkRXqprxWbAeWtfmKkEoQpADOq08jrojtBwvyKYq4J
         qG5dX8nOjn/AbLdUnyUhFnLFIGyoxDbTiNih3q4IUMv79NT9gbN5SQVHt1LumfwlTx40
         Rff0uYuEDUpVZ/VlkhdzX3YwDV2UBjp8uU2/LhD66WtJ2OXLkV9UzscVsUWRgWP2Ntzf
         +r44ZDcK99lBUXZbMThJNIpLv7pPVLvJ1bYrTg5tpOzwluyuiVZGn+6pLD2/OUCqBK/V
         gr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776363053; x=1776967853;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YL1VZb94MOlbPm2mO4ff3eoT52AolKZxJhbwThzPtps=;
        b=p2gEkQ7r49rJRy5u3ClnWZ9Ima9jyrCAKncCVDj7K5s4+N0yfVTtnYlj+rvU70n1DP
         /Vr0svLNMhpFYrZ0KKSp8qPHIJKFQftqnPgs5hz6v5DuXeMR6vO/BT6Gzq+obrxvyl8h
         Ns1wbpKNMZqL0q03qFERMT9c7zU6eDzjDwM2SOyfmAvUetN8yGvDXKWJezrx8gi3x611
         iGYvMTKgxBU9QDR9LVuLGGJNoJfXsZIfuHnTi86ikSirp0S8P5+B3TGWEc42k5RIiD1l
         +JZuG1r5pNHyxux/lAfDxMQMKPduP5fCUh9wuSbiSvL9g4Hio4BZg8YxeKVxyVkoUd0q
         EP3Q==
X-Forwarded-Encrypted: i=1; AFNElJ85G07rFFOl4r8LarbOKqLUMHx9x55ZpcsfwMt4juIOc5MJ7uXNJ7Sr0Q92kUPYmFs0RxjsH6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt2LlAesTFxm1VRxhdJBeRvaDCxWl8ovWEIxRoRxRtyJV/nJ5m
	iRdRVkeSJ7Gg0sBLUNkdcXoPOXfaIaLCJI8zgfDKdOuiSST4M/YFceJ8YpL6kwP5pX0=
X-Gm-Gg: AeBDies7i6qa8MULzLYpGFMft4N23LDo6w05+tGVjcD4pcQwOpHcw7nbuKq6EhZ3jag
	fw8jUJ/bMeq3OnNx1q8ni1FYRyu/hJdWXduG13YR+I0/n4nMIZgumsIeUCEWcsHQY4hHdc5O0fS
	aNYm+0IVMeZaaC83zPm5dRcd/QKSCbP92euNvjtNKUTyoCXdMQt6g7ag/r3oM0YQxLQ8QwawBVs
	fouhKDyqrB6oXYc/JI4jLrWupZnIYFzPU2xMgoB2hb6p4vV3pcn/31pA7+m96cbxsH+A2Qf3Cmq
	kyAW6z/N1LBP8+UK0G5kYm77S/qp4MN9JB2hWc/O7RXGrGzQJLCqbNg98elBHUaLhGqX7CnsSjm
	bnGsrw3xY7BtY5kSDhy8sCwTzGZqIJgWY0PCtdvJh9dvwLilTGXVSk4wSP975PDp5Iq+MnNUBql
	Pf7n7jahjBugLteU0=
X-Received: by 2002:a17:903:1acc:b0:2b0:59c4:e9dc with SMTP id d9443c01a7336-2b5f8f2c8b3mr95275ad.22.1776363052927;
        Thu, 16 Apr 2026 11:10:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782acaf0sm65385575ad.67.2026.04.16.11.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:10:52 -0700 (PDT)
Date: Thu, 16 Apr 2026 11:10:51 -0700
From: Joe Damato <joe@dama.to>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net] ipv6: fix possible UAF in icmpv6_rcv()
Message-ID: <aeEmK5cmNkZXG1JV@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
References: <20260416103505.2380753-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416103505.2380753-1-edumazet@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279107-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: 1BA714139DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 10:35:05AM +0000, Eric Dumazet wrote:
> Caching saddr and daddr before pskb_pull() is problematic
> since skb->head can change.
> 
> Remove these temporary variables:
> 
> - We only access &ipv6_hdr(skb)->saddr and &ipv6_hdr(skb)->daddr
>   when net_dbg_ratelimited() is called in the slow path.
> 
> - Avoid potential future misuse after pskb_pull() call.
> 
> Fixes: 4b3418fba0fe ("ipv6: icmp: include addresses in debug messages")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/icmp.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

