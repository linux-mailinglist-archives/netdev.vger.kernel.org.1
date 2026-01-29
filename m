Return-Path: <netdev+bounces-254516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCCgEg3Bemk3+QEAu9opvQ
	(envelope-from <netdev+bounces-254516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:08:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C51FFAB041
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6CF03037475
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B3F33BBC0;
	Thu, 29 Jan 2026 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBTBWiC8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82467298CC0;
	Thu, 29 Jan 2026 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652310; cv=none; b=a0nGFZSPh83b7g8bV99VLIkGlbwdvI5hcw0k3nPJM+NQxQh79zee43O8Q8HQbuQwJceuDSysJ8VOfcv4OR2MHdulKCwoEQT+ink209fQOfybdmDiVLw+HsCvUBVHKmkdmjETtk0FwC2aGj+InyyCZ9McsfG1BMY0RpRUF8gcsR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652310; c=relaxed/simple;
	bh=KY3FuAaO7jk+J7ntke3xNfca9dezrklOhRP0dI2G3nI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nACNyRGh+tR/XLdPi6cuA9UqwVdrhyzgPv4or10cgw/g/MqCpUxx8Msbr/5ooDPtshbeOxjDTP3uuTTkGTgQXca3Ag9GeHw2c0vaQtfSiec86+SIHegKXOtWJUA1ANxWr6p4kttb9nlgOA0mzf3lXcjOZZci5c9FUO03mjpzr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBTBWiC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2EEC4CEF1;
	Thu, 29 Jan 2026 02:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769652308;
	bh=KY3FuAaO7jk+J7ntke3xNfca9dezrklOhRP0dI2G3nI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kBTBWiC8RkwGjdhpKB1/gTBfD23akxEgAZuJJNmDNRSdIF8oj5apFGYIlvWpRo1c0
	 rhzTEfUMblXtP5uvG7buE08wa/ASToQ4TQjvS7rCOBGwmhs3IhlOcvVVpGgz1kZh+W
	 Sk09UIF1F9Z30PsitKwIZmAGKY5FtCnTh8M7SxUMu/NSgu7ozOTNf5dTy5YN2iyg2T
	 qPUvMHAOzeR0kxQjUWPiWHtuUJ+tsid7qO2RzkkkpYvT5+0F5Sk1MGTyTjtlatZ4zW
	 GMY540XJXZDNA60P4ANKfdpWs0piro9jU8LqM3vJu1/M4u5T+bulKBJ+l9QWR9ZpZq
	 BDPpdkIjXvHCw==
Date: Wed, 28 Jan 2026 18:05:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
Cc: festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, horms@kernel.org,
 shawnguo@kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, wahrenst@gmx.net,
 pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
 richardcochran@gmail.com, edumazet@google.com, andrew+netdev@lunn.ch,
 robh@kernel.org, krzk+dt@kernel.org, andrew@lunn.ch
Subject: Re: [net-next,v20,4/7] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20260128180506.742f20d9@kernel.org>
In-Reply-To: <20260128225533.39665c74@wsk>
References: <20260126103400.1683125-5-lukasz.majewski@mailbox.org>
	<20260128022558.4151582-1-kuba@kernel.org>
	<20260128225533.39665c74@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254516-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,pengutronix.de,kernel.org,lists.linux.dev,vger.kernel.org,gmx.net,redhat.com,davemloft.net,google.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C51FFAB041
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 22:55:33 +0100 =C5=81ukasz Majewski wrote:
> > Would it make sense to merge these two patches together, or at minimum
> > have a note in the commit message explaining the dependency?
>=20
> @Jakub - If possible I would keep things as they are now.

Not ideal, but okay, we can leave it as is.

