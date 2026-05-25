Return-Path: <netdev+bounces-291395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDHTJpuPFGqrOQcAu9opvQ
	(envelope-from <netdev+bounces-291395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:06:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7EC5CD8B7
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D363019173
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF434D929;
	Mon, 25 May 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAgI907/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB833A9C3;
	Mon, 25 May 2026 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779732376; cv=none; b=qt14K9VQzAPMKDGS1x8UcFvnNvQ5DG0GC+TsOQBTrqNzSlhtyNxvLq97p3AhW4DK60jBlLqT+JiF2Rpole8pQOCY363aPBVzKqUgkGUMxaRBCmBI2gIWRN8Lx0IOg1dhi5eFlEEh0ivTyraBuA+tKaenydJq6NNd3iqeg2RnLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779732376; c=relaxed/simple;
	bh=VbZtE92DEJPaUYzv2cVoHkrnhRBWIh/74nXctkLSO7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnpEN9Ovz5Qkl5QbfXDxbQTbcCUKvM7n4ZcasMLRrFgXnmbUJHb3LZg3WFGOs/68WDIf97gQHRjszoXT3cglMdvYoS8702jsU49iEKvktEHsCVTa9PHkgbR1Z5yWKwb2B+c4gwfObGq75WOaDve3DJqwGPHe0k36+fBrcrgxHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAgI907/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7586C1F000E9;
	Mon, 25 May 2026 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779732375;
	bh=VbZtE92DEJPaUYzv2cVoHkrnhRBWIh/74nXctkLSO7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AAgI907/ix46+f/o+rYSUASNl8Yo8MzXYWgMHOPxVQjSOz/9rNLLJAMGiSsZRy9kR
	 24OkeO/nW7oiHdYKn9CKwPVryjJZPiCbXB9uj46v8sPOIJcH0o4USw1R4bcQr3SMb2
	 qRsI8szcQeqKDxz12lDgwHcp/Sx1ai2OIteUhNaDJ9EwOVOZ3Ub8KR/kOZ2qPxujJs
	 TuBA3gQvTjWdMif4+gt+B8Gef+ExtXfg9DUinsd0gwRyk+Z+ooifQywadijwrh1aqM
	 +9Gich1xLUVPf5UeKH82KDuYcvP11RtvdzBd5yE18jMt6JkAcwkenpmwiNVUQKcNSc
	 Oyp1w5SFyzYNA==
Date: Mon, 25 May 2026 11:06:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, "Mike
 Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Pavel Begunkov
 <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] fbnic: Support larger io_uring zcrx
 buffers
Message-ID: <20260525110613.4a1641e8@kernel.org>
In-Reply-To: <CAJ+HfNjE8e1Lj1yDEPYXk_KPspjN166rDbHon+zwiJb1rPqSrA@mail.gmail.com>
References: <20260522113225.241337-1-bjorn@kernel.org>
	<20260522070515.044d7d97@kernel.org>
	<CAJ+HfNjE8e1Lj1yDEPYXk_KPspjN166rDbHon+zwiJb1rPqSrA@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291395-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B7EC5CD8B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 13:08:59 +0200 Bj=C3=B6rn T=C3=B6pel wrote:
> The driver relies on the generic XDP frag coalescing
> (xdp_buff_add_frag()). So, adjacent 4K completions are extended into
> the same frag. IOW, GRO should see coalesced skb frab, rather than one
> graf per HW BDQ frag

=F0=9F=99=82=E2=80=8D=E2=86=94=EF=B8=8F=EF=B8=8F I'm taking about coalescin=
g across packets.
You should enable RSS-hash gated payload packing, and then we should be
able to combine frags from multiple packets. But only GRO can do that
safely.

