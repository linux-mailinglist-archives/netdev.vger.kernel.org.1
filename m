Return-Path: <netdev+bounces-300827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UUAjO+m3NmolDwcAu9opvQ
	(envelope-from <netdev+bounces-300827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:55:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1CF6A92AD
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:55:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=U9Z2ZPT8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300827-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300827-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8432F3027116
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4D39A040;
	Sat, 20 Jun 2026 15:53:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9704399036
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 15:53:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970817; cv=pass; b=SB5QEakfETmAa0DH4NhJA2page59za7H2WIcA27GP0cm0OhU5BGjU+l1UddfDT9NewTtfZ7mpsVJGilR6KraeFRralFLWv37+GMmZXpBQg3ZWQ+2OwQKFVcYLY8uOuAcP6Xr+lu/fpT9alJqWcWzAMFolAhmtIMevOy3CE7DexY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970817; c=relaxed/simple;
	bh=PprN2t9rjdBiH7hNZ9B0fAoZIV5oRd1FHv4010wsUIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtLkwAEtmulOo50A8BGAKS8O3xjZWPRim4SRbAX8evr+gfzm/vITeTNWjnGrADuVhMv5j6VnSreDGoLydiNmLJYCnnT+WkGxY85d8HkNkinC/0D/QuzUXnJz7r1hWmizwDsD7IrG2UKJ9aqFmn617DVjKo/utdKyH4F6hnp4pdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=U9Z2ZPT8; arc=pass smtp.client-ip=74.125.224.48
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6607e80a846so3212953d50.2
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 08:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781970815; cv=none;
        d=google.com; s=arc-20240605;
        b=gEWkgeZgN3bDlaLbG1s/pFh3YjphGBfDeGB+jk6Tzx8o1POUae0M4Ap+FI1MwQSo1r
         hMj0yS2Tp5cWYezsp2kZx7EW+XyFjiU/7UxAHgOVFUDbh88CSMrAzD7GFs04k/szeAd9
         KmUJTSOdeJ6mxhBPL9rlle4oIQQQE+vgK6AtS3SG46ptoChPQQEzS7CdC5Zdz3hLxBFU
         kEOMdgpRr6TruKEoe//pkazqVUmoDT1AqZw9TYnAz7TGT5WCKv9L8MhgHcASyN+zKrmR
         NwIwQUf/hXlirIAphShI7UR4bEE9+MFPflvkUJo1M8ZzDjj0NtTNLTOAdcQlc+6B3DPc
         ZIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PprN2t9rjdBiH7hNZ9B0fAoZIV5oRd1FHv4010wsUIo=;
        fh=qDARnxlziA7ezqKJhzp1IESKpdTWDUdDO2t0DyCT7Qg=;
        b=Ft9qIbUhKs1TXFlS/cTMKWwjVRaq98uJW85RRChsD6SdP8KUF5ApN4Hcx9z9elgYqQ
         /Z7g8KzSbf9ga6BZu/oL/E1UVJSEjfTroi00fJRtZKpFMVG1t2X7i+Vtkg7zLQoeu26m
         iFO49Ma4s/SMsd7rljLxVHROLY9zs9eOIwvAIuiJFkxQpAMQmwkzepgkFowyXRocbB49
         NOtYcxbvwO2FKUflBDWe1LKMvoseW78yJr2+JlHlKOpFZr2vXcSzptyzdZGLSqung+w/
         gEePm3dl+GypV6hP55VU6K1dMPWdhbHYwsaBOd60UgRcgQerWWm+qSRGuxZUuntPpf/0
         rzmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781970815; x=1782575615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PprN2t9rjdBiH7hNZ9B0fAoZIV5oRd1FHv4010wsUIo=;
        b=U9Z2ZPT8o6rPpXDNvC0733ikSVYIdCPba9OWRwGiD5c9kcDmM9jPR73EK6j9u+1kHr
         2sVGAfRgXhtjGn4Q/c/jXeHCFJrnBouoXScb92l110QKe3hC1ZsBqxQkfOm3o5V4fvJd
         8Q3ZoFJJGWnNO2E/oAh7Oe/oqV2Yk4oK2HCUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781970815; x=1782575615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PprN2t9rjdBiH7hNZ9B0fAoZIV5oRd1FHv4010wsUIo=;
        b=dBtA6qGZiQBZGL5PNAT686NBJgQy21cjqT/y2Ll6qFqdcqobWsCtzhQDuuD0yokTwD
         1pFIl8+HbLnNCwIDGU2vCJg4BbI9bKf0E8nH3Llo6fDpv6OX88/SWXX5CGoBLNMzynwT
         SZJ7pHSmCRqNA30f6Kbqwo3YqHM9rkZ7ARCOz2/bNvLWccBWSEbs3plSwBU715ll1Xqd
         aZKm/og2q01XvbLl23rKl+stpgzw+bYC3iBHidQAp0t2NXqz823s8JihKGJpjIA2xO1j
         WTMvKqR+ruqQpYnSDrcmw+gQx8vqzNSkC76dxDvPQYffzi0ZMnk7QH7yMQfNS2rwGjqo
         h44w==
X-Forwarded-Encrypted: i=1; AHgh+Rp1JEwpyRd5ogr9sZfZr+V0KwGjt49/Nz9IS5IAfhGb84GYeEX43Na6tV8mPV7/8q4/5aPl5jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweUBxot+Zly+t2sfG931KJSsblBSfMNPf9eSvdxvGzc/kOO/of
	636szRFEQJkmqVv51wzfqQcf0Euyd0C4IW4Bkxq93Wl1irZvBI2zOKlAMnM8lE1wlEwwBMb/p4E
	rcysxlRMLewEafOE+G5k5erWIppsoyCXat/8Tzl31
X-Gm-Gg: AfdE7cmOIRfxQZWEsbdz+ZshNyUQplkTdMq3VRKgm+ZRLv1T9l+yAT2QSgLy4/S2gFx
	xLqxHynj2ylVMpIy0jxgvLRKWNkNSl6Z5c35+tyJL36rbtPOXiWMFFBgyTtcTaenn0ltxSHWJwZ
	Zy15Smk4HmRZW54TyE2YfgJficSvC6ypRsijyAM8sPWCQDTQRRrTVWWIrg+MPXHvsTojyuZyXjQ
	xHofVtAiTOotdl1tUHcNG6QSDc+vqYKKNnwTkIo+PTwpIEKJekEWM7OQGH5J+8BturGGnYIYPTp
	3nfSWltNtlFjYJOUa5KnUAQd4TI=
X-Received: by 2002:a53:d601:0:b0:660:e9fe:18e6 with SMTP id
 956f58d0204a3-662fc5eb415mr6811831d50.8.1781970814676; Sat, 20 Jun 2026
 08:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619151447.223640-1-b1n@b1n.io> <20260619151447.223640-2-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-2-b1n@b1n.io>
From: Victor Nogueira <victor@mojatatu.com>
Date: Sat, 20 Jun 2026 12:53:23 -0300
X-Gm-Features: AVVi8CffwPZzdgTHf5I-e4yibNUpPw9ZYTSlgla42xdPOTrEgy9qgzAZqsIDlDA
Message-ID: <CA+NMeC_jyE33TtATHTNMPBmp1nqjqnGwAPrqKVBECTzR9huwNg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/tc-testing: Add DualPI2 GSO backlog
 accounting test
To: Xingquan Liu <b1n@b1n.io>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:b1n@b1n.io,m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:chia-yu.chang@nokia-bell-labs.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300827-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime,b1n.io:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C1CF6A92AD

On Fri, Jun 19, 2026 at 12:16=E2=80=AFPM Xingquan Liu <b1n@b1n.io> wrote:
>
> Add a regression test for DualPI2 GSO backlog accounting when it is
> used as a child qdisc of QFQ.
>
> The test sends one UDP GSO datagram through a QFQ class with DualPI2 as
> the leaf qdisc. DualPI2 splits the skb into two segments. After the
> traffic drains, both QFQ and DualPI2 must report zero backlog and zero
> qlen.
>
> On kernels with the broken accounting, QFQ can keep a stale non-zero
> qlen after all real packets have been dequeued.
>
> Signed-off-by: Xingquan Liu <b1n@b1n.io>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

