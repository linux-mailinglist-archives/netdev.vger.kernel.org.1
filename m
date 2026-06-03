Return-Path: <netdev+bounces-294790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rFNxO81AIGo5zQAAu9opvQ
	(envelope-from <netdev+bounces-294790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:57:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5602F638DB4
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:57:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294790-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294790-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=hotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68287316ADB2
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8634B39A80E;
	Wed,  3 Jun 2026 14:37:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47475396D2E
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 14:37:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497440; cv=none; b=JwbWUfFGdIDkw9OilDW0vUtMbba1KtJTrQ0pm8b5YK15WmEvp/WLZcVdWqxnhD2nH0vE5C+La8YP5ldlh8RXQ+JJg+pVMEGz/nZGd/GcfOg75ytaqVtUyXtoHPKL/V7K6KJK93xAgCrxiqdwF9MFv5Gp/3pehad7ztbi9KcTl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497440; c=relaxed/simple;
	bh=7sotkPWu1wfNu67XWnbqYZkTGv9k1u0xzUPyOcRSLKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPAh5Iw4yq6XDnm466rm9c+TkitF0tWvrh5aB2zAbVYfTJro5k/4X+In9Bm59CNEiPKXPQZj2yhyJQn/x/aY+ONWK0Dict0DTz4/19Rp4Tg/CnV48gTV69sg3SLBzUjbAWzyphiTvJLQhrDhUMQ0pTlHUb/nfdQnLnUamkrh9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so37796166d6.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 07:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497438; x=1781102238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sotkPWu1wfNu67XWnbqYZkTGv9k1u0xzUPyOcRSLKo=;
        b=nYbCmT9UjoKhZOBgJQc/q8hFbOyV9HG5UzjjoZHlJ1vSC5FlvrqBfqacL9h2ZjnO1X
         PMleOfnV/tJrV82y1d7zxe3Y0VXGCC64/gDZH4HvepFIa20FI5QzITJLnKj6xVSLHF4f
         Uyz7bK5ZxLkqMNmbu1TpF0lfGD0QQZmKhrFwe899TE06iucLQynb9u2+3a+M0FvEaNKy
         nlAnu0ksk8g9mv2T9OwxFin38r+p852YMgUDmf+52NOefB7+6jNUfN8M6s9doMccOsKV
         XKEvC2P+gzjnwt7xfnhzIGk0aJwMapdFvTrmDH5xd66kpYtbobPJ4TMuqcMBr8xJOaK6
         RQNg==
X-Forwarded-Encrypted: i=1; AFNElJ+vtunHEWPTR+zRUk/727ASfxvU1cXOXeOn533usn0BNIFTi1c6zJNKb15Jb3kY/9sy+/C40xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcyAO6RwF0EXoqR9ccpBVjIqi3hwXo5an+askCSzb9fn+sWSl5
	9zKw/5noxDWcL3aeIoiKyNUWHXvNmxmRVlWuXlut2Zyr2HT8K7Z9gyRc
X-Gm-Gg: Acq92OF8SpMW61NW7FVZOpqlPTBLF2sYhWl5RwYqnewJ7BcImOJ1uW7q68Ua0mD+iWX
	sgZ0FfEDvcuETRVSzXFA1XfOqNsWCBzQ0raNF5mGkzZrRzwqjqUKdvIiah09eg+8qWPNdS00NS7
	83Kr/G83bmqszxpkk6kbgSnQoAqNqjqzS/uXdj7EEVMoPMEB5Y9ivAlFjdHiwz9FxiWIp9InYuY
	JUD0QhkHB/hxfH4Cys3AFJg0Q19Axdmv/cTOqT/rnWYzGjByoJp/KaC/gtEAx40ReboExF5lgFj
	GfZO9DVanwcN6GXFY2pX5+zIGtL5U4mmFi8clYjzgQm+W/ZRj1cdgvRUVVdvDJFxr+C9mZftbzj
	s4XHDXvBSMqbLf1IelAv3e4MZNi44imbv1T88QyJXxOjgk9xE+vV6wOxNhfuCzP0HFOzn/xKB5Q
	nFYmz8FvrDPA5Zyowb/VFVCfhNFjbcvecGXRkEK+orjGgustaGIO3q7o56GnaSL2PNefQVJ1lAU
	h59vs9hfEijt7wB6O21Fk03f97YHA+3N3IkCCPaWTU=
X-Received: by 2002:a05:6214:459b:b0:8ca:25d3:bf41 with SMTP id 6a1803df08f44-8cecdc52a1dmr52727396d6.8.1780497438259;
        Wed, 03 Jun 2026 07:37:18 -0700 (PDT)
Received: from lxc-docker-tertiary.local (pool-108-45-26-115.washdc.fios.verizon.net. [108.45.26.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fda2sm21883976d6.2.2026.06.03.07.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:37:17 -0700 (PDT)
From: Greg Patrick <gregspatrick@hotmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] net: phy: sfp: detect presence via I2C when no MOD_DEF0 GPIO
Date: Wed,  3 Jun 2026 14:37:17 +0000
Message-ID: <20260603143717.2985309-1-gregspatrick@hotmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <dd3c9c23-a9de-4505-8e49-97d4bf18f465@lunn.ch>
References: <20260602235528.2795028-1-gregspatrick@hotmail.com> <dd3c9c23-a9de-4505-8e49-97d4bf18f465@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[hotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294790-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[gregspatrick@hotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregspatrick@hotmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[hotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5602F638DB4

Thanks for the review, Andrew -- folding your three replies together.

> > ... wires none of the cage sideband signals to a software-visible GPIO.
> Are they wired to a software invisible GPIO? Or nowhere at all?

Nowhere usable that I can find. TX_DISABLE is driven via a PCA9534 I/O
expander, but no presence/MOD_ABS line reaches a readable input: the
RTL9303 gpio0 lines the sister TL-ST1008F uses for MOD_DEF0 read stuck-low
here, the single PCA9534 is fully consumed by TX_DISABLE, and there is no
RTL8231. I haven't traced the PCB or decompiled the vendor firmware, so I
can't prove it goes literally nowhere versus somewhere I can't reach -- but
there is no software-readable presence source. I'll reword the commit
message to say that precisely.

> You might want to differentiate between an SFF and an SFP, using the
> compatible. An SFF has no need for an MOD_DEF0 GPIO. I did not look,
> maybe the code already does?

It doesn't currently, and you're right that my patch wrongly changes the
sff,sff case too: sff_data has no SFP_F_PRESENT in .gpios, so a soldered
sff,sff never has a MOD_DEF0 GPIO and always hits this branch. v2 keeps the
always-present path for sff,sff and uses the I2C probe only for an sff,sfp
cage with no MOD_DEF0 GPIO, gated on (sff->gpios & SFP_F_PRESENT).

> Did you try a 0 byte read? That is what tools like i2cdetect use.

I can't on this board: the cage I2C master is the RTL9303's SMBus
controller, which advertises only I2C_FUNC_SMBUS_BYTE_DATA -- no
I2C_FUNC_I2C and, notably, no SMBus Quick Command (the zero-length probe
i2cdetect uses). sfp_i2c_configure() therefore selects sfp_smbus_byte_read()
with i2c_max_block_size = 1, and the presence probe reuses that same path.
A 1-byte read is the lightest primitive this controller supports, and it is
also the only form that works through sfp->read on both raw-I2C and
SMBus-only adapters -- a zero-length transfer is not expressible there. (I
checked on the hardware: i2ctransfer reports "Adapter does not have I2C
transfers capability", and i2cdetect -F shows Quick Command unsupported but
Receive/Read Byte supported, which is what presence detection rides on.)

> > -static unsigned int sff_gpio_get_state(struct sfp *sfp)
> Humm. Why?

That deletion was wrong, for the sff,sff reason above -- I'll keep
sff_gpio_get_state() in v2.

I'll send the v2 with these changes after the 24h window. Thanks again.

Greg

