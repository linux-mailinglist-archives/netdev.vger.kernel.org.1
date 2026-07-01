Return-Path: <netdev+bounces-303521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QHlfL8jFRGoH0woAu9opvQ
	(envelope-from <netdev+bounces-303521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:46:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3040B6EAD23
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:46:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cAU5uV7t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303521-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303521-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFE0430DB790
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 07:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494C63BBFBC;
	Wed,  1 Jul 2026 07:39:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244413B4E9F;
	Wed,  1 Jul 2026 07:39:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891545; cv=none; b=CPD+DN62hNhJnX03UsWp66Ic2PO5Qc0N9iBMxuIs65iHWBAoEG5ick9yiHX276XIDlx64SovWJUpCxl4b7M1IJNC+YVbZrW3PaPEhoD4TCIO0HfTicOR/tvLgBFLqgA2sYWTQj8bCwLaGbnnE3qchoaGCoQqhLLpsctol9FVgWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891545; c=relaxed/simple;
	bh=XaX53Po4ovU7ZPzq7QPVyNbQo32xCiYFUNR5s061QE8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=jShWqXnSvZHlCn/8hWofhlds1SJqCTbXFu6Ob0JizRV8ZQvy+curM1b2oheeKK7ZnxX4HRBMSpuiHJxw6qPEkd/itCb0mYb1HJX+fo2zraoW1X9ylIUURWphP6n81Sij7HMmezBx2fyaPY5HcHxJsq85xLAhDLeB/jJBM817rso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAU5uV7t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270391F000E9;
	Wed,  1 Jul 2026 07:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782891543;
	bh=FxIvamBqMlsBi+/SKXVzsQl47j+QQeYfU7+8GoYnQGg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=cAU5uV7tHfUD4td7WzW6SzahXNQ60itbL99iMJxhdna24U4WLd6S7c1p92etgRCBI
	 3BZ+StpTbDDWlHBE9PRIHxB2xBJRXlZnnWutnEwxdNoeuDB/UabooEKnbWNLW12aWV
	 m0082uXFSIcVGL9oyTBzPX22pC+F/mLXViKdRsaiJ5G4W0Gczvi0aL5ct/K4YBPOAq
	 +JfKjr4eEz75j9ZdLhfj5n/iEa9GApBokvCb3Zmc5CDSVDH1P2YfU++NtEneGHRdcF
	 ZbrPduZWB0jCnAHB+P2yjYLTAhHrHZgv2t/8emYqKXtOKRbZRM6JyvGPcsPXl+u0tJ
	 KfN39AxK0Y5Zg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v3 5/5] selftest: Add tests for useful
 handling of LSM denials on SCM_RIGHTS
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1957659940.3537950.1782830112890@kpc.webmail.kpnmail.nl>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
 <20260629194327.2270798-6-jkoolstra@xs4all.nl>
 <20260630071701.6b583d1e@kernel.org>
 <1957659940.3537950.1782830112890@kpc.webmail.kpnmail.nl>
Date: Wed, 01 Jul 2026 09:38:58 +0200
Message-Id: <20260701-malen-gutmachen-stengel-2c70ad5d2971@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XaX53Po4ovU7ZPzq7QPVyNbQo32xCiYFUNR5s061QE8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5HBHZseCnxmzODOetfPIblGoySp7JHFiq4Pkq+dKp6
 Q35ztsvdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykpJfhf9Ff9Unze/s33vth
 8WxeXb78+gxWZyf2mbOqfy4Qsv3hvJjhn8mb8LxHM3ILp1+83hpdbqHdP+1Rybkc9VzGmvrbqWy
 PWAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:kuba@kernel.org,m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303521-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,brauner:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3040B6EAD23

On 2026-06-30 16:35 +0200, Jori Koolstra wrote:
> 
> > Op 30-06-2026 16:17 CEST schreef Jakub Kicinski <kuba@kernel.org>:
> > 
> >  
> > On Mon, 29 Jun 2026 21:43:27 +0200 Jori Koolstra wrote:
> > > The test uses the following Smack labels:
> > > 
> > >    "Sender"   - label for the sending process
> > >    "Receiver" - label for the receiving process
> > >    "SecretX"   - labels for the files being passed
> > 
> > Not sure this test belongs in net/
> > 99.9% of people running this test do not use Smack.
> > At the very least you need to use XFAIL instead of SKIP
> > we use skip for problems with the env which are fixable,
> > like a command missing.
> 
> Ah, right, because you can only use one of these LSMs at a time?
> I mean one of AppArmour, SELinux, Smack, TOMOYO.
> 
> I just need some LSM to trigger the reject of security_file_receive()
> and Smack was the easiest to get going. The series is totally agnostic
> to the used LSM. I am fine with moving the tests elsewhere or porting
> them to SELinux if that is really necessary. We could also drop them
> altogether.
> 
> What do you propose?

I'm pretty sure the easiest will be to use a tiny bpf program to reject
security_file_receive().


