Return-Path: <netdev+bounces-306261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xYqtBFOsT2oUmgIAu9opvQ
	(envelope-from <netdev+bounces-306261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:12:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C36073209C
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:12:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=2padB9HP;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306261-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306261-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C193132C314A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3693242BE;
	Thu,  9 Jul 2026 13:55:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3223392C;
	Thu,  9 Jul 2026 13:55:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605349; cv=none; b=EkTlMvHzFStPiPJ7eFtuG2/DvdYHq8F9GtQurrJsUwfuy0gyC0DEOuhcJrSD3scoinYEaMnuB4yVapLtUMDpqo0BF80PcvdZVss0J6Emc5RKLS42fxKvJlsl4y4kmkM8hOkdhZDTiq7Du4/WSbyh4xwQLXFdz2wnVztgtqtZSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605349; c=relaxed/simple;
	bh=wVw6UZpVS4t4a78wjps4yVjYC4L+UDlxnk9elE542J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc4amRSi2fdoeXSQNvYycvoGdJhltlJBUY3UpfAjEL5R8F8WAZI1DtL1Mrvbxtgo3YzqhpHQkVuqiUckg+eHtPBGmqKTcHy50Z7ynM40H2sD2gFx4yJLsujIb3oa2zwuary2Iu23lmf6VYSnmwoFraVjoubo+ARxOUWS9ztrJN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2padB9HP; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MucB5CKGfjv4+GOLi7wkC9IaakOiVHgho3CeIBu+2T4=; b=2padB9HP8PWde2UbF1S2MK2wr8
	RZhpvyfCBskJhqMfJ6EgJXCWchTJuTwInoPobCQZ5MNzbsWAbezsi+MRUZLICzbA1kQwb5bO4QB++
	+UIaFtrnJDk4wvdEu3Eoosyqg7biC3NPtNFaaM2p0qDPfWcPbpw57dMuqy69M4KEGZFw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whpE1-00BVI5-F9; Thu, 09 Jul 2026 15:55:37 +0200
Date: Thu, 9 Jul 2026 15:55:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Oliver Neukum <oneukum@suse.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net-next 1/7] net: usb: centralize
 usbnet_cdc_zte_rx_fixup in usbnet
Message-ID: <e136d383-7593-431e-ad8e-ad85a9af0f8c@lunn.ch>
References: <20260709120116.1423033-1-oneukum@suse.com>
 <0a0721d511c10414cb6a6e53f1bb33698ada963e.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0721d511c10414cb6a6e53f1bb33698ada963e.camel@mailbox.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306261-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:manuelebner@mailbox.org,m:oneukum@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C36073209C

On Thu, Jul 09, 2026 at 02:37:32PM +0200, Manuel Ebner wrote:
> On Thu, 2026-07-09 at 14:01 +0200, Oliver Neukum wrote:
> 
> I guess a couple suggestions got lost, that's ok.

This patch is a pure move code around patch. It is bad practice to
make changes while moving code, since that needs a different sort of
review.

If the comments are to be improved, that should be in a separate
patch.

	Andrew

