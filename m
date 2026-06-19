Return-Path: <netdev+bounces-300636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MbawCVXsNGrNkAYAu9opvQ
	(envelope-from <netdev+bounces-300636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:14:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F916A445A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:14:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=hCAbBPit;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300636-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300636-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 865B63029778
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C533F8D6;
	Fri, 19 Jun 2026 07:14:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD434DB7B
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:14:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853262; cv=none; b=SI8kOmaz0CULtlrLnr+77mbwag5Qr+i9OTPopFTFbqUWTyd6goFPsaY17JTy1NIn0oVxpN576cB7Yv9WOxB15LUME9g+vOknuS7TUV2HrqKbAnAnMBcewFx/XvluCd4XbU54M16s0AWxXskGPhxklbWJejcGcLska39ZA/RhuzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853262; c=relaxed/simple;
	bh=5g5YGofPTDcKTTBlyH2UVXlBM4H480Pv5JkBfDsZK2c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBrWRdTDQ19t4HLq7I44G5zrYkiLLHixYqoa53b8d5qLWXqVHNH96wb97Ief6SydzRHZKEi43C3X56kxtjR6gy1k8mfkBsv2xh4VRXwuwNeJ1CdHcViCTul6B2eW8jnPjbrkGq9929o7wgSr0cHEbywCuY8xX80NEfEpfIr4Eao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hCAbBPit; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46255b269c2so1322387f8f.3
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781853260; x=1782458060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dO+UhVuzDjOR9Xal9erNoYHD+4hYeE1itAO+Ot7PglQ=;
        b=hCAbBPitM5hEMx855/8V8v3d9yJ6DNZ9TbIGYFPfc9nn02JUi1Ds+tXMIF3hkz99k6
         yEIzFaBEi8lpX3Nhz/5oh50u2bx6YTZB/P/PCd1uNrjFdbXkX+cOWgGQ27TJ17DFr4wp
         9BGlisO94IY7qNGbgEH4axoBJTvsKu3Rb1hw6N7dtXcmrhImUE/0dj+d3QLSQUJpCsZb
         phXJ3F5GbKlb6x6Gyi4//GT5mWQpms4YCW3xqXq60nwb8O3Lef0MpUdnPuqo+Bw/8pFE
         qV/R4WQGzDkAmTNWWKPYwA9I5BoX7Tcuka9CVsEeflZRBkkhFEWb+caXMbgfmif1Jc9v
         MCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781853260; x=1782458060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dO+UhVuzDjOR9Xal9erNoYHD+4hYeE1itAO+Ot7PglQ=;
        b=TSfwQrbH5+MN7WHMOrFHEm+stB2lNBLQvJVtX0IDykuX0btnuMkkUSGK1WQKx2Jobr
         0DxVA9movJuFVvUGTvO0ldMmTuRaVM/JR6RvaUJvZpsGOyLKrflXTPvOkbdyYSZji0cT
         M69n9nBCV6kdtBhRpLzkbzQDgrQyHGkmvZRKDDu04Y1Enz0ok7WXJLmI4jJHHCRcYycw
         q6uNnAUESvBSbpXJDETKSohF76g4rOPqzuVLxJCopaWluBgqjhk1RYW8PKv7olZRVZLv
         091Yh7BCp8WoAbwAK0zJqxNXwnl7giaCUtPdU9ZFLJQDQMCPZubmA6kMqDxZ21thZ2Bj
         C7sA==
X-Forwarded-Encrypted: i=1; AFNElJ+MO4EQwjZz/GT5hrpC5cLF3yYZ1+x+NuAE3a7aoknHDH0g38Uh8SnzX3l1up4BtsV7zlk3qZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGKERhh2u/mogdzKkerIww2Rp6bDAPfMoPEmHVMKU/b7dISwiZ
	1vRIr/Du94PWCCWn81GXO2mPW4pd9nS4ufTOiVZ9DR3jgjMGGr7/MGxSBD7R6adgJxBbb006g6H
	TrsZDUhE=
X-Gm-Gg: AfdE7cnjIWIiVBRhjZxp2D1f3/nqzF8d7HUFExYkAyumlamKGaDpevkpB8rtVbB7412
	eMEyo+0zHg7PuusUoga+gSuIlfyZ5c3wx5ZDXO7QGA2dDEGh+lh/Xfm8rGelZM0Z+AKRed9Y6Q0
	s54mGvEfyZGvcIYm4zTkKwgqY3/q0i+ZWBcCjA1dz4OBnf4dX3N7jJ4uMz56//XLZP81eXAn1pm
	shpcoR18gem3FROhXf3dEsOhczGIOzXDNaM8ogb+Jfqf5lUbWzBmsZVOy2U4QjzuW2NcriOM4U5
	pgP9vkTkZewxl69L4wY6wM7kxfzV0xZnUfwk3dXGbwRyMVTPdHnNl9s4jPnBpbcp0ZCZOplJ+CY
	eM2gD9wzfB8o5b1hxqSLIceYHshreUintphJL8Z8KHoLUDmy8PZ17bE+pyXWNTskqGKbyUp2Km0
	ty6DPl7jGKGA==
X-Received: by 2002:a05:600c:8b24:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-4923f439be6mr49271215e9.14.1781853259707;
        Fri, 19 Jun 2026 00:14:19 -0700 (PDT)
Received: from localhost ([195.94.150.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fce9590sm46202215e9.4.2026.06.19.00.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 00:14:19 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 19 Jun 2026 09:17:43 +0200
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Lukasz Raczylo <lukasz@raczylo.com>,
	Steffen Jaeckel <sjaeckel@suse.de>
Subject: Re: [PATCH v2] net: macb: add TX stall timeout callback to recover
 from lost TSTART write
Message-ID: <ajTtF2xy3WS6NfBi@apocalypse>
References: <468f480454a314303bac6a54780b153f689f2267.1781598350.git.andrea.porta@suse.com>
 <DJAKGHKZGUI2.29AHYNFX4LGBJ@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DJAKGHKZGUI2.29AHYNFX4LGBJ@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300636-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:andrea.porta@suse.com,m:netdev@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rpi-kernel@lists.infradead.org,m:nb@tipi-net.de,m:lukasz@raczylo.com,m:sjaeckel@suse.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:url,bootlin.com:email,vger.kernel.org:from_smtp,suse.de:email,suse.com:dkim,suse.com:email,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87F916A445A

Hi Theo,

On 17:07 Tue 16 Jun     , Théo Lebrun wrote:
> Hello Andrea,
> 
> On Tue Jun 16, 2026 at 3:23 PM CEST, Andrea della Porta wrote:
> > From: Lukasz Raczylo <lukasz@raczylo.com>
> >
> > The MACB found in the Raspberry Pi RP1 suffers from sporadic stalls on
> > the TX queue.
> > While the exact root cause is not yet fully understood, it is likely
> > related to a hardware issue where a TSTART write to the NCR register
> > is missed, preventing the transmission from being kicked off.
> >
> > Implement a timeout callback to handle TX queue stalls, triggering the
> > existing restart mechanism to recover.
> >
> > Link: https://lore.kernel.org/all/20260514215459.36109-1-lukasz@raczylo.com/
> > Fixes: dc110d1b23564 ("net: cadence: macb: Add support for Raspberry Pi RP1 ethernet controller")
> > Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
> > Co-developed-by: Steffen Jaeckel <sjaeckel@suse.de>
> > Signed-off-by: Steffen Jaeckel <sjaeckel@suse.de>
> > Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> 
> Thanks for this V2.
> 
> Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> Any news from the Raspberry Pi community about this bug investigation?

Not from my side, unfortunately.

Regards,
Andrea

> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

