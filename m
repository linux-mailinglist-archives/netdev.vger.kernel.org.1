Return-Path: <netdev+bounces-256483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO9yA159gmnAVQMAu9opvQ
	(envelope-from <netdev+bounces-256483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:57:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B92DF76A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7CB303AA84
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D402365A1D;
	Tue,  3 Feb 2026 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVqMCQtE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAED31A56D
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159451; cv=none; b=kG9SZBdYXb7dFnkd4qRk6Mfly2sMniXiRmMoej2Z+5JVfCOQZYHJOia+xZpAxAf+uQ2GMt4WC/BVraR5dloLzj+MJlL8h0jXBHqCdEDDFOt+jBAERwa3eU6P4Nw0cYXY2rFlU2P3fkzthqqx9rf0cWES0Qemi5FzbwB0wdaSdyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159451; c=relaxed/simple;
	bh=ZPGoWml9B3CG2RjjvCfS1WHH5jV05Cb3Z1s+Ti229NI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meTVMIJXkx9e7X39cxKzRzNT+EyLyJSc6JuprtnUl4AyL90B84wrGM8E2302BxITO4nLrRKmL483YXS/G7riZuBiMpGCnXnQJCBrA13PQmyaeaRbyTiBkSSAjD8c2H32S3FiAwRBLzz44tLal51Z15vyeW+4GYa7saq3c8XjY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVqMCQtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8926CC116D0;
	Tue,  3 Feb 2026 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770159450;
	bh=ZPGoWml9B3CG2RjjvCfS1WHH5jV05Cb3Z1s+Ti229NI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TVqMCQtEHpNRZz3Vftt1TqWdpwfDGJle98LWBbUkP2/dF6FpHMlE9hY9dk30NKcqs
	 6jdiW2H1oEnWNXtCZi5Mmd7TfoUqkiUktRvR6MK7JuKIkJhLYAiVo+csm0YEGvFE90
	 /i7xDbqlYRLAp/ydXirmN7xPnhCAc3Ecu3uR+2LDpXjvakFQudgQf9W/XbQbQDSx79
	 5ElpkmEfOQpz/Zv0IHjPOdCT2plMpRqsFCisdDwDyZDbyfcWmNHJP9DMpjpuAEWXji
	 u/UUU8rdYL3YTEOYzQ6S1so2lbSSOK/68LhiPRa2QNKL5NqDgig2wtRPkGBSKuwY6u
	 ozzmfUeGta62w==
Date: Tue, 3 Feb 2026 14:57:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, Don Fry <pcnet32@frontier.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: ethernet: pcnet32: remove VLB support
Message-ID: <20260203145729.5c491d71@kernel.org>
In-Reply-To: <CADkSEUiAvv6eHEcLBkHRW8KFqSgcxg46+1BE25T50hT6ZkGbbA@mail.gmail.com>
References: <20260131012119.25863-1-enelsonmoore@gmail.com>
	<20260202182054.0a755aea@kernel.org>
	<CADkSEUiAvv6eHEcLBkHRW8KFqSgcxg46+1BE25T50hT6ZkGbbA@mail.gmail.com>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,frontier.com,lunn.ch,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-256483-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82B92DF76A
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 21:32:13 -0800 Ethan Nelson-Moore wrote:
> On Mon, Feb 2, 2026 at 6:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Fri, 30 Jan 2026 17:21:19 -0800 Ethan Nelson-Moore wrote:
> > Unless the maintainers acks this I think we should just wait until
> > we can delete this driver completely. Unless this unblocks removal
> > of some VLB-related APIs (which I wasn't able to spot..) =20
>=20
> I don't think that's going to happen anytime soon, given what people
> have said about its uses.
>=20
> FYI, as of 6.19-rc8, the driver works with KVM's emulated device
> (Advanced Micro Devices, Inc. [AMD] 79C97x [PCnet32 LANCE] [1022:2000]
> (rev 10)), well enough that web browsing works fine and it can
> download at several MB per second (multiple large files at once). It
> has random short stalls (of a half second or less), but that could be
> due to QEMU emulation issues.

IMHO we should probably start deleting the "QEMU emulation uses this"
toys, too. virtio existed for long enough.=20

But let's wait for 7.x with that, we deleted a bunch of drivers in=20
the past few weeks. Let's see how many of those we need to revert
and whether any lessons need to be applied to next removals :)

