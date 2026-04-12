Return-Path: <netdev+bounces-277902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP1GI+UF3GkgLQkAu9opvQ
	(envelope-from <netdev+bounces-277902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:51:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E31363E5F2F
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D94873006B29
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE55E35A3B6;
	Sun, 12 Apr 2026 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmB/Iq2S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729812F290B
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776027073; cv=pass; b=MHNw6N2WjauIK4TAEf0R/SW57Nzt04IrK/54Z0UY3YH/p9aRwhcWWpXUenic3/NOldIHH99Mo54sdLhTLTZKWF/3dpMr6ttJQYg+xNyIBW1/jDrSr5WXZ3lzsaSPyE0W7vMF9hzBtrNc14SaqTcNA+qvNBf2rKxMSKPZm1XxV6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776027073; c=relaxed/simple;
	bh=LM9m6qr5xH+ZDR0Fx3Qfau/KOHG3S3kieN3xmZMulpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLoQS7AZ63i2kwd7buYg47EonknvbJD0MZecKrLDD7Tcg6QDP+YYLL73GEShR/3aBum70WffbtuzZQc7PWTEYwtYTN0th7g+ZHx1wbk4QKfhAfT/q9nGBBF5d+Tu0wgnZZ3jWR5XFy+KIVCwYWutWFNQ/DnL4CaW7YvsYIHTWBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmB/Iq2S; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2d832f2f44cso819794eec.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 13:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776027071; cv=none;
        d=google.com; s=arc-20240605;
        b=eN/9uI0hpJsISuJicJXZB5KiG2+wOfkmTCRujcfvqrH6ftYsVaqsXxTLOD0Si0D/8H
         dRuk4+aNngwwQUQ30dj97+1ESh4lmaB4+Q/+Ov9in4vpJ4SX85tVRYGNunL0pRumKRWf
         FiopaCFr6IWzTAcqfwRX/zoq4/1KX5UM8FjDXgGvXv/rbm7enhO1Byf5LYaOCPGQjsO3
         ZVIk1QkvOvkxT3+xrjuQgtnIGLy9emMiQAIPz4XCisPIUS7Dhbtv06jwA9CgxGv9ZVp7
         PHkemB2kxUkdtVOPgJiNAwyd/lPurstBkBwq4YUz44A9ksqsCk2eZ83Q+GfxqZ+kR0Eb
         Fplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wGZRjqJg00QBQnctViP/wqWYri3SLbuWT35GAvVVtt4=;
        fh=gDdbrjwpiEXMMh3brCb3voGJ2bl3TWQtdTPbP3DVk3Y=;
        b=ZtFOkW9iUundcG+O8vayi439dH4w6vTC4ZhDYy77NAKjjMsFSvHaZHdNIWQd9G6lLU
         X9O0gwlU3MrUiKof31Mjz3M42J0DNPVQuN7oL7IQEL4llPRPcVRguGpLbilDmVYDFKb/
         BF2c8yCpmbFQ1nxXkIKU9OAhtvYA4fmfHIBOvufpsu/3bgH5m/4tfrLu6EyGYUWkB/nR
         Ff2ywEm9AGOaQWoO9+qxVvAS4foDOsEVZd3vXVyuvnd2Yq7K+yptj2ZoegtjxWI2pcJU
         iVj0i3VFUkLIsH+39u3cj0IMU39Ssq438Yg78IQUVai/z2wSKG+04XcnclPE4BnUDTwT
         7G3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776027071; x=1776631871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGZRjqJg00QBQnctViP/wqWYri3SLbuWT35GAvVVtt4=;
        b=KmB/Iq2S6nsf+SsIStCQAs8crE2dmDjzxaI2r90XQLtxxD9PVplCOoqluApP/Dwo+w
         eCsZ49ftwXa6qk0dRkOym9o6iEgLdymeWKevv5xpBWZiXU10Ld09h3Oy3AYQDWiXuaf1
         wHg/YtkIPPGmtdHdPCK3FOU1ezf1dgVPFKws8O6+lOYCVtosDWCMpV7I7k6FrEMgh+BD
         8vpANGcHMCF2HFvFpoN/vzRLjvKqfSJyg044+QAIynE+fRAOClOBxZVXT8XZXv8RonAk
         3V3na95J/5huKOEXjcFRCGPYbk7mK+IE1nQEkAfXlnsfYVpeuGkPqoF4VM8tc8o4NPcY
         k6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776027071; x=1776631871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wGZRjqJg00QBQnctViP/wqWYri3SLbuWT35GAvVVtt4=;
        b=JpgztM+SGYMGR96NyCSCD9Ee2Ji9H9kGNwWQA8vfPSQTY/zFMeeGNZrn5n+CJWIu0w
         JphujTkcf0YMA5nRZEXEOinRc0MR94SP94tJLjoHWMqcfxe2m3HohSunYPLv0Vs+o3ix
         CA2kUNX8sm6TJMXLxOZnnJeK6pV7c0ca1GoX+g5HSSGkyNEfWKDOyCd/+FJmTmihEged
         O4q4Nol3/43QjN1MZDjst7TH3Lw2Y3YbWWeOF8u1WQaEBBZlnCfOha3GtgPk0EDXW/Qu
         cH0GSe9CnBimGU5ez2EjMzCGPFHdH2qjMix/bLoPSC2IRo6tPXNYfUmPexyR5pCqEKv7
         gQVw==
X-Forwarded-Encrypted: i=1; AJvYcCXjF3rBT6b2HNbNNOEv1m1zX7e28ezj+dL5oBc0l6AJA6f8N/ux/9DdTTKCG06e2ADYLZ2QFbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIn5STSAMOO+cB5FiPrlL+Bq0/Tt6tCbWmtEPJnxcstnjbKN1d
	nI8jMHtIS8uAgGeolbIe004u/xLMV9a3GM3DeuNWiIKbY9iqoEigd+fSS3M9EmYxCL9Akp1NxxL
	jENwbGyvCw9CRZ3V6YOhFkrpVsnYcBBP2MSRH57CA
X-Gm-Gg: AeBDietsZKfL4YwySVBtiqraaBSHBBWo7V0oK1hDIJpyqhIeM8YTC4GkHuHQue6OxbD
	jg4BxUoi86AQvnaLp7r9QYza5vkdYijlUienD2qbHURamrAATP0MkNt2HFDzSERX8c4/Psjjq7I
	4Hgn286U58uWJyZU8Y4H/AKZCGCV0OrOmy7gmsvsjIhOazeehwCKLgDk/kP4Bp+VNYhHfchei7l
	G8Hec+n/Vg7zmS9MseCShh7IHh5UBcFnSvF6HqM5N6041hQqpOE+yg33wXbc3UzYHrOgLwTjj0Z
	EWkK0Ncee36mIogpv/cxpnQOg8M1xL+dVpuDB8Adk0KzW35tKCG/Nt4aoH1CnpNPonCUosKkH9q
	jnBCR41u8h9++542WfFlodCTI21OFPLsRf17uGkCC6rOun3kf4+e3U+uHPUfZJCI=
X-Received: by 2002:a05:7022:327:b0:12b:ee7b:51ec with SMTP id
 a92af1059eb24-12c34e6b527mr6456905c88.1.1776027070887; Sun, 12 Apr 2026
 13:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com> <20260412075856.68f37eb6@kernel.org>
In-Reply-To: <20260412075856.68f37eb6@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 12 Apr 2026 13:50:59 -0700
X-Gm-Features: AQROBzCaXbNou2DDMFiXp3It0xD3Y40LlrtifSSqITJSjlRr9lUycn57fZLCGfw
Message-ID: <CAAVpQUAnpk+A2M=Or=0C=ksbTMo0zuBst3aKC3wpAdP8AKpRzg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 00/15] ip6mr: No RTNL for RTNL_FAMILY_IP6MR rtnetlink.
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277902-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E31363E5F2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 7:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 10 Apr 2026 21:16:56 +0000 Kuniyuki Iwashima wrote:
> > This series is the IPv6 version of
> >
> >   https://lore.kernel.org/netdev/20260228221800.1082070-1-kuniyu@google=
.com/
> >
> > and removes RTNL from ip6mr rtnetlink handlers.
> >
> > After this series, there are a few RTNL left in net/ipv6/ipmr.c
> > and such users will be converted to per-netns RTNL in another
> > series.
> >
> > Patch 1 extends the ipmr selftest to exercise most of the RTNL
> >  paths in net/ipv6/ipmr.c
> >
> > Patch 2 - 6 converts RTM_GETROUTE handlers to RCU.
> >
> > Patch 7 removes struct fib_dump_filter.rtnl_held.
> >
> > Patch 8 - 9 use RCU for mr_table for CONFIG_IP_MROUTE_MULTIPLE_TABLES=
=3Dn
> >  and CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dn for ->exit_rtnl().
> >
> > Patch 10 - 12 converts ->exit_batch() to ->exit_rtnl() to
> >  save one RTNL in cleanup_net().
> >
> > Patch 13 - 14 removes unnecessary RTNL during setup_net()
> >  failure.
> >
> > Patch 15 drops RTNL for MRT6_(ADD|DEL)_MFC(_PROXY)?.
>
> Hitting a bunch of:
>
>   SKIP      no netlink MFC interface
>
> on the new test here. Do we need to add something to .../config ?

No, I used SKIP() intentionally becuase only IPv4 has the MFC
netlink interface and IPv6 does not have the corresponding one.

Should I just return 0 in this case instead of SKIP() ?

