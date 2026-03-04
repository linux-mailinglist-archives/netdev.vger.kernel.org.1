Return-Path: <netdev+bounces-263579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMrjJz2yp2kfjQAAu9opvQ
	(envelope-from <netdev+bounces-263579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:17:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6FA1FAA2D
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 613EA302260A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 04:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460DE37E2E7;
	Wed,  4 Mar 2026 04:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltett1aX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED278327C13
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 04:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772597818; cv=pass; b=G4asTF3hOSVNJq3yfCIQjCqEJ2kc5VuM3jDWbGhy4eKYxVESZlEQaNgIcvQI1pS8iDVSSt+nRbpdCiFUX3U0k4owYD7dzaK5o0JAi4lj2eFZ8PdWeLoZ20hU3qyIlbGCAhFJliy27Nq8Dl2F1e+4fw5LSyhCuF7fBxVUpVc8t3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772597818; c=relaxed/simple;
	bh=yPmACYW6vztC/1Of+1uRXukRBmKyCZbH/I1KQ4BLctY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8iAPChLMlU86BAo4gzxR2Sr5+kyvkjH1Ru/N4MV/8GgcTxmjs/64UBjRPnytwlcGh7c996bKlqdhCGO6EZHUMVn3BAHGE/onS1xLME3dth1Q1CXM+VwhhQd9hqmiMWGLAr4CF+bpWYwTXbzZxyFIeWVvGOdcirD6LBlIC/iev0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ltett1aX; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4be94eeacso6899545a34.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 20:16:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772597816; cv=none;
        d=google.com; s=arc-20240605;
        b=LLZVIdasz+32fVi9vcSIFdsRBjdMVhzGTeuzGgcRqgsWXVyQU5w54Cu+oJ0VqiVfOZ
         Ze27SMRO9QRb4rqyH3iXX1499630iqz29BvlEvqfXL4aVblKVhZfUf8pzlphYl2PYSg9
         AvwnLp/f4zDBLBQbEKGvdYrzu/Osi+OuJqlciK4orqUNx9SV4lqU+uM+kdmsLcKpJqX2
         YVwMxS3VTsm5giVQreZdEe28mCx1s6T/btReEeG8uouARsYrVLa3GxfmsZGjkMOApuOu
         vw4ajCV8QLMXwa8RANjmxrwtqeVsdD4jZnPVb5J0F3SFsnOTWwF5FI11PnnvF8OmyVJE
         3AZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yPmACYW6vztC/1Of+1uRXukRBmKyCZbH/I1KQ4BLctY=;
        fh=kOE9CSoyk92Nb1b+L1fxmb2+9M77Alq/C69IcdQjG7s=;
        b=fGc0n1yxYaOQmh0CpgryOWdQFyW8jc8FwWyHyqfZ7bhJr3EX2GkZ65dJU9oye8iO+/
         a6eMRazoc8CSR7fSIkBgsucEE7G1/8cN9eyRCPvO7qtNqO5fvcyJiDXwA8xei9e4Mud0
         6dIU/577nKRdws0Gi1HrBYTzxY762E3FPI/CGIblwp5CNZ7xMRilzdjN1dsDgQ1wt6sQ
         rzpMZ5I2p/5DduCbeWmlvRwi6AJrVDJeuKOJAittJhCsb1g3H435oPYGaRqEfr8vc6Jr
         Onn9DpLNHi9oPed9tGZBppzo1Q79Poy4urk2einsTvm2ZB1onWHSUoFW1igp3wm3spUS
         KXBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772597816; x=1773202616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPmACYW6vztC/1Of+1uRXukRBmKyCZbH/I1KQ4BLctY=;
        b=Ltett1aXT1nyu3+sNz8wEyZnP2tV+XvnUXK+FUPk13VkiGK5utsZlybqqt5kSfCIqf
         mcLvb3++GtOQGdI2XdeDZJUSVLivT0vMECyQDW8F9zbeiWyDtnxwNa5Kwhdu/x4JasbV
         Xhl/uTA6qvqonn50C3+jJxp70oW1hcOOgeqx+dS9bzlgG4VEuiu8J5I0rArTQb/yeJC7
         2u7TBJ8KCbDKAisbCxwtHK2fOzT+RyemwF4Uk5WydEEiQkDwU79/wHfGmuqTk380qK+t
         9pT1qdlkUw5e9CZbHor29JZ3YzLvhkyhKp9hCrtDqMDEQ1uYRJayhS2mhA3CqkAWdBTd
         YpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772597816; x=1773202616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yPmACYW6vztC/1Of+1uRXukRBmKyCZbH/I1KQ4BLctY=;
        b=FG7surXNZcgTYu+5PrqQyET10KYsA5TWS2jFsEgP9bs31qqGWk3EHRGG/zNkoDo5dG
         qU5RJqd0GEH8qQPBu6x6d2Pjlvzq/W6GsubLa/aR5jhMw6LrOsBI7M1AV6jETV4wrppz
         JIo4ixlzeK8adiZF71U4q8rlLW1H7JcYS46YJbElB3tNRnxRGhC1POObFkBwN+pk2Uby
         GH60dyHoiT3xmaLPY4ZL/O6NRPUTaDjrPFXyZ+hCl0P2ze+zK7JumPf1pthV1WffFTJJ
         PbGVsmGvA/7/kkz9hU6u8sawjrP4fdimAGsxLq8Ft7li7nBcce9MkeYpJbI9GU4uie0a
         288Q==
X-Gm-Message-State: AOJu0YxnygBF9pONx9rh8I7acdhv/KvHfQonf5fZJcUzMJCBqNtpyzVo
	sYEtfNq+ZxEOSijByhqe4Qmv1p+vijIGowmWCYRisk9CwcIf3eEvLYwJwHinvteLV94ToWmoK43
	bm/4JkTNbIK7eMcJc98wHqobsb2uLCmI=
X-Gm-Gg: ATEYQzyH5/dg7RgwvQFZQBOtgZCS+nmVveVSrwh6hKXJceU93+BRGopIIerFYbrdXEL
	BC7PJ/DJbIq/m6f2itf3hyR7b/1TyStz/rJ9xF+1JuqN61PP1wkKrm+fnYxiPNEhcd5gXSfO7su
	l8tC2zST1aWZf/eG+ZzikPocBHB4/BqqZ6XybFic4OY5y4eVP4MTViFP5PyRrPLIFEvywGSfrOK
	x1ybWLvjWi/umZpxk+bDb4b5Qn2BYhzNFcoomEvNFLVV5GWRagoNDJlLSvHm8bvybce4mLCfobz
	wiyJzCNUbUPP4rYi+AxOxifIg99xN0jm7O4+bNYTezTblLJNpMILWiLVFgXkkY7S3pOBMQE7
X-Received: by 2002:a05:6830:378b:b0:7cf:d9bb:63a1 with SMTP id
 46e09a7af769-7d6d136e4b5mr552669a34.16.1772597815951; Tue, 03 Mar 2026
 20:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228074735.10438-1-mr.navi8680@gmail.com> <20260303181700.25878b2a@kernel.org>
 <CACQ1SaB0cnBgEAiX0iTM+WXL0cXYOsoi9wMUMvpcK-04hZLhAg@mail.gmail.com> <20260303184901.011fe650@kernel.org>
In-Reply-To: <20260303184901.011fe650@kernel.org>
From: Naveen A <mr.navi8680@gmail.com>
Date: Wed, 4 Mar 2026 09:46:44 +0530
X-Gm-Features: AaiRm50AyVUxl-FJfzQ5kVIapYXyW3NbGG2Q1uoYKHOcI8oKHj5y8ByHRRo6TOQ
Message-ID: <CACQ1SaAtHqeb-H4sw0fgXBfdcPYt5yBSBphyJU7yZix7A9zC6g@mail.gmail.com>
Subject: Re: [PATCH] selftests: tc-testing: fix list_categories() crash on
 list type
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, jhs@mojatatu.com, 
	jiri@resnulli.us, shuah@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EE6FA1FAA2D
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
	TAGGED_FROM(0.00)[bounces-263579-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tdc.py:url,mail.gmail.com:mid]
X-Rspamd-Action: no action

You're right =E2=80=94 after checking with git grep, it looks like
list_categories() is not currently called anywhere in the
tc-testing framework.

I originally noticed the issue while manually testing the helper
function in a small Python snippet, which triggered the error:

TypeError: unhashable type: 'list'

since the test definitions use a list for category, e.g.:

"category": ["filter", "fw"]

So the patch was intended to make the helper handle that format
correctly. But since the function appears unused today.

Thanks for pointing that out.

On Wed, 4 Mar 2026 at 08:19, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 4 Mar 2026 08:04:18 +0530 Naveen A wrote:
> > > How did you find this issue? I can't figure out what's calling this
> > > function in the first place.
> >
> > I encountered this while running the tc-testing selftests locally.
>
> Running locally meaning? via tdc.py ? Or some other way ?
>
> $ git grep list_categories
> tools/testing/selftests/tc-testing/tdc_helper.py:def list_categories(test=
list):
>
> I guess I don't understand what the purpose if tdc_helper.py is
> but the function you're polishing appears not to be called today..

