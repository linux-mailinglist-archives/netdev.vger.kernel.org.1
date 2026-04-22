Return-Path: <netdev+bounces-280314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAPkAExg6GkKJwIAu9opvQ
	(envelope-from <netdev+bounces-280314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:44:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CFB442256
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07F0F301828F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED4322522;
	Wed, 22 Apr 2026 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsLbL5My"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2321314B62
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 05:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776836587; cv=pass; b=J2/nEnwOlq7pq7a/GrgOzAtChrA8ERFk0MZjqNZWWqSwcMYXVO0JqENi/aWpnlkCgU0JiSX+nAOwvIycFBG6MAIk2ccgy2iLm6NtGBaKESqbLjzVDb5vMtfPnKMlXCFYgYTkSx4Ykmq9qL6UmZIebwf968NXFSyfZlFqms/Ggdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776836587; c=relaxed/simple;
	bh=1z6+CwIf81CdUEn3OmgLBSZTnsdWh7+ehW0OB49YGQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKdnaMHAF16qB6+yypR5CIMONvkL/RnLSo80hNkAH4vyrNjzEK2cBrCYYIQChmYShMiSLAEEZQKVw6WU9ud/jPyI2kQcysyT1O+61TcowENNZTAnqYkCMLWXJc7H7lG7UMyVbHOGG33AQBpW6GFKh7You9tg78kV3nDYUMquFoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsLbL5My; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-670f6ae9c7dso6768647a12.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776836584; cv=none;
        d=google.com; s=arc-20240605;
        b=i5nrKx5zrrg53n2VCCxurDtQnjgKW/3Zy7AlUpRIFfbWEjLDdAMO6F80vJjBheTr0y
         /o8lKWX88sma0L2506c1y8KKQ44cbHZtHGWSLoC8YNNDHUpEFG0CnFwPFVlH2wR3gD3R
         VHDscnsNejs0HTr2D99i2JWZLfpBEXerqmMmFAZqEIYJzt8CJ5n2dTrDw9O6wyaGR8e1
         Qv0v00aiPCqxR/CS2zzRiMuj086nT51quQqKlwVFn1PyvKWEOPP0ago+hl8o3uej7q3w
         OWF6uGEqw9uYV9O2tSJTB8aIInJPIv3hoBF9iBuRx3YN66dTnyRxFiwywkIWolBj/en1
         XjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=s47VEHvLbliHKK0viSRRWufAOuCEbbkMyz2w9puHPtA=;
        fh=n8BucJ+HnO4gDLC1g3bgxvg8xuZ/um4opF105LwyOlU=;
        b=ldywKozoZfJWLlxCBkz7gcHxAkjx0NglU6sxjrxZLKR5i7kVXlGyGEY0rskkDb+0Ul
         JgsTVAU25ZWSUXgKMBi7Z6+jE+pZ1q1vy8N8Nr2hADz6TL/XHryhnXvIO4I2AkzP1SYQ
         gnr3Qi+DlzqCf9oiUsnSIqKUSRpm/erW7T6QZXruiKUXXOq6sYhK4vilGtFy6tXAOYVE
         sQ8+uE50s2YRO15plF88tPVZ3J9+KjHhyBoEOpFiff2oqJAsKiJryRSA5BmF8VDK6rJN
         6ERKPIpl7bHdUUuV3BxRLYQFE2FltRE405IkMVCTBDZ9Es2rSzLuAMdR2PABAy5NtErQ
         O8iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776836584; x=1777441384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s47VEHvLbliHKK0viSRRWufAOuCEbbkMyz2w9puHPtA=;
        b=dsLbL5My7catvaQIvz92s0r+2zWPo8Tov006l9ItXqUxwSOR3vsdKm3zZ6Q5x74jxM
         LDSOlM75eICAok4e22oypsrI71nrIE64fC9haAiKIen2p+8ZBKNVoXcGqvk5mHlcORXo
         mX07f1DVZsqlwdZGtNyyqjDQ72Q8ZQgq8rHpO+KaaiJzl1YYuRTUJ2FZ5Hp/Y71jqfMe
         OOhfSuFaVTZa2Whv408p2drpQX6hcntkShT8N9HlVawZfAHPhhdbmjhM0fEpxfizX8DQ
         pc9kyCfU4Q7Y/ux8+Cg3bnzJEVrQ3BUGhjwjc6egK1ev8ZPg0pwVMM4jX927fYJQKS00
         UUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776836584; x=1777441384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s47VEHvLbliHKK0viSRRWufAOuCEbbkMyz2w9puHPtA=;
        b=hv3W5CLyM4Z9kkw+LcoyvcY4efurU7gIhIMKkfQTdJAtNDgbXhpfqDfP7dR6RPQtcs
         vBw+5YUV50Bw/Octr8sRBr6x5uDdfRiHhIBDaoD++wwfMof1jh7SF2l5RjoUMV3N741X
         sefnvUGH7z3n9Fd1CQKkSuOYyzbV/nM5d3Fx8p326pFHbJhBSdy1Cuq1jdaTTGrdm8pb
         FqbONTHvwCKe9REx0elAHX6K0YZ1qwxierzcnNft6S/3M140F2Q4Xh+d8kc7d17TWquj
         3PDCdtE/jHbwrq8lPP+Ihb+H79Ia55HviqTSXwCGgJVyQ2pOwtSWxkiUqu24NeNCi3J8
         +HKA==
X-Forwarded-Encrypted: i=1; AFNElJ/0VC2SjhG4J7jpPGVtF5hVvxLVrCKtWhIn0JixgFqbvbotoIFiQ6MFK7kV9dn8SBM0nmuBwLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGzvxjBGS2LMIJHvACYTC2BBsXLoDIc1UyhXIWkCRnY84Fh/bJ
	iZftTQathrp2s1fUWTAt9O59u8a8nDysrBJpcxNCyjX4nQxh/S+4Jhg4LNfq2K20Ohv7qCHZr7D
	VCu+TjCJz698ct2lCbv6Qlsc//3WDRJo=
X-Gm-Gg: AeBDiesLSzSrSxZRtt3HiVKe3A5PvzBH8+qruLcOonegid//ifpMvMLXQCVrwmtEJAX
	KdgnpLUveKVsEj3gpLY9O0CGmRpEDY4su0mfQ8NpkPx4er6b8yAQjFLJXgyLHvp77kE92FTVOsG
	HKCIY7ePSayr6GA1DDiARyEc913QEgSrYZRE7nKMSik+4SvdxWHF3AfaPUELrli5h10AS8owN55
	MPe89SbVvYHDNxDljGgLTUoTaPiy2+mp4QFCPxIdNYj+GAuraNaFMptqhKNZ4LUghjc0ZB+7hsN
	HhQIQ6QO99Pm3paTP8U6OP5K6CDL+akH4S4ISUCfjIsQPIlR2w==
X-Received: by 2002:a05:6402:20c3:20b0:66d:d0c1:f87b with SMTP id
 4fb4d7f45d1cf-672bfd95986mr7065221a12.10.1776836584020; Tue, 21 Apr 2026
 22:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-7-44fb63033b7e@gmail.com> <CAD++jLn1gWBmSN7bDkVr_8RmbM3KptKx-z5cycYv+jG-d7FHPg@mail.gmail.com>
In-Reply-To: <CAD++jLn1gWBmSN7bDkVr_8RmbM3KptKx-z5cycYv+jG-d7FHPg@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 22 Apr 2026 02:42:51 -0300
X-Gm-Features: AQROBzDYf_7mhUsbADXomIDhbSAeJtcPiNrtMoAZ-ppRAh8gwQyj8CH1hG4BD1g
Message-ID: <CAJq09z6vqnwb=LT=isBXf=0TdTBpYDPgfANZy92sopj_ot2ozA@mail.gmail.com>
Subject: Re: [net-next PATCH 07/10] net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280314-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 99CFB442256
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +static int rtl8365mb_port_bridge_join(struct dsa_switch *ds, int port,
> > +                                     struct dsa_bridge bridge,
> > +                                     bool *tx_forward_offload,
> > +                                     struct netlink_ext_ack *extack)
> > +static void rtl8365mb_port_bridge_leave(struct dsa_switch *ds, int port,
> > +                                       struct dsa_bridge bridge)
>
> The content of these functions are very similar to
> rtl8366rb_port_bridge_join() and rtl8366rb_port_bridge_leave().

It is likely that these functions are a variant of those or they share
a common origin.

> What about moving this code to the shared library rtl8366-core as
> rtl8366_port_bridge_join() and rtl8366_port_bridge_leave()
> and add per-variant callbacks for ->port_set_isolation()
> ->port_add_isolation() and ->port_remove_isolation() to
> struct realtek_ops and share this with rtl8366rb by refactoring
> rtl8366rb.c to use the same callbacks.

I agree that moving this logic to rtl83xx.c and introducing the
necessary abstractions makes sense. However, I would prefer not to
refactor rtl8366rb.c within this specific patchset to keep the scope
manageable.

I will also use dsa_switch_for_each_user_port, as
dsa_port_offloads_bridge() already ensures that CPU ports are skipped
and it aligns with RTL8366RB logic.

> Using shared code will help us to avoid having to fix the same
> bugs in more than one place.
>
> I don't know about this EFID stuff in  rtl8365mb_port_set_efid()
> (maybe RTL8366RB needs something like that too) but certainly that
> can be an optional callback in struct realtek_ops for now.

I will keep this as an optional callback for now. If it eventually
becomes clear that the RTL8366RB requires it, we can update the logic
later to make the callback mandatory.

> Yours,
> Linus Walleij

Regards,

Luiz

