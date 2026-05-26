Return-Path: <netdev+bounces-291684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KlhBxmUFWpSWgcAu9opvQ
	(envelope-from <netdev+bounces-291684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:37:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6982A5D5A5C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C20B301DAC6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB913F9F37;
	Tue, 26 May 2026 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="ZfBnmjMI"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C463DA7C8;
	Tue, 26 May 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798981; cv=none; b=oI3c7N+2Dd01sHT5D3Hlo+yRrQmy4P/ZDtuFVbMrAsivSJvYOprmrBSmBqUMRLPDjdBg+mfPw36/Vuxb2k03lakjziQkmgx+gsjlhMTcKoihzN2nDXuOe0knkRaH/1Bz3m1n2eKYTgiGEZaDFkpLTre5MKDnHAfl0cyghC+0hNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798981; c=relaxed/simple;
	bh=l6UgDq/qGUzQevbylUN3LrhKWKPuYHQqTL3MKUb4VqI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JNZSRL8pxxQoV1yiW9ekmnEdoEvk9P3pS0dLyCxgFgv4BXbyxuGZyXw0NDs7NUAGNLGLlpM1HMor5y4Yxj6ormnCoqpOLzupL/QO303prEqy/lMyn5m7rGwy+K1wnB70BEt9S1g9SkN5D0wT9MdjJPJJqI+Kp4ma6KNIQJwcYf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=ZfBnmjMI; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64QCZj6Q002441
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 May 2026 13:35:48 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64QCZj6Q002441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779798951; bh=l6UgDq/qGUzQevbylUN3LrhKWKPuYHQqTL3MKUb4VqI=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=ZfBnmjMI68R+GwIC36l15gPHmiL2d5+X42cuPjVlTZrB1gGsn+Bac5JCGdHP7ZH3q
	 j3JROPQ5n+MzUt4KR2y9zh14g1XU3PdUFVng2EhJrG2XN4P6g7c4Onj5vtl4qpZSFc
	 IEX9kIZXgIjE2rDAurTGMnP7Pz/4v0iXQ64Fo3MQD2KgcjzIvspLnvmEU1JCjG9VP8
	 KWgUTWnJSVK6QbwjPkqs154t2o6+rRONqtOI4rHbBdjlsfI7cis6B1qn9j9RcaZFQG
	 fFYlYYa6pCwmg4XVmmk63fe4BoXPA1AhchOVbZrxWGz9uxF67vDOPFOBEA8wxqKi3q
	 71e7BjbRl+RSQ==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <PR3P194MB1505960E42BBFB9AD9E8B18DEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
Date: Tue, 26 May 2026 22:35:34 +1000
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kieran Tyrrell <kieran@sienda.com>, Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA812A81-2ED2-475E-886A-197D03C332F4@padl.com>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
 <PR3P194MB1505960E42BBFB9AD9E8B18DEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
To: Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291684-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,sienda.com,huntershome.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: 6982A5D5A5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> I've looked at these patches before starting. I quickly ran into the =
limitation the driver only supports 3 traffic classes. I want to be able =
to send traffic from the cpu to other queues too.

Yes, fair point, a compromise because our goal was to support offloaded =
switching of SRP-managed AVB streams. Only the 6390 family of Marvell =
switch chips support CBS with more than two queues (the third being =
legacy).

> I'm trying to upstream changes one topic at a time. Eg. this CBS patch =
is only for configuring the shaper. How traffic ends up in a certain =
queue is not relevant for this patch.

Right, we did it in the reverse order (MQPRIO then CBS, as separate =
commits but in the same patch series).

Now I have a solution for flagging SRP-managed MDB entries, I should be =
in a position to resubmit the patch set after regression testing. One =
thing have incorporated from your patch is dynamically enabling strict =
priority scheduling (thank you).=

