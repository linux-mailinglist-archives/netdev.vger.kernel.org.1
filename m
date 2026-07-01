Return-Path: <netdev+bounces-303522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dja0KyHGRGoZ0woAu9opvQ
	(envelope-from <netdev+bounces-303522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:47:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EF96EAD43
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:47:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=T1uk3EQZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303522-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303522-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0ADAA300620A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF093BBA18;
	Wed,  1 Jul 2026 07:44:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85983B1016;
	Wed,  1 Jul 2026 07:44:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891851; cv=none; b=AyLCKmVKyP1fyDJy6YKHYKxy2v9JdOmMOtiyLeI1Kiom5POqbqlmtSbp4PeESweGyE6eqqaZrFikgPguccuAbS9A9FJ/hVkMpk1ZOxvpyAY7EoH316wCDbypabpR6HvkfiFrpr7/8Pixq9A42NzuwUSjPRnrEZnXFzMirXuVlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891851; c=relaxed/simple;
	bh=MLHJ55u6fkpaD2Px1OJT5Ffy8FyDtBQJsFcLHSj4Oq8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QjaYcK3bvHMqHFFpyAnKI+aYswfTKNkWMrj4sdtoyNXsmx0JqS/fsOvk3zl0oLUYDKzpg/8FJKghWrubtmxU2E0H2aWYCKvoM0hyZ0Eyzr9xSWk9Kkfk4pAqsXKvo2SCjS7OTbWIYNZrWwTPdhF4loHmJ9lhGio3zxjeBqEbRs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1uk3EQZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59181F000E9;
	Wed,  1 Jul 2026 07:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782891850;
	bh=MLHJ55u6fkpaD2Px1OJT5Ffy8FyDtBQJsFcLHSj4Oq8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=T1uk3EQZYvJhT0cMxWKx+q7GONtrv9fvk1of19IekudsERiTc08aBC62mVyzyj9IG
	 h7K2D9udhy3hN/rZhQ3jTohEirdlXfm7krp7PoruFREobPRj1a7MNjy1wdNwv7rE5W
	 o1zRz+6ruO7cAzKrnsWGlHq1yc2v2TPrJZpL5AX7cRw33yKKaMN2qwRwlAegXS6e5x
	 GxFCD7ADMlxE3Upoq3v46oIAXdlFGpO76KUsgt9PQdqIfdcFW5SBrkZ/2+hLza40xy
	 SzpVBrS1qe8kFMka90BdwmklkIWBNUQB5/bVrPxXZ0XRWXXNSyiCqSgoij4K567W4G
	 02OUx2Oc/942Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v3 3/5] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <158151977.3525022.1782821834050@kpc.webmail.kpnmail.nl>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
 <20260629194327.2270798-4-jkoolstra@xs4all.nl>
 <20260630-getoppt-granit-gekrochen-78244e8979d9@brauner>
 <158151977.3525022.1782821834050@kpc.webmail.kpnmail.nl>
Date: Wed, 01 Jul 2026 09:44:05 +0200
Message-Id: <20260701-angezapft-unreflektiert-galant-e89d63be60ac@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=237; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MLHJ55u6fkpaD2Px1OJT5Ffy8FyDtBQJsFcLHSj4Oq8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5HHV/snTF+qDVDH9smy9veXglwEU2MZ5ZaWIxz33p0
 OPdCwSOdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk9hNGhksHM+wdVF++yryv
 7Z529r9KRoHClyTN9itpyrnLamav3cPwv7LM7e5OXYmTGmKzq53sA5wOzyg5ZpITlLHsbEtX0i5
 XLgA=
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	TAGGED_FROM(0.00)[bounces-303522-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brauner:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0EF96EAD43

> I also choose to not put -EPERM as sentinel as suggested first, but use the
> actual LSM error. Agreed?

Yes. We have to surface the actual error. In case the LSM is returning
some custom error (can easily happen from a bpf lsm).


