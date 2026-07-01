Return-Path: <netdev+bounces-303809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XqGOEaBqRWpt/goAu9opvQ
	(envelope-from <netdev+bounces-303809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:29:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F17A6F0DB3
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:29:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=G9BcdIwD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303809-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303809-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AADAC3011C59
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 19:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817544BC034;
	Wed,  1 Jul 2026 19:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E1360ECD;
	Wed,  1 Jul 2026 19:29:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934173; cv=none; b=DRAlePkWxxZLTW1tJeQceiML1WpuJNE16E9P0dALExCqTJkCjWZUoVP+ZnZvV4QBS9CYzdSCVwHhtbw2C7qDEKnz8b0P6LQ4B+3fwvNiyAaHuClkvuk+RBaUHQZBcbf/x8m3UiVdMK1N19Yq6sOyqPPxaQmdVih4pgxMwY4PnKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934173; c=relaxed/simple;
	bh=kHVC/vtNwrT1HqBTKmwYI61YVPu6xaxQ45SQLFsaBbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUVczvS9pQu5sjdYbaURf2S978iErqVzeSgMXZB1N5dxzTFEzTah46hj8T/zkKjQEFE2dSzDvQgE6wNXH88/54VlP8zhiAaYJHxgjdYwR1N+Is8/vvy+jAcUQ6rTjhLpCCi8tCRQCgNha/JY+P6OCzDqrv5J36qu4rI8fF1zkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G9BcdIwD; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tNT+14cbVtp0W75j5lih7s5tZTzgV8pvNl9tFErCdQg=; b=G9BcdIwDOCVOpsy9xMSd1pFwwB
	dKHoJbW7ECmyvSn1eJtaMNhfRqi9aW7L+VDQBdgXSr2g9Dvjek2PmXObN3CfzCJ8V2hVZQNJXnXXI
	2dx5AdwySFMjWYzAVNxulHpifAEaClfBAlC6imffaoPPWdUKFWwLaVT48XFm+jPWNPo8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wf0ca-00AEME-11; Wed, 01 Jul 2026 21:29:20 +0200
Date: Wed, 1 Jul 2026 21:29:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, hsu.chih.kai@realtek.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, olek2@wp.pl,
	pabeni@redhat.com
Subject: Re: RTL8159 firmware
Message-ID: <8f349e00-1710-428d-8c70-5d1b1f4d42f3@lunn.ch>
References: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
 <20260701171327.2916132-1-kernel@jfarr.cc>
 <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303809-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:mail@birger-koblitz.de,m:kernel@jfarr.cc,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:olek2@wp.pl,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[jfarr.cc,lunn.ch,davemloft.net,google.com,realtek.com,kernel.org,vger.kernel.org,wp.pl,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gitlab.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F17A6F0DB3

On Wed, Jul 01, 2026 at 07:24:13PM +0200, Birger Koblitz wrote:
> Hi Jan,
> 
> On 7/1/26 19:13, Jan Hendrik Farr wrote:
> > Hi Birger,
> > 
> > it looks like the firmware file rtl_nic/rtl8159-1.fw isn't in linux-firmware yet.
> > Could you send it for people to potentially test?
> > 
> > Jan
> > 
> The code to create the binary firmware file is at:
> https://gitlab.com/koblitz-rtlnic/rtlnic_fw
> But I cannot submit the firmware itself to linux-firmware, as the sourcecode from
> which the binary data is extracted is published by Realtek under the GPL.

The obvious work around is to not convert it to binary.

8152.c has a clear GPL-2.0 header. So you can edit that file, extract
the two arrays, and it would still be GPL. You can make the firmware
loader in the driver parse the ASCII array as it is. It also looks
like you can .xz or .zst compress it, and the kernel
_request_firmware() will handle the decompression for you.

Just clearly document what you have done, and i think you are O.K. But
IANAL.

	Andrew

