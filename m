Return-Path: <netdev+bounces-279030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHy7EhPR4GkkmQAAu9opvQ
	(envelope-from <netdev+bounces-279030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:07:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B22840DDAB
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 580FE3040A99
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30DF378D78;
	Thu, 16 Apr 2026 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4Peg+cL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F18389E18
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341264; cv=none; b=YekRN9691SHly4F66qqHdxvxkaz7gNJcMFzlhda7fg/m6sLLfi6vv9WWHJCCJKdACd08ldTuX++V5vU4ZT9HDXhSjSGAePJ1SuNohQJNfJ1gRB7kXkN6ET/kFkvskZ9W6OjA7Lv3Uak27lfGYg07DCzz6bNC1ZpXrRnpAO0AkCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341264; c=relaxed/simple;
	bh=NrEkgIT3CavejDfgxIjI56C0I2Vtk5TSlqb7mwsouqg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UKDjq+iEK3aG0tnnqUSnt4yt81d+6wIPFg8top12W3Q+WjdGH3xuYY0kIweOrrFS4ucgseJ4HGPQb5sPCE0+qbWCfEyt7qFAA5mtifgP1b/lYdQp1euAGC2OtH/qeJ30l3bmhC7KmOCfLX9rkLLtBJsxnwdZM2SGyytcEU3DPZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4Peg+cL; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ab5fd969aso87659947b3.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776341262; x=1776946062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJeUcOg0KStbfCJl2tWAHQlnlr3rxF6lVtgfzmtYhko=;
        b=r4Peg+cL8jMM9b6ktQuppqO2mXy46r1liPSmrooD4x9nrghj+kO7Ji1BGrWrp053nK
         ZHxPZ2b3JU75CjtqKxBu+OO7c7s3kzrrvvyQ1NSVZ4Fdi5kK4kWwqgbBI+t5kSG7x4V4
         B8Qy2ekNIGbC6y59Xj1wPG88FbGU7rIEFJa9duaDwgfD7EPzk0PX9T5uag/7vvmITc5z
         hizwtTZexOEHXmwC5MaH4aeLMnXGyr1pFP3RihtHWvgcaUsa2OR9Qd19rFt9S3mDDS1i
         kITfsNDWsJPspOJoL/PVkEsgEJosX2Ej12ZbMf8lL8j+HhwOPDPtCry7QDEErt/OMPWS
         y/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776341262; x=1776946062;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJeUcOg0KStbfCJl2tWAHQlnlr3rxF6lVtgfzmtYhko=;
        b=MkTaHXAbC6Bjh+qt+xvM3ZyQTq3WTFh6MMmP/D7WttVpWFnp+y/rE4/zZrWCyxOJsT
         rt80cAtJ9X2T00/1DslnuJSVWTIJP3O2uxR7vj7bxKxwFHsH2yRPyOHE1NIosLdO6e/V
         nUyur0YURpZJqfsAER+lKFbUnCjAyRjtTqqSkmGi2TTu0FkWedj8IlqBsE1syXv+a4yV
         tY40PuxrUvlNavmDjMM/K1AgSs/9nVCTrzCmX7yjlEUKzSjqKD6YO7rzyTx9zWzyiW3A
         Xbbync4hh2gBq0iU2Cb9Z0jdTNUip3i2JFlZZITf8HFfTEONMnB/yZYoDOwIqARpl+ym
         kW8w==
X-Forwarded-Encrypted: i=1; AFNElJ8voptx6q6A9EP8zV0wcAhtOn6OxRk2JGh/cmRRb32g4m8dL0ib6U2HneDnc4O+3zsx51gYkG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTisfFYy3BNsVRApFL81JVsiqQGdnzJW3CIQiNixnxT0MxxY0
	67td46NLiFxJaBWD3DCemn9Uvh0GgJf1lkLMDGkCNohrRTmpdMeQ8Rif
X-Gm-Gg: AeBDievVEnYwVX685WVpB8ExFlqohMbk1CgYEa3ZC19dPL+y3y35uxM8cneyg7ag12p
	9YGcwJ3ADWp+4XiJcToamZBiosqAK5TC0gBqErt+2ImPKVdJ0HiaTRymOpu8vYnwAeT0S/1UQTY
	NxfFb060baNmEpzU6tCFTvOer/fbnBK18uZMPijykviisO+40OMqXYdRXBT1DvtLLkCvo34cxlq
	1oBHKVeJ1Q1dJF8kkMq58jRFXyPJP+Fls5a7ml27zi5moRTJyy9KD6+EqcrOkaAjPT0unR8Q53+
	TNRpgKR20lJw9tqOLtwPeCbioX/utTSUlDv0vKuJ6RwWgvWAmCORHv482WPKfc85qnPwwzghL79
	CUw3OkNaB1jPpzjK6l7LjMZTq64RCm2KdXMzsGKVfrCtG7TxPz7t2KFeEJtyVpKOCcb+x3fhryg
	REctEdKqaiO8mPG1dreMW9KnooSoLv2u72xHNuLditp4Tf6ssrUwYQbubuy4U48AyWt9sAJpBO2
	gen/FGML5mGvKE=
X-Received: by 2002:a05:690c:e3c5:b0:7b3:f33:35e0 with SMTP id 00721157ae682-7b30f334109mr173594107b3.2.1776341262509;
        Thu, 16 Apr 2026 05:07:42 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b769411295sm21500077b3.42.2026.04.16.05.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:07:41 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:07:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice@isovalent.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Stanislav Fomichev <stfomichev@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.35ffa4501e054@gmail.com>
In-Reply-To: <CAD0BsJU_Q6O6MpOMvD7dv6tPYsB8w8SFc-=2mEGpVJtUJW2u-A@mail.gmail.com>
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
 <20260413155552.5cd00bc0@kernel.org>
 <CAD0BsJU_Q6O6MpOMvD7dv6tPYsB8w8SFc-=2mEGpVJtUJW2u-A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/12] BIG TCP for UDP tunnels
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279030-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,blackwall.org,lunn.ch,strlen.de,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B22840DDAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Alice Mikityanska wrote:
> On Tue, 14 Apr 2026 at 01:55, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Fri, 10 Apr 2026 18:09:31 +0300 Alice Mikityanska wrote:
> > > This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
> > > support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
> > > IPv6 BIG TCP doesn't require stripping the HBH in all various
> > > combinations in tunneled traffic, adding BIG TCP becomes feasible.
> >
> > No longer applies, sorry :(
> 
> That's a pity :(. I see that the only conflict is because udplite
> parts have been removed from net/netfilter/nf_conntrack_proto_udp.c,
> so I just need to drop my change that touches udplite.
> 
> > We'll have to revisit after the merge window.
> 
> OK, I'll resubmit after the merge window. I'd appreciate it if I can
> still collect review comments in the meanwhile.

Sashiko has some points. Predominantly false positives at this point, I
think, but do take a look.

With that aside, for the series

Reviewed-by: Willem de Bruijn <willemb@google.com>



