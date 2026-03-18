Return-Path: <netdev+bounces-269030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNqRC+yzumlWawIAu9opvQ
	(envelope-from <netdev+bounces-269030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:17:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6B92BCE37
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 566BD3023DAA
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52B3D9DCF;
	Wed, 18 Mar 2026 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX2eREON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E13D9051
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842583; cv=none; b=f5GNkodRpjhOolSjM4afTcM5UqjaRAGn3aNkdQhkGVS4XUHov1UXDTDIUdSibvBvrKN0JYykUxB0oUC4ZcCQTXfKbfe3nZFTeUPH2yojSolSPJaioJrjPDAnFQWmrfxbrPNSYF6K5e9IORb83Rq8wdNNR5lbzi+S6wy0z+dIWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842583; c=relaxed/simple;
	bh=d/xjx15tJydD0O/ZMBFaiDtt1yrFADtv6QjRJyR2POs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ5Hh34YCTlwuXvlu93KEFaIiEUf0hlcUst76kfd7fUQnFiZzpsOl7kTbefxP1NdwBx4TK2ZYPLih0/j1wB4wQNVABgMY/zx8YpECU95Ip5hzzz/noNQZ8twklC5X3Dro1arQI2DESrQwOaNtdKEqWTwfNLTfybAkVMtaXgwxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX2eREON; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439ab83f773so775695f8f.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773842580; x=1774447380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hz5rzCflM/Tpqt9LWNenXWEDo92khmGDAEQ0OrdSK+g=;
        b=QX2eREON5O8E04Naz08ky1N9R8yXjcLJACc5w77rS7oJXqvXVa6YCyTULi4QlH5i+j
         lv0CTZbr8OcpP4FJb+TU+6UbRIs7YXtJ1IrFQRIuLvGN7mbvSpqlpB/c0DEQjY7gavsV
         I1x8LTHtRnDUXTY7tZl0Br5ed35TVMHMEzHafZoeaysrSmumAK/SAw2hRt5VyZCtH2on
         e7rqqCBIR7u41U7w1YTBec8qoIlxzilfmbVKX8ZsREIQy893UmtIJYVjckfbeu3JaDsB
         uVlniPZKsD+0yJNdWUd4z+kPtfBm/V1R1E0ViKLTLDV+Mky272URZp7l92a9hFj2Bjmx
         uLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773842580; x=1774447380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hz5rzCflM/Tpqt9LWNenXWEDo92khmGDAEQ0OrdSK+g=;
        b=qhWgSSZCmw4e1zCvJ4RfVFTT6RmTZTwCQq/EX/LepsU+lrEJcPvt9oKmXUnLqf4Gd2
         W32byNXJILMUCeF163a6Ei19rMEUoBZiHLibFEoRhArTY2mRI40O6Gm97v4cG0Z0t8gw
         AIyRTAq2LvI6ndjoWQZnPqZM8PjpkCXnLfBTi7WOBrlqOyV02yLlkLDg+UOSLK6D3r3I
         aAp8xP74fACNimSlwJXD1Cq6WkQI7vRPk7eq5CvFD8KWx9RbY085LlW28/oQ9qc4DYWd
         K5MaQ8MFZ9mJD4E1uD8g/u+M2FGMI8nypi5PjNSw+C5wlos7LRReOa7Qx0CaGdv0094y
         yEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX18IaWTV7F+iTOLf6NafpmS/5Qn44u3fmjOuBhqsOJuWvaFVmQVvSkNHAP/3EvKcNQhD5LX3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+FlCtfOHqQijZnXEzPpdSzXGcJO28Zw3afkHw5S5femghMQE
	wHuOSqFLGLXceGcSEs4juap5V32dtvNq9v3n+TTNg3bR78zb/zKhwbnh
X-Gm-Gg: ATEYQzx16eTxJa3kPpwnxHJiTYKhyyN5Jov3oUjhyzseKIbpnfZt8WWnKfbZUbLsOLj
	71YnxOdFkNNWjLoxTYCe6i9bye9E+4wAX43aV5SizK5GkJX3+/NmHqZrEq6CpQYsv/4hkzUA0Md
	S/GfPt6EelZeHHFjSff1coQ2OqqgH2BzjM6yHXZcJVbRu54lew/dyTTbXSvdOTn7xYo6tIjwt5e
	X3v/p9AQQE5taDH4/kRxwL5TZqyE19eR0B+vmAV5NCIEtI11wt6n1kP35V4wlUlca09eD0mW3Pp
	0zRzlHJRbVC5S1v597NBu/62IuZXtk3mKKQdzzOQ0EKicsEghHO4z0CQxhZh03+qDXcZ7Kcl5m5
	nMLwjmO67BQFQbGls6HB4r7boafSEh2zSxu5eb/o/Q/8kQeBqM9xoynSI/bNnrT44lsjKInBvE1
	mRrESEjLRGo4eUOww=
X-Received: by 2002:a05:6000:2b05:b0:439:b114:60be with SMTP id ffacd0b85a97d-43b52651682mr2127401f8f.0.1773842580078;
        Wed, 18 Mar 2026 07:03:00 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:ef9c:34de:b42c:c04d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5184957bsm8751992f8f.5.2026.03.18.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:02:58 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:02:55 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Tristram.Ha@microchip.com, Woojung.Huh@microchip.com,
	UNGLinuxDriver@microchip.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, horms@kernel.org, pascal.eberhard@se.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <20260318140255.kqjknfwjlaojkcdu@skbuf>
References: <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
 <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
 <DM3PR11MB87361761E911D6EAA0311DF2EC44A@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20260312134526.3lnifstvb5dpghrg@skbuf>
 <20260313153849.qkfzv5c2u6fepjku@skbuf>
 <DM3PR11MB8736ECCCE15258C04287889EEC45A@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0495251f-79d4-49e8-8829-60e3ad105093@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0495251f-79d4-49e8-8829-60e3ad105093@bootlin.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269030-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA6B92BCE37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:26:49AM +0100, Bastien Curutchet wrote:
> I took a look at Tristram's patches, they should work but I'm not a big fan
> of emulating other hardware behavior to fit the existing driver. I'd rather
> go with Vladimir's approach.
> 
> Thanks for these patches Vladimir, they provide a clear path forward for the
> remaining work. I'll rebase my work on top of them. I'll implement a
> ksz8463_setup() function to match the KSZ interrupt scheme before adding PTP
> support.

My only ask is that you take over these patches and submit whatever part
you consider necessary. Sadly I don't really have the time to do that myself.

