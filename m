Return-Path: <netdev+bounces-279436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fyp+NXeq4mlJ8wAAu9opvQ
	(envelope-from <netdev+bounces-279436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:47:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CAF41EC35
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB38D306F339
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C3436EAB9;
	Fri, 17 Apr 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANLV9i68"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B736DA04
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776462361; cv=pass; b=iS4dngJ49qmFwBrwUT/D2pKfo1W+qWXxVWeVka3UZ4plWSQDbGUS7nV9GlbuGl0ed74RkDOYFlX8rQrjU6KfMi28ulv8bqDGBLcpfTCM0mbkPWDruMmI3YaeIreAg2ewkSL36mLzFtEl+tF7j2uBUBhaWIqUFGK0TUHMLJQyx9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776462361; c=relaxed/simple;
	bh=qIJimZDxfSqQgBoDMZswcY+iDXLgNpQ60BAfVGkRSAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWchKLdQ14LQNNpzq7bCxD+Z+mNsjLg2l7MU6ijK18qljsZ/xMGXpmIkJkRGUv/PinLyc11lWpvL6h/qwhvBnsLb7w62sxTp1m6MyxZP2+FOaSv/j/GwknkkqVFytizjYoOVPSFUV2NODqWhbPZXYbLWGkXsCu8HGueyk/eiaf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ANLV9i68; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c9f6b78ca4so138136785a.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776462359; cv=none;
        d=google.com; s=arc-20240605;
        b=R/sBZzQtwXzw6KwUpPM/xi3dZYWUwdVgn6/7PzMZM3Fa8PqR+13B0MQzHUYt1xXvvM
         4gIQoyz5hj6hsGNZ8IZoS9ZwpPSOq0LWYjI7x6hpTQitka//9henbgU1ARhMRc4Um3RZ
         UOGF2edGjEBafidC/p3Ox5bWWZUJS+zdZImKKct5Z+dMQMAak11UvsH4cmhEtIN13jb8
         IKkgZNnCz8MSnu23Trwec66nUbHyk8E668NoRtcgaRcR4UO8H5OmLzAsp4tkTS478Qzi
         MfxwkVoqva8MyoZu08Q451rGx9vIYTW8I9oFIE9WlHU7nETy0ffKZuFwBDEVpIC4+DLS
         C9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yM0HJnvqi23fGMohnKxS6RaACf3ECNoFGiDjXpVyfJ8=;
        fh=PYt91ZBAedVIqNaN3PMF0Ft7f6PHNoZgsfzsLhu7Ifo=;
        b=CsRfDADTiVRe8vTLpG5Te4m71HH9H8X3Ibc5k0hJWa/MGp7HePiJZgMqdkBSfe+nYi
         6qsF2AfcBlO2fLliSAJG/WNo9wQcZyHK5HOnrip2dU4PBHeg/CQ32X2qLSicp/CD+e6j
         ZMw5FAY33XpFUCqWd4BxOk2qjPw4rrqiMCjBstsC33J6yM0W4ojojPgZ/JMB9YFhMWRh
         RXNlhiVaPOv8TCZB/KqyRTbfBGk3yKsagGqInt70/I2BS+W9Zu7Vfw2rN9umMej8R+3x
         ZJy0AMj13EMeFdwsaM8oqgJAtTV+WUcNmf3J8GaKgzFYOyhuLjxwnKuxMNAaI5WV4XNX
         t5Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776462359; x=1777067159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM0HJnvqi23fGMohnKxS6RaACf3ECNoFGiDjXpVyfJ8=;
        b=ANLV9i68SD18+h8QDIaHspn/F8J2gcxAMSIZP1p0wNY4djv1C6fahi8+j6RtjBT4bD
         EBOCmHzQoSZ6sMP+MYhF7t2kbcyYO2LmrGv9Mji2cpVMhV1uti8shllgXPUQJRFfuFw7
         4APIrbu1UtR8K5GGN045JfGHBYJSAfHYnis+RHavscLiuRaXIWll2fwEX3pSnBMkAMEK
         +i1t6OqdwqQanXWFVcevaivcrUbvifrdSuj+I/rBDpFlqMFC6c1HG4nNIZYotuTzd9EQ
         EO0lvPWUlGVAM6isScfNIWXPeGifdn707eCv6FvY2nZEFuPnSVk4KmLabsZNp31x58+o
         dbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776462359; x=1777067159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yM0HJnvqi23fGMohnKxS6RaACf3ECNoFGiDjXpVyfJ8=;
        b=gdbnYkh75+F03bU3Irdx3YS6KyDuBchvLule5+XTSxxHuwmHUWzfFLgc0jDUKMoS5l
         MPmzXdAY8vEMsSSHpqVpVN0oCxNt40U8JGhPXgA7UsQ/v2Lh1MGm3EIWycSeZIjaF/zL
         CJlcmJPi00+ZzJf1bQcTHVSlrg9gnBXHGM+hmdgHPuFnpzl00VC3Znb9liiM1mTV+qMj
         LOz61xj3ESYq0XPzNnRJJz3HhiUJk7tRsct4uaWANozXXHIcF8yxnrcu2B1NLUBVVpRw
         oNtRwZcaDu/LmbdKAm5JHP+Wy3F+hECvqEP5x6fEVU+0jKYYAuU3heqm/2aH4GHAKD2P
         4Qhg==
X-Forwarded-Encrypted: i=1; AFNElJ+g1ryLitvnZzPEfCw8+lhRaqc+6i8LZ2QDLaFz09RvJv1G8aOOjRA2E13BgP1bkn1Ev4IvX6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvS48DjqrJAy1eaenXVo1gmR7q0ritmRUyrsGurD1eb97iNQ7
	SFmzYwDpf/Hoj1DO4tq8Di5WPhuf90hpCuOS5ebHZOvQMS+UdJkLneitXUBcHrz54Gm3FYBEAWT
	Kpk9jIXzAPKkLZZtaLSwUvZ0h3mihbvKpA++xIA11
X-Gm-Gg: AeBDies9ykvea475g57CtI0PtfOQLKKryHbsoZdf23BITdhhv5abkMSmWKIc397UseN
	sNt+jh5nZP1UHkGtY0tf/ZfwqpZMH73u4eZFTpDTVQ67zRzglbBjeZsX43dIUaKmNlQ5BPKr392
	3R4+n7J2tqaVoCxLzNuqS0PkGy955vv/R5+xZW1OzysWVrEx9dzJilWpNrWmyMqgqgwJFT1BkR4
	hFvl+IgLo0SRwBqo/YPor+tXD2PuqYhisV/XHJt2/fGYrgP2Os+wfdTIjzTL61vCA128rz0J3co
	H2PLYQK0RkNdhqIQd2Q1WUCjDL6kJAaiDzlh/KmOAovFHJLLdzgSlsfBrh/1rFV8aIiJMaGsPIw
	hCPmvja5Z
X-Received: by 2002:ac8:5ac9:0:b0:50d:7c4b:5c5b with SMTP id
 d75a77b69052e-50e3682827amr69022881cf.5.1776462358866; Fri, 17 Apr 2026
 14:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417171831.687053-1-daniel@iogearbox.net>
In-Reply-To: <20260417171831.687053-1-daniel@iogearbox.net>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Apr 2026 14:45:47 -0700
X-Gm-Features: AQROBzAqLQO2s6QYRC_MSazXKwg0iQtKRLkjecdQ2EaTe9FcVFCOo0n2VgLly6k
Message-ID: <CANn89iJDisPmSeUo+ZwhsGSDbMq2sK5-XkUV-eG0mKhjxHi90w@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: Implement limits on extension header parsing
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, dsahern@kernel.org, tom@herbertland.com, 
	willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-279436-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 76CAF41EC35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 10:18=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> ipv6_{skip_exthdr,find_hdr}() and ip6_tnl_parse_tlv_enc_lim() iterate
> over IPv6 extension headers until they find a non-extension-header
> protocol or run out of packet data. The loops have no iteration counter,
> relying solely on the packet length to bound them. For a crafted packet
> with 8-byte extension headers filling a 64KB jumbogram, this means a
> worst case of up to ~8k iterations with a skb_header_pointer call each.
> ipv6_skip_exthdr(), for example, is used where it parses the inner
> quoted packet inside an incoming ICMPv6 error:
>
>   - icmpv6_rcv
>     - checksum validation
>     - case ICMPV6_DEST_UNREACH
>       - icmpv6_notify
>         - pskb_may_pull()       <- pull inner IPv6 header
>         - ipv6_skip_exthdr()    <- iterates here
>         - pskb_may_pull()
>         - ipprot->err_handler() <- sk lookup (matching sk not required)
>
> The per-iteration cost of ipv6_skip_exthdr itself is generally light,
> but skb_header_pointer becomes more costly on reassembled packets: the
> first ~1KB of the inner packet are in the skb's linear area, but the
> remaining ~63KB are in the frag_list where skb_copy_bits is needed to
> read data.
>
> Add a configurable limit via a new sysctl net.ipv6.max_ext_hdrs_number
> (default 32, minimum 1). All three extension header walking functions
> are bound by this limit. The sysctl is in line with commit 47d3d7ac656a
> ("ipv6: Implement limits on Hop-by-Hop and Destination options"). The
> init_net is used since plumbing a struct net * through all helpers
> would touch a lot of callsites.
>
> There's an ongoing IETF draft-ietf-6man-eh-limits-18 that states that
> 8 extension headers before the transport header is the baseline which
> routers MUST handle; section 7 details also why limits are needed.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

