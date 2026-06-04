Return-Path: <netdev+bounces-295229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ga4RNDBzIWqGGgEAu9opvQ
	(envelope-from <netdev+bounces-295229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:44:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E823B640016
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:44:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=KoNM8iV4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295229-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295229-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 541A03102A95
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E6147798B;
	Thu,  4 Jun 2026 12:37:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B92477E36
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:37:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576664; cv=pass; b=SHDOmsQKiUR9K9MESk3Zyba697Kc3A7aCNjw564JNHD9t98CFqAMY0ElxVyYzMkz7uyPpoyr03GB60TUpJqWfbSg1iTV+l+2HI7C3Jevct1WGVD1KnrtUcUkbLP37mmRziGm1zqslvD2CnWwmhKmat24e61S494Ki9Q2sBjED7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576664; c=relaxed/simple;
	bh=eecKwSkFz6kBSxAziuAzDOf/uuk+1dBSku4wR63srpY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aqMxHLHCi5GpkoFZygBVWmWINBln/OZSEOzsK/1ZIdaKfshRH64rj7xuUsozBVYWeviUv1YWMI3uvqPZ8QR6vZVjtzPe0EfOVtmH+YmIllY5CtMxd6X9Sf1sQfQMr9sOxV4rCV+jG8JLe1OX/fxL26jhvIsigh3ahTkukaSd940=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=KoNM8iV4; arc=pass smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8585cd8400so247749a12.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 05:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780576660; cv=none;
        d=google.com; s=arc-20240605;
        b=O5DyTX2dzqxurCWZ++OeWKhhB7JLBTf6Be3wbz2lyoPSDJqYGheSh9IXto1s7rOviS
         tKQVq86fmQmJKIt7B6uSjnsOwmP1EonDZcRJJy7TTTSheZv0NbocJz2nc/yXYgjQ9LL/
         htbs3HVOESkphSBijy47zs6KarEjn9lhns3uwBgxU04zccTfwVraTkBZVhhZW+fqmeYv
         bY7eaGIJWB40FUUTA9RdiJgoI5XasJVdkSssLn2puA6WELEQTVM9WOgbpvP03PfZxgyy
         GYJ9aSwaDsOr6VFc8n+pfRjsLskUYk1/ZL2JSpoovt9/Z8k8K7uSn2PyGZF8+1BycZLb
         kn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=T6iEHZVQzF9ogQCO7/aeBuEDiXsPvwfwZqExDSXWtEI=;
        fh=5vItltAusB8n2n3l8+BN4+wkiyA2y6xZLyuDBEvprWs=;
        b=iQyPvwZ20couPMKFt/W6wO7PsT6CCrjz/Jd1NkFX0XWjkK3SWHzGzaDJ06GBNZFypn
         dCwQN6eZOPb3nghXRdqZAlsUvQ6a7kqZibTi0Aw5JnvcIDUd4u5Z+HJprE6WjY5sRVb2
         /HCw8VoY0cc/5KSfcW+IOkcD8djJAQ7V6B9vkqiecIFzQLR54gkqoyWnT3Cr0p1FM8En
         YV4dyeKnck7/2aB77Kv/yhdOnourwc/yXF8Zsb6Yw5emwgLCy0F9u1xlRE0BJdK3jzD5
         1wYZKAHX/cbCIL8PosNppWP+HBJzNqqEl7btoQ042DHtpHTgnSHST5+NB1GUcOh6Flbp
         dHLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780576660; x=1781181460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T6iEHZVQzF9ogQCO7/aeBuEDiXsPvwfwZqExDSXWtEI=;
        b=KoNM8iV4d2d0o8s0VPrVGkAId1k4Zbr1CKy4gYZvxQUmhk0wiP8paVWmSyK+XOyRuN
         buEqnSNfoUirCQY9TOjyRxAqmgYQRja288OhJzgtyhbO0VMwUb4PO+dOlMnB7vTP8xJ9
         y9dFeFTSuahO0G/pqUT5N/vmgLeaCPi61sPAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780576660; x=1781181460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6iEHZVQzF9ogQCO7/aeBuEDiXsPvwfwZqExDSXWtEI=;
        b=frIeU/Kg9/liE8rTTrXhsSCciMdX6jIwsDXZeolzKUeVEZfpzJu75aL1x8p4eT3qcz
         SsE1ZPrNVLIEgQXLJdlMPUMqiw7rDRjVra/wT02N0S8Ukyu2bBuVYNnEmjRAoAIHZVYf
         A1JXQ4qufctNHgNRFLdeElzIfSKJ1SzAgYNBbS3D66Ad2QshKf5lbZ/6mjoVAwVn+87U
         uyBrE1J1wdqCcz0qfaTPP2nG23/6vaDyEIlSngGfwldx9hyvjVkjZCQIwtQUnJsKqycJ
         mu3OfYBPD2yrEIxfW8fYXB895n5txokdnsbhRwxUcBA+Kkm/U4SmedFDbDZoLeztn907
         ca7w==
X-Forwarded-Encrypted: i=1; AFNElJ8P3YQzS2UKu504rWV6M3GEQudLke10JvkCG0S5LYdHYLAizSMZwNeK8Cr1t+H84jRazfHmzuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQs6v5sGIuutaay+r9t2e6B2BLSpQV6XGjXAOaub54v5f4ueF
	pBv6exxUmBMbIb/sBNgGBb7/5wEKlc3d5R9rqCIDqNB/knksDsr3y4xVLL4FsOoZ+Yy6zHRUHrj
	JEZGhD6dT2/+r8Idp6470ug6A6e5oMgu/PPA1Lt0r
X-Gm-Gg: Acq92OGfpeCwu+wxs1rjqKv/hj4sgh7C1+rvabFW8T1V3K1s1IXXCPLlaw6k0qIj1us
	qOoElf0FSVbQ+9kokUksgSwiJ6o5st8eMttaGQHTLVKCRoScB8oHBpjYNtJbqABtX4xZxdhdV68
	7wbiukM8Ed+YXymKrmjhC9kZH+zVlguEF8zyeM1zhvjmaf1Nkjv13YnjAftGj0kV28phUtphNdp
	2dbUtkiO4U8Go3KdonLFJOLoHJj42T4onXeE5dgaH3mpAcr3ybZT1NJRDVwe6BuVoosUOMjgqyw
	5T8syJmJssKnRk5tmtA=
X-Received: by 2002:a05:6a21:9146:b0:39f:a8fb:3354 with SMTP id
 adf61e73a8af0-3b4977e59c8mr8046550637.17.1780576660316; Thu, 04 Jun 2026
 05:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 4 Jun 2026 08:37:29 -0400
X-Gm-Features: AVHnY4LlzJb5RlJLg6o1J35Nb-MJatDdIgZiKhnggUIpS5hc_9Qn5rm87J2bKe8
Message-ID: <CAM0EoMmC7oT99G7Qz8Kw9oB79agGpsHmJtzzhrc3MS5Nb101gQ@mail.gmail.com>
Subject: 0x1A: Keynote Speaker, Greg Kroah-Hartman
To: people <people@netdevconf.info>
Cc: Christie Geldart <christie@ambedia.com>, Kimberley Jeffries <kimberleyjeffries@gmail.com>, 
	Stefano Salsano <stefano.salsano@uniroma2.it>, Lael Santos <lael.nasan@gmail.com>, 
	PJ Waskiewicz <pjwaskiewicz@gmail.com>, program-committee@netdevconf.info, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, LWN <lwn@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:people@netdevconf.info,m:christie@ambedia.com,m:kimberleyjeffries@gmail.com,m:stefano.salsano@uniroma2.it,m:lael.nasan@gmail.com,m:pjwaskiewicz@gmail.com,m:program-committee@netdevconf.info,m:netdev@vger.kernel.org,m:lwn@lwn.net,m:laelnasan@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ambedia.com,gmail.com,uniroma2.it,netdevconf.info,vger.kernel.org,lwn.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E823B640016

We are honored to announce our Netdev 0x1A keynote speaker, Greg K-H.

If you are a Linux developer and dont know who Greg is, you are very
likely living under some big rock somewhere. Maybe this would remind
you ;->
https://netdevconf.info/0x1A/sessions/keynote/Greg-Kroah-Hartman.jpeg

Greg  is a Fellow at the Linux Foundation. He is currently responsible
for the stable Linux kernel releases, is a member of the Linux
security team and CNA, and is a maintainer of the USB, TTY, and driver
core subsystems in the kernel as well as other portions of the
codebase that he wishes he could forget about, but LLM-generated
reports keep that from happening!

Greg's keynote is titled "LLMs and the kernel security process"

Right now the networking subsystem is taking the brunt of the abuse of
recent LLM advances with a flood of =E2=80=9Csecurity=E2=80=9D bug reports.=
 Greg will
go into a bit of the history of what has been happening, how the
kernel security team has tried to make it better, and perhaps a few
things that we can do in the future to reduce the load you all are
currently having. Also any feedback on what the kernel security team
can do better to help aleviate the load is always welcome.
Come and listen and interact with Greg.


cheers,
jamal

