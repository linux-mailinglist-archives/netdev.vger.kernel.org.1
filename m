Return-Path: <netdev+bounces-295620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FE40EQtLImolUwEAu9opvQ
	(envelope-from <netdev+bounces-295620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 06:05:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D34D644FF2
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 06:05:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=jg2ynLis;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295620-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295620-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F5683013ABE
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 04:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448BA2DD5E2;
	Fri,  5 Jun 2026 04:04:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C831B6D08;
	Fri,  5 Jun 2026 04:03:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632241; cv=none; b=T36ecpkMvmeW7/uynuqwsVAt1B/eg9u6880K3Ftd3gxI/xPRkcZxPyC5A2oeh/7NnqPgXuGjVeSMh1FCmc4oxAcust229EKDi5adJQhC965H4X7YOxQfFDmGOYDzuyOg5XFuBhffqiAawARK4ixVbo2HpGcm3BrvJZMsw79ZVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632241; c=relaxed/simple;
	bh=Whx3sQMluE7DMB1qNGQ21AhcBh59lFH3V5pYzvSSqug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBtbfqoHKKJcY4la9nfrnfs3Ruei/2Hrn5y/mnsVYtYSslQR+R8uSPFDWEmfMIUiZd5yHw3EST1FD3juvJGygLupQIcP146j7HEDHW/1FqLHqMuK1bmIvdDMrIPbL4x6jzYkjNaercJ5CO6YD7Ayk1llSJ/xLkhJ78/qf14KtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jg2ynLis; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bANUXCFrVrCd6bLm0zhgtB0sbNZmZO2gt3veZW1sXN8=; b=jg2ynLisWZx8nDLiGgvYQezxur
	akoS4KpVri/A698HWbLtW8MGT55C18zsjT10rCEaNkSF7z9us558lmq0XpEFRb6n56vFk/xqi/K8r
	LgpwlFWh1Y0cux3GTMzkNo5TQyu/a/FpDHdMGeGpLxE8UAb7dDecwWyvqx0COxpAFMhA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVLmj-006AQk-EP; Fri, 05 Jun 2026 06:03:53 +0200
Date: Fri, 5 Jun 2026 06:03:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net] r8152: handle the return value of usb_reset_device()
Message-ID: <3e108daa-7913-4890-8331-9761a4654b1f@lunn.ch>
References: <20260604092247.27158-450-nic_swsd@realtek.com>
 <c1ddf8f3-71f7-434c-ad10-64096b65fe51@lunn.ch>
 <ce2651bf86fc401b9e1e7cc29b5a6c22@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2651bf86fc401b9e1e7cc29b5a6c22@realtek.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295620-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:nic_swsd@realtek.com,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D34D644FF2

On Fri, Jun 05, 2026 at 02:42:34AM +0000, Chih Kai Hsu wrote:
> On 04/06/26 8:54 pm, Andrew Lunn wrote:
> 
> > On Thu, Jun 04, 2026 at 05:22:47PM +0800, Chih Kai Hsu wrote:
> > > If usb_reset_device() returns a negative error code, stop the process
> > > of probing.
> > >
> > > Fixes: 10c3271712f5 ("r8152: disable the ECM mode")
> > 
> > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > 
> > Does this bother people?
> Yes, it does.
> If the driver does not return early when receiving an error code from usb_reset_device(),
> the subsequent execution will trigger a kernel call trace.

Please include a link to such a bug report, kernel call trace etc, to
to show it bothers somebody. Do you have the hardware and can trigger
this?

	Andrew

