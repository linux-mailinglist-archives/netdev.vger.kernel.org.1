Return-Path: <netdev+bounces-253710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rR9gFYNUeGn0pQEAu9opvQ
	(envelope-from <netdev+bounces-253710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:00:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B35B89032E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ACB9301D4FC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450F130FC39;
	Tue, 27 Jan 2026 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLDqdHPf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ABE288AD
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769493632; cv=none; b=gh3Yfmua3JCHIIxhZf1UkovUSenOqS8kBap/XEsIHpv5nTouTLqZ4QoADASLNpnAeUf6N+rmVFxVV67rXKFQ62Pavn9RhfPALaeLF7yoDVLaCEamFE+jJHsdSr/SoKd4l0QclDoSTGZU1sXaL2dGzyAhT14A+QQ6K8J+2fhIma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769493632; c=relaxed/simple;
	bh=v/u+rBX4luP4l2y0k4d4MJwxSQLjgxjIcVpFBIL6lHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7XsrpuoTDuiSHfZCjDQ3L+AWLvQlp+ZB/MR4fzRbPTss4IVd84+/ZfHqNqq4J3Z1A5/1EPk0sm5rx5XOovvfx12nXfk4lqLfPyHmtALIMVx8qq88/c+vgSZSFtADhvUgrFYxfe5Mw1R9z7V9XBs0cL5to+ej8PzHseFVJFXS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLDqdHPf; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11f36012fb2so7484145c88.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769493630; x=1770098430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a803xA0SW+lSUQWToabOiMzbo1P7cUc3kCdEW2eaQec=;
        b=DLDqdHPfWk0o+gSD5pgARfeKHy2TUdAaS8uw1NmauBipNaULr5DL+mLTBxcMKTkjxG
         +w5gjtRDs8DR1RtwVb9nwlv7k+E1OtsCPJHtHONYHtT4J+xnSMPhA3VCb4CJe8ycczuL
         ENFpSLbU5Adck6SIVvpmOJOok+lWIPro6yf7zoPVJONnljqQkIEdVR9sALcLQ+q7EKSc
         7STZ3CSGsWs21Swpq2QhkaTIzMZc1lpqNNyXJAlMWlTLoT8JYzcKcJnVJ3HzGRiSskV3
         K/vIJ1pcgleYZHjGwTu/c0OxE510Mvuzwk1kpR+elyWCeiOr5GzExE5p7ak0Kr4t6Yxq
         EzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769493630; x=1770098430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a803xA0SW+lSUQWToabOiMzbo1P7cUc3kCdEW2eaQec=;
        b=N0sOc+UAjnr2Dh37ZSpGdsZM3WKgmy21qNcEXwlZWdR8UMaqpoi9DHHnAkQTlTRVUi
         FT2USlY+ltDMr0SJhLKOAVq3jTPcCY7UOf43BWEzHfevobQE4HOrQlbBUcjCooDnqNuG
         rYkkndl56Jz2dQpFMiDeAIijo/XFkn2e9gbB7AY+/E9jPmofwfEtHiXyGrESt0EUqjwr
         3QvPLykQV+cIUmQWRVbfOBkFkPHlmaVLCA3mn4Zsvgz5ByHMulQ5FF+9DMUBmz2hxJcZ
         OGTW/9Vs2EwNrdePEVW+Qh51+Apco9aTe1OklD1dPBMVpU1FcRYaOc10O4/fFwWwNowi
         tVhA==
X-Forwarded-Encrypted: i=1; AJvYcCUAM+aHbGE5jGleOTmB5clX9AMzJ64fgAA2En2QkaS3ttoz0yBha2qyQVXR3HMFJBPfDPnNQ0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxonDvL2VeXZKMWolUKVvoUSRFApjNotNcjKQO7ZZ3fh2FEw9TF
	i4hb3v8VYkQlMtvfTrPKjmktkqgZDBiPqIjJHQKD61CsoR+EktOfNX4=
X-Gm-Gg: AZuq6aIMXOkskzP9AtVBfn1yZDaBkHwR5n6EMo8//v9WgZhJn8vKt+KNtEoq3uNWKTh
	gIGq9RG9O6U1k9eAPjH5BXHs6xIErWhkAzeN7iwCzc1ctbXdtyPQY4X/SMEdxjete/6iic2q1Ii
	TqjYcdU2uU5S+q2lVWAfzPquSCcaoL7bRlp9u6ZIHhA9xby/BThDvBqy45xYB49mFd5UJ5DiQQN
	g9I6bPWz3YTUZvLVAYM/Hf6zEEiR2nP8fO+ZzSSDnd3dPs/wH1rj9b1CMqr8JoIatkYPvsNyXZH
	9aVVJ9qU994mAXpz463qgcLN/OXSRRZEpCRdVbryD8k2j9Mct4+vvAaiFyQJD6wO1EB05btiLnP
	ojUUBS6fbxeYVQhT1S8PFpBRNOII+tIg94cD59Gy8VnJJyYYibBtdyoB7wP2MBK8pGtain0WVTy
	enUhN/cnDGpu+fe7wp5vIq8jDfAaRotV7NmMl60LEZyxdDDbjaVeA4T0U0KIDmEuM2wamsJz4q3
	m6Xqv+qHADdHMzC
X-Received: by 2002:a05:7022:20f:b0:123:2d00:1668 with SMTP id a92af1059eb24-124a00e861emr496547c88.49.1769493629755;
        Mon, 26 Jan 2026 22:00:29 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90d13esm21240114c88.2.2026.01.26.22.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 22:00:29 -0800 (PST)
Date: Mon, 26 Jan 2026 22:00:28 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
Message-ID: <aXhUfC7ZyYge1jti@mini-arch>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260120170749.101e8bcc@kernel.org>
 <CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
 <aXe2QhzL4DoVbesQ@devvm11784.nha0.facebook.com>
 <20260126173124.1f0bb98e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126173124.1f0bb98e@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253710-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[gmail.com,google.com,davemloft.net,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,fomichev.me,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B35B89032E
X-Rspamd-Action: no action

On 01/26, Jakub Kicinski wrote:
> On Mon, 26 Jan 2026 10:45:22 -0800 Bobby Eshleman wrote:
> > I'm onboard with improving what we have since it helps all of us
> > currently using this API, though I'm not opposed to discussing a
> > redesign in another thread/RFC. I do see the attraction to locating the
> > core logic in one place and possibly reducing some complexity around
> > socket/binding relationships.
> > 
> > FWIW regarding nl, I do see it supports rtnl lock-free operations via
> > '62256f98f244 rtnetlink: add RTNL_FLAG_DOIT_UNLOCKED' and routing was
> > recently made lockless with that. I don't see / know of any fast path
> > precedent. I'm aware there are some things I'm not sure about being
> > relevant performance-wise, like hitting skb alloc an additional time
> > every release batch. I'd want to do some minimal latency comparisons
> > between that path and sockopt before diving head-first.
> 
> FTR I'm not really pushing Netlink specifically, it may work it 
> may not. Perhaps some other ioctl-y thing exists. Just in general
> setsockopt() on a specific socket feels increasingly awkward for 
> buffer flow. Maybe y'all disagree.
> 
> I thought I'd clarify since I may be seen as "Mr Netlink Everywhere" :)

From my side, if we do a completely new uapi, my preference would be on
an af_xdp like mapped rings (presumably on a netlink socket?) to completely
avoid the user-kernel copies.

