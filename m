Return-Path: <netdev+bounces-304443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d0HRDg5xR2oxYQAAu9opvQ
	(envelope-from <netdev+bounces-304443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:21:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 978D46FFFFA
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:21:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=D1VgSgdA;
	dkim=pass header.d=redhat.com header.s=google header.b=YBt3cOZt;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304443-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304443-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC1753186790
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9F837189B;
	Fri,  3 Jul 2026 08:05:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161543019AA
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 08:05:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065922; cv=none; b=jviqN5qLT0YUR/DUftrVMxL3KpYdihbFIvocpF9AB8MkZUonkb2pmxRy9VVXPR5GMqJBKFIabxOsejA74bLnmUkZHBPZYv0aeeY7Y7Imw0UUwDNqhx7AY8B59NOCHVQZyAuEF2VX9K+AUKeEkkY/ioAgrXwXgWpHD9Fr3XEBGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065922; c=relaxed/simple;
	bh=u2buSlHtHKFY89eUiaWjnl5Wyaw8lWPR6cA5aEZJnbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8UguXWvcZpfQPA2HArNjI0BRj7s7utHpyBWzVIw6mNEOtU2plwA527cSWYtGHNbRvkzQdLGibntBdO0KhzyCoLBrLf3SfqtO7g6FRlvXUetqFRYu/lDUpfx208QIvzJY2RzpyWpbMcJk5rSHNlBNQ6T9uBDlqOVX3VjSCASckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1VgSgdA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBt3cOZt; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783065920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Va31V3X2qcf0jxD3q9RVNeTf4NDJusjqC7c+xSp+nLg=;
	b=D1VgSgdA6UiNE5RjlhiUUvsTxHEYP+axavDOPNDNdZprwBpPm3YlBAJTYDpXnJ6ShjZx+B
	UpUZGg4VK2VtPBGySRSNAULDkKi4ZPiOtAXQLLI6fR923v2zXlWWb8gc4IjZ1G+sCYCWoW
	pxfAvcwNhdaEtRvhZEmSfLfMpQD2uxQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-DwfjpLBiOl2jRcovrEeWJA-1; Fri, 03 Jul 2026 04:05:19 -0400
X-MC-Unique: DwfjpLBiOl2jRcovrEeWJA-1
X-Mimecast-MFC-AGG-ID: DwfjpLBiOl2jRcovrEeWJA_1783065918
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-474170b59dfso198964f8f.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783065918; x=1783670718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Va31V3X2qcf0jxD3q9RVNeTf4NDJusjqC7c+xSp+nLg=;
        b=YBt3cOZtRiDfS6otMcNLVSATUbxMRFdDCa+Ko4MuwPZLDScgmLf1Fzfw3dpNJuSWhq
         CnpIsZb2qLzuAkNWceDMvkQ4FydWJTPOj7CgstVOO75gh97468KuJhZCPdff9e6WhAds
         kbgKxZGyOOVtAmcJ+IFaRUHCJa39+NfOdDafWVbotqhP+CTkv0BjZ3fngkNFWPS3LtVh
         t/Si+DfQTmxTlA5uWPzp9tnI7kxJA5PJJajqUmJIEDNa9fgdv9jVRYCW+jGDRDPxm/MQ
         aJwQATpM/uZM1fpIxNXXKlbiGSsEbRD+D9bOy0pVNPpuXdtlcHN3BwOugdGoLCB6SMjW
         bcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783065918; x=1783670718;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Va31V3X2qcf0jxD3q9RVNeTf4NDJusjqC7c+xSp+nLg=;
        b=JNlKwEC9GyPfEgoKtwEUhBcHu7BePVXHzLcn2ocnOzdTrvUiVGwl2PiuTUKM/Jevr/
         G5xBqoQ/TuqXl9WKuWTVUwVDraGw/Z/9b3YanfCh+ZbvKF0a8WNgJSRcoIWlzr8XKOoM
         CP6YyjG+75ej+aqezfQ/U3VnTdadNWUwuYFdcVn/if5dXvfzgogY9Val+Df0Zxb/dS/y
         ehT/MKzk3KfI8oZx15bzip8TpWJy/5BxXbqtvkLGsWORV6dYQM0ZDZVl8uTgzWQtztgv
         SD5JKmoSqFkH12p/REDROpHwFiFeSlvTVXKfyVkmuipKKdw1AfjaUi5gz8RFkvjUvBKP
         RlwA==
X-Forwarded-Encrypted: i=1; AHgh+Row7B/doHuxN/vzE7pMwkFGPtQrz8vztJpQzuEeXTPQcHyMVaMiodlgOukFQTj6NwxxE40xE5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZLuNk5FfD+QD7gw9MS64FCbWLtkxtXKPeA/bMR2PtZJ1RkLF
	0PxtD+jnEjn6/E2s7NPQXzNqZ5N1lR2Mr4u8On8x5DUj1U5K1MuEvFD8FbxA80yTOauvuUBYwkO
	8gfHDNWiPrqoGF/3JUGXYCIVHnWP2vXGYiDou7GPJT4RPawf5dXnpEIFvgQ==
X-Gm-Gg: AfdE7cl5SA3dzBL+62A1CKFuDo13SCVwbDbBdVwjsG05E08NVeZN8Q7JaGCUvimx8D9
	lLwwyMPuWI56wUEPRkhjqBJJt7zTs3djV16MhdWxGRERbBRZrykS0N8+ow/7Z3gPgmPO91YK2TA
	UB72jjMV7bfbaRuwoJFYnz6U76M2P2JQ3Y0f3zSN6eLGGC1PeRyNu5OjPlVmXJDvncf6/iVCk2n
	FqbOsNYfAm+aknq45jswg0ak8sEAoabac3CAsJjYO8shV1NRftr5vdIrxO+UlLxauscIJ2xJRaV
	mac6BLSeMroyUwt+rbyrfaGeLhAqzho36ZvFisCOCBSGvOSjGfP+52n9Ma46cg2b0wiP8lax/p7
	xlYNgcbkfRen3LvMubriDB8II2ReYcQ/F7UIH6HxFclUa0/N5nG/vcJ9j4bTVuQfhoyrKRzx9LU
	35Do2uYDs7yw==
X-Received: by 2002:adf:e191:0:b0:460:1223:a044 with SMTP id ffacd0b85a97d-47754483e04mr13627338f8f.0.1783065917453;
        Fri, 03 Jul 2026 01:05:17 -0700 (PDT)
X-Received: by 2002:adf:e191:0:b0:460:1223:a044 with SMTP id ffacd0b85a97d-47754483e04mr13627296f8f.0.1783065916889;
        Fri, 03 Jul 2026 01:05:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f310sm15740950f8f.31.2026.07.03.01.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 01:05:16 -0700 (PDT)
Message-ID: <774f7b1a-c46a-4b12-b69e-355d03ebb3a0@redhat.com>
Date: Fri, 3 Jul 2026 10:05:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/17] net: dsa: mv88e6xxx: support for Remote
 Management Unit
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Richard Cochran <richardcochran@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, Max Holtmann
 <mh@rme-audio.de>, Max Hunter <max@huntershome.org>,
 Kieran Tyrrell <kieran@sienda.com>,
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>,
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304443-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[padl.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 978D46FFFFA

On 7/3/26 9:46 AM, Luke Howard wrote:
> This patch set shephards a series of commits made by Andrew Lunn
> and others to support remotely managing Marvell switches over
> Ethernet (as opposed to MDIO) using the Remote Management Unit
> (RMU).
> 
> This is the second of four patch sets: the remaining two add
> support for remote management when MDIO is unavailable.
> 
> Signed-off-by: Luke Howard <lukeh@padl.com>

You have already 35 patches pending. Please read carefully:

https://elixir.bootlin.com/linux/v7.1.2/source/Documentation/process/maintainer-netdev.rst

and specifically `Limit patches outstanding on mailing list`

Also note that the limit is supposed to be approached/reached by
submitters with a well known history of positive contributions (i.e.
reviews).

I'm deferring (at least) this series. Please repost only after that the
other pending ones have been processed.

/P


