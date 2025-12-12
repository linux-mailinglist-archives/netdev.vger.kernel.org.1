Return-Path: <netdev+bounces-244452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9075BCB7DBC
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 05:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9D2C3005013
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 04:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406412C11F3;
	Fri, 12 Dec 2025 04:26:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50AA2F2909
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765513588; cv=pass; b=lnW7p4Aoiffk5frnOdISIp/zsG3ehisbFhWkPsJNNLmFNGLTj8UcvMNeb0jpL4jOkMfX0Vn7gJD4M1mBfNWdezelwxLbHQ1RLBZhYvDstPqJPbSsCrY0QsMl0CN1l0HGl2CfEAMki35GPbrgUmqBYq0Y7jmAvecQobDzW6zN1iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765513588; c=relaxed/simple;
	bh=8pkmy2FlWxSygJE1dQiAtceFHABT+5+Jikn/82zUWBA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W0w4JalQyBzKiX7kq56NeDNLWSis2XZjM/pMZkW5CvOFS+MqDTcKcljedM3+9tK+bDkIqRHG7S78bQ/CA9dEOY86mY+6K+BbSaPgEpF7qHcDliYlOcem4Y8pWieLcEfHRnr2Hc9XhhO82JVNX9u+pN49tvDpyKbxqEyVuIulaQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christoph.anton.mitterer.name; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christoph.anton.mitterer.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DCB5F46166D;
	Fri, 12 Dec 2025 04:26:18 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-1.trex.outbound.svc.cluster.local [100.102.46.239])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2E3194611D1
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 04:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1765513578;
	b=3dQdl0LMGm1cdnyxzjGWDhnun3fdrd9szHTKMycY+j5+tIu1WGa518EFruwx55zOl1aK4t
	hx9tkJqIskcRWBg+GgJcqW4LFFwirGl+d3XAExCijoab7jrkto/LYA8LueznSWME26TE2M
	RI8s7Toxbrwqrk8ZYir5xf7pJ96F4nvBdqbsWFaj/0/dG9xysxJ5h6PR00ZaWQRD/dcHgK
	zpWrDW3kcV2shdHXz8aAfk8OXy4bWOhsNQGv4VIy/Q2zjMbCILU9voz8iRtfOOvKaCCgHL
	8aGa3bfMGOC7QIwcCQ+E8DogxLBGLdymunCbCyg/0JTFKC22+FEAgOMoWTVzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1765513578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8pkmy2FlWxSygJE1dQiAtceFHABT+5+Jikn/82zUWBA=;
	b=DfKqzT/03zvaa9lUTywwAD8sYugyLfox4W5EklQ8Vb8BOblTGHVxRQuNX0kAqvXBvApu19
	NHQA8DfoRbbZ2/7sYwocH6XZJ9Shc9RZKK9dRiQg0WviXy8lDKwjNfux+91bsEv4iC4iK/
	w4oCqeI4dyITJGrghcFK8LndNuew+9cZoQ+mBuuMC0Gcma0Y1FAIC9h3jbIgdQoPvTeIwP
	p/io2rhusBRfX0KRRMNo6enX4SnSJ7hREjUPjnLuAtfAM+KK5XBetforqVsdrVlpinKGE1
	Gu8c8knyZ4blUdQde3+Tm+ev42KY42Yxad9sUJEpz8kiAfgdyFqvy27+WfMyow==
ARC-Authentication-Results: i=1;
	rspamd-9c757c4bc-ksz2f;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Battle-Befitting: 1b68fe2714c81dbe_1765513578757_1638524499
X-MC-Loop-Signature: 1765513578757:4273121484
X-MC-Ingress-Time: 1765513578757
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.46.239 (trex/7.1.3);
	Fri, 12 Dec 2025 04:26:18 +0000
Received: from p5090f480.dip0.t-ipconnect.de ([80.144.244.128]:63908 helo=heisenberg.scientia.org)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1vTujR-000000068cH-0uCe
	for netdev@vger.kernel.org;
	Fri, 12 Dec 2025 04:26:16 +0000
Received: by heisenberg.scientia.org (Postfix, from userid 1000)
	id 7422C6213AAA; Fri, 12 Dec 2025 05:26:14 +0100 (CET)
From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
To: netdev@vger.kernel.org
Subject: [PATCH 0/1] lib: Align naming rules with the kernel
Date: Fri, 12 Dec 2025 05:18:12 +0100
Message-ID: <20251212042611.786603-1-mail@christoph.anton.mitterer.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AuthUser: calestyo@scientia.org

Hey.

Seems the check rules in iproute2 have gotten out of sync with those of the
kernel. This patch brings them up-to-date.

It shall be noted, that these changes would also affect those for alnames (like
before, just without enforcing the maximum length, which AFAIU was the main (or
even whole?) point of altnames[0]).


I made a small test and compiled iproute2 with its `check_altifname()` simply
always returning true.
Turnes out, that the kernel seems to accept any name (i.e. including whitespace
and `/`) and I didn’t find any check functions for altnames in the kernel
either (okay I didn’t look that hard ^^).

Not sure, but maybe altnames should really be allowed to contain anything?
If so, we’d of course need to change this patch.
OTOH, e.g. systemd already assumes that certain characters aren’t allowed in
interface names (see `Name=` in systemd.link(5)) and e.g. `nmcli` uses `:` to
separate fields in its machine readable output.

But then again, the kernel should perhaps check altnames?


Cheers,
Chris.

[0] https://lore.kernel.org/netdev/20190719110029.29466-1-jiri@resnulli.us/


