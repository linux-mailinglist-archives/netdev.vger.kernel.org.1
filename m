Return-Path: <netdev+bounces-294550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yQHXAMy7H2qvpAAAu9opvQ
	(envelope-from <netdev+bounces-294550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 07:29:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B58634472
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 07:29:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J2jm6rRI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294550-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294550-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DC30302E7C1
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB236379979;
	Wed,  3 Jun 2026 05:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D34377553
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 05:29:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464585; cv=pass; b=MfUDgh0ciy1JRmS3sarU7lcsZZ/tTsZBDvUV0oFWHopgskILAQDDRiRcWw2syLCzKwYxua+BfgSroFVX4W4AyWIfJzAglQiCtczybMGic/gcwM2lJYlg5jgvZIDFjiVv88T7hYCVEwN1LI+MqHUCF+02FnyggfjUhlzwh8d6ZjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464585; c=relaxed/simple;
	bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IumTQm6pqwbbcgRojr0Eu+HJ1P5o9Sw6kU4zta1KJ+loQbSWXHqTz1d/qlgWJA2nxhEg2X67fptRjFgsNfDHIPp9orHv4V1ixRH7aIHaAMcwxkCTxR50cXpuGhiINsrPHeHan1hD7rB2MeBqD8KZ67Pp1rQLp47KDHnshF55AiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2jm6rRI; arc=pass smtp.client-ip=74.125.224.47
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66077f6c438so3323119d50.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 22:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780464583; cv=none;
        d=google.com; s=arc-20240605;
        b=KcyLdX63QPPINUsgqh4W9fmMjuUnBlqsBaMYwE3cSmsYdSuuLiPT+AASkErRV7iEgi
         edjQkt+Cm6laJm8/i+r1G/BC4pxFgouI8CWTyAORXGOB2OjlzAMYeMdBsWCy7VgwCPYT
         mQbY49eKLR+8lKQoIvGPVV72XE8yZIORgZ/UZZpC9aC3M90QRhvDtQOcRjf1SAHmAnox
         D4xoSUgU0Cc8y4i5NwiMjcbjhKiyN1EQgMQKogz6rJpq/aVTQitsWwPnVG1ZinM497Ld
         iYM+OZc2MTP/tvHyE9TITvRUYFfCgAky1vPmoU2ZyOExhAVv15257EVep7b0OTWu6oI2
         BW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
        fh=qAI+xyCc8UPxeY96Z6YL9jQ6ahawyHuYTkMRpZvdzQo=;
        b=fgQiUqFF2DyJwJ8U84kBuHCKGEml1xxh03FkjUNeP8OxvC/N3S+Nfz7XcGaJsgFGVJ
         inpG/vUmosAEQTK3RbxtV+2LgkCqP7jsDW3cg/HvdblaQSvv55tWMXH3yC7YNv2B1yLo
         Sf9IesEmlTgf6jJrE0Od+9tchA0leGBK9YrPTwH1VhqJCWSdZt8OJoLycX0xKHk7gE/+
         /E980EZZFEz4pGt4u8AIo8HlOXlt4+MxUhZbMolgoMolk+PyD1HI+9hZ2w7Z7DmsVvOb
         Dmpv24WtbXBecXFPPnT8hDuLIHLO8LfZhtw4+OD+XamFfYi/cef2ScHJiPnszCxMF18n
         1YhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780464583; x=1781069383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
        b=J2jm6rRIZj2zRdB8XCHuo9IqWk+9TVP+MwA9DrupQ3m7exO4eNX3O/6iDvr7axLuAw
         VaynVLRzB/PP/0R61WveRyPuxbuLRgYf/L6RaJVb1XMGE5yv8lHl9jEuFK9mYGsghNUW
         0/TTB2BCJjNyFdKekcPHHcccx6Y4amE5oJNYnp0Z7s5QvXQ4QaOmi7FyidU2OCey/IqX
         Ys62GRofGN9AqMX2pJosjZqZXsQSROGSlLWbCafTkIEIQpXPwiR3XobtXTTMRB2MJmG5
         zBAd9Rm85DUzxz7qm3nL99QyTft5ndxNcsOsB1ldoNKGtmpv2gOzAGMhqlRGIWuUF0K7
         q+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780464583; x=1781069383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
        b=SsRlwZTXBU4MQfGtmKtmq7Jk2wT5OYO5HX5y9UxL4G6dZWnwvLsqK1T7Q6c4m0ZsL5
         1Jrj3lFu3g9AnXhLFyWKGFOBvJicfbwflTGBz1ncws8a4M+gO1al7m3Y2ecAhRtTVYr9
         JgdsePxRW+emcGHhXrUQiKIVxddTAzOGSn8/VBP1mmqRxC92ASXadZ/IvZkaYMOP+I13
         X54H6V/QKhz68qCELGeSeX0TNpTshhWdEstC76YN1rOkoxlRX4evKbLsYRGgp+i8Wj0C
         A4H9Cp39PxR1tH84DwyBRdWyEwQUH6w+jAZvRtSrDITOc7PllZxr/kGn1aX3vy2HiBxf
         bgeg==
X-Gm-Message-State: AOJu0Yw/1KYVkWj6q1g0vrQMUxE4APnwQRzmLVDDyOm4GqvdISvUBfnF
	KmV7XaNOTep11zQ5eeK4uS831+3yWHmZ4Xy0BsSbp8DIkeXuSLyMfQ+6gMAPYt1nFKWo1guYnDP
	618PGU2lM74fDJssXyL//S4H7zumKgl8=
X-Gm-Gg: Acq92OGBXZPG8pi03BvI2iuKv5b4tgHc90bgjruexdyx5W+Cbzx1jYk3R8zniGoHh1h
	kdf7zD0AeTe8i3RNdpnqaDS01VDBLSY/bjbW1rcB6sGdzFInc2NAB3RmXmjTgtApezPGYRS4/nI
	9L5zLq1adjgvd3eUUvWKrpMDrrkGDSBpe/5ELKUlp4bCqz8aRhx+Ngkj0ttMEUwQqH/B4AH+z5I
	V7C2d4BxXKvLWQfXM9/xPbyE2MJm1ufyDZPc5KQ7WXvcxbY4I1lbERXk7Zw9664LrYoHiUDwi21
	sz1NKuWa84ZZFcMw/RfJ
X-Received: by 2002:a05:690e:408b:b0:651:b2e4:63c1 with SMTP id
 956f58d0204a3-660dd530b47mr1468054d50.22.1780464583418; Tue, 02 Jun 2026
 22:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602155210.90987-1-leontyevanton1995@gmail.com> <BY1PR21MB38709E89497445EECE3C931DCA122@BY1PR21MB3870.namprd21.prod.outlook.com>
In-Reply-To: <BY1PR21MB38709E89497445EECE3C931DCA122@BY1PR21MB3870.namprd21.prod.outlook.com>
From: Anton Leontev <leontyevantony@gmail.com>
Date: Wed, 3 Jun 2026 08:29:41 +0300
X-Gm-Features: AVHnY4JnwoCsNKa6ADnSbG6NTG6nP0KaPkNGbMnFr4WC0wsdE_B23uevxeXo304
Message-ID: <CAAN-wAkSjVbfzto+Pi4-OLt2vXyzeCNpqhen2VQFA+VCFH2HrA@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH net] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Long Li <longli@microsoft.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294550-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@microsoft.com,m:netdev@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[leontyevantony@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leontyevantony@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86B58634472

>
>
>
> > -----Original Message-----
> > From: LeantionX <leontyevantony@gmail.com>
> > Sent: Tuesday, June 2, 2026 11:52 AM
> > To: netdev@vger.kernel.org
> > Cc: linux-hyperv@vger.kernel.org; KY Srinivasan <kys@microsoft.com>;
> > Haiyang Zhang <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > <DECUI@microsoft.com>; Long Li <longli@microsoft.com>;
> > andrew+netdev@lunn.ch; kuba@kernel.org; pabeni@redhat.com;
> > edumazet@google.com; davem@davemloft.net; stable@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Anton Leontev <leontyevantony@gmail.com>
> > Subject: [EXTERNAL] [PATCH net] hv_netvsc: use kmap_local_page in
> > netvsc_copy_to_send_buf
> >
> > [You don't often get email from leontyevantony@gmail.com. Learn why this
> > is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Anton Leontev <leontyevantony@gmail.com>
> >
> > netvsc_copy_to_send_buf() copies skb fragment pages into the shared
> > VMBus send buffer using phys_to_virt() on the fragment PFN. On 32-bit
> > x86 with CONFIG_HIGHMEM=y, phys_to_virt() (i.e. __va()) is only valid
> > for LOWMEM addresses below 896 MiB. For a HIGHMEM page it returns an
> > address that has no kernel page table entry and lies outside the
> > kernel direct map, so the subsequent memcpy() faults. As this happens
> > on the transmit softirq path, the fault is fatal.
> Please include the stack trace in patch description.
>
> > A HIGHMEM fragment reaches this path whenever the page backing an skb
> > fragment lives above the LOWMEM boundary, which is common on a 32-bit
> > guest with several GiB of RAM (for example when the in-kernel NFS
> > server splices page cache pages directly into the reply skb).
> >
> > Map the fragment page on demand with kmap_local_page()/kunmap_local()
> > instead. Using pfn_to_page() on pb[i].pfn maps exactly the page
> > described by the page buffer entry. On configurations without HIGHMEM
> > (amd64, i386 without CONFIG_HIGHMEM) kmap_local_page() reduces to
> > page_address(), so this is a no-op there.
>
> So, on 64bit kernel, it has no performance impact?
>
> Thanks,
> - Haiyang
>

Correct. On 64-bit (and any !CONFIG_HIGHMEM config) all pages are
permanently present in the kernel direct map, so kmap_local_page()
folds to page_address() and kunmap_local() is a no-op. The generated
code is therefore equivalent to the previous direct-map access, with
no extra mapping cost on the tx path.

The kmap is only meaningful on 32-bit CONFIG_HIGHMEM, where the
fragment page may live above the LOWMEM boundary and the old
phys_to_virt() result is invalid.

Thanks,
Anton

