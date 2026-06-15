Return-Path: <netdev+bounces-299543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vt8iAxYxMGraPgUAu9opvQ
	(envelope-from <netdev+bounces-299543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:06:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC09688AD0
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:06:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kXE4LLhy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299543-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299543-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AEDD3030B7B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A6E40FDA4;
	Mon, 15 Jun 2026 16:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00440F8C5;
	Mon, 15 Jun 2026 16:54:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542444; cv=none; b=fcAdwTdfKC68EPphqiJPjyQQAMA0mH7TF3nRT9fqnAdsEiaEyi1y99ctc50JCe5ngVsTcC1ueIC8n8XDxDhUA7kRF972Y0QN1LMVnzZalSlzrsitS7QQf21KPfFRqw+LB2mnTvu9lzTW0AU8JMLrbAi7hS6H4OF/kGp+Tijsbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542444; c=relaxed/simple;
	bh=uaptR4eB/ksjA8/Crygio18xgxXnoIhbgU+ERQEvnRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9xADFLjzU/o7OPP7SGHEuB40OMFTS6cI11oeUWBxE0MnzwCmc0RmjVFMWc633UpbqZNi13mpLn8xT3d6/DzzpTHY+Ft4hPv9+7jRWYfIJjT/QJCn6DJ032Fq1HD7MIP/yMHBdmTqsyfSV5/ycgsZaH4ta/21ddfmf71hm4luOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXE4LLhy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B1E1F000E9;
	Mon, 15 Jun 2026 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542443;
	bh=c7VLpTjiJlPakzgidAeJWFZIvAEOGJqmv9AoRpZJbBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kXE4LLhyWtex2w1o3Y41tplzjao1nvvTI72/KjlE6bHni7vXnToVnpVilqYDDx8F4
	 L+CY8m29jNCP+2TAEmeAcbJZQyjts64yCdPMC5oHJI0xqJgRxgViiDvmEv0lyRNSML
	 eJjEAGI0qEkjRFO3Ic8FammvCBS2lM+6EjpnqlnMJO9sO9A7KhnV3QbYmQqh1bJGVg
	 iubgo3QFBIFUWHP32XZZYDMgqP4lc6dlLJ3tKbUMfIDLr3GM6ytmqMg8857MzNWQ59
	 khaT+5Rt086Klxfy76Hs/mGc6S0WBXcULigcTPOgU9Y7DtiCCyelmKQ5lvHCZUsR6q
	 2JoyeCW/NvVfw==
Date: Mon, 15 Jun 2026 09:54:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
Cc: Cedric Jehasse via B4 Relay
 <devnull+cedric.jehasse.luminex.be@kernel.org>, cedric.jehasse@luminex.be,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v7 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <20260615095401.4be9706c@kernel.org>
In-Reply-To: <4dvydmir7hw4zhfrxonjuu4l7as6hma5yg4iuv3vgoqed7zai6@knkmyvh4sa54>
References: <20260609-net-next-mv88e6xxx-cbs-v7-0-7d5d732df545@luminex.be>
	<20260609-net-next-mv88e6xxx-cbs-v7-2-7d5d732df545@luminex.be>
	<20260612153656.4c5b8c62@kernel.org>
	<4dvydmir7hw4zhfrxonjuu4l7as6hma5yg4iuv3vgoqed7zai6@knkmyvh4sa54>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-299543-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cedric.jehasse@gmail.com,m:devnull+cedric.jehasse.luminex.be@kernel.org,m:cedric.jehasse@luminex.be,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:kabel@kernel.org,m:cedricjehasse@gmail.com,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org,padl.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cedric.jehasse.luminex.be];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDC09688AD0

On Mon, 15 Jun 2026 16:29:34 +0200 Cedric Jehasse wrote:
> > > +static int mv88e6xxx_setup_tc_cbs(struct dsa_switch *ds, int port,
> > > +				  struct tc_cbs_qopt_offload *cbs)  
> > 
> > please stick an extack into struct tc_cbs_qopt_offload and use it to
> > report the reason for rejection back to the user
> 
> Do you mean modifying cbs_enable_offload to report a driver specified reason isof
> reportig the generic "Specified device failed to setup cbs hardware offload"?
> What should be done for other drivers who handle TC_SETUP_QDISC_CBS, but don't
> fill in extack? Should cbs_enable_offload fill in extack with "Specified device
> failed to setup cbs hardware offload"?

There's a "weak" version of the extack-setting macro which you can use
to avoid overriding the driver-specified message. With that you should
be able to set the generic error for existing switches while allowing
your driver to provide more specific reason.

BTW please note that net-next is now closed for the duration of the
merge window.

