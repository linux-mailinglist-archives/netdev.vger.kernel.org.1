Return-Path: <netdev+bounces-267771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ItuNEuOtWmX1wAAu9opvQ
	(envelope-from <netdev+bounces-267771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:35:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36028DEC4
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3B0430247D9
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9EB2F6160;
	Sat, 14 Mar 2026 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjg3QaOw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837A296BC8;
	Sat, 14 Mar 2026 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773506120; cv=none; b=HjlfKd5f3keuniOGEqXzFrxfVVRUs4YoEX2gnGoH31nnTS63YLt49QUYwLq+x+Nt37DeJPeRQCkOs+dehS1gI6Zm5If3kJiWghVzjmExJbudnDSJqGAx6REBRF3JRG9et2ev1hJQ4nMMkDF+QeLk1Q/XOBX8CsbgtCa3TDE5B6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773506120; c=relaxed/simple;
	bh=L/eakVxCmU6z4MfVX/Tn/gRdChsPQgl7sUT4bvaSUng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRPbhTFDWzZ7qGiIE3bXY+QHHgGd59zP7M3jqtCkpgzNpRvKISR6sXbtviPm8HM1VTXg+xMHtJ8y0YRBLtiDGFgqPlu/Ipf64H/1T6IaV/yQWDnDW3jiNpymX7B8hbYustewDhUI6LJPhlvu4Yj41u1PXHPrLqdOHbhEx8vVFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjg3QaOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF82C116C6;
	Sat, 14 Mar 2026 16:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773506120;
	bh=L/eakVxCmU6z4MfVX/Tn/gRdChsPQgl7sUT4bvaSUng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qjg3QaOwYiWXU5CENRLW0EU8+MysNrtBRN2lvo+qCMxW8LYTl2pHBh9iA9403VxSo
	 5dd8vVB4NmjmecXcm9k3ZqyWASernSVsaMKsS4LoG1EJf9fJ0r2Z9aWWZwd1M2+6eD
	 mO6e5RDg2kBMD04bhJtS/FkC+tsPOiWBthQVCt0c7BYi8ENxytga7jlW2ofHhNCl3A
	 mOu2WXZoc6VyfBoXP5h43Yp+NOy2yWtLyAr9og2MIkYWzJ66gQDdpYxOKfXKCLAq3C
	 i3/TG5kz8TUhyZFL+pmVgsiG0vg7f/ZXhTEhlbe8Iu8M+iUjsRh2NvQMhHhcp8jX5e
	 Z9V5Q4/GbV9tA==
Date: Sat, 14 Mar 2026 09:35:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Shuah Khan <shuah@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 intel-wired-lan@lists.osuosl.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v4 0/3] ethtool: Dynamic RSS context
 indirection table resizing
Message-ID: <20260314093518.43b820b7@kernel.org>
In-Reply-To: <20260313071322.3489243-1-bjorn@kernel.org>
References: <20260313071322.3489243-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267771-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C36028DEC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 08:13:12 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> Some NICs (e.g. bnxt) change their RSS indirection table size based on
> the queue count, because the hardware table is a shared resource. The
> ethtool core locks ctx->indir_size at context creation, so drivers
> have to reject channel changes when RSS contexts exist.
>=20
> This series adds resize helpers and wires them up in bnxt.

Sorry Bjorn, I was typing the explanation below and I realized that=20
we may be violating user intent. We should already record the user_size
from rss_set_prep_indir() as part of the context (and presumably some
netdev state for the main context?) and don't allow shrinking the
context below that mark..


Now for the broader audience - my understanding is that the RSS table
is a precious resource for most if not all drivers.
The direction of this work is to allow user to explicitly specify what
RSS table size they want. The Netlink API for RSS already allows users
to send tables smaller than what the device reports (Netlink code just
"replicates" the table). So if the user asks for X entries the driver
should be able to allocate a table of any size as long as its a
multiple of X. This series only support "global" resizing but it
should be simple to add the state for the driver to mark in the context
what table size it actually allocated. The only reason we haven't added
the support for that is that it's quite hard to know how to implement
it without docs for the FW/HW.. fbnic has fixed table sizes so we can't
even prototype there :S

Please reply if you'd like to collaborate on adding support for the
user-defined RSS context sizing.

