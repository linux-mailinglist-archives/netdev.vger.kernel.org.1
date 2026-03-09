Return-Path: <netdev+bounces-265752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLPfMXMzr2kPQQIAu9opvQ
	(envelope-from <netdev+bounces-265752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 21:54:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE02412B1
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 21:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4CAF302A7DB
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2D036CDF3;
	Mon,  9 Mar 2026 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFrDm5Zj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3436BCC5
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089647; cv=none; b=Y96G4BJA04AfQX1azkIWBErQ8JtUbb8AOTkkBA9XxeiqabxrQ6hfHgP5XdT4wqgJara6Rok9iL+D1gQn1kCFmbdCdqaKk+hSfNI4dDoDL2D/Pehi6ex+XZ7MiP9eRcY66IQ/YPTPvL9m7wKRaVryyYszxmcWYxMYIvo3B5J8MwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089647; c=relaxed/simple;
	bh=iZeho7hFDpbblird7vqPtnvPNXymAdFbrY0gJyN65/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ4KDXB2+tpDk+wzab6EIMc5+Isc5KNfR8NEqEGqZKimVFP2Yp39NDQMgQeypN5FsZO1clpNf10cr7w5hp8aK/ZcvuJ+Nxrplt8PbDP/aB7sLQiaDVpAEuhICIyYwS5q5RGAImPhkVrvL5NW3G+DByQ4W05xqqAuoK1HUyaq0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFrDm5Zj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4830f029407so17575395e9.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773089645; x=1773694445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6J9v6HIc6YeWEf0rcl0hK+DGUzadszKEdiVzfGZTkYU=;
        b=RFrDm5ZjQxC/lSwhjPCCQYxh87wT3xR+cXt13LCnVYAxiD4pJ79SCxQEP1zZQ98jX7
         papf7e3HyOqObrL7k0dFrL1mWzj5Zk8GzrH++ZxWVYz6GJTRloe9BWkDYFyZrU6D/9oL
         SKtoaDoNr6G66Ma3GU6YeBeurRIbGC+rLG6hIOltmRX44R5Ux/9HeXjCXzEVtH5FgsDJ
         UbI1nl9dY4djbnP2JVz0knYXYwiDZReV0HZDBKq61ee7UbeDJZULZlqbufircFy48YTr
         5dkunq4J1fzBAPgkXLew+pBpuLPRmTlwnh+3GygriajScCS84+c1EjhVY59VaqpdIazt
         fZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773089645; x=1773694445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J9v6HIc6YeWEf0rcl0hK+DGUzadszKEdiVzfGZTkYU=;
        b=FgQZc8k6cbftKCWDiFpjjgjylcYFczaoVVw7y1aHnQ4VEa154xKpElz+sW0Sgek7PD
         Z2O7m6VolV4qLXXvavGhXkCLEUmjkyG2V65yU3zcjGG/V7u7bQpDnLgJE9PCJdVJcOXH
         mDKZjukBpSOBWt2plJpAST1Bpvy7sCS5C3b5sr7wvWg3nS7H06Ib8BgCaNpUKtnXrWCz
         /GWYHAT2jKT39y5jNBjgFDNSPw9dUZJ0YJ4audyBEMbV50YEb7IqW6Pexuwpw6pyOnsC
         E7msM/Neo5Cn7zd3IjdhSzSx0PI5xSDxnhp62lxVxt8bAqeC5wCw6XlQwt8TA8IoIet6
         ij7w==
X-Forwarded-Encrypted: i=1; AJvYcCXA8MvJVzVHPXII8ToHYWQHk7tsjgeMGRNmgQCuAK021/OeCmI2VEdN7Ry/1Ssgds3XxDsxH5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rfXVDnXDzJqwjiIMG40QIg4920CNa71u95RM/p0LLUzRuNRW
	pXdKgrnL+Ou+naQjqg5mLN91Ngc3pKwlRYiEDwSbQR26f4TKVhH2Pwb1
X-Gm-Gg: ATEYQzxnfzEwMmBOyx+J7HvnqtcJoRJ2vfQbgAlUcqAAWq4mhvYh1hx4zvx3nnjbq8N
	TA8cuZqaSkT3dQoIyUIqTV2Mm9fSF8xk4QD32pZykgRamz3SxWQTXrIznW+FPGklB6XRv6ZSESZ
	TWDo+EBAvSl2VdfWwlNeTtOQlLSIRQ1JAvY3WK7E3/VECnm3M1Rbx1k4HaNe6RyjmeI4uWvWJaH
	ajz4ZNFrNcxWL/ycFGk66EdHORhxyRCqMQ3S0Ll3yViUOOQPFgnpm4RX0frmE5dRgGIeb3921yr
	Uaiy1FuJO9PyCsL6t8i6iMuYMFiseoRmtUQMTlFenOy/ePuCLxzcVbIvG2SPtSqUoFx1Fq3ewpt
	J3d8+t7sBM7cWLfdKsX+n2DpIUrIMcW5oBek1p5B2kScUGbcucs9qv+KwgtmbNiJ9Kh3z2jva9u
	4Cp+MpGPhj+xqkcQ==
X-Received: by 2002:a05:600c:4e8b:b0:485:358b:e7ed with SMTP id 5b1f17b1804b1-485358be94cmr59002665e9.0.1773089644437;
        Mon, 09 Mar 2026 13:54:04 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:8799:3a7d:3c86:3200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm32428815e9.2.2026.03.09.13.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 13:54:03 -0700 (PDT)
Date: Mon, 9 Mar 2026 22:54:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
	pascal.eberhard@se.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
	Tristram.Ha@microchip.com
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <20260309205401.bk5fpw6kqnmlktbu@skbuf>
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-1-3f4c47954c71@bootlin.com>
 <20260305095656.vlyaztv6nbdqrmil@skbuf>
 <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
 <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
X-Rspamd-Queue-Id: 40DE02412B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265752-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 01:54:28PM +0100, Bastien Curutchet wrote:
> I have a new iteration ready. It uses only the high byte of the interrupt
> registers for the KSZ8463, which keeps unchanged the current 8-bit accesses
> logic.
> 
> Shall I send it ? Or would you like more time to think/discuss about whether
> we should split ksz_common into several drivers ?

"Send it", you mean on Thursday after the weekly 'net' -> 'net-next'
merge so it doesn't conflict with your "net: dsa: microchip: Fix error
path in PTP IRQ setup" change, right?

I don't know. I have to say that I may be partly responsible for guiding
Arun Ramadoss a few years ago towards unifying all ksz_switch drivers
under a single dsa_switch_ops, and that doesn't seem to have been a
great move, given their amount of differences.

Prior to Arun Ramadoss' refactoring such that lan937x could come in and
make use of ksz9477 code, we had two distinct core drivers: ksz8795.c
and ksz9477.c.  Having checked out an old kernel before his changes,
I'm not sure why I was so blinded by all the false code sharing hidden
behind dev_ops that was already there.  If you factor out the MIB worker
thread and other inconsequential small driver things like that, they're
perfectly separate hardware architectures which could use perfectly
isolated drivers with only minimal duplication, and we possibly wouldn't
even need the 8/16/32 regmap tables.

"Resources global in one family and per-port in another" is a recurring
theme, and the inability to have clearly distinct code paths that handle
these clearly distinct hardware architectures is a problem. I'm not sure
of the extent to which I was aware of it when making those suggestions
to Arun. I can recall this thread that indicates a still unsolved, to
this day, problem which was caused by the desire to have a unified driver:
https://patchwork.kernel.org/project/netdevbpf/patch/20230316161250.3286055-3-vladimir.oltean@nxp.com/

I don't have a good plan, but the current state of affairs is not your
fault, and I don't want it to stop you from making progress with the
KSZ8463 PTP support. Maybe we can continue discussing a clean line for a
KSZ8 (and maybe even KSZ8463) split where the code duplication would be
minimal, with further input from Tristram.

