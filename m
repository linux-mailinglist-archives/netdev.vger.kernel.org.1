Return-Path: <netdev+bounces-306262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MXTuAG2sT2odmgIAu9opvQ
	(envelope-from <netdev+bounces-306262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:13:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8187320B5
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:13:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=Gf35py3v;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306262-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306262-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C8AD30516BE
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A45376BD3;
	Thu,  9 Jul 2026 13:56:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1482E2C029D;
	Thu,  9 Jul 2026 13:56:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605375; cv=none; b=nyE81eI/exCGc9xiw5NQnhxLsmWumASfrIvg21gptIu1SLvzxFvbTRuAnYy8y2TrD7MlPYYG41VBpnH3hjQVhScJE8vQ2A73lgiIJdg+FjZrUJ2y3qTS2jVA7IGneC8avLmQ0y8XBktDMzhVtZAAfpnq5VN7G58wYpdEdjrZuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605375; c=relaxed/simple;
	bh=i81NxTEkmydaKEAl/LkQcNPgm4/l7R5b5H1ealDfRec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrH/v7vr1kUMR6BjX77NElcK66owUsXa0pFhRGTeJOFGGY4Dg+XHtmpV3/+8Ick0x8mShNTsz8l9q9WsmvyvfcRug14RN1z3vPf1VJOmWfeyYFD1dkAEFuUgkvi66FVdYjhpa+L9L0loAl4gLbdEGLSu1K8pEgVvmSQZMUlPTbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gf35py3v; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TyGZ4Yh2PYydxEftijgf6pm2ZKSoXc/AcJ6Hxr9na54=; b=Gf35py3v9mDSMerax+jdC1Mpla
	tvNsEtvbK9GG9GkwpaNmKQJte3VQqWwpGU+T2hwlaDWAjMAdRKQ9QVEeC/5feCLGrNLyI+SHir31T
	u/sFvqnx4T85tLub1TN5rKvRrA0k7+09eE/T68bfgtTm9JQS4/M8IkWKoP6FAD0M6uxM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whpEV-00BVIl-DS; Thu, 09 Jul 2026 15:56:07 +0200
Date: Thu, 9 Jul 2026 15:56:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	manuelebner@mailbox.org
Subject: Re: [PATCHv2 net-next 7/7] net: usb: usbnet: remove outdated sanity
 check
Message-ID: <94418dce-1b66-4599-8c5f-6a814048427a@lunn.ch>
References: <20260709120116.1423033-1-oneukum@suse.com>
 <20260709120116.1423033-7-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709120116.1423033-7-oneukum@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306262-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:oneukum@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:manuelebner@mailbox.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:from_mime,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim,vger.kernel.org:from_smtp,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D8187320B5

On Thu, Jul 09, 2026 at 02:01:16PM +0200, Oliver Neukum wrote:
> The cdc state is now included as a proper member in the descriptor.
> There is no point in checking whether it fits into the scratchpad
> area. Just remove the check.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

