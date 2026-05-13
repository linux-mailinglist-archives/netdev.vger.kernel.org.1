Return-Path: <netdev+bounces-287707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCR4EAfGBGrdNwIAu9opvQ
	(envelope-from <netdev+bounces-287707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:42:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A57539261
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CB77300F9E9
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE7F3A8755;
	Wed, 13 May 2026 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="miiOQM0v"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B435B632
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697364; cv=none; b=CxFYQMH4B9Srn8k+bmdeVuE8bYTdpItvHqJQ/fosfvUJsCDu9PykYb3pUVpTaqXS1MhMmiRHx9wtC4lUCICTUrxx0AL62Wkv3cofbVJIhuKrv0pSo5NIFFi2kBk5FAGn9ZvlxUYiEvWLl8nev3KzsF9zHMYRMeoSyApIHdqM/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697364; c=relaxed/simple;
	bh=+J8vDguIcTbUHW1595rtimwASjcABHZYtC2lDRVvj58=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=R+Uqk6GPnA1bdNn+qksaRb50efjC2StSJVKxyoAiKyOPc0oVxbsLhHo+1IhWHmiOQviUuCeMtbcrwsM5+Ss/Z4FujuaOTNAag+Wbc1svsjoOAg+TqssEfqHz9XiJKsf+wTX/16m+teGGGvdOLuRnzHxcfmQNnjc3I1pQI5iwZ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=miiOQM0v; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 May 2026 20:35:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778697360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZahbxcLMk4nFiXMIuxR7pAqjPA9tjQUCG0y2N20ur4=;
	b=miiOQM0voUMout4J80B/M5yKxTaXCtTgD+KAfkWUCITTOCOycrH+VmAKy+fmLDhjr/6v1M
	kcQag3+HWu6Rj0xPSHs4UXeIO9wVTAI94ROQN9ZwgMkiZSG3ri+AaMqGYjxZ/27OA9G05Q
	GzRj26YFX6r0xXyMSgKKw8qWO1huqXU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: netdev@vger.kernel.org
CC: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 fmaurer@redhat.com, luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v6_0/2=5D_net=3A_hs?=
 =?US-ASCII?Q?r=3A_strict_supervision_TLV_validation?=
In-Reply-To: <20260513182657.20346-1-luka.gejak@linux.dev>
References: <20260513182657.20346-1-luka.gejak@linux.dev>
Message-ID: <7D68E562-7941-46EF-B4B0-AE0DBAD15FC0@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 95A57539261
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-287707-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On May 13, 2026 8:26:55 PM GMT+02:00, luka=2Egejak@linux=2Edev wrote:
>From: Luka Gejak <luka=2Egejak@linux=2Edev>
>

=2E=2E=2E

>Luka Gejak (2):
>  net: hsr: require valid EOT supervision TLV
>  net: hsr: reject unresolved interlink ifindex
>
> net/hsr/hsr_forward=2Ec | 6 +++---
> net/hsr/hsr_netlink=2Ec | 7 ++++++-
> 2 files changed, 9 insertions(+), 4 deletions(-)
>

Just one note: This series has been resubmitted because it was never=20
merged due to window being closed and I was instructed by Felix to=20
resubmit it now=2E Link to old thread is [1]=2E
Best regards,
Luka Gejak
[1]: https://lore=2Ekernel=2Eorg/netdev/20260413103449=2E169913-1-luka=2Eg=
ejak@linux=2Edev/

