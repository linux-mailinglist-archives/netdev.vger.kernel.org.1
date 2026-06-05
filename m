Return-Path: <netdev+bounces-295729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kQBeLhyRImooaQEAu9opvQ
	(envelope-from <netdev+bounces-295729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:04:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A8E646ACB
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:04:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=r8tz4hux;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295729-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295729-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9CD73041B88
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823FD4ADDB9;
	Fri,  5 Jun 2026 09:00:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE794ADDBB;
	Fri,  5 Jun 2026 09:00:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650008; cv=none; b=UXpnUEDrPoV/zVWvxR6IxFh7aLPI67xIg12ZNFVACIQ5fUN9waUy8rNYLCT5sAVSd9YYzs82jvCQ2jFswmRRZQM05caXQ7hkZjsMH2ijrYhX76BGmpxaRsv0ETpKgNmUBckCtzk42IhK75qU2o3YVsLdIPuEZFPCF/P8U9bD500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650008; c=relaxed/simple;
	bh=Ds1PAnRsEm3ccvRy1HFgEUGyEQPJR9Mx1ng/I3h/cog=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LTl1Y+2U3Nk7c4SXKX93ySL4r/3byCF1N7KKnF4ZFGFH5G+xqJE4kQHI910jE8zkoYuK1SGO3VxsXMnCT6lWyKvSFubVhOmUPQfyZ7H6J5SWT1jV5FVI2BBXGfamoFpQzaN9DSZ138Ff2MyEcX4Q2rQJ40I+eLrt84IWhXOLlXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=r8tz4hux; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77544A4C41;
	Fri,  5 Jun 2026 11:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780650004; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RccDxgGvZ5+/QF+jvmtjhqDNtfqK/hlFJZrrDuPIo/k=;
	b=r8tz4hux9RMrLyuflZK7aivZEQEeNvuKAbFI7fRsSU6cjBc3QyVJNDyVJL8p0rRyFGTKMf
	MZzwQWQBUUzLIOpw4MUQQNdygKzSRSujwU9eupQ5WAG+MfMDcUmSgZEsp6ioi/CmbMirb0
	nMcvKW/gRouK0H/Pn7TpTDu0OFclPUU7ep+8ddoOYre1SFcDHcompXIug4uH2CqaO1GSqt
	O0k/0zzaepzECzDtEzIAlBLOoRrgFOsLPIxxfTG2QnjMEcSwgkk5ptKgY8IfLpkQ+X59aC
	h1VCDFh1r3rIS9QmcvVTt2uIwuwB7Yc3VBtAvScMWlkISvMTZ5APaZhK6x3HJQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Jun 2026 11:00:04 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v3 2/4] net: phy: c45: add
 genphy_c45_an_setup_master_slave()
In-Reply-To: <20260605074328.1800-3-javen_xu@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
 <20260605074328.1800-3-javen_xu@realsil.com.cn>
Message-ID: <f3df03371596e5ff3465c0010a9f07fc@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-295729-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,makrotopia.org,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24A8E646ACB

On 5.6.2026 09:43, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic helper to configure forced master/slave mode for Clause 
> 45
> PHYs using the 10GBASE-T AN control register.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - no changes, new file
> 
> Changes in v3:
>  - re-order function according to the order in phy-c45.c
>  - add kernel-doc about return value
>  - add MASTER_SLAVE_CFG_MASTER_PREFERRED,
>    MASTER_SLAVE_CFG_SLAVE_PREFERRED, MASTER_SLAVE_CFG_UNKNOWN,
>    MASTER_SLAVE_CFG_UNSUPPORTED, MASTER_SLAVE_CFG_SLAVE_PREFERRED cfg

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai

