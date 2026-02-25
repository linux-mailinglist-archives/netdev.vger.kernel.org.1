Return-Path: <netdev+bounces-261090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN9ILwhpn2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:26:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA7319DD02
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 504A13016CA2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B75311952;
	Wed, 25 Feb 2026 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="gVGXgfxY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED718306B21
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054789; cv=none; b=J0dDhXSHrZM1ZvIDSbxh5CZ9AtE62qq0h1NZVMN3K8OhREIRXh6DCf4z+bH1JQKPgHZzwOiZubZ8Ypuot2d9BSz2Iq8IuWGp0Crf0C6MmojmNDjOrpxmRd/1AF/Hd/Hdaq6DyqnG66WL1dYHqukJ3LF7dFHk0umYedM9XZMC1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054789; c=relaxed/simple;
	bh=qG5sCU9pz3l6BgeeWxcfpPlxQDYPFk/W6rL2Jdt16V4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dShZ5pIKZPFM1qzf1ezwqZbtQvaKU0t8+0xH8m2vJEA/d5PrwjCh/iGsgCAPuSBaK2xwrd+2gwyAUs8OXkGMgcgY6dNpXqMnTXlHBSvqZQQwv9xW7pyMcybkN1LY18weozvYC9qsuBvoJY2ssfpIdTTPvGv/V4c1WnMgNcjQLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=gVGXgfxY; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a3400f30so1690201cf.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772054787; x=1772659587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSiH0cdETf3zZDL06Rj6UMjPMSR2mrBQHmf07RezL9g=;
        b=gVGXgfxYwYuKGfzrBwvP7dXLplxeYq5syBbSIXm/Syy5zY3fMNlqM98N9l0w9eQR9F
         2a6XK5tsNbTvhH7tX19MOKfsmi+724RY3fKdASeTW/FpG6ts3j4rfu8LdWkZ9r7+GBSJ
         Nb7C7MHvwFj8olpQvqjlYBJWV1VkCTO3T0/nH86d9w2bHz9g+rDLJ67K3MkYgcPtyRQd
         T76zP/YmW6gLYLK8DC2aWUIS40N42vUcIhupzWUXZ3rcWJmfKeKCUZCwTbyGSTNvxFEu
         2Bv2WwBf1XQPZZI9Q3rkjC67xJxsJCi+em04hCdggwWl9/tRfkF9NWxl4L4d6WL3rUP4
         wbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772054787; x=1772659587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zSiH0cdETf3zZDL06Rj6UMjPMSR2mrBQHmf07RezL9g=;
        b=Ek8dxzRKGTn/vcvJjvJ3fEU5CkZKAjkbiMycamddBd3axkpUMMjv57ElQMJIx/ENDN
         5CM2ygSZF4ghWlM7Y/crh7dE2l+FXpbf17j3+x4rZNrnfYYUm42Srz0vjvHd1aa+lMD7
         o0tukYU1V45UieV36GXl0Ridl7aQhOCnbUuipAU3zjr2qegszkdGFsuOWjRBBMqoTl0P
         R7ML49jJyaul6MDIR07oaW7iZflix+2piudrVPhLsQNcNbxRB+7EBpVqi0rbcbbwng9m
         COI93v0dnYywT3mxuG6KISp8+iAkFJ7fPi7GoLfWXKL8T2H3MS2/oRoCZHIr2AwUqM+C
         1QuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6/w0bTARiYHBnOCGP2XBzgp1ULlyKuTTEC0ramIrk3dVS2kgffqOzd06GRKTW+wZiP69uCgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN23HwjdhN0H4MxpjOEVSc9Jv7WOvWu5lGB9a/FuTtQkW4i4c3
	tBLp49pM+uGBUxuE03+l7yz4xB1SWdB5S87EJcnqwYs+j8gWDGY0pbZB6uDfwmyeXxc=
X-Gm-Gg: ATEYQzwDVRhixFAwLpQWtM2ljmi8Zn8N0tdOW1kYzqyJ3TVNCcPE3rpKLytKViiVmQ7
	Jbk6g2v4o+WlxQV4NCWoIsQise8F98W6NVYRxnO63u9/avHGt55XhLCLpCTKX+6mLOut1m1xh5q
	eiUP99hKvbyGsKnLiu+RdubGjtsap+D2fMWMIr1rjNasFPWplMV0WLywb44A3DSq7qSmBg8QDH6
	5lK9J3kvESNVyl+98Cx2kTmtqilAOOYQrPF83pWF7DZd4CK16GggupD/rs8xyXf9OVxvMTrRKA/
	fWFrE9w7o/KSemEhwSOa0PtV1UjYMoYhJsJcBoCssejDCZtVXUegC3Cw2Ru+4HnxkgSPZJIYE99
	HlSpYt5ktrgh84gP1f7a6FjnOuoqwQQcD0UASymDL+REJr2W8ZIkZUu6gCKBOq3rsA7svbhpWxL
	mfJwvz9cuKm8Ta/MNJ+TvF/fIjhe1ojDtULK0F5vu+KUMml4bSBbvHM1b8h6LeANPe
X-Received: by 2002:a05:622a:509:b0:4f1:8bfd:bdc2 with SMTP id d75a77b69052e-50744461c41mr8415191cf.41.1772054786879;
        Wed, 25 Feb 2026 13:26:26 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449630absm3104091cf.5.2026.02.25.13.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:26:26 -0800 (PST)
Date: Wed, 25 Feb 2026 13:26:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: dsahern@kernel.org, jhs@mojatatu.com, deren.teo@outlook.com,
 andrew@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 0/3] Add JSON output support to the remaining
 qdiscs
Message-ID: <20260225132623.0395441f@phoenix.local>
In-Reply-To: <20260211170725.1514427-1-victor@mojatatu.com>
References: <20260211170725.1514427-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261090-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,outlook.com,lunn.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phoenix.local:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1FA7319DD02
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 14:07:22 -0300
Victor Nogueira <victor@mojatatu.com> wrote:

> Since qdisc core already assumes all qdiscs are able to output JSON,
> add JSON output support to the remaning qdiscs (HFSC, QFQ, muiltiq)
> so that a JSON qdisc dump outputs valid JSON.
>=20
> Victor Nogueira (3):
>   tc: Add JSON output support to HFSC
>   tc: Add JSON output support to QFQ
>   tc: Add JSON output support to multiq
>=20
>  tc/q_hfsc.c   | 29 ++++++++++++++++++-----------
>  tc/q_multiq.c |  4 +++-
>  tc/q_qfq.c    |  8 ++++----
>  3 files changed, 25 insertions(+), 16 deletions(-)
>=20

Good start but some minor issues found by AI patch review=20

Must-fix bug in patch 1/3 (HFSC): Copy-paste error on line printing
level =E2=80=94 it uses st->period instead of st->level, silently emitting
wrong data in both text and JSON modes.

Design concerns worth discussing:

HFSC d (delay) field is emitted as a human-readable string in JSON
("5ms") rather than a raw numeric value (microseconds), which goes
against the iproute2 JSON convention that JSON should carry raw values
for script consumption

HFSC service curve keys use flat compound names with spaces ("rt m1")
rather than nested JSON objects =E2=80=94 functional but awkward for consum=
ers

multiq bands emits a compound string ("3/16") rather than separate
numeric fields =E2=80=94 once this JSON format ships it becomes API

