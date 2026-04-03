Return-Path: <netdev+bounces-275170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCCLHSgP0GlQ2wYAu9opvQ
	(envelope-from <netdev+bounces-275170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:04:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C2D3977BD
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5196D3009810
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBFC363096;
	Fri,  3 Apr 2026 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="LDFHGefQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064F34CFD1
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243043; cv=none; b=EzhF2JnskMfvJfXxgNO7I2ucsZttoWAnUwrgV4kIVPSj0cKTC8zb1VjcjSzxlIHRyfy9CdoRL0aNi3B7frVrQdPQg9mbM9MeaO7aKegxO53eUD+rHNq3+3BpAvmnwts9zp8668gFQwjUkslW1dcqm//+bYCCkJjhebuVSfvDiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243043; c=relaxed/simple;
	bh=0mMwqsak03jT0m6LuqHCgjHlJIdXelVwMbfb/VLpqvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZklBrKm275nhztbqpQ6DpH44x+6cdSBEvH6psqO98CvcDiv/uao9FgmfNp4h5HW+jadUZZYCRrGOPJOx/vYay8+tDQ6KUWvJZX+KFnKyLdme0K2llX8nHPMC0yAG7/vBSpjVxFwkDj7p00XY+xf/tcrEXiXut4rTWmqxyn52xkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=LDFHGefQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76bc3e8de3so850097a12.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775243041; x=1775847841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDV8wAiAFRy4IFjWNwe4oJsu9yhPXzTBHR8DZiiXMq8=;
        b=LDFHGefQNwCIQ8OxueXbweGs6HF1hDjnK0AIAobR0vuvhbFHwd9UEk17nGPkHg8Gao
         e8cbN5HPdfK5TH2Uw4BGKfsdhvGKwafG0VH4TenVOWvQq8ESwSuApmRz+pZSQyV9Gjv+
         3pxwXadBaiNP1vKMrFqKaTo7vD8B2HAQIYcJ9ryMNAqG9MokxkPMDCdVQfedgjwc4vll
         s1wJgjAfg59bqoW0O+cmY/cAJZcRWKPTCdVNv+kYuRErv9MTpyLtR1zEgTlUgdewvLZn
         Mucj0ZVgOhANlkjoLZGN10pC9ypGNNm11lrPu+u7wXlhVsXrLWp2NGoJumWLko/bWwOS
         hgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775243041; x=1775847841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mDV8wAiAFRy4IFjWNwe4oJsu9yhPXzTBHR8DZiiXMq8=;
        b=ErYTl5sy5PMp3BHXsABFfWiG8Fd+BVvkfhJ9qO3cWCsXHz+VTpwYlPs7z2VtL80/mO
         Nlhx+6GIfD155sYBQyITweqzhtPsKpIkv3YBZqd5Bdu3xjkmmbC9SiNN3lWb5Fd00aXj
         hZd7zyckStxfEpWrtskIsM/aYuycm5GLKUH2r/P7PU0qAanodBgGT3pdX5M86IREZQLy
         QPFnd8lB4AoQHiMM6JwTCcw2DewR1pfUJxu0ZczWVjZQCFhDK/3EFMG87+7H/TxLymX0
         YgHYuXD23KwGOk9hArLIzT1s36Cj4vsQ8ENl1As6AhfUbvBP5Pon7CUR0MDF+EHJTsYE
         5+fw==
X-Gm-Message-State: AOJu0YyULYtj0r3VWoagYSwtBdxEm3wGaM+RTL/9h4Sn2Ihv6+hZcpvF
	BVy/qFD2RFGmRc3HXms54VBasvqGEzEb2Bf+SszFhK01Xn+9S3KyPm2h0Wu/H5gtpDLjgKRRrqh
	Kfqvb
X-Gm-Gg: AeBDieuUGlf2+bE7xlHPbu+l3kuzsuY7sbioHKC0Pm1asTH7lLIhG4hfSLx1qjD3Lgv
	z0CamrGMC/ARL3YYmxtw6a7HioiKSSScOlUUUm+Ei8wde9tDhNa3u3d9sMLe/RbAR2VVBFZ2xx3
	xp1K5OwbY0FHOChN44tkryZG88MzBpNACaBjxbFQ0xsT63zTemARCeFE8Qisy0vuXDFS0tX+Nde
	mry6LqPBNBq6MIq1vZp0Y/Eqmc/rF3/PEBuzt7suC9jqOG/1jgG6PapVEzMqY0erbZLK4L8KIo8
	PkXWYDETqZigv3kOOvLzm+XPQyefFC1CZjdUyZlp3WeKm6JSAJGyxu6ieYXb9DrVuBeyG+A1lOV
	yIki0hfag2yiBxSGW0TGlPyQptRtPSvuMzNAqeoKnGAOG+O5TCjHhqekWbSD8vvaNi0Y40nZyvH
	d3phNTd70UMrb5kcaJ0fl8mJKqTvBFR6NITS4qFPplj6dDXg==
X-Received: by 2002:a05:6a00:408d:b0:829:8c23:f70e with SMTP id d2e1a72fcca58-82d0dbabbf2mr3952303b3a.45.1775243041192;
        Fri, 03 Apr 2026 12:04:01 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b60199sm5965694b3a.25.2026.04.03.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:04:00 -0700 (PDT)
Date: Fri, 3 Apr 2026 12:03:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v3 0/7] net/sched: Fix packet loops in mirred and
 netem
Message-ID: <20260403120354.6e926c05@phoenix.local>
In-Reply-To: <20260402174906.0ee218f2@kernel.org>
References: <20260326181701.308275-1-stephen@networkplumber.org>
	<20260402131618.21624737@phoenix.local>
	<20260402174906.0ee218f2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275170-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,phoenix.local:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 46C2D3977BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 17:49:06 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 2 Apr 2026 13:16:18 -0700 Stephen Hemminger wrote:
> > Why is this marked Changes Requested.  
> 
> Is this a question.
Yes a process question what is the blocker? What needs to change?
More review?

