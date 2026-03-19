Return-Path: <netdev+bounces-269646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHqCLshgvGlxxQIAu9opvQ
	(envelope-from <netdev+bounces-269646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:47:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6CF2D25BF
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C301315D422
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03303F7AA1;
	Thu, 19 Mar 2026 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="uTzvlQ8n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9323ABBF
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773952717; cv=none; b=JVcjHWjOHsuQK25DhnbaHcL85RE4MO9hpDIHHTQh1fs5+AZu+fcsI8G9bT3nOrrUOjBwiJw7qmh5QXoU8NLypEl0hLtPfrOaukYXAfIyMkIs7DBmXrKtPY537aVksmK5NOzgHNo1nkgwaFQwfZXlQqhsg4h0ae7XOZQL5DWNX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773952717; c=relaxed/simple;
	bh=eCKRj0Z9NWsC2dW3DueD3z3cOeo3X5xFIoh9/uDqTtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axf+IoEGNinxFI64R4TAU1QsbSJRPw63h9Jvbu8crEYjGlmPdd5EOdKfei5rG2Ko5Hl5WawU1USzg5lEjT2ftlNZjDB3bS4QreJ4Dow7OQnuLiVQ1jwJU0ba3XCTFgxDjcqwVmx9A5/rMTU50iSaK+hkCoPN9KEBW5KEZ5oL1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=uTzvlQ8n; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eCKRj0Z9NWsC2dW3DueD3z3cOeo3X5xFIoh9/uDqTtQ=; t=1773952716; x=1774816716; 
	b=uTzvlQ8noJ99KvNPJRUhlCYFP9nC2QKAf9+XC0Wje1j1iCO54ALmJ3DwsE1FBFQ4x6/thGKp3nr
	y6HkYok6/B0Gg2uB1gyjvfz40CefDPij/8ywlpAqFvLLYygmToAdzdmVZ5wsN1iL44PsIWYcRcNfj
	c9wLuEDfgJ3KXlg36zp+IfidbuFslTEN9UJXU4D6o4YVb/Rp1iP0R+Dx/7FqxMGg3Hd50TNRpVJ+V
	sP6cCXQEEhfg9JVn208fvQKdX4SzpQVktnKzXO2fBTd4UJftV64r0Wr1QogUYpf67/De2bbAmmygs
	UqGQ4SZmdLMj7D33EZOXZE3HnIYznoXhNr5w==;
Received: from mail-yx1-f48.google.com ([74.125.224.48]:52304)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1w3K8T-0006Um-QA
	for netdev@vger.kernel.org; Thu, 19 Mar 2026 13:38:30 -0700
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ca6595c8aso1451086d50.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:38:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHyIqyz3HO4i9ZL80IvcNH4iUNE8yYnHFgPUI4pdef5/BjJL+MsnoCcbA3zr48kFKk0pyVYHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztOlYRoHl+jmUhJaWwjxjuEPETYqSpgfPxQMotrbdV0SCCeERz
	eW0p/H6F1GknirkzO7qkL88iP7vUhFycF9U6IZV7w/IgUdv+TJDa+j48ZHBlLRRDXRp2gfDQaTl
	ye+JxAGSR6WXWTKAC2Fq83WIJkzXJf9w=
X-Received: by 2002:a53:ee62:0:b0:64c:f993:8496 with SMTP id
 956f58d0204a3-64eaa815bb4mr678572d50.53.1773952709124; Thu, 19 Mar 2026
 13:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316223228.2611-4-ouster@cs.stanford.edu> <20260318072022.268417-1-pabeni@redhat.com>
In-Reply-To: <20260318072022.268417-1-pabeni@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 19 Mar 2026 13:37:53 -0700
X-Gmail-Original-Message-ID: <CAGXJAmy2+tQT-0T5eW3hLsz_PD7JSBejYSLTKC5Y5KDg3QuQ9A@mail.gmail.com>
X-Gm-Features: AaiRm53TVpu3JUcsgcyKmvswG3iuYV9St4McQphAluotPb5P57ILTeUkch2ppAY
Message-ID: <CAGXJAmy2+tQT-0T5eW3hLsz_PD7JSBejYSLTKC5Y5KDg3QuQ9A@mail.gmail.com>
Subject: Re: [net-next,v17,03/14] net: homa: create shared Homa header files
To: Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org, netdev@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: ff384b2b9a2989b26e23b1d864f6aba2
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.132];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2B6CF2D25BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Does the comment in homa_set_doff() accurately describe what the code
> does? The comment says "Drop the 2 low-order bits from size" which would
> be a right shift (size >> 2), but the code performs a left shift
> (size << 2).
>
> Looking at similar usage patterns in TCP where the doff field stores
> header length in 4-byte word units, the code appears correct - it's
> converting a byte size to 4-byte word units by shifting left.
>
> The comment should probably say "Shift size left by 2 bits to store in
> 4-byte word units" or "Multiply size by 4 and store in doff field" to
> match what the code actually does.

I have rewritten the comment.

