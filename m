Return-Path: <netdev+bounces-307526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aGYcKPBnVmrJ4wAAu9opvQ
	(envelope-from <netdev+bounces-307526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:46:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C277570B9
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:46:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b="qmLtb2/+";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307526-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307526-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EFDC3020EA7
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1271748A2DA;
	Tue, 14 Jul 2026 16:46:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C72C375A
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 16:46:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047595; cv=none; b=aS9ncZ7lTRUCtNoQgoDbznRGGkHBBFHg0/sUZlTUF7+itraDISC4c90X/meMDxAXA9lLPy99bX1fhQMc+DckkyWTQoiRMHupMAGMcZbYe5m1Lr/xubOApbXWz9wYkI3tLUE/oS9NZgn2rG2da/Ke5AHVhB7IIgmsNag4cRHL3eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047595; c=relaxed/simple;
	bh=VzArmT7nUp//GvC7u1Ew+TKOM8ByFP4IkQWLiZaejoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyaPj1kWcWGF/pcqDbLlkEM8ZRo0OKaB8pvqFSRzlOjGx+CXsg5NkMd1HozmXoHhNmbdK8mJpR4WRxN/2ag9AX+CQgbakjQNHxUTZHkB26/VX7gBfGDM7uJdfj2U82ON7LWlwdqW5swvIcPaVe7LXz3UK2nK0bPlPCAq9h/KfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=qmLtb2/+; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-474560436c3so905031f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784047592; x=1784652392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nGZqGZVOotZvIfQ16pDrwhVFuI0Zyt/cSEfsEhB0qUo=;
        b=qmLtb2/+zdCD4ZDNoQ8SY+H4VpKIh1QOB77sNLkle//2+Ee5Ybxr4a+B7uk3OY8WLk
         h3diZPIVKkbWJFKXYtwZ7dpC7a0sWtzmCgCE+eiqfWII5vriIzdD9P1bsCK1YezOH9To
         CWq4bXgRD6V4cu/ivcpZ1Q0Sp9oZgpyfjjrk+5u6ZnRCz72BP+aTLWCF03rsTMsuSq55
         xeOmcGsvwLAA7VobDHn9y+poJC6qG0frlz7CuItJSYHV287GjTAjlzHge7wqLRqwJxAJ
         Ehi6a9Wn8tzTb+x7xH9KK1x+/hlsC4kDgL8SQpWfvYBKNHn+6BMRAqg7DQJ/cHboarU2
         YQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047592; x=1784652392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nGZqGZVOotZvIfQ16pDrwhVFuI0Zyt/cSEfsEhB0qUo=;
        b=Mdj92lS6yG6uEAICz6EryAVRCcCqy5cD7BWMSF5pDUGZPWo1tr7kKLjTr2L7/sscD1
         9vFsa7a3EGd9caxEVkK3GGwL2EGKuzgEsS/ZUEJEuVnT/x5KXRIqVhBV4Zn9sMeKRxqq
         icSnoSW8NdiVtqlD6WTUrv5+v8v4DtF++0ATNsTHcvQx7YNl/gB2SdJeQ4LUzU/YMZ+T
         UVpfbbclS4+AY0V1PBd08W+1YvtQ1n/6Nv7CG68/XzZ0gxVVTak3SbdnSWG2JPXdh79D
         2XqYP7bAee9EHEa39qmrSxaMRmYYyxlBC0ziSmmr7t4p8zQnT/0QyhdXt3FC/1I7MJsW
         5bEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPVuLoAEA1n9kFy74ylb9yS1yUAbtMuaypR6Co4mFgj8BmGV54Xf2Ir0/0NQ9Si4MlIaTHFuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbja9IQJfxdIoAZCG3FF2BLSNIWwHOfMIv0nYZ1RLQWPE7ex+Y
	9DVQcrS0KJbbMmJJiUsSZ0DW+VoXd4L3+Gl2kGnueUYmITiOi1ynnLNVbHYr4qPC11Ow
X-Gm-Gg: AfdE7cl58zggj368/u+rh7kqSVx6d5npOWDuG/L7Bpu+oTYyJLr7wD3Rp2JpH7uBKAQ
	d6ktCk0uWpwcyv6/dubnuXZWl8g0oU6vGy/zfnRbLlPRTYxJe+vDORiWtJA7COMvcsctuixwRF4
	g400ypfIKN4zP2yisnpPNwgbg74XPgkXjxH/N1Jpqd8l5dQhcfz0bv8P/mEaZX7exGuhiQwaHpi
	pHNyNTdJf8O92FZLbzgHVP6bbD5u+8DuBLCREcYR7eYMm/hPN2q0rogYW1glCPdHjqDN4A3rbDp
	okSVxwEX5Dnd0fQgAimXH2dNJTKAYvVfVqTQsqRHUx0tw3oEZFBk5MeFOdZ95no5eCUsnKlOAg7
	/DRpyO6PavbnS0OJkjuLm0qNRh8jNITKzdUwT+3+y9UoSLRoJR0kbvGN4X5zUHsXNBX62Kv/U0Q
	yCHxnF3HHuisI2+TdL3rBALgC0Oa09HkAwmrlVmJSCVzEM94DTh0IiY2pkn7H1DQAjP6hBzoS2T
	Cexk4YIArAflj80h326HRR3G5yjcdMLsPM1bIBf1CnV8g==
X-Received: by 2002:a05:6000:470a:b0:475:f0d1:eb61 with SMTP id ffacd0b85a97d-47f2dd1ec66mr16303746f8f.60.1784047591553;
        Tue, 14 Jul 2026 09:46:31 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464b7f84sm9164956f8f.27.2026.07.14.09.46.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 09:46:31 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david.laight.linux@gmail.com
Cc: david@ixit.cz,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: llcp: reject PDUs shorter than the LLCP header
Date: Tue, 14 Jul 2026 18:46:29 +0200
Message-ID: <20260714164629.75051-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713221556.13a830b8@pumpkin>
References: <20260713221556.13a830b8@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-307526-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:david@ixit.cz,m:vadim.fedorenko@linux.dev,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[0sec.ai:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13C277570B9

> Is there a similar problem with non-linear skb?
> Maybe they can't get into this code, but who knows what can happen
> with unusual configs.

Good question. Today every skb that reaches __nfc_llcp_recv() is
linear: the target path (nci_rx_data_packet -> nci_add_rx_data_frag ->
nfc_tm_data_received) and the initiator path (nfc_data_exchange ->
nfc_llcp_recv) both build the frame with alloc_skb()/nci_skb_alloc()
plus skb_put()/skb_put_data(), and NCI reassembly uses skb_cow_head()
and skb_push() into the linear area. Nothing on the NFC receive side
attaches page frags or a frag_list, so skb->len == skb_headlen() and the
v2 skb->len test was in fact sufficient for the in-tree drivers.

But relying on that is fragile: the parser reads the header out of the
linear area (pdu->data[0]/data[1]) while skb->len is the total length,
so a non-linear skb with a short linear head would slip past a skb->len
test and still over-read the linear buffer. pskb_may_pull() is the
right guard here -- it also covers the non-linear case, and it matches
how the sibling NCI and HCI receive paths already validate their
headers.

I will send a v3 that uses:

	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {
		kfree_skb(skb);
		return;
	}

That is strictly stronger than the v2 check and does not reject any
valid frame -- pskb_may_pull() pulls the two header bytes into the
linear area when needed.

Thanks,
Doruk

