Return-Path: <netdev+bounces-306257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xVNRM2muT2q1mgIAu9opvQ
	(envelope-from <netdev+bounces-306257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:21:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DCC732264
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:21:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=rsYXgrIk;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306257-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306257-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D2493074233
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48C642980C;
	Thu,  9 Jul 2026 13:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1942848F;
	Thu,  9 Jul 2026 13:50:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605026; cv=none; b=fXu0ey+ywKEyrW1fslJ0GdtvIwYyzE/TK2C+ny0nF8rcGGLml/NdBv6uj+uncxPRwKsko1FkwInxSYBgwpM2LTQP8y73hCS/FGd0db6Kq8JgqSy+1Y0Tn01OaQZjDJTpTEa3bjxIC0FmeQjMnGkIL7Dv1b7mTjY97OfummA0GSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605026; c=relaxed/simple;
	bh=xyTvNOaCsBw/CL10SIzB7HEGTW0o9ceXYVHnd5cHUBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzfWhdb/aYR9jaXPlNhERjZDx8u2dOJPF60nBfo6bfJjg2IZAi8/0GMAobKeeJwiuYtaspaH2LuloLScjTQ+pGnyUq7ScTx588jkN+E9nzSQJLvEAbCDJeEsPv5LHCKFWmZAx1hBNK01SvTIMtGHtBQTYV/HDPNac30YZmQrAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rsYXgrIk; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6Wcg+ldBwl6wwvVGYpvQMns6Q/59ECPDO4bDoPMkTQA=; b=rsYXgrIklt/SYzerXvsOuBnKnx
	zVCwEz6yM5lwS8UxGX5oxalaY8N4RuMIdsCWayBC+XRVPj17c28AkyWnogelkD6UaQRaVAi8RVBD0
	LMbzgmXE0aTbftPUbVVkul/+y63TLy4pZtSdkq6upQfgi13Fw434iXufPEMDu5QL5M90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whp8r-00BVEG-NC; Thu, 09 Jul 2026 15:50:17 +0200
Date: Thu, 9 Jul 2026 15:50:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	manuelebner@mailbox.org
Subject: Re: [PATCHv2 net-next 4/7] net: usb: int51x1: drop dependency on
 cdc_ether
Message-ID: <b29a4235-6f6f-4909-820d-93da9b28cb64@lunn.ch>
References: <20260709120116.1423033-1-oneukum@suse.com>
 <20260709120116.1423033-4-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709120116.1423033-4-oneukum@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306257-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:from_mime,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20DCC732264

On Thu, Jul 09, 2026 at 02:01:13PM +0200, Oliver Neukum wrote:
> The driver depended on cdc_ether only for usbnet_cdc_update_filter().
> This has been shifted to usbnet. Drop the dependency.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

