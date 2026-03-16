Return-Path: <netdev+bounces-268251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOkvJfdNuGlHbwEAu9opvQ
	(envelope-from <netdev+bounces-268251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:37:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C63829F1FA
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2398300A66E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3441E33A9D3;
	Mon, 16 Mar 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTJ5agef"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3A313E18;
	Mon, 16 Mar 2026 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686258; cv=none; b=k8JY15Xq0p2cuqtWqQ929c/Ei3g58uEebUNe6gpHFXyiPXKjJnRQfhtSYkyJpiGLZDlrJMGRSr7xGMqCLamKZZ2bewF5HZDbeikRHdx1PRxfPpI0PIdiuUf1biehw4QsXemULpfbrNgSRDGiNgssOT9g6YouoC2yj9sy+xEbtVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686258; c=relaxed/simple;
	bh=fbnaxQdPF1NKBtNr8u+6iRWFM3+H2AhkpAFjiOQfI9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hbkd+KpIi32IlOb/yUb6v5lwFSxxpyV5NeW5bqCZL9ulyluzOeAgcTl5/7rHJcjjhpnuKMckW7GYV2eIvObd4U7dN6APD8w5LsoUNe1gFgRafX18vR9Psc6mC+e51e4p4VjTtkDhrQhDHKCMFrEncx7y7O51e8k2V1diYBEQdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTJ5agef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38678C19421;
	Mon, 16 Mar 2026 18:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773686257;
	bh=fbnaxQdPF1NKBtNr8u+6iRWFM3+H2AhkpAFjiOQfI9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eTJ5agefPpSPtm++Q+j7JuMdMQt/xEdjP2Fi5GUEz9hz72sTGBcO7pdKz/CRN/Fqc
	 9ksaoZdl9AHYMLi/eyc3eNSWWhkjfDmGebGPBxFWfMo41xVz8J5fhy61g8LiJk89Ye
	 Qo2w3dGDioaRu/ksuOuFLRZZ1nUSFZBii+4ErU8y6++8NfRbs3BuI4VPIsqqCEQ2d8
	 OGPQYb0YdQU7TaxWRgNyFtdfrtY0t/f4SoABz7r3c6kD3h6Po+5vCvHAP76Oq81MDZ
	 7Tt0FNJ4aQQTzwnwT54Q3Jk66cl9UXXG8aOi+hy28afD5qZwCC1rArVHl8LizmHdSk
	 q1l86Gc0dxrSw==
Date: Mon, 16 Mar 2026 11:37:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?=
 <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alok Tiwari
 <alok.a.tiwari@oracle.com>, Kees Cook <kees@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] genetlink: add multi-version family support for
 protocol negotiation
Message-ID: <20260316113736.1085a124@kernel.org>
In-Reply-To: <20260316151507.3958299-2-christoph.boehmwalder@linbit.com>
References: <20260316151507.3958299-2-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-268251-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C63829F1FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 16:15:06 +0100 Christoph B=C3=B6hmwalder wrote:
> Extend the genetlink infrastructure to allow families to advertise a
> range of supported protocol versions [min_version, max_version]. This
> enables a single kernel module to serve both old and new userspace by
> letting userspace discover the maximum version via CTRL_ATTR_MAX_VERSION
> and select the desired protocol dialect in genlmsghdr.version.
>=20
> Rename genl_family.version to .min_version across all families (pure
> rename, no behavioral change). This avoids updating all callers.
>=20
> Add genl_family.max_version. When 0 (default) the family behaves
> exactly as before. When > min_version, the controller advertises
> CTRL_ATTR_MAX_VERSION in CTRL_CMD_GETFAMILY replies.
>=20
> When sending a reply, echo the request's genlmsghdr.version, so
> userspace receives responses in the protocol version it spoke.
> Notifications (where info->nlhdr is NULL) continue to use min_version.
>=20
> Add genlmsg_put_ver() for families that need to stamp a specific
> version on notifications.
>=20
> The immediate motivation is upstreaming DRBD 9 (genl family v1)
> while keeping unmodified DRBD 8 userspace (family v2) working. The
> DRBD family would register with min_version=3D1, max_version=3D2 and
> handle both protocol dialects.

What's the delta between the families? Do you have any examples of=20
the the version ends up being used?

