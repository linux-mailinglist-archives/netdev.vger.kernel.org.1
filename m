Return-Path: <netdev+bounces-267757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDKjKEeEtWlv1QAAu9opvQ
	(envelope-from <netdev+bounces-267757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:52:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2112328DBFB
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A366301CFCC
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DC525B2FA;
	Sat, 14 Mar 2026 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCX8HljM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78A10E3;
	Sat, 14 Mar 2026 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773503554; cv=none; b=HR+T6oO+FCGBE9x2ZL3hzTyxTAaN95PJ5lvPHRXqzN5h8/yO/JsD0/sWvTqnbiGSO4lZlatk/6dilIFvRVBDmIAWYGTbdBZdIYdMRmlvi5D4RdvnqAEJHHpkTqotS44ID6uOsmCHvrovv7LGtfeI0b5/XjJwe1tYKzDdgLUWe9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773503554; c=relaxed/simple;
	bh=lmhf33+qHK/vgfIIOKevHtIBkxesI9cNqyczpIwkR6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWtlGoV5ISyq+xYvzyP4p5FMWwCKQIxmyJlFMbAxny77Y1nV2iicSNC9QJDUaaD3cfk1FokSaEBl4u3Inp1SEnvQqnKAwIVjlEzA8/NOIIPi6PlcU861gVfXPdlbl0rQjM1QzgScmoFeNw2pvY+kmFYw+m7hjzMjwo8QQe4g5/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCX8HljM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C40C116C6;
	Sat, 14 Mar 2026 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773503554;
	bh=lmhf33+qHK/vgfIIOKevHtIBkxesI9cNqyczpIwkR6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mCX8HljMp8HlBMbXGHXtEOiJ17g0v2KRMZJwH7EyytyRY4hsIDaxq+zh1JoHF/7fI
	 JA4z61gajsoGkY+BXv2NsJ1TfhURynNGCKMIYTJ+oLugd7ZlyWitzfbxeYJYGWIUbB
	 fbmW8BaQeAnNopPJ+/DJ8vk+d6NV5awrFlEwBKZWzdBsQW19JzUrwKaisZ1SUqMnzy
	 kh5bjN9slWjyUgXPC61Aq99ZCjI6TB7rwkZeYocM2u86mDNHNP3PDI9HBglZuWgGYo
	 TqHMHDe4z0DL6MGs6v5A1b+UkNT8aDcUjBhRo15O5imsptBAPii6lBrFxVWavGzgnv
	 aHzptjW+o3XFg==
Date: Sat, 14 Mar 2026 08:52:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Bhargava Marreddy
 <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, Eric Biggers <ebiggers@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Markus =?UTF-8?B?QmzDtmNobA==?=
 <mbloch@rooftopnetworks.de>, Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] net: bcmgenet: add XDP support
Message-ID: <20260314085232.089ea669@kernel.org>
In-Reply-To: <20260313092101.1344954-1-nb@tipi-net.de>
References: <20260313092101.1344954-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267757-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,broadcom.com,kernel.org,rooftopnetworks.de,arndb.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2112328DBFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 10:20:55 +0100 Nicolai Buchwitz wrote:
> Add XDP support to the bcmgenet driver, covering XDP_PASS, XDP_DROP,
> XDP_TX, XDP_REDIRECT, and ndo_xdp_xmit.
> 
> The first patch converts the RX path from the existing kmalloc-based
> allocation to page_pool, which is a prerequisite for XDP. The remaining
> patches incrementally add XDP functionality and per-action statistics.
> 
> Tested on Raspberry Pi CM4 (BCM2711, bcmgenet, 1Gbps link):
> - XDP_PASS: 943 Mbit/s TX, 935 Mbit/s RX (no regression vs baseline)
> - XDP_PASS latency: 0.164ms avg, 0% packet loss
> - XDP_DROP: all inbound traffic blocked as expected
> - XDP_TX: TX counter increments (packet reflection working)
> - Link flap with XDP attached: no errors
> - Program swap under iperf3 load: no errors

Have you had a chance to run the XDP tests from 
tools/testing/selftests/drivers/net/hw/
?

