Return-Path: <netdev+bounces-263559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK9bMFeap2ksigAAu9opvQ
	(envelope-from <netdev+bounces-263559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:35:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0381F9E72
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE90830B770F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D32B30648A;
	Wed,  4 Mar 2026 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWeJPMEZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE56282F19
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772591672; cv=pass; b=gLYy2II46F7r9LSpfxJqINbezSAFE1txK+Mpc/RyQma4yB53vQKnQPZXnIPkiEVtlWJ3Q479rHSyRog4TG/JbAzug0OT4jszea8eOExm7wYvBs08tMYtcXcaGnt3GJVLOdGzv5kKX0mkdeWhf5b1pboXNILY7HK67zDnVd9j1xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772591672; c=relaxed/simple;
	bh=lLvfMUPCqqBJTSJhP3cm5kFNukqeKiBLJqApsgrzImA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XK2JxQTuZzvCBwOyvfaq5r6NU0Za6vMFBd3GxXMRNR5frITHn1gvAw3QvZfRqX43HR6qigrPsDShR7z04keUN8X5fWkq7epSaLPxgsxiLqkV+OauCJwgrATvJV+lE5WzmsCzdP5dil/McHjoFhs7NHk5DBnwu9Rzv6QBRjhuQrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWeJPMEZ; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40423dbe98bso867066fac.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 18:34:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772591670; cv=none;
        d=google.com; s=arc-20240605;
        b=D63jH4/unniXO9E+/ramS4L8GNVWkoDktqo46Z4XwfBVxhJ3oFpWF4s0WmVDNzj/Aw
         xqCQMwLbpDq4tKT7f3C9vAcw7ax6oVxSpl2/DFxxpwraO993SODrgQdk0g7VMyWAdzUN
         t/5ihgRfV3anBFgFvnHcQfxO38HHPI1cBRt46uZqRYuRskBuqNpjrH2n4n2iQjv93P5I
         1vfhxtw6zK8oLcDtv0aTl6JLEGhZHKsdApKNYRrUcEExX+d1qgkawfoGs9GGhrzxWb7O
         CgfdUHETExncCkjfIq2cs48iJF/GyPEzGgdAFINRVp1q9JxFbkW4/sT4Uigeh8VCJbpM
         8yIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FzAVneWa3Xh7z4I4PhJMo14ZSKYpGv8t7blqiZcWhHc=;
        fh=kOE9CSoyk92Nb1b+L1fxmb2+9M77Alq/C69IcdQjG7s=;
        b=kC/3Bs10Q2vHZ/qAO7bmT9xYVHDOgNcvpsodUxctfqnhYHsevf0hGpN0ZvWWloa9PJ
         kUdzaxcrob1zjVKWezmOB1B4swIVbgaf9VVMAWt0//XkdcRSrwRK7J74qqIdO90cqv8b
         snmB0XDXXEc9YrCcTqtE2JvFqZRmQuzDywWxA9g134CRkS+IpblI5NLhYX8+Y252PK0H
         VGar5z9flm15cCTAHiqX1InVH4d/lOXfUoqgqVzPUeyTpPFnDao5CYNYXG8J2309BztD
         bmA+WulAGJba8pgqPK2UxbSciW8AJKxGt1LoyT3ctyQPOjBDy0H38QK1qkJvRNN6qNyp
         83nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772591670; x=1773196470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FzAVneWa3Xh7z4I4PhJMo14ZSKYpGv8t7blqiZcWhHc=;
        b=FWeJPMEZZ/Q3rcIJtvOumUZQzhFso8O6EppM13EgWSHMMq3yfMpCSyoZgzf7ZjksDf
         3qZ1IUVQGiUc2Rh2i7wejXoEZEebiBs8gYw05HXAzE0r8Tag7KveUGbf6wZAOMzgSOVa
         CmOKTYzubD7hRr5HBiPU6QSntd3PM2AQN1D+U7Et9PquoQCyFovcXLwSZQvWb4xC2idR
         YRFl/pCgqnY0m1jn3bUsJY/yIoWU7uGRhT2vgza3/pnTdHZRAjLZhgBf86hqunGRMnco
         KN2QyNnoRXFl7KP80DquIGGzy1lF7mHeuKUjYLlkcanCxF4/XAWIZe+zxdV8K1gl83jn
         PnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772591670; x=1773196470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzAVneWa3Xh7z4I4PhJMo14ZSKYpGv8t7blqiZcWhHc=;
        b=RClXrpWBMs8AHc0OD8AzcS2kSG3fNWItgWp0SPQL3eezzuF/+3b/CLMJMkmhfeKBxA
         d6XGWR+TgByf35TZtpV2n92wkwhwD2sx/63wAgVi+TiabhxSg29s3IHUcPgtSq4o/5rB
         6tvZH22jmLgfQJsV43gf23B8EztN4g1f8E7FEyYgdHGCbUuoozbNAHtNpYbTTcXhju/k
         CNBs/MYI1zRjMTUUCfX4z/NXFlCMDveaeSOkAwJPBa4TDEVhWwdJkaXr0Z3i6tSiWgoZ
         VoGD7eASu7s7IIqjHby6n5YCMrqoBvUCjGF6rioQdt7QhHaKnYCBHn9UYrDnxJ4hYyZ8
         0kEQ==
X-Gm-Message-State: AOJu0Yxv8N+aoDBhpnuudAVQH33fjGmsfqAHsQAWKCIFG5x+7d8HRdqw
	qofQPt9WnIJfM2KQTgvz2rpYs8c3F7eteX2oAB4wzwzbasi/X0Fye/a0LLxf/1pHsPI3WD7Ev2y
	yI73QRcWdwNcRDKNCOivdLBdvJ868R+M=
X-Gm-Gg: ATEYQzxiXNzkncvk4pfm6IHPifNiotptqpTjsQF76ID0g8GQefJVK9Ex1VuKlYUbOyx
	Jnv1DfZDDbqvg2EtH/6PC0bVayfQmG6NYk2vJs99+B6cW1hOcT1kGYU6Fe/xl8ZQpl07bk4CQfN
	WNf9JrXVLipKsXQjTJI6DV8KSNtiiWPumAUPp7rzhfKpI3QjPhHls57LGkCfRCerStf48u4cnjx
	A/Wy3nqFwerQi2fvmgtair6l3zlNGam20B1oIDysAXUn4Sg18aKnBE63u+ebz9HUVEXti0ehli2
	RpVB6DYgBBWkozJj7FbFU/6NDtUe1ofkM8UGuKTg08dcS1YM0JZLqCELY/KvtirQ8TLDib0=
X-Received: by 2002:a05:6871:72c:b0:409:6ea8:5f7f with SMTP id
 586e51a60fabf-416ab595928mr311211fac.20.1772591669896; Tue, 03 Mar 2026
 18:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228074735.10438-1-mr.navi8680@gmail.com> <20260303181700.25878b2a@kernel.org>
In-Reply-To: <20260303181700.25878b2a@kernel.org>
From: Naveen A <mr.navi8680@gmail.com>
Date: Wed, 4 Mar 2026 08:04:18 +0530
X-Gm-Features: AaiRm53dKDZnJe4vn8tGAY5vLRHmWRPeD1MU5t8oKL40T2N30omzntlRAwwQ5EY
Message-ID: <CACQ1SaB0cnBgEAiX0iTM+WXL0cXYOsoi9wMUMvpcK-04hZLhAg@mail.gmail.com>
Subject: Re: [PATCH] selftests: tc-testing: fix list_categories() crash on
 list type
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, jhs@mojatatu.com, 
	jiri@resnulli.us, shuah@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6B0381F9E72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263559-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrnavi8680@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

> How did you find this issue? I can't figure out what's calling this
> function in the first place.

I encountered this while running the tc-testing selftests locally.

The script raised the error:

TypeError: unhashable type: 'list'

The traceback pointed to list_categories(), where a set(map(...))
was being created from the 'category' field.

Since 'category' is a list in the test cases, Python attempts to
insert the list itself into the set, which raises the unhashable
type error. After tracing this, I updated the logic to flatten the
category lists and collect unique category names using set.update().


On Wed, 4 Mar 2026 at 07:47, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat, 28 Feb 2026 13:17:35 +0530 mr.navi8680@gmail.com wrote:
> > list_categories() builds a set directly from the 'category'
> > field of each test case. Since 'category' is a list,
> > set(map(...)) attempts to insert lists into a set, which
> > raises:
> >
> >   TypeError: unhashable type: 'list'
> >
> > Flatten category lists and collect unique category names
> > using set.update() instead.
>
> How did you find this issue?
>
> I can't figure out what's calling this function in the first place.
> --
> pw-bot: cr

