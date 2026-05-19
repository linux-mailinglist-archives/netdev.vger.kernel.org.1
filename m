Return-Path: <netdev+bounces-289590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD+iIEi5DGrdlQUAu9opvQ
	(envelope-from <netdev+bounces-289590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:26:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9DC584224
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 115F9304F326
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194B1377561;
	Tue, 19 May 2026 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="iXjd7okG"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA233E36A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218758; cv=none; b=WZ9kJy1mHwCSmyuNRIYWyJgr2fGL6w3JBOHNj0SsaqDZlLQ1GWPjyEbCFHEUB6yNtUzpKO+7WlrBkCJsMm/oM7ZpdLm7GcfO2Z6j33sy3/8+/cQF7J2BM5u0S0TpnH7wCDyasVtLjsIOLRFRVHYh3i+cEV3k8xcOUmhUj4QTpjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218758; c=relaxed/simple;
	bh=pg2hEA2cAfHS/VAYtF0SbqQ8ZHqEHd2B5ZK9ug+N2Ko=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=FZ+zaqfaeYaE1/EKMFJaYi7FNXEE0kUOFfxSO+iPFQ2DG6Co7j7Dh0HyH7Z0dX/YDOcXpcBGyZubzz2ctAC7dvs/5gdvhf/aG531CRSDUQapJ5UCcxSoABZ+lbeCEdHDgIj3iDeNufTKfjOXE8/xoQOc2lqiT7Qni9Y4MRrihxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=iXjd7okG; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779218736; x=1779823536;
	i=markus.stockhausen@gmx.de;
	bh=H/MBjPjrReLo1m0gfGj19n2AQPWEGxMzuiYO24+DaIk=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iXjd7okG7nYqL3wkxrBKORldNfGhVvg8YbxXVCQLW2d4+ClbpUpMBn4Xf9Ra8IHL
	 x8YBm5uuhCC+1nPHukiZQ8aToW3Fx32A2X8sIv5De7mFii1jiyGyXtNF2gbhokg5/
	 0wSCu5CG667JyQwzzWpuUtPY6Mr5MHCe108jHE4Gy+voEEusSadZ5UdDWa/ZPNgFv
	 RWzXB+nYDSD+TiailnjJ7n8EXyM4PgOvJcQeuJu741ZOSddV1jCxOfnIn/jDt1b2s
	 XBSStea7VejHaPSB4qWxbHT/IwS7XPimRuLKVQIW4kD1D7xq+EWwDptFyUhs7My5u
	 H+BRTa13UQxdN+aBXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1wvAzM3Hci-00lGyT; Tue, 19
 May 2026 21:25:36 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de> <20260519165747.1288903-10-markus.stockhausen@gmx.de> <e4a1cd96-ff7a-49e7-add1-353a24b9aa08@lunn.ch>
In-Reply-To: <e4a1cd96-ff7a-49e7-add1-353a24b9aa08@lunn.ch>
Subject: AW: [PATCH 9/9] net: mdio: realtek-rtl9300: Link I/O functions in info structure
Date: Tue, 19 May 2026 21:25:30 +0200
Message-ID: <021a01dce7c5$450cc2b0$cf264810$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGwSt0WOf381P4OW8TiHCSlUsVjdQJgmcywAlNqeNq2SU/L4A==
Content-Language: de
X-Provags-ID: V03:K1:sGwj+mVObvRKeqAWWiWRA9/qiLMO5Gle3JX3rWeyvRKImwUYb4p
 ACLYzOvanek5mIY9xffi1pJ3EO7zNhj20Z9ucGJhOEIGcAoBr+ILVEvhuruOzkLe0PkAlPp
 XfTORg68WvGi9DGqtfUGUxD57yxtmC24ymA7OgHZTb629N8SMvp7BPR6jWccDx+LgSFJ1Is
 /fuSoDLpZmKxbfjwG+XdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cj7EzP3p1xo=;hEaxVoMN8p2q3FeY4zVuUsBnt5Q
 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
 rdWYSmtcpAKlzR6gGsJERoaMkGU=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289590-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmx.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmx.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: 2C9DC584224
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Dienstag, 19. Mai 2026 20:46
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH 9/9] net: mdio: realtek-rtl9300: Link I/O functions =
in
info structure
>
> On Tue, May 19, 2026 at 06:57:47PM +0200, Markus Stockhausen wrote:
> > All SOCs have slightly different I/O functions. Make them device
> > specific by adding the functions into the info structure.
>
> If they are all different, why put all the registers into info?  Is
> there some level of sharing?

Patch 5 tries to explain the sharing concept:

- A generic access function will always run the same way
- The info structure tells it where to write (registers)
- The indidivual access function tells it what to write (data)=20

Markus


