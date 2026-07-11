Return-Path: <netdev+bounces-306859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5p/dLXVNUmogOQMAu9opvQ
	(envelope-from <netdev+bounces-306859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 16:04:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE03741C11
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 16:04:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=auJzsx57;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306859-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306859-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA65B305D840
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9773C73D9;
	Sat, 11 Jul 2026 14:00:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E43C2B95
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 14:00:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783778419; cv=pass; b=XRft7XnawQmm+DDqV+L5Yr2C6gFOA4UTDoXqiSllMqxUNDI6FZiCvTaKRDegP8+Y+szTVz3icj8mHQwwToHhXVbOEn3ekmXumsNvVcXwvRx9k54frhmmx2bRC9VHt1jW0hbzKYNMKtTj8/yK01N4yo1IKyZEJILtT6Qv/iaceBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783778419; c=relaxed/simple;
	bh=2x8s2hRIzfzcX6kMgVsDG2qEJDcy4Ak63lIwgjF35zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlzajNq0yBZL8K/dEpq25cynPY640hq5ATw8C0d5OGvCXZq4pmEDj6luZMc05ZGrrvGTXEgJKKR2NMz5G3LzGmt8HO6R23Zv1y/BvDOs8cR4V6H9cIH4G93A+WssnPnznApXpi+hQs3Y5yWHbDxJgDWEzwk1FDAZTsu63WKbx9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=auJzsx57; arc=pass smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c8e2e39easo13706961cf.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 07:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783778416; cv=none;
        d=google.com; s=arc-20260327;
        b=KPA64Bzk2Ik058f4XHkcsg3bk6hkLHyouklwulzv+rJFq+hfSSNOrFSVZNlmvCK91e
         CpagCSJlK+y4Oz1CnOaCSHsbdnzHTP5d3v0sQwnqGdJUFfxKSMzQXxevyoTfa8SnZMc0
         k9jebefAvnBlhbeEgD9MHgVnhcWCnetNLrC7eRzEa+qEpVwx984afgeOhvmx1llD89UT
         ryf/sLUPVn7yBRBODEmIcTn3s7wOsEB8ygI3yQvninOyypoMpQ82Z5gmvIcSsFjevz6K
         S4SEguA5AgBu9/QqxN51/stnYGCq73f/hDOjmjK9WUk0nq4W1QTbMSHydnocqLswuKgk
         1OXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GqDR0IptsjWrOWRZQ2Jyt0YxUIjEB4dj30T2XPWVZdY=;
        fh=jK0q+7F8TwV8RrE84Jz3ZQXX6FPOAlq5oHMg1Kh3aMo=;
        b=JWJxxcysUnADDmoHDz8A+JpT7OKWSPDLzmLzAsNK+pLM/7krK8UK86zGDqerWGF2zk
         q9JfJi1anTGT+vQqaza8jVINC64ebQpHKhtpKEDhrPUw9YEOmukaA58GBIw/+CS/pQAx
         n3b/C9bsB3FvHv8txXT1ei+ju5c7YWYPXYrBeOHHVI6tvab3AX7wvpZa7jx3ltuYKdlR
         UrtExyxIwxmaltuAWFbfoCIScVMIPBOInBbHXmgbspVdwafSB5/Ortq7UmikJnhKkiZE
         z+pLlS6Be02b5+6WyXK+uMJiMBx6uEmTM0cm22T5BOEhEs7A8jUbdqpbew+Iah8Zhpd5
         Q6RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783778416; x=1784383216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GqDR0IptsjWrOWRZQ2Jyt0YxUIjEB4dj30T2XPWVZdY=;
        b=auJzsx57xi10LJGLIaOVxsXhfVM0fjiBx2oR6Y2FSzzlA3J5s/0CtG+K6p/ImEN6Pq
         Q4JDugXNtrSC30C3c8oD8QT18rckS8QA3Tnkh/DKmdo/imspPHiENW7SxRc7bGzjFftK
         KfqqJAj3hPCeO1oaE0ut7s+gLFJ4qfHRrVMfCopt85k4OXpJ7urYArr+JuNW6FyXxlv1
         HUXaA7nIwdLbik4Rh5zlZulLgDMAKQAlUam7CndKegMSvViKmwPFW1hquVvBcGP8/DuV
         5ggKoF3C3f7jDNeDGOCCZ+0vCCc8erQEAGbeuKfpwbCY/+4ZZTa1twjZDEf/NIbqV5vJ
         q0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783778416; x=1784383216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqDR0IptsjWrOWRZQ2Jyt0YxUIjEB4dj30T2XPWVZdY=;
        b=YQcpZ+q9EUylZY3fgViKIJtTHluDAf81dlZYF58UUmhvryt0d2gw8G+y2WeDuJVvcq
         LvnU4bsUKTBao2I1NQr8sXVKG49Qh64gykK9LBo6/ZvEUiMlZ40GIeTW/t8BeM89XEha
         zuSoAKnAoUYqJvGGdMYhu5JsMEFhasABTtIy2tp26MviCAVuz5OeGMylQ6XvoKHktANK
         yLSLtMa6eAye2jH2UzfVrrk/EVdDwTQE8FS5fRDcViI3Vl34VryBsukWB9RMPyW+xW30
         6B/87GoWsmmnc4uIcRJaVzu28zaaWxrLqKqA27tiIg37eYk4LCl6Z/WAIMCcz1G3MD89
         iUFA==
X-Forwarded-Encrypted: i=1; AHgh+Rokwfbm+R/IpDuCz+pXDHue4tXnxHvSfMWm6BLuABYOSbKClb6FrkC95rXR2rmZpcV2K8v1oqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrS2NMJap7LsGsAp893SQNu36nr7zB17X97jERF5reX/9ENes
	7kMXGNfU7Aw3P/zoVRJt90HabVwHuc2aAmc/S+gVxX0XXfvxOB+vr8WxYMwtXS2tnQl85rjmqjn
	2/GOSyRmmtZqy2TYIVw4fr7YwGTuSAhco0/NXQWig
X-Gm-Gg: AfdE7ckWtVI0HsRegrrj2zragE8MRDL/Y7rpY5DnoWlm68YBc35u0gy0lyyfwIRre/b
	DqJgDFy8HUIw/Xewx9Mp64ZB0u1DUj7e69oiLlACxifkRrKY0A1A7ElV8YAEZA+cwaAYoGSZTCI
	te0TrOCB1ZRsRV8222mxgRxQTR19nDyoEKClVfzcs3U1WoSDl+R8SVB5y+5+KCne0inNg7fWbW/
	r4Y1lIkP9+N2jE2WuNRuALwODRawj/GSMHgghMqUyuUoCxCwZo481mBNlttJTF5M9INDG2vP9Ai
	i/+ydavstuwJ9XKBa45enWA10dpGnTr3kPzNO77cRcdlfokZsmpoWlNF843orM6hCYLzPKLWKY5
	bSQiDCfA1
X-Received: by 2002:a05:622a:4885:b0:51b:f0ab:2b1b with SMTP id
 d75a77b69052e-51cbf26daddmr29126701cf.49.1783778415594; Sat, 11 Jul 2026
 07:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711134732.1385563-1-tristmd@gmail.com>
In-Reply-To: <20260711134732.1385563-1-tristmd@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 11 Jul 2026 16:00:03 +0200
X-Gm-Features: AVVi8CcY5CaPIMoOd8xuDL4_gMxfAA225TDZjOSaO1YM-5oHGXW8erun50xkGWY
Message-ID: <CANn89iJo1HFtp6EoUmwo7KJ9LRsq_iQqhGV4Eco-7Szw5oN92Q@mail.gmail.com>
Subject: Re: [PATCH net] ipvlan: add xmit recursion protection
To: Tristan Madani <tristmd@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Mahesh Bandewar <maheshb@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306859-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:maheshb@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AE03741C11

On Sat, Jul 11, 2026 at 3:47=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> ipvlan devices can enter infinite transmit recursion when combined with
> packet forwarding configurations (such as IPVS) that route traffic back
> through the same ipvlan interface.
>
> The recursion path is:
>
>   ipvlan_start_xmit -> ipvlan_queue_xmit -> ipvlan_xmit_mode_l3
>   -> ipvlan_process_outbound -> ip_local_out -> netfilter hooks
>   -> dev_queue_xmit -> ipvlan_start_xmit (recurse)
>
> The existing per-CPU xmit recursion counter in __dev_queue_xmit()
> (XMIT_RECURSION_LIMIT =3D 8) does detect the loop, but fires too late:
> each recursion level consumes roughly 2KB of stack space through
> ip_local_out and netfilter, and at 8 levels the cumulative usage
> exceeds the 16KB kernel stack on x86_64. The resulting stack overflow
> hits the VMAP_STACK guard page and causes a kernel panic.
>

Please fix the existing mechanism. 2KB of stack space seems excessive.

If this is caused by some DEBUG option, it will be just fine to limit
XMIT_RECURSION_LIMIT to 3 for such debug kernels.

Adding a workaround in every virtual driver is not an option.

