Return-Path: <netdev+bounces-277545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHeGDINW2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:58:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 864F93DC3EB
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10B273007CB6
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F1F37E302;
	Fri, 10 Apr 2026 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2D9alwRc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79233090E8;
	Fri, 10 Apr 2026 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851108; cv=none; b=r88ECZtzDLLqo7JXp6F3PB1R9mt0EfGbt6tvsDtpN6dyfIJ03KnLPl1kNdr6QhP9XFHQuWHjmvYO3OTGHVf8VPjjkMeJvrjN+k+5WEditCA92tqxd7uisg6U08tKd1TfwsAKgmOEWH/LRdAJcoGq2cmtdPpxPFnQZc9X4b1+k5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851108; c=relaxed/simple;
	bh=fg0VeVP4mEH0rTqxEDA9xJj7jMG6fmClR9YtcEzccpo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=svkBCmUNFQX/0b8TLAuClq7KvzhEQVTfVSJt8AAgxpfz5kt5pNNPxTyV1IFqPArZDlMzN9+sjokeMxt61XWFa0imUx/d9S4RDjcetn12fBCb550eQJ3ApNCSrrtcGkXPvPYBBn27vvGLTUMjJyIr/J/ue8Pelk8Uw/sUsqZtKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2D9alwRc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8765AC5C1A6;
	Fri, 10 Apr 2026 19:59:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 18E39603F0;
	Fri, 10 Apr 2026 19:58:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47EE710450082;
	Fri, 10 Apr 2026 21:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775851103; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m4mpLpyfv3GbV9QTkJMcG3dPA4hBt3sQOSF8Go70ggg=;
	b=2D9alwRc7AyqeWn4o9TzssqZ65cRMJioaotw1ti40Izy1nvxpul+Dy3GHWRiU8E+n3ICTg
	pEgaNnWuvFXY5o6hTZzqpjsVm/zdUGTRvROoePQd2FexfA7BPxzwn7J2ZwKl4ntbaN6amz
	gJBqiUihJoPI8OXvF/S0RiVfo4l3icMBnFMxGSLLH3ECWeCmUpZVOHpRTril1gp+Q/Ap8/
	L7yoKfQbrO20zk306pDNDDBM5ehEs6afFswn4chd2E1d9Q/3U4EhgclnZcbgvLoUSGaQmT
	Ov9kxkrKOL7NqKLYp3pJH3ElQe6OaIGJvESRW51/C8fsHJomhu7pVFKXCr3dfQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 21:58:18 +0200
Message-Id: <DHPQOC9JMB77.3KE345N57M5ZC@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 00/14] net: macb: implement context swapping
Cc: "Paolo Valerio" <pvalerio@redhat.com>, "Conor Dooley"
 <conor@kernel.org>, "Nicolai Buchwitz" <nb@tipi-net.de>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
To: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
In-Reply-To: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277545-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:url,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 864F93DC3EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri Apr 10, 2026 at 9:51 PM CEST, Th=C3=A9o Lebrun wrote:
> Changes in v2:
> - Patch "add subset of `struct macb` to `struct macb_context`" was
>   messed up. It contained much more than what the name implied. Split
>   into three commits (I caused trouble by rebase reordering).
> - Fix tieoff; V1 allocated it without initialisation.
> - Fix NULL pointer dereference on context in mab_get_regs() and
>   macb_get_ringparam() when interface is offline.
> - Patch "unify device pointer naming convention":
>   - Fix build issue when CONFIG_NETCONSOLE=3Dy.
>   - Rename `struct net_device *dev` to `netdev` in macb.h.
>   - Rename `struct phy_device *phy` to `phydev` in macb_main.c.
> - On swap, call netdev_tx_reset_queue() to reset all DQL counters.
> - At end of swap, add missing kfree(old_ctx).
> - During HW disabling in swap, grab bp->lock to protect against IRQ
>   handler.
> - On swap, cancel the three BH features MACB has:
>   bp->hresp_err_bh_work, bp->tx_lpi_work and queue->tx_error_task.
> - On swap, call macb_configure_dma() which writes buffer size to
>   hardware registers. This is important because the change_mtu codepath
>   changes the buffer size.
> - Rebase onto latest net-next/main (58dd34dbd5b0) & resolve conflicts.
> - Link to v1: https://patch.msgid.link/20260401-macb-context-v1-0-9590c5a=
b7272@bootlin.com

Forgot mentioning patch "re-read ISR inside IRQ handler locked section".
This is a follow-up to the race condition discussion we had on V1.
It addresses a race against IRQ and a swap operation.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


