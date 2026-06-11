Return-Path: <netdev+bounces-298264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EpDFAdX5Kmpl0QMAu9opvQ
	(envelope-from <netdev+bounces-298264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:09:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77667451B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:09:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=hotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298264-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298264-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A49733237DE0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE83BB117;
	Thu, 11 Jun 2026 17:54:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F649253D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:54:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200488; cv=none; b=iP5L9hl2HT1o9q+9m2k9FVN5gHXtPNuQ2ncm+BLmO3Tbk+cqiRJaJChPcCqKPYE9Wgp12LNpgQy6/Mvu9whMDRxVX8ywHi0nD+4pmZAXa9f+hMtt2xBfbYrRpIypQ1gRW+lxSA2Wi+zR/5nEdhM/usaYTgNgj+M0hdhb+zEac6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200488; c=relaxed/simple;
	bh=N3qMiFXWa3P4vzXQt0vNb0DSrMF+54zK+S61h7juR2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ai0U1FW1fR9uvAvlG05gnHP1kFTZNPfQDJhL7SxQ+aadnFAXfLVUEbpTbGpMFc3IHsWlWmcjgkgvrDM2RlXaaCqw7OlJpulMr+TwIkEpr2i6XfhhZAELPXt/00/0nO7t6Yd9DMts6DGUMUcHHMwI/XPVTF7K9YhGY/OGdsYKytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ce9df48e1bso2266256d6.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781200486; x=1781805286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3MyD5sgrCXG8g8emQHBeewZ1qL+fszaeWMzfNzWpns=;
        b=PT2yyKpah1rATrFQtgqX/1AVju73ySFW24M4TYX5IF0obgtZFznBUNr0EL02EqNjD4
         RDjWVHtudPJXnlXWH5LGtBo8r2iE0ZY6xKNkjQOKMxXxzHGkBftpsaa966lz6PSDTg9c
         eckUVhde9cJNH+Hr0VwtLd1VRzM8QbydGUNcJIg++jXssh/En1XiLdXiyLgV+uVcM8zw
         YE+X5a1up7Tb57lfx6hVA8ceg06zjTHcpWPinbuh5K/gNsju8PxLqc3aPF2e3MiWQY/D
         Voj3a1Aa4mycZwlkhzv6M0MqsuHv76jyS0V2FT3rbtdmeOQzGcLFzfoDorLkDj465H9b
         Uplg==
X-Forwarded-Encrypted: i=1; AFNElJ8UZcyFizABHV9nj4LkHhBRD66XYMaEAxhyoC1uRYSCNF7LiGrcFKyIQ93D6YUmdFUNAhT6euw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8Pb3MdSVzmdrXnkj1S5FKdN+5eayJuXXhZm0QtiDKM8ZScXD
	+xxOo79XY7QG/F5IjIP/V7Cl1Zyjfue5xG89A/ETMiDlZgvYH/IfwqdHAhkeWhMk
X-Gm-Gg: Acq92OF3MvELtH8+pmlAtAZZCrFGxzX1MaiYjkFgNjGTV8m6FfsjpQBr4zbELweQXEj
	rowVPUuJdizYy9bUCmh/UxKVFWFgGLmcc7D4dXhKvbOvGP7p8ipvGQ9aUhjZMOIegWfVBrvoiU8
	+kxMpUzEujmRzDD9tmJu/sokgEV3CeZ4egZ2yWxkBzbFLwJbWnnA8p2IWo/z+HjhK0cxk7IkDVe
	NZAhVrWe7scXenYbnLw8vua2Q9Whek8CbM+WgjnGjjulHqyl9BjJHtu3WAQyW6R2zdhiBGqTwvs
	WKKZ2obyS3am5ZkqT1eUk0JH4e+U0iV30trtFbHbyQkGSyxzg16vkuhV5CMhzWJFgfVcsJCpkkp
	TLCpbuMdkgXW2WR2xzS8Q02Vx0oQbNJFXRoxUvwSnu7hevaP40olj1RpTi3y17/wgfAcNwQiI69
	eYFeqBmKRBUBh4eW8FUIlDlsiu+wn27bKZ3d6qJEp/O5T32lmTMUc+uSuhGHfxraWJoI0AGWUBe
	QldNpNqGvVEdiaZ8ubQgQ==
X-Received: by 2002:ad4:574b:0:b0:8ca:1cee:7c5a with SMTP id 6a1803df08f44-8d1d7f63589mr64073926d6.12.1781200485513;
        Thu, 11 Jun 2026 10:54:45 -0700 (PDT)
Received: from lxc-docker-tertiary.local (pool-108-45-26-115.washdc.fios.verizon.net. [108.45.26.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1ea7c0d98sm24121476d6.31.2026.06.11.10.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:54:45 -0700 (PDT)
From: Greg Patrick <gregspatrick@hotmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manuel Stocker <mensi@mensi.ch>
Subject: Re: [PATCH net-next v2] net: phy: sfp: detect presence via I2C when no MOD_DEF0 GPIO
Date: Thu, 11 Jun 2026 17:54:44 +0000
Message-ID: <20260611175444.2223563-1-gregspatrick@hotmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <399497f5-ab96-4a8c-81ef-d3c4588fe341@bootlin.com>
References: <399497f5-ab96-4a8c-81ef-d3c4588fe341@bootlin.com>
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
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mensi@mensi.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298264-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[gregspatrick@hotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,mensi.ch];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[hotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C77667451B

Hi Maxime,

Thanks for the review.

> I'm genuinly wondering if 2s for this isn't too slow. With a 4s total
> including the retry, this definitely leaves time for a user to swap the
> module with another different one, and we wouldn't see the hotswap from
> linux here, leading to very interesting problems. I think we need a
> faster removal-detection time.

Agreed. v3 drops the re-probe interval to 500ms and keeps a 3-failure
debounce, so removal is detected in ~1.5s instead of ~4s, while still
riding out a transient I2C error on a live module:

  https://lore.kernel.org/netdev/20260611175341.2223184-1-gregspatrick@hotmail.com/

I've now validated v3 on the hardware (it's running from flash). Some real
numbers from physically pulling/inserting modules:

 - Insertion into a cage that was empty at boot: detected and linked in ~1s.
 - Removal, clean pull: 1.2-1.5s (the design floor, 3 x 500ms).
 - Removal, slow manual extraction: 2.6-3.5s. A human sliding a module out
   chatters the I2C contacts (intermittent ACKs), and the 3-NAK debounce
   deliberately rides that out rather than false-flagging the live link.
   Tightening the debounce below this trades directly against spurious
   removals on a good link, so I've kept it where it reliably never flapped.

On the same-cage swap-to-a-different-module-within-the-window case you
raised: that one is inherent to a polled scheme with no presence edge - we
can narrow the window but not close it without a readable MOD_ABS line,
which this hardware doesn't have. I've noted it as a known limitation in
the commit.

Manuel Stocker independently confirmed the I2C-presence mechanism on a
second board (Horaco ZX-SW82TS-L2P, RTL9302D); his Tested-by is carried on
v3.

No rush at all on your end - whenever you get a chance to try it is
appreciated.

Thanks,
Greg

