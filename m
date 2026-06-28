Return-Path: <netdev+bounces-302414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WCYqA9OAQWqzrgkAu9opvQ
	(envelope-from <netdev+bounces-302414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 22:15:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFEE6D4DDC
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 22:15:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=1zmYmYSS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302414-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302414-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19B5E3002B74
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 20:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58C83B6BE4;
	Sun, 28 Jun 2026 20:15:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC13B52EF;
	Sun, 28 Jun 2026 20:15:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782677709; cv=none; b=K0/sefeIB2ZU3pCAtLgjo7PMmdiaCdBfk6YungC3Gd3IgJOmUJ6At6s/K3xWGNs88X0pqHypFvjuSWOZ0ayCa3VgwUjNqEQHOMjfcMa4q6tAR0CHS0OAG+9J4HmQXgiziCkwtBWVufyCtUw+rMGpZT+T7rrMIKsYGaTKdY7a0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782677709; c=relaxed/simple;
	bh=cJfm057tqHIFt78HMXnD6ULZrlwea0zk279xkwsY4uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bzn3u23KF+eVAuXXSXuvKqNH7wwszFyZDX1nKoYihcvxuH4sskNbzegPZATLg+41A6I0yx6VZcJ7t5Njn3H+h9eb6ZntPcxfE4g7571A3gND85ucS9AA6K94LBhnAB2rpwslK7T6bM9FGGZVm25SAWhTgK46LFbiS+tS4L1ZScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1zmYmYSS; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=93cNbwIyQUD3lbjk14PcWay9gegKO41oR3z08L7WD0k=; b=1zmYmYSSOqHAfgSCe8dYeoG/Hm
	HcRjQuAW6gwQCDiy8BvL2AZmof1+sJ9G5S01ICsPOxRANpjS0WMln6h/7/x1EecPS9Vd0mXNjbdqx
	tDgeMG7V65wqMtnr+R+5VHHTuSJAjwy2I/QPi0MpHN/TJ2W7l3dAi9jo+ZDpXtkrHw1E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wdvu1-009dyq-Pf; Sun, 28 Jun 2026 22:14:53 +0200
Date: Sun, 28 Jun 2026 22:14:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Poupeau <lucasp.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
	sdf@fomichev.me, brauner@kernel.org, krikku@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sysfs: cleanup coding style
Message-ID: <83dfe4d4-167e-4073-ba05-6ffa299177ee@lunn.ch>
References: <20260628185824.231250-1-lucasp.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628185824.231250-1-lucasp.linux@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-302414-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:lucasp.linux@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:sdf@fomichev.me,m:brauner@kernel.org,m:krikku@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lucasplinux@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEFEE6D4DDC

On Sun, Jun 28, 2026 at 08:58:24PM +0200, Lucas Poupeau wrote:
> Replace DEVICE_ATTR() with DEVICE_ATTR_RW() where applicable to
> follow kernel coding style conventions. Add blank lines between
> function definitions and macro invocations. Fold multi-line
> attribute initializations onto single lines where it improves
> readability without exceeding the line length limit.

When you have a list like this, it means you should have a patch
series, one patch per item on the list.

Please also take a read of

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

