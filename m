Return-Path: <netdev+bounces-252099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKljOmZScWkKCQAAu9opvQ
	(envelope-from <netdev+bounces-252099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:25:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BEC5EC2E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B08B686D406
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB63244A707;
	Wed, 21 Jan 2026 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SmjPFrz2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF243CEC4
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033883; cv=pass; b=nytVLMPd/JRLsZA0kZrh9uT5aJ60rUWkdkEwOceypJJWpLg0nXWFjETKgflUF9VsSB1LfpFXZl0A6jzkxeTEGzNlA1+bx98y4cKaY3XXVVe9z0lgn63TZfuwYIn5BxwTChifMbT8hIvvg0O/vjXIhJkN87HIXTiSVrQxojSrC28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033883; c=relaxed/simple;
	bh=okRy1IbB/C7/nsmreF0CIQby9JoQgbM5OnwU4BhTTm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6ORh6BC4bCJ5f0m8bI5TCQolzGH6JKjYup2Yk3pwJvraDJdt1GNCRZxf++mdYPooAd1SsOJauz2w8a3zI3faaNCjMOh/u2YZRsuRytbTeNVwYxdCryH52fw5R/FJJSvOfXKY7q5JknIlNvUsJQa4S42vIPo0V3oTuxdPpWgv/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SmjPFrz2; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5f52b0728ccso156874137.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:18:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769033881; cv=none;
        d=google.com; s=arc-20240605;
        b=d9DSF2X2Mu6bGYtTUjwXXiMyHtjvrEuZe21eECtjA5kpJlcMvhaII/hROVsvvXmgki
         0W8LgUTPIvRfJ4nMwjE0qaHmvIh9VdXBZEq7wrUf6miPEpnxWJJUUBV/hDKe4kD88YH1
         9QOrjsY8CfMZZPStbMX8WIBoWMJm+U6EXQDBam9pA8IKbIVeS0oBKb2SYOJ6OfY8pIyN
         HpVrODP9nii0MbBSSddStIoSQTtrcEe1vQfFSiz9w/lBRCdK9ielmGTBUUvvJHiVvu53
         CrPIEt7RbZwvnB8xvEXBMOmR0BWnc2fy31W5g0MmgH9qnuowfBI4OjipSElxe94pFcXY
         Evbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9A3bDgQ29yFgGpz1l+NhIUpPbzjtRClNWYncXyZN3wc=;
        fh=iXMFX/DltXXm7WjNEQykVMET0lniBK4Pub6hhjpNz0A=;
        b=VqS5zw3Nbr2i5yJcGzpkcaW/7BnEqtYlt5yaFXnUGch5PzW5en64RpjDwX2iLvc4k7
         5t8KPuTK8dPbmrRa9TZ0YijCnRFmH8R67Cl4klfqe4QMChpCgHNz9dYG6DDf30VlHdXN
         ffh0Ol9lNHNcEl+RGxbR6aaFZgssgqOe9d7+nymGDjUFN+N1vH+vnrTSDUha4JTCojSI
         lxNe2z43flCcmrNEnxhWFnPObvtSFHLyWZ8eoz93HyWcOzgfAHY6AW4OkJCEloOA63hr
         LT9TZdBtdpjpp4IEjH5ob5ngV3Ku2JcqMomPH8bpwwZ94N9YIz4B8ltSNBy1mYmbW4ro
         ZYjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769033881; x=1769638681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9A3bDgQ29yFgGpz1l+NhIUpPbzjtRClNWYncXyZN3wc=;
        b=SmjPFrz25hD28QLxHjPOp+k7oW3f12M35tj9qkOhsywsX/6pEJKZenRMylpMIYV93T
         ysLTvFOtvswHw3vYWGCGow9VpwofcOSUQ+TqD6uFEIHzt/Pcd0x2EXl05AQcVAbYDZC/
         jl4SGzraFYN1W/FAXtkqSHPMm26pEqzmTiUSMl5pHXMKWgcK84qjryKuf9Yprd8Krnrt
         5nRxqinagIKwAdf70O6CLDbPkN7itTJpXjBIG0zXs/50QZA4p56d51fl7krLbLC09dbg
         O7iZ9KicoWR4h3sgfW3ZXqUWNiN1j0Z2TwY544te8LtiTC2emHWlHtDJjz8WqLHO8UnA
         cY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033881; x=1769638681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A3bDgQ29yFgGpz1l+NhIUpPbzjtRClNWYncXyZN3wc=;
        b=KY6usRiIPNpTufG7YQj4iWr9skohF0wjLWMc6rclqI7WI3WcZzFAH57Z1zPeyV2uCS
         FZSoAmN8pB666FEKMFouJsE9oRg3F81aaQhmRPXVtQew2MOenio0tVugWk1igVtuBeel
         P1ueGZqPWJUCt2kXe9EoGGmHlnMwo6M6dN39229xHOAM/jBJtOTRIdSiB8M8Y4LOL+t8
         sNUusIjoydLlOnmKXTvnuL3l7bVRB1u/lwvQkvuRISvW2emCjUn9mHkpBhyynCTG9W6h
         qTWyzJdfQb8UEyzWbisMPtljhp48KVnOIMbmg2JQAsPIWN5RyQAljnPx34QkfkKPly1T
         7cSg==
X-Gm-Message-State: AOJu0YxHxCSY/3O/+iBy7iD+weP5trusuE5IQ/ggJU+nsccscSTizuZk
	Sh7Sqv0ajW6r2C71CLUIJTNYBZFBxKqsJ9F/jeVj67owf2fbyNfAxeVic5FpcMC3CkmwJiCsXwX
	2wurGxV1bF9WWSsk0MfIurF1Eeg9q5czmB6cB3pjnTw==
X-Gm-Gg: AZuq6aI087Q427HENoWhnpL07VSxBzDDB1R7CMh7x89CwkOekI2JDYkxpwuX5s9FYcB
	xJNKSJCtCgIR7AWElkaYbl9XggX9n3ASJRntpfDLAQiCXUI2RFHunS/PTeLekEBD9CMZhWzg/rm
	hN5gbPy59/vfUtYrIxXVbJKZzfRGZBVO2WmLSe7q2Z8GnHayoUK3o7u5v4kmxO0j+OPd8AjOslt
	sGdHxLGIp2/wwQIIg/EAqGvdj+tcFwzBt9eqmaCKRyKGffrT5T8QHmXxOETFh3TVzvL+fA=
X-Received: by 2002:a05:6102:290f:b0:5f1:4c53:3c21 with SMTP id
 ada2fe7eead31-5f1a551ef6bmr4956245137.24.1769033880782; Wed, 21 Jan 2026
 14:18:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102184708.24618-1-rjethwani@purestorage.com>
 <20260102184708.24618-2-rjethwani@purestorage.com> <20260105172745.5cc67e79@kernel.org>
In-Reply-To: <20260105172745.5cc67e79@kernel.org>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Wed, 21 Jan 2026 14:17:49 -0800
X-Gm-Features: AZwV_QibQ8TAG7Cm40waHNCj6UpTpw7MHvE4vII915BuDRrvriGaj3yZH0RXj3Y
Message-ID: <CAKaoeS3Kps61Wbk+EtEpbijemj=_vpHK0w35BBGfMuDCHnXuFg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tls: TLS 1.3 hardware offload support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, borisp@nvidia.com, 
	john.fastabend@gmail.com, sd@queasysnail.net, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,nvidia.com,gmail.com,queasysnail.net,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252099-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[purestorage.com,reject];
	DKIM_TRACE(0.00)[purestorage.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,purestorage.com:dkim,mail.gmail.com:mid,dummy_content_type_frag.page:url]
X-Rspamd-Queue-Id: 81BEC5EC2E
X-Rspamd-Action: no action

 in
> I don't see you handling re-keying, which is supported in SW.

Added hardware offload key update support in v4


> > The upstream Broadcom bnxt_en driver does not yet support kTLS offload.
> > Testing was performed using the out-of-tree driver version
> > bnxt_en-1.10.3-235.1.154.0, which works without modifications.
>
> It's a bit odd to mention that you tested some out of tree code.
> Glad it works, but I don't see the relevance upstream. Please drop
> the mentions of Broadcom until the driver has TLS offload support added.

Removed Broadcom bnxt_en out-of-tree driver mention in v4

> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
> > @@ -319,6 +319,36 @@ static void tls_device_record_close(struct sock *sk,
> >       struct tls_prot_info *prot = &ctx->prot_info;
> >       struct page_frag dummy_tag_frag;
> >
> > +     /* TLS 1.3: append content type byte before tag.
> > +      * Record structure: [Header (5)] + [Ciphertext + ContentType (1)] + [Tag (16)]
> > +      * The content type is encrypted with the ciphertext for authentication.
> > +      */
> > +     if (prot->version == TLS_1_3_VERSION) {
> > +             struct page_frag dummy_content_type_frag;
> > +             struct page_frag *content_type_pfrag = pfrag;
> > +
> > +             /* Validate record type range */
> > +             if (unlikely(record_type < TLS_RECORD_TYPE_CHANGE_CIPHER_SPEC ||
> > +                          record_type > TLS_RECORD_TYPE_ACK)) {
> > +                     pr_err_once("tls_device: invalid record type %u\n",
> > +                                 record_type);
> > +                     return;
>
> This check is really odd. Why is it relevant, and yet not relevant
> enough to handle cleanly? On a quick look it appears that the user
> can set whatever content type they want.
>
Removed record_type check from tls_device_record_close() in v4

> > +
> > +             if (unlikely(pfrag->size - pfrag->offset < prot->tail_size) &&
> > +                 !skb_page_frag_refill(prot->tail_size, pfrag, sk->sk_allocation)) {
> > +                     /* Out of memory: use pre-populated dummy_page */
> > +                     dummy_content_type_frag.page = dummy_page;
> > +                     dummy_content_type_frag.offset = record_type;
> > +                     content_type_pfrag = &dummy_content_type_frag;
> > +             } else {
> > +                     /* Current pfrag has space or allocation succeeded - write content type */
> > +                     *(unsigned char *)(page_address(pfrag->page) + pfrag->offset) =
> > +                             record_type;
>
> wrap at 80chars and please refactor this long line into something more
> readable.
>

Refactored in v4

> > +             }
> > +             tls_append_frag(record, content_type_pfrag, prot->tail_size);
> > +     }
> > +
> >       /* append tag
> >        * device will fill in the tag, we just need to append a placeholder
> >        * use socket memory to improve coalescing (re-using a single buffer
> > @@ -335,7 +365,7 @@ static void tls_device_record_close(struct sock *sk,
> >
> >       /* fill prepend */
> >       tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
> > -                      record->len - prot->overhead_size,
> > +                      (record->len - prot->overhead_size) + prot->tail_size,
> >                        record_type);
> >  }
> >
> > @@ -1089,7 +1119,8 @@ int tls_set_device_offload(struct sock *sk)
> >       }
> >
> >       crypto_info = &ctx->crypto_send.info;
> > -     if (crypto_info->version != TLS_1_2_VERSION) {
> > +     if (crypto_info->version != TLS_1_2_VERSION &&
> > +         crypto_info->version != TLS_1_3_VERSION) {
> >               rc = -EOPNOTSUPP;
> >               goto release_netdev;
> >       }
>
> Are all existing drivers rejecting TLS 1.3 sessions?
> These days we prefer for drivers to explicitly opt into new features
> to avoid surprises.

Yes, currently the following 3 drivers support tls offload and all of
them reject  TLS 1.3 sessions.
- drivers/net/ethernet/chelsio/inline_crypto/chtls
- drivers/net/ethernet/fungible/funeth/
- drivers/net/ethernet/mellanox/mlx5/core/en_accel/

