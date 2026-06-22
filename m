Return-Path: <netdev+bounces-301077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zr+POAshOWr3nAcAu9opvQ
	(envelope-from <netdev+bounces-301077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:48:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACBE6AF367
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:48:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=YhivKm41;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301077-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301077-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 056913009F0B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103722DB7BE;
	Mon, 22 Jun 2026 11:48:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F82DB785
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:48:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128900; cv=none; b=KN/zicktHA+Xh6Hgf7gNbq4hGKj/PN+fykEsd134XViBGlPW6Zh/D7shNvldTzkbbNHTyqtD3z5AU5F6B1pvwBjhvK3GZHdeWUg8G7W88k5y0CCG/ZEO9eIBBgTpJyn1YrXWFj6Ar1ndAee2lPsKpLbjT887ojFgBEG0ZZf0ucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128900; c=relaxed/simple;
	bh=7wGMTBX/NPX6TKl7mPXhlgA/oww4mJLEPtUGxQQ/49U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMd+0xmwaJ82tF2nY5aHlhWpBH1z9yaq07JR9mcdOrk6bIco0iiQ2OYf0lKY9FPJ827srl7GvEgnMtPL+WNXMtqcq0260Ccxfti6bJZZfH8GoxTzbUXCmgMGij80L2pauKHy+7N/lFuzmMSzY3WKLEwQ870nRykuUDIZuiEfnww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=YhivKm41; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b1aefe1cso1665045e9.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1782128893; x=1782733693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aAGl/5S+jqA3djprjDdIdhQwP3nVUtWvMxrvU2bY9Dc=;
        b=YhivKm416Lg7L6JvpijotaKPrdM34HQRzs5czsgMH5RbGo7i+JK4CcnwYsHqkLRpop
         0feZZ1o0LJ9Ao2aX+qSD+ovscGidmwX6clQzc97BUd2sFcqzyviWSRaCr64JjRrIz8Dy
         yyT793yZiFXsdahShU+LyM2gWbiPV638iySz8MQBj/Z4aJmRQUDNvhTRESXMBdhy+dXU
         CZOjMLMkZl3JnMPdS3Qy4Jxq8JtVty8D0psp2+BMUeOFXYPRz2I3j4t+hvoz7m9FtXiP
         945I2wNnSLNvYyKhV1io+Am9job7FUJaujB4Vw0qA0kI8Tg8P4VIzSiGajd+/f7hUBsp
         r/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782128893; x=1782733693;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAGl/5S+jqA3djprjDdIdhQwP3nVUtWvMxrvU2bY9Dc=;
        b=RFQ+8BiijhpnjgizMma76HxsdSKOlbPWtyOL/a86AEnkrg7cRFaOZ290GP64mCFplW
         eElmOQPzoIM3fgaoTjUg9k8j+qN1mxvnI6vH7ENN4fUjL1T6qZ8D82O1Fu3YWUXxjq/I
         GhN4yJgc24LQdQsbt5oHlOWuBvqGlqxpl5XAfKYU2CMfa9P/RBx8oyLD0Wd8SIHar16Q
         /F0u/ItEWA6kUiZG1b2lFaoSLV60LR+w+d77Ur6r2Cd+tVLFs5AePhlG9mvZbNth30Fk
         7X66sSxNlhWm1jeP/4GMH682pQ+KNANPD4TdsaeyyqYOd7KfDQO9TEQLkTPJwSUZzCOS
         xvPg==
X-Forwarded-Encrypted: i=1; AFNElJ8ay2bD0oe180ZPPRDqP7BxB2eB/weHyN5r9klGW3atPU9gZOEC9Lue5QWEHo4Irf6qmQgVmBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQyN7SEeDA/133W6GiAVzgzNoiMtvLqoRTAFgwQscjxkqKFTs
	rU/d+tHZUpQWVcDLK2i8jYLBOJl8RNaoCg0MvcGz0jPXlz/soulTPcWNl4o0Ito7C50=
X-Gm-Gg: AfdE7cnFKUq7mGSGcY+WlTdgmX+vMnOtKFwcA203+i+yDa5CduwK2cSU6NdejBZl8CN
	5Aix5OhOEq2T10/XOFBPWhdr/dx09E6knVpoVwLBnNF584X0ze4rQer22HzHOXTvGDrckFHtG+j
	SiDj4S27f7mVzmxJ8ksN4+eUOjvC5UzH8fvI4CeBu44BxJbKfFUdIju2aJjn3r20qVrCFLBpb/J
	qYXtn+aD5g9RezWbxiDfUqjPiELc7/Q2NqJsTXJvZXx2Kg+xUSFejkXw7zX9R3kjbuZLYlvUY8H
	Bx8QnvhyF+neegW6wko/2QwKawYtdDmm7qY9LM4GKNdfjfqnRy3aD3j9CPN6N7FD1uV14d1e6bm
	JpCjM8Qfdw6KiwJz12lNlKHy9mon7lIrd0Igb13WJBDUp4nr0z7QOM9GHs18cAwfnydtRj2Kn1S
	M94FjqblW9KyogxTW2pUz5k7vT03DU0Wd0EERbiTI9b8enSX/R/f3mTMFvmW7tYq/XWA==
X-Received: by 2002:a05:600c:4715:b0:490:b71f:2ed with SMTP id 5b1f17b1804b1-4923f6b1196mr114975385e9.5.1782128893462;
        Mon, 22 Jun 2026 04:48:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1f886sm272395845e9.4.2026.06.22.04.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 04:48:12 -0700 (PDT)
Message-ID: <5adce61f-baa3-4687-8db9-b75e718c42e8@6wind.com>
Date: Mon, 22 Jun 2026 13:48:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 5/7] ipv6: reset value and position for proxy_ndp
 sysctl restart
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, brian.haley@hp.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org
References: <20260620161850.7114-1-fmancera@suse.de>
 <20260620161850.7114-6-fmancera@suse.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260620161850.7114-6-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301077-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,6wind.com:from_mime,6wind.com:dkim,6wind.com:email,6wind.com:mid,6wind.com:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ACBE6AF367

Le 20/06/2026 à 18:18, Fernando Fernandez Mancera a écrit :
> When handling proxy_ndp, if rtnl_net_trylock() fails, the operation is
> retried but as the value was already modified by the initial
> proc_dointvec() call, the restarted syscall will read the newly modified
> value as the 'old' state.
> 
> Fix this by taking the RTNL lock before parsing the input value if the
> operation is a write.
> 
> Fixes: c92d5491a6d9 ("netconf: add support for IPv6 proxy_ndp")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

