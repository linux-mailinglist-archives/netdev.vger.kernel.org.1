Return-Path: <netdev+bounces-254331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAvRM9Uzeml+4gEAu9opvQ
	(envelope-from <netdev+bounces-254331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:05:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29807A50EA
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 786113053292
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95DE30274D;
	Wed, 28 Jan 2026 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N6ccxv5Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88CD288C22
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615673; cv=none; b=ufFbnJQrDZ1Azm3LHR8s0lvwovGQ2VnVz8HS/q9wn+Iw06E9LR5Uyx7fQZ/NhBV9SBnqJ48Y1Qz3EXtJFFEaORxNUPCSRLZS6kH1WIl5MxPu65hQCdJRGOvLQ1wbKAz+nODnwBsUFuyb/J/6wbTxsGKeJzyVolxfeIxuhJggl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615673; c=relaxed/simple;
	bh=7zFQMAueteEBXuRscGq9SmKOgiZk6KkfanUBpMe78R8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuVSoZpYNhcazHgvAtUF40NbheizHYvNVXALn5ZOgLgC7yN/Gj4jTLFlH5eABddGpZ9DqBRIciUDmNyNNp0IHdk0+RbrSBJt/1QpUbH+T2Jt0AFogXJ+PJceIVMaBk4kyv7zEeVPUumaM7ey1/t3ciYBSflO7QBbCyELQbWESns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N6ccxv5Z; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6C2B31A2AC1;
	Wed, 28 Jan 2026 15:54:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F7E96071F;
	Wed, 28 Jan 2026 15:54:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA028119A8812;
	Wed, 28 Jan 2026 16:54:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769615668; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7zFQMAueteEBXuRscGq9SmKOgiZk6KkfanUBpMe78R8=;
	b=N6ccxv5Z2zGUP8k1Pn45ZSolsdl2Nhh55xvinqSLIfwyGr9erLQmW4AJ9KvZGOD1QmcH8B
	B9nZVeC7Y4BnXrXtmB2O3pl49otpfd0s3ldb+Wv2KBPQEpJ04oi/NAi8OO9xpwlWjrA7aT
	6ODSD03TwfpyaWcG9Oy9NXz1y+ru2hKZTl+/JOUrONiNeDYryRshA3ggi5b1tF3uBpun+R
	mTgCAKli74i3k7reJ1QrA1laDX8DVB3/jHJbg/+P+YBIhAZDjFcb++sjNK5hAT1SJfpUyY
	LJD/aCxDFvEMwWaBvLFW0E86SVp4hQNR0+Hmc21+7JJTQUn5Y+pyLBXWomN9rw==
Date: Wed, 28 Jan 2026 16:54:23 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, jianhao.xu@seu.edu.cn,
 marco.crivellari@suse.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v4 0/3] net: liquidio: Fix memory leaks in
 setup_nic_devices()
Message-ID: <20260128165423.0e1b0cab@kmaincent-XPS-13-7390>
In-Reply-To: <20260128154440.278369-1-zilin@seu.edu.cn>
References: <20260128154440.278369-1-zilin@seu.edu.cn>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-254331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:url,bootlin.com:dkim]
X-Rspamd-Queue-Id: 29807A50EA
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 15:44:37 +0000
Zilin Guan <zilin@seu.edu.cn> wrote:

> This series fixes memory leaks in the initialization paths of the=20
> NIC devices.
>=20
> Patch 1 moves the initialization of oct->props[i].netdev before queue=20
> setup calls. This ensures that if queue setup fails, the cleanup function=
=20
> can find and free the allocated netdev. It also initializes lio->oct_dev=
=20
> early to prevent a crash in the cleanup path.
>=20
> Patch 2 fixes an off-by-one error in the PF cleanup loop. It ensures
> the current device index is cleaned up and correctly handles the=20
> post-loop devlink_alloc failure case.
>=20
> Patch 3 fixes the same off-by-one error in the VF cleanup loop.

For the series:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

