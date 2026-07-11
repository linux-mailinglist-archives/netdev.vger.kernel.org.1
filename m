Return-Path: <netdev+bounces-306877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mYomKYRhUmplPAMAu9opvQ
	(envelope-from <netdev+bounces-306877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:30:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B164741FCC
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:30:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ajtiv3oa;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306877-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306877-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EB543008249
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA2D3B47FF;
	Sat, 11 Jul 2026 15:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8C395AEB
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 15:30:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783810; cv=pass; b=N+Uz92v5oh4+5HyqVxommIC/oAS+28VGNFEsWnamvfcwopoQ0/8A0ZNcCuEF17K6vcSCMol+1X7+OlkgxiaF5BEBuRYHnRBmewBslq0cEM1jbIVmGkNgmNjhiHqlPdbH5EWydKENQwHOdPhNAj4UzimlNAhSAHTjWi3Bt6sLhZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783810; c=relaxed/simple;
	bh=VgLcjMWmevXm7ESHz2wQzgI3sAUBCb1NgNAir+5i0GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glRN/MnKWf97esz3w1Sr7J76IrDD5a7DMVHgBZmlQEqc0MlpLqLYWK/Sda1DXOMLGBlQL+RMrOtipFyexWYtM4LykEl6qRRlnMlJpXXKopJlsIjDkYTVMqaebYBoSLU2xj1382GVLzMDFc9Y4D7BQDr+EgIiTDGU5MAJXpl63/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajtiv3oa; arc=pass smtp.client-ip=74.125.224.43
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664cdeab266so3011672d50.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 08:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783783807; cv=none;
        d=google.com; s=arc-20260327;
        b=H9JgpK5eZ0UrThytn91pWvmABK/eodSI8oYadGJeBZt/uZ3Wkz5MTQZH/IPwb54Ytz
         u9o2+60VLED+4NoiHxXqupQi0K5h39s2CSXhZM7s9WeJYfoAFx9KcIcFRCyeGZokae5K
         AnkcHDE66zXO1eC3gxL/Q1o8Ie17wbgNn4QuW5ELlv6nZaHKaEMRZh/n128iVqpZ6fO0
         u1o60eUQ6slIDnDETz/wTv71GqPiGYa1/NRAkRVUHq//QR599BZvXLkMAHEgBWA+clSt
         6NK3S7V7tZEfyvWRrLOSJ0CcWd2t5qHzVv3NNbwPMv4YqzSwEedBkO9MbfhvYb7FInmg
         j1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+djRPG1+yP7gLniNybddU9i7XevMPm8WBoJDKoJ3OMs=;
        fh=2jTw3kE6d/Zp6gVgJZolMgsEvR0l933NG/b+D3PUV+c=;
        b=IopohuRilzTPNMZ05Cbzd5cABsNgutXx2zRAsO2qeLHbfI9Lbkvc/LMsRcArmmhdxe
         Ip7Wx6JXfwfAKziXcn5hgnGQ/IQnkTn/877TRLTXGo9XZnACZca2+2vwrl5uhQp+CwmU
         aqm/P72LnSgiNj8vK3Q+/cLYl7BWjSRF2g7O1jFj3YNoMkK9/HJkc0OpLOuH5InNQq4v
         9+BU6cakJjPOdhQ8lKkxQJF9SSPhcoIQpprKZi00vfWWL4NcLriywGECIykO6YFdUhHj
         zozTWUugqDtf99NXNwJ/acSNoO1R3vDE9wtpj4DFoBKluE98ovNYQGZ0ce/TEzLXhJ+q
         9a2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783783807; x=1784388607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+djRPG1+yP7gLniNybddU9i7XevMPm8WBoJDKoJ3OMs=;
        b=ajtiv3oavXmmjMpbOwKJqH7BAIYIvgVi7IIg9dXw0KTqKp/ph2w4B417H3PMC9/sXD
         /7AgFV5NXnEXnJfPAKh+7WbIecsq+UPWtCG4gaojfi5GSUH2cpqz8ija6B2TzVkLPedg
         YMaS1tyT1o0bl+LrEeIdp2MoC+OS8I4R7jUc5dvuigIOODJIEYORv6K70pxrG9cqGaL5
         j6+DWMkz66QfbcZGznOt6NUyWwoHeFH+nDRMCkRle1kbETISrnQf2kIfV1QnJs2zC9tV
         P5umBpOZr2Vo9BpdpfGZ/qpyZVwnEQDsdSpN1ZAtq1wHgGp6WqbswLGnYM/I509tk7fU
         8L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783807; x=1784388607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+djRPG1+yP7gLniNybddU9i7XevMPm8WBoJDKoJ3OMs=;
        b=gn1R9sxJcwAUAPfSl5m0cgD3RY3hnkhtHPWpmK98Ls2Xp5oMDfJADFJUyXShJo9YoY
         11ng5jAhaen08FKbak/M/uYE3aW7ojHOVGA/czJN0fMnqrVSLd6KCW71V235Rea4M09w
         Ya+zYprHBY47wi4/IQvLPCro1IjMSdXg0gLVOFYb2vj79Kj8Y8C97k9+M4yOY5Pw7z+f
         Jbng1NWR69PGpA6aLylizSUNvvVg8nafFSKJSoGkBjvtv5vDcTB+H8+gY7le4kFAhEuX
         9awU0ILkGoRjULXYubPeC6DGZqphkTgYzvtT9Kiu6OmCiAZ13uiyjN6BxyMan442OghL
         NH8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpofXTOtz3vt2mLXPjOsdl/nErkBkLViZGXw+pfkDzKlCgWaJqWv+4sKHVporxBNc3PA6VHDJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8TatkHO9VkcihJIujrhLz+JEZscaltLOLTVIyHF4FsNT2rri
	Asm1LPB56sJmz3Ew4RxLzs1kBCnfRbjR4oRhmwF029NWGRJfpLBPJJ/hg/osSO2KsY2xU64eNoO
	Hk4Ne3g/gL9WKrVExAiHe2eMMBhHAw9w=
X-Gm-Gg: AfdE7cm3QZV3Q1bSqO4/0vCWXH99QzwrNHJH/QI6i0xcebeUxBqa5qKxDSFUyD2kN+z
	fCU3DuyvyGvfIhfAgEdYpCD1MR2SaUF9LVtKI1lzIUhT6eARJBgVFB4eQKdIa+feJBII6bme7/H
	KGNOIOgqrAht2SyKGzzPbeDwmYtnrmDNeO1OVTg0k1W9ygOVN/a3LGAVj2AmXmxCQ6f9rIUJjOi
	H0uQ9v7QByBb5r7hKBxHNx+v3Wf76+mG36O3VIXz36qXe8KefnFiS/YRTXAv2p8vOjPeT70wmWU
	ZsB0Nw3TcibMiIqtJQzEjaQRNzJ2sRvbjKyt
X-Received: by 2002:a05:690c:480b:b0:81e:4e5d:4849 with SMTP id
 00721157ae682-81e90060695mr22842997b3.16.1783783807477; Sat, 11 Jul 2026
 08:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711150754.2918392-1-michael.bommarito@gmail.com> <20260711111503-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260711111503-mutt-send-email-mst@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 11 Jul 2026 11:29:56 -0400
X-Gm-Features: AUfX_mxgD_lh4gOsRso7LSqjgvGgXmvPV1lIQqbOp9oTE3YTU5O6OP4lBsiP8lo
Message-ID: <CAJJ9bXwUtQ3pHqZ=AMuwaNLs16pmujiMdeBQtB5kFc6JjM-Pug@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: validate device stats reply records before use
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306877-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B164741FCC

On Sat, Jul 11, 2026 at 11:20=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> Why does it "matter most", or at all, there?
> Host can always deny guest service. In fact, this is how cloud vendors
> charge their clients, by denying service to whoever did not pay them.
...
> I'm all for making things easier to debug even when the device is buggy.
> But I'm not inclined to add tons of hard to maintain code to
> that end, and I would be worried broken hosts will come to
> rely on drivers working around them.

I am always confused by the CoCo threat model to be honest, since it
seems like some people care a lot about maximalist reliance on the
contract and other people are more practical about how many other
vectors exist anyway.  No hard feelings if you want to NACK, but at
least it's documented publicly now for people to consider.

Thanks,
Mike

