Return-Path: <netdev+bounces-303192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oGEpNI7JQ2q4hwoAu9opvQ
	(envelope-from <netdev+bounces-303192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:50:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4266E50AB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:50:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=D0LTzYUY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303192-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303192-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A43A30785A3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89709334692;
	Tue, 30 Jun 2026 13:48:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66E2F549F;
	Tue, 30 Jun 2026 13:48:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827313; cv=none; b=OO32DOhX0IrNTP1qzD5m7dmGc0nQ/zDnFZqGrxawikXgxiPhOM6ipsTgI5Wm+yH/Jv4nwSOuOmEOmMLnGmYsoPbFCuoXX+MYcIFXap7ve2RKUcP6YRgcbQS0oSl2Sp3Lxb3R/406Pjk7pBteodUWEhWKKFj4K9ClJCDBro+i1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827313; c=relaxed/simple;
	bh=TonebF7Ag32GOyOJMqqlwc8e8lXlquoAPTTINlV2joc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbVRethvFU2CfHe37nB/lq94QgbQArrz8b494eojdCVhJZEK+px4k5/sf0WNhL0xLDR/iQANLIKcl+wM072RQK+FnmvKJlVUxs2iUwfpQeF1XkBdVUPOVcpYlUs/oJARckgjjl/hlBP+gkwybMKQKCTASBljaCA6Q+O5B2RIuiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D0LTzYUY; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/wA5uNWt6gB7JZ5iwu/IO6wZKMVB6pWC14dthf5YOGA=; b=D0LTzYUYJSQhbOHlkEmQgOV1Pr
	rFAitysvqjixjc/kDLrZXlv16PJ7VZwrjSPFeycp5i2syZJwkCsmeuPAknZFP/nK6T827x/e5WKsy
	GvD3efgA2XwrWhtWRz+kl63THBUOoX3TEJQbMDywpcoySg4Pdpv32s537s3LWSlQm+zg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weYot-009z3M-FY; Tue, 30 Jun 2026 15:48:11 +0200
Date: Tue, 30 Jun 2026 15:48:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v4] net: usb: rtl8150: handle link status read
 failures
Message-ID: <355409c6-0b52-4dd5-9b0f-bdb72159ade4@lunn.ch>
References: <20260630101216.10365-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630101216.10365-1-alhouseenyousef@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303192-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:petkan@nucleusys.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzkaller.appspot.com:url,nucleusys.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F4266E50AB

On Tue, Jun 30, 2026 at 12:12:16PM +0200, Yousef Alhouseen wrote:
> set_carrier() ignores the result of the USB control transfer and tests
> the stack variable supplied as its receive buffer. If the device rejects
> or aborts the request, that variable remains uninitialized and the driver
> chooses an arbitrary carrier state.
> 
> Leave the existing carrier state unchanged when the link status cannot be
> read. A transient USB error should not be treated as link loss.
> 
> Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
> Suggested-by: Petko Manolov <petkan@nucleusys.com>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

