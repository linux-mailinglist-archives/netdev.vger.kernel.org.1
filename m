Return-Path: <netdev+bounces-278237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIyzGpGC3WmKfAkAu9opvQ
	(envelope-from <netdev+bounces-278237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:56:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E8D3F4529
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 486C63012C5F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BBE38B13E;
	Mon, 13 Apr 2026 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="psEDmpNh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43331C68F
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124523; cv=none; b=SL5DEkE7OdktSpwQzwUwLtEQfSe6risTKAIAPx7aT8MfPoLV3K1+fnIM/GO1iqNQlIJ646//YYNmJmmvSai6yYMlTaws2eii8Vmpgsu7e/fiQVGpmY6KZkLeLOG6S6g2hQbca7sZaM5c++TIfdY8K43IqXO6sX3kClsLh1luy8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124523; c=relaxed/simple;
	bh=XyDHrOBzF3OueFEnFgTzxlUdg6VBfCg6iXaxoOWc/Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MK8MMgc3gdrXUEQBVwwe96NxlOcStH4mm9Sa4tUof6BGY0SHbKd9TE+g6mMpIF770ceOGi+gGZDrbSYGva4Uoq6Yo2pAbqiVKM0goMsx3rfUbdZV7GwlSj1gFQLr6vO/+FtzZ40wZBBrAYJ8rulR3LYmobuUAPxCS0p+MXj5CJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=psEDmpNh; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XyDHrOBzF3OueFEnFgTzxlUdg6VBfCg6iXaxoOWc/Hs=; t=1776124522; x=1776988522; 
	b=psEDmpNhhFXb9JT0Kx1MjjF4STindQpHXp0WsaoX5lpF4fipmD8UPXziudOMGXGr3j390rQaMOa
	81vh1wm8+6gASEbSXIUaHcmrZjQkqKblqWWYnZ3EuA0zirnWqsw9LG8DPnSyWuFQQPHxOQ1PlQ+TL
	sfeFJMG0becGangz3rwqNKmdTSmTDB6EHUgp3jBAxv1ZeBDwLnc9lH16Ps9sLvZONw60kCdaPkPjH
	9OQTzMmQDYinjkk9pMc344yv13NphECRUq93spHZH/KyZcI1BMoAGRg5GwEJq61ZN3z3vSzu2iCsl
	HfvrXrm6EnHXRWEVR+34YJw9ecoAPAWxoQ8g==;
Received: from mail-yw1-f181.google.com ([209.85.128.181]:53731)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wCR7a-00032x-W4
	for netdev@vger.kernel.org; Mon, 13 Apr 2026 16:55:16 -0700
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-797ab169454so64105637b3.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 16:55:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YxYsOcJez6dYf9AYr6dFMlfy2c2cYrRafFpqwO3bwcvWErylQGF
	ncGu/tfjYQr85A3NCYtdQyHen+3aucvF8RxtNMM6cE4jaI60YL9PLzeDt7Kdi/4RFC9ApPerDzJ
	2uSX70SjewmC6sTYqCXYXSYaOGRUQnxQ=
X-Received: by 2002:a05:690e:4186:b0:651:bc51:e6b6 with SMTP id
 956f58d0204a3-651bc51e998mr8205141d50.38.1776124514331; Mon, 13 Apr 2026
 16:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410200310.1915-1-ouster@cs.stanford.edu> <20260412134531.21341692@kernel.org>
In-Reply-To: <20260412134531.21341692@kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 13 Apr 2026 16:54:37 -0700
X-Gmail-Original-Message-ID: <CAGXJAmxCsBPJttXdvK=s2SLxFUBzTDvf6PewPo+6QkxZbuES2Q@mail.gmail.com>
X-Gm-Features: AQROBzBeyYT6aw7wGKkFjAtgvA9-5JG_H0sYC6rjuXNt3zL2Bl-nu7Sadg-oLVY
Message-ID: <CAGXJAmxCsBPJttXdvK=s2SLxFUBzTDvf6PewPo+6QkxZbuES2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v18 00/15] Begin upstreaming Homa transport protocol
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 9dddbef7dbf47a29383c7a3c8e5dce6e
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278237-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.812];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 58E8D3F4529
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 1:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 10 Apr 2026 13:02:54 -0700 John Ousterhout wrote:
> > This patch series begins the process of upstreaming the Homa transport
> > protocol. Homa is an alternative to TCP for use in datacenter
> > environments. It provides 10-100x reductions in tail latency for short
> > messages relative to TCP. Its benefits are greatest for mixed workloads
> > containing both short and long messages running under high network load=
s.
> > Homa is not API-compatible with TCP: it is connectionless and message-
> > oriented (but still reliable and flow-controlled). Homa's new API not
> > only contributes to its performance gains, but it also eliminates the
> > massive amount of connection state required by TCP for highly connected
> > datacenter workloads (Homa uses ~ 1 socket per application, whereas
> > TCP requires a separate socket for each peer).
>
> make coccicheck says:
>
> net/homa/homa_peer.c:213:21-22: WARNING opportunity for swap()

Fixed.

