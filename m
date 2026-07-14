Return-Path: <netdev+bounces-307591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ag4xE7ahVmp7/QAAu9opvQ
	(envelope-from <netdev+bounces-307591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:53:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 780AC758CE3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:53:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZbZtBtow;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307591-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307591-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 469B93067285
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA282427F8D;
	Tue, 14 Jul 2026 20:53:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3142BC5D
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 20:53:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062387; cv=none; b=LBt2926EKqgfiULmCOMONWP1XpCpBNQGdQWWUjKaaRvL2VCv6BmfaK94hWxJTTFZ6ZrxaZfGy8dduqBO1BpKTp/p5ljF7Li72vjxoHvxl4973ST4mq4D5SvG8M5OBMV2FsTQ6XgDi2rQRg49Wt+ho8r9SBBKxmjZot4jnSwUKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062387; c=relaxed/simple;
	bh=JYol08YXW91ovkNpZaJIz1Ed+fcIPymArOeW437uj6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDoRJSA8PzkkfEL8eggHDIgEzJeSxxYiMoKGbI/ChVzK7cK3rtKbwJ+Fp29hyJq+uZ/F+eSo0byeMZ8tnZQj65Z926NL79XLvMmjFS7gnD/KtW+Sca+CFEuTTqj/YAHAMo49/GIRGIw0fxKKUMMNlRLJ+4vmkJNYcmXH8ysbHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbZtBtow; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4720d22c94aso1404053f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784062384; x=1784667184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hPy+9VG/Wk31EHh/SoTTpkYEXwE1ur2uoLWA6FIrzb4=;
        b=ZbZtBtowHnKVwWhiD6W4WpkjM1/b4ytWELp6smlEUBB5giX4gp8gZHd7HyjyC1OOfY
         LajJeYuFBpaPRAz/L2bwLnCrsOv9cynhodMK8KYLSmwYVLKbULpao6pQorQUGizkzhFD
         JHoSvOCriqdFWVhmgBO09XVh8RYV5HHEa9jiLW9uV0vydVAzmdLou8TZe3jLJSGIj8d6
         J3mA3HToUkf9CvaEpLyUM5uBV9rag6Ga6RIZi/TLvYG+aANH8NqVz6O0yQK453L8GIMt
         4ewJDnzml3D2e9wQR+aEJGFHcoKbQYlv1gVoCoRhiOa+lyTFgmq3Lysw51/MfiOh3DgU
         60RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062384; x=1784667184;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPy+9VG/Wk31EHh/SoTTpkYEXwE1ur2uoLWA6FIrzb4=;
        b=LfXpPvVJm6AOrJOFCkWEJKZHSFtXLBS5HZXALf8GZ/bhHLbDzv/Z26XcvZhYNGkapT
         NE5H/Q4918AJ9BkOzpagiRUio2j2cTHsaM1Byb2ZnPa1IxcuklNLLTt/1q+fWqlA76Ew
         Z9oVgvEZg6y7ea4erlvB8VLpoHUpsODvS3UKU6J4m8g3VTNkNqEsdfiNr+Z0cLChFEx6
         ZryjdMA4QPR7qhuUnMYHkpqEI+HQry0L5bNAyxGSWKUIZIgDon19IKIBW72heYw/tnOQ
         AHhtnlhS1dGYBfbnNoT8VhAO+PoXj9eSD0fK5Dj/O2DZ3h5EtqOceGpBcrEFEbTAIqGa
         Pcow==
X-Forwarded-Encrypted: i=1; AHgh+Rqq27LoYGDKHIQGIJqJGn4lLzyC7pB0cMpmpn6Dg/JN3UgjHfX2UqUPppvybNQdJHi87hK6kqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8qUfK35sjCoeBHTkpedKS5Bt4ZTPVTqFUhuNb6XT9OenEsKqK
	aAh2N7HrAaNHhz2UDefhKDu6snEcG79SOFy+rmGk0OZIETQ9vf4n1X169Xl0yKBi
X-Gm-Gg: AfdE7cmaUY56jwqe98LfZw141JoKPG65topWtzqBQ7kptbFKZICo7HpDFpQ5cKC/m8i
	zlbASL3b4TZ9C5pB2TJ4YNPG2rq6t5steQ6kQ1em/u74hMXWnHsDpp7uSI8tWPFp9fZyupJZh2S
	HRF+faEQhRdCEODk/+8NT333SUpE8V74FXFe+67gvfjCP+Q8wFuXdHfKSSZI3my4/0LdjGaF+1Z
	zf4eJNNVWBVB04r+q4Lj+YyRNfqZ22nhZRFZqvBdwPOC1VGlF6YNSxY5WV1IVt+y/sC40CdO/DI
	B++29PPMWwxMo3fuC5cZMK5Hnt9aNANH3otRGKSMDNOyDChXP7R4Hbt7khaP69CtnFjmcp+ATnW
	oGuh5ZTPOZhmriGv4pp1QZ7tygaqb1pEihSx9BJtoDQUPnaOHr2Do7tEWK5Tc0DrNTZaqInRUvC
	J5pp+NBhHeAsjR+OBPxXYKInSQH6d+KPdwSncuWNDhZkqs/w4VSQ==
X-Received: by 2002:a05:6000:1866:b0:475:f0d1:eb56 with SMTP id ffacd0b85a97d-47f2dd0d63fmr18015724f8f.49.1784062384331;
        Tue, 14 Jul 2026 13:53:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634debesm10998794f8f.8.2026.07.14.13.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:53:04 -0700 (PDT)
Date: Tue, 14 Jul 2026 21:53:02 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: david@ixit.cz, vadim.fedorenko@linux.dev, horms@kernel.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: llcp: reject PDUs shorter than the LLCP
 header
Message-ID: <20260714215302.75d8bf72@pumpkin>
In-Reply-To: <20260714164629.75051-1-doruk@0sec.ai>
References: <20260713221556.13a830b8@pumpkin>
	<20260714164629.75051-1-doruk@0sec.ai>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307591-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:david@ixit.cz,m:vadim.fedorenko@linux.dev,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,0sec.ai:email,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 780AC758CE3

On Tue, 14 Jul 2026 18:46:29 +0200
Doruk Tan Ozturk <doruk@0sec.ai> wrote:

> > Is there a similar problem with non-linear skb?
> > Maybe they can't get into this code, but who knows what can happen
> > with unusual configs.  
> 
> Good question. Today every skb that reaches __nfc_llcp_recv() is
> linear: the target path (nci_rx_data_packet -> nci_add_rx_data_frag ->
> nfc_tm_data_received) and the initiator path (nfc_data_exchange ->
> nfc_llcp_recv) both build the frame with alloc_skb()/nci_skb_alloc()
> plus skb_put()/skb_put_data(), and NCI reassembly uses skb_cow_head()
> and skb_push() into the linear area. Nothing on the NFC receive side
> attaches page frags or a frag_list, so skb->len == skb_headlen() and the
> v2 skb->len test was in fact sufficient for the in-tree drivers.
> 
> But relying on that is fragile: the parser reads the header out of the
> linear area (pdu->data[0]/data[1]) while skb->len is the total length,
> so a non-linear skb with a short linear head would slip past a skb->len
> test and still over-read the linear buffer. pskb_may_pull() is the
> right guard here -- it also covers the non-linear case, and it matches
> how the sibling NCI and HCI receive paths already validate their
> headers.
> 
> I will send a v3 that uses:
> 
> 	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {
> 		kfree_skb(skb);
> 		return;
> 	}
> 
> That is strictly stronger than the v2 check and does not reject any
> valid frame -- pskb_may_pull() pulls the two header bytes into the
> linear area when needed.

Does that help any code further down the rx path?
It might be better to drop non-linear packets with a comment that
they aren't expected to happen.

	David


> 
> Thanks,
> Doruk


