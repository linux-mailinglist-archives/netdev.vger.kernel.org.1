Return-Path: <netdev+bounces-299968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /UkMG2XHMWoPqAUAu9opvQ
	(envelope-from <netdev+bounces-299968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:00:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3614695818
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:00:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=2U4caDUx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299968-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299968-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 147783156D91
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7778A3AA1BA;
	Tue, 16 Jun 2026 22:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01138C427
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 21:59:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647201; cv=none; b=tkXzySvTxT6xgl6CoVAgNE3gtdWelPzn+EQYleWYBX+O6WNfv1mNYQ+tg35w7hMzxmal7JLq7g1eW/yNj20Rd0yDBYGQr3s/c0IXz9X0LcFaX4Bd0zhRfOX3KLOY4hOMO7DdslaDQ0iUBlYTclpWL1lvGfraCqCbV0jL33bzlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647201; c=relaxed/simple;
	bh=PCSVkWb9evagpAo7A/b0nKVdvhkhvdTJAPdD598sx00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0lU30W4MHefbcAfd1I+tBtk8K+8FwoCYEJBcE0eDOU8bUxlDEYytiMVvlqvGkQ12U/+yzoRBmSDH1NOXyf+i8RyNw7I+Bj7mfbnxHpIbNxKYxSj7qNOL7Pj6kL7bgKMx8cepQXlR6kMdETa6C28jt/0bq/cv+4K2caqIUt7MUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2U4caDUx; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yn4JTONkucNpp7G5/eQyLNtOYAjCl76BiAINMQrjBJw=; b=2U4caDUxztGMOCq6pv1Xs7gM/H
	E6QBytWGgAUz1XgI6p2uVi2GfwWFOCLKay67naLp6JV9n3LPpTwD8xMzGYvpDtSUINmqUqC7L7YzN
	qYgBlgEvLhbyiRNPnoVp9d8UFR1T7izBq3HMwdiviHdvTsm0EHkVd+0D4mVEcFADq5u4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZboy-0082AE-6c; Tue, 16 Jun 2026 23:59:48 +0200
Date: Tue, 16 Jun 2026 23:59:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] e1000e: Report link down after "Detected
 Hardware Unit Hang" ?
Message-ID: <d86c0dd8-8bd8-495a-b750-2a0036fbbee4@lunn.ch>
References: <ai8hmGQmXQu64Ld3@carbonx1>
 <e78576e0-9b55-446f-9d10-da3b7aec9b31@lunn.ch>
 <9d80ed59-5483-4c33-9d27-52fdf24aac6e@gmx.de>
 <51828156-e859-44db-9926-c076796d0f75@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51828156-e859-44db-9926-c076796d0f75@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299968-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:dima.ruinskiy@intel.com,m:deller@gmx.de,m:deller@kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,intel.com,lists.osuosl.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3614695818

> This does not seem like the right direction to me.
> 
> The "Detected Hardware Unit Hang" print does not indicate that the interface
> is dead, but that the transmitter is stalled.
> 
> This can be due to an unusually high load, or a HW fault / race condition
> with another component, etc.
> 
> When a hang is detected, the transmitter is stopped with netif_stop_queue()
> and eventually ndo_tx_timeout triggers a full reset to the device, which in
> many cases recovers it from the hang.

Does a full reset cause the link to be negotiated again? If so, there
is no harm in setting the carrier down. If the reset is successful,
the carrier will be restored. However, if the reset does not recover
the system, does the carrier say down?

    Andrew


