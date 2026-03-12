Return-Path: <netdev+bounces-266963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OS2KSKKsmneNQAAu9opvQ
	(envelope-from <netdev+bounces-266963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:40:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0026FBEC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E38B53017796
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80369387367;
	Thu, 12 Mar 2026 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kBHKPxkT"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47919EED3;
	Thu, 12 Mar 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308443; cv=none; b=kjKL34B54QxZ+V7Gqy3G1IFvJ/ula4VTenOWdyvLB/5qCv8xmp3myCq4jd5cPZoktktr9I2QnQ0RMYDuc3WroovrCp0Twq/lXjv/ZnN/39bK+Q7vWhsC0ot+ptZ74TP/D9VIoZN2vaKlsaPCticU4S/Q//jJwbtwxmJyVPIigrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308443; c=relaxed/simple;
	bh=9AHum3gpR+3YNNMJecWJb7TEqvi5Ld5xBEzm1+lPvm0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KvLMBea0yqNAMFTQWHc0WkByHf/NfJ495ITsz1j3ifLc+Sf3876E+WpUE1RWVVSYpjdi34HdS82t+RG+qY9lL3cTHGQsqsyaoiwWpmSMD5fA1/xkAWQF92MogfSYi0wEBWUGMKb4q3BMYjTLQgkdfELZa2NWlrJ+0RviIh0pGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kBHKPxkT; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773308419; x=1773913219; i=markus.elfring@web.de;
	bh=9AHum3gpR+3YNNMJecWJb7TEqvi5Ld5xBEzm1+lPvm0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kBHKPxkTfFBj4yBccRF78U4++HzHDm+mm048hLsKYubOXruH8j/WVwplP+N70HxO
	 fQtuJbhubGrSYts9KidqsooGOHkFrOg1fX5aajvcsbnrX0H0tQRKlvKCO4x/xC3Wg
	 BZNfoCCRisfT5uofTC9GtDfHyUd3WeVFm8T9m01To2TTLIl4cTPfLoFlK2/UHI9jo
	 1MUmSH2caxmxo0LdmHoAUMpL9toj4v6LIYTtLKTe/S7GyBvZd/Ce7sHM05lga3pT7
	 JMb2ubWeEqtGsEZOQOSMqXPu9/Px40HLtJl9kggDQLyOr142YZQz4xgW1OVuuvAfp
	 p0+HGZSLZtorCbg1uQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOm0r-1wGvQi1slj-00L4Zx; Thu, 12
 Mar 2026 10:40:19 +0100
Message-ID: <fa8a6d12-b292-4cb3-98b1-bd32aa45864e@web.de>
Date: Thu, 12 Mar 2026 10:40:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260312084612.1469853-1-oneukum@suse.com>
Subject: Re: [PATCH v2 net-next] net: usb: cdc-ether: unify error handling in
 probe
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260312084612.1469853-1-oneukum@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QgdERwvsGc6c890IgmWa79luGZOtwk8vwNyDPNSbi5EIMbt1jb3
 8n+iNVpKor+myP8MH0pAf4q14pAysTLCITf2SLMTqEux8qs444cZ7IE5PTPHsMqlC/vz114
 WW9UETkkmj0aGDJuEKE9/r8RA4pWrwzH0yFGbXW0v0t7upmHnP4LgBtaGKWuDKNuF2OBZn5
 tbcz7rkWTyJQfaAKcJdAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N4fJCQVLUPA=;CQxQtgs/yAnQandMwlbZF1Oa9NT
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266963-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4A0026FBEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> usbnet_generic_cdc_bind() is duplicating the error handling
> multiple times. That is bad. Unify it with jumps.

I find such a change description improvable another bit.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.0-rc3#n659


> V2: Update error logging with every cause a unique message

Please move patch version descriptions behind the marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.0-rc3#n785

Regards,
Markus

