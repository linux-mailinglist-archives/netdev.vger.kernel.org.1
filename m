Return-Path: <netdev+bounces-289258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENugCm3JC2pSNQUAu9opvQ
	(envelope-from <netdev+bounces-289258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:22:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84548576660
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEB533001B79
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61262313E01;
	Tue, 19 May 2026 02:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVfL5rGB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7331355B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779157278; cv=pass; b=pHJrd1Gaz/aV/yRmOz6YfKrc/rqb6DyVJshj/1skl3olGfQzL6F65PESW++wl38n1gUcP16BGWLNMGhn+eR13nApEA0NOM1u8QbI8UBgaGQY9szll1WpE/zc2wyM7GAZfEqngE/lNhUHzyrJJybS9nRsJXzYP9InLXfi2pS9MiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779157278; c=relaxed/simple;
	bh=LXVepd7dNd3zA26xI58VT4Whz27BenyseiDtEWoziio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxF5/j16R3q2Uw5w98ZTnAk+HJjFv3avNA5sAsf0VT+xg3UKSFXk4IeQNYowcNssx869T8wcxfwETq8rVSVvsa4vsCOK2bi/aekNqN/zKCJCia7r5udCYvgNzzuvF2jSOEsV/XeRpT4gk2Ooiv83S1/7cYy2yoprtyLu99TWjuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVfL5rGB; arc=pass smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-912278ed3b5so329131885a.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 19:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779157276; cv=none;
        d=google.com; s=arc-20240605;
        b=EoXyYH1NUqZC+EwU5DeqGIE9IIrYRNYxbg05QHHRxWF26aPZ+AiapfHA2gTm8V9u17
         N5x7i7v4qxOwx2y0V5IYhF+KX5DjPttdMTPVTI9F2kW48Of6oi61K5d9jWCp7JOVUBNO
         PvPzbNNWVH/mNOLU6QQUFnk/GlULkdtLc+BDctERRUheFoHSXlAoESasElB5DEWTFnW/
         Z9bGYfEDZaomVA08CSxYVKkrWiYuWwXD87jTVHFmCRzI7euiAjSTjfGHh/MGCNy8vZV5
         7OPsmKIB3XvPM4/IPYkRMKBeXBC8MxqxrruZ0v3l2yuNqeh772hulzqQEdrmXlNXXwta
         N4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LXVepd7dNd3zA26xI58VT4Whz27BenyseiDtEWoziio=;
        fh=GwuQ7veYuf77ovxzW9yr2gdJyC7kih3MdI9XgSIkITU=;
        b=efYEkpPvKpPEE5D7AGpyp4Y2G0H3u4Ec+/Rsv37BdVB1QTBqgGT3Mlz0gOazNHXNsQ
         okwp0dMGEZr3z92niPUL0n4SnbDWqMvn96xbC6VAPRV4m/X3gVowvi1fKQcFQgIWDVnZ
         cAeBpP0TapNu2jFsXjmv7KKuL5cqoJernLlC5D9c3EEEAd1qX59lySkjFJ9YzduFjL7Z
         MSghOebRTTV+NtsrBcJW8uq7Ui/H4Mna5ioesSE7737RLoFjIHnLo3GK67l+Iujg8blG
         BQZ2DNOXzQ0Im2kXmE9RVwS0oERgddAsglNS3SwrTfuqXjHBSVyChdDZhvGbr10Zqc6s
         phzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779157276; x=1779762076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXVepd7dNd3zA26xI58VT4Whz27BenyseiDtEWoziio=;
        b=TVfL5rGBtzkwj+JRL4a4ftoPGNC3usaJCJ1Ge8G4U0aFt3qRS4wVEP91gRtWWzWaNp
         5rEDnM6Xyha9ubwPOt+iB4qcQ5VJ0E20yL0AUdWPELFjJVKXQkdZjfNEIyfmKOSzLLw/
         LQfnl5y+wYlnc11FUtAYBb3QK7rx6kN78zGxgP9RNH1WzaiEWt9OXMJmI5rolkw+APRI
         FgR3JqF+uCfcJ/voYR9PYTkWUphC7IEXoX0L2osRNzNIOfBUEYvTI3Gn6PUwgt2eSIAe
         D2qd6nZUpDX2kZ/wyO6m6GKvhwRKG62Otvx9pl/FBM259lKs+XeENzwfnAe2EpA4tsLY
         q/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779157276; x=1779762076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LXVepd7dNd3zA26xI58VT4Whz27BenyseiDtEWoziio=;
        b=LIxX73r6CVGrDmkzUZHcxOF7R+UyFoSB18YoIFJQUm13c6Ahuc/tXwiNy9POj9uGRO
         Wzr/1apYqlfccp7XZOrdZ2aQCpwIPHw3LAEAY8aBkVkn/8W2DDiBXUBWVT0kGxFioJgA
         YyZlMQJyQrHe/WPRPCwpY5M4d04pShs9SWredJckg5qLJebZjgZkzms/+jBqd9cgW4SS
         lBYTWsapMVd8CWfWPibnjax9TV7VnWeukVsN4TI59k+Vjc1oT/tN2MTU29S9DmaG7syo
         /KO4nhF+BXvrOR+JgceDoJj1yvayoTgLT4KCOW5WSwVlOf6dzC258d9dWtkTfNUFsFO4
         ag4A==
X-Gm-Message-State: AOJu0YyHI3+b/aNby4KJHp63MOLgdaqV8TV/xou0gUq1c/NkXpjbEVSO
	CwBKv9zjS38W7i7EoWW81bWZdvmFxd42RbCe9ot1YH18DV0EN6BN6RZjPj2wulNrC8jTYk1+b4f
	a88ZTsaGGGeCrs7RXoDqZQKejcFYhfkQ=
X-Gm-Gg: Acq92OH+Or7CBV2jDm6nsOVAfyBfbs57FbV40NKGsMzA4E2i9YM76x6Va2EUyK97vF4
	e0bNtgh1cuFg0mAjt8jKbWXGArN1JmJYt/XVymAYR0iGAKwaRG0KBh8ZrJ3NJhiiek+cvtSj4PJ
	QH7gyrrTq4ZpZIMhF4g2YXLag7xpSdw9URF0XfAGm70SvRA22dIxs0bd+K3GbPBtTksvhRA93vV
	G6BcniutJI6JvW2gj6hpvcoQA6wYsbxyonQ0dpJQBncXfOi8fDEnWJJQjWTA5kL+ldyA/7oBQtu
	7fYLEN3gsQCF2k/7hrlTKRKWPP8jACv4DzvbaiHADL001VpgjGdMOwcvf6e6OgcK8fZkl0rZUNt
	nhaU=
X-Received: by 2002:a05:620a:2907:b0:905:ea56:6ce4 with SMTP id
 af79cd13be357-911cdd4d811mr2628043485a.17.1779157275995; Mon, 18 May 2026
 19:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
 <20260518010739.80979-5-enelsonmoore@gmail.com> <20260518182220.78a9ae80@kernel.org>
In-Reply-To: <20260518182220.78a9ae80@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 18 May 2026 19:21:05 -0700
X-Gm-Features: AVHnY4LBxUaISZgE8Evh7OSO0l1fsWdbNpDU8JL1EHgeiwXhSnm1KAHeQgUtqXU
Message-ID: <CADkSEUhXU7f+k+yBO2Y=eonch2k7YmwbQe6o9RP9osRoo1KFBA@mail.gmail.com>
Subject: Re: [PATCH 4/7] net: arcnet: expand unnecessary I/O abstraction macros
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289258-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 84548576660
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Jakub,

On Mon, May 18, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Sun, 17 May 2026 18:07:24 -0700 Ethan Nelson-Moore wrote:
> > Now that the BUS_ALIGN variable has been removed, the
> > arcnet_in/out/read/write* macros behave identically to the functions
> > they wrap. Expand them and remove their definitions to make the code
> > easier to maintain.
>
> This one reportedly transiently breaks the build.

This is due to incorrect patch ordering on my part - if you apply the
ISA/PCMCIA removal patch before the two I/O abstraction cleanup
commits, the code compiles after every patch.
i.e., use this patch order: 1 2 5 3 4 6 7

Ethan

