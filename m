Return-Path: <netdev+bounces-297836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XvhnAt7IKWohdQMAu9opvQ
	(envelope-from <netdev+bounces-297836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:28:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F46366CC94
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:28:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="gJ 66Zm6";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297836-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297836-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC9253008C33
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F547D937;
	Wed, 10 Jun 2026 20:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7223546FE;
	Wed, 10 Jun 2026 20:28:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123291; cv=none; b=agwSP9XAV/2A2IU/ZuEunCDFPQigYdW2KzIlbIaBqIFhzzkdtFgrikaZKnnTRvbudlAIK7IxKCwfldiL/16PqGVT7CWuEN96KejJXDSqrK0FhYT0Q/wxi9eE4mkcs8YTcw50oub8Uwb3NLtk5FbISgtf1+JRNrGJ6jUOzXXwBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123291; c=relaxed/simple;
	bh=s8PLSTWqayI2a24VIoGdE8eYoVMdHPP9Vz7IaoHuIHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw4xRi1hGFFf8dbD5Y8oSsEGWTcJQoa2pdELZQVu18bpiFazcFEK2KX/15ZcvE4Nkjk21Z2yik2cAh/jNENkNszupw8n4VC8EKAq5fC0XD4/MLZVpSSf21qP/fiYmHgueA4HYKGILwzrgL5nfzkF5FIyq144v8tSob7F801zBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gJ66Zm61; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=gTZRVG2MQu2TxnmalgtedlBp1TY5xnipy0GHzJFdNAw=; b=gJ
	66Zm61a4TvqRNNULPTFxRoOwyYXIOrEqG8p1QSE4W93w9zHnn1q3Y0Ra1oh4olazY/ULYbh3x46na
	Lk+5NXlR3PsBSKbPG7JqwNkjtNzxRvcenqL5f0hbdO3OYtEDdBCfpVXNAqBghopqdnYtdRNGSd5iL
	6rqV8HmlKJAo6Gs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXPWt-00733h-14; Wed, 10 Jun 2026 22:28:03 +0200
Date: Wed, 10 Jun 2026 22:28:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: loop: Fix devlink resource ID
Message-ID: <2c8baa5d-32c2-44fc-9075-27da9d6b4c7a@lunn.ch>
References: <20260610062554.769892-1-mmyangfl@gmail.com>
 <53211107-5f22-4ea6-8374-b70317b9b2cb@lunn.ch>
 <CAAXyoMNjX5rMpcj2N-WTkUD871tp0-2ceaOzMmUdwWSSGG6J4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMNjX5rMpcj2N-WTkUD871tp0-2ceaOzMmUdwWSSGG6J4g@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297836-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F46366CC94

On Wed, Jun 10, 2026 at 09:36:59PM +0800, David Yang wrote:
> On Wed, Jun 10, 2026 at 3:23 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Wed, Jun 10, 2026 at 02:25:45PM +0800, David Yang wrote:
> > > Fix collision with DEVLINK_RESOURCE_ID_PARENT_TOP (0) by keeping the
> > > real resource IDs in enum dsa_loop_devlink_resource_id starting at 1.
> >
> > Please could you expand on this. What is actually wrong here?
> >
> > When i look at mv88e6xxx, hellcreak and b53 it does the same.
> >
> >      Andrew
> 
> dsa_devlink_resource_register() is, but other users of
> devl_resource_register() (mlxsw and netdevsim) avoid 0 explicitly.
> 
> In this case for dsa_loop, the usage is semantically questionable (0
> being its own parent) but might just work as well. But it is a real
> problem on mv88e6xxx, where ATU_bin_* are in fact registered as
> top-level siblings, not as children of ATU, due to ATU ID colliding
> with PARENT_TOP.

So please produce a patchset fixing all users of
devl_resource_register() which pass 0. And then maybe add WARN_ON()?

    Andrew

---
pw-bot: cr

