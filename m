Return-Path: <netdev+bounces-273258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILCCNNyfymmg+QUAu9opvQ
	(envelope-from <netdev+bounces-273258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:07:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E4135E664
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2953D301DAF9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF0D344DB1;
	Mon, 30 Mar 2026 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="BD80Oi6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897920297C
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886488; cv=pass; b=uDpW/aZkR8eHWH83jy7DyTdqckzWIJ+p4N2ffx2IdLIdKV8fKpj6PgzjAKR8LTNg45zE5EjqwNC/5G/WYdEjrrOPf14s0va0m6M7EjFAnMxfqpKii4NEUB8Ha7J1CI12La7DrHPnbJ8QxGo7L4v4d31fIPRVpn4DlJL7CWsVKvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886488; c=relaxed/simple;
	bh=SA1vNAl0SIiwT1XVeWiojHnZ7WyhntStWscaAacrolc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDcr6DwSiq2B14wg/LDfW7A1oEjES1xupBLWYc/CHqxK99ifB6E3NM8k/jOvCgrTup3zIxUYPynUAe1PH6N/dic54kipzvuzeqjiAo++TePqM8PLJUVcSEpNBF/osX0hkmdHkvpU0+BQvwc7W3dcWo5Sd1eVVtsbazwPgZayD2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=BD80Oi6S; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82cd6614a90so17249b3a.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 09:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774886486; cv=none;
        d=google.com; s=arc-20240605;
        b=DNhk2NTFanmBYxMBKjBFKx2nAt8GU/lElx1Z9cqKjj7NdLaJpdvvYQVo8w7K6LlviT
         jTZdwORuTJH0zDu9gIgcH9piDbn8IU84gf8cHM2IQzB6WyZ0b0eE7s7pYUmWIt5vcXqJ
         fsWhJO54ehplMo44wHlW1/QPUF5W1kXd0VPWlZ0TunTzO0t5t38OiWEqD4IKFTlByEYv
         XIh6FngscqJZsTmskIu1d2cGD6CBua/pgojLggY4+gP5vhaNTK29e2VqKj8b7QtZf5qa
         h+JRKV8Z27ihdQlIDlsaWu0nk/M2IoNb32ptl2TGuqGw4mbeZ1CDOeTTa/3b4AzAfCet
         WNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SA1vNAl0SIiwT1XVeWiojHnZ7WyhntStWscaAacrolc=;
        fh=8SZ6pNiQwfFfclIXXCszV+P7tSOc1M1Kw6zsabfqBkg=;
        b=QB8csTzuUn3VU77CDrU74kQXaY1nwl7VRtfdNSRRupGeHsXIf1oNAwSQvL6lync+zj
         tiJWPTVoE8cepZarTwrVVzfW0M/vd278OpQ4ILR6KFaM8BrtSqMsqMw/9P6UhAuOe+nF
         +f7DF/+IwvJp5suOtNoY7JshwajqSujltvyFjjAOrfdTYdb8GqYQ4Mp6NmEgtsgT99dI
         uZ2ECFduHuoaCYd+lMTms/OPHvAEKgPwZmSRW1UDayYmLKLoWm9NgG2o1qdmcndNDifR
         bGdX+dSqaPvoGtQ3nM46JPv2nsvgS54+2h/hNM7LuKgJglrENHzPM/C+v9JVz5/2Ufal
         3nnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774886486; x=1775491286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA1vNAl0SIiwT1XVeWiojHnZ7WyhntStWscaAacrolc=;
        b=BD80Oi6SP5173LeDOnYYa1qbXT/P6UXLdu9ixzlIPNQ7QqS6QCXw2ZZ7INhhU3PTZe
         MhCiJ8YZYOOhnyVeCXK2jY7cYAHZOea5LHTX2BBWbU2VY//gECtzLc8GuwuNpoux9sLR
         z1AyUN9ry965VA5q5u/Keh0GdzvlnPhhist2O3DwUtHZ5bRMmXV9pDirvwtP2bmKPaGZ
         WqMtdWw81bBqeSH0SoRUYBRszgCHFy+iKtFnOokpc0AVK03wUepIAO7wj2ElZi73nowv
         CRGhh5vyH18ffiPSlk7ZRUT2iwkVDXTQ8553NprMlODhdBLi0Z+6Jn1C/WinnaWU1fcK
         0uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774886486; x=1775491286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SA1vNAl0SIiwT1XVeWiojHnZ7WyhntStWscaAacrolc=;
        b=E4AIQ+l+H5aj8AUzJj81F301dIwfsR23V6a+2hhz9Mqkvr7weUOZVw7+2xjPYJm57t
         5j6QFyMA2qKqRiBiFy6Lzj2ijCQliP8VYAfivkcngrQZmL27JHOkq44hrevNYv4rwqV3
         iB0cnXZk7PJrJq8rksTdt5hw3GOkzrdYTXxPO4lAPtpGwezlLI5fW4raFeloSzxL/ZL9
         p52SMSYmeuRFDnrE3Xz2AwY2Y8n6iG+gmC9vE33Ksx/B+U1T0Hlb+9tjCF0zt2e+6ZU8
         MeBHLFrQpZkegf48OjBkSgoWgnxtqrstn6js+VbZHJ85XCvlzXfvEhlUByKHlvQAtoU9
         xUaw==
X-Forwarded-Encrypted: i=1; AJvYcCXGny30Vlh74UhgeLVoOJuPPG5ftzJTgy2XO/qB1KAHXUrNMheNMNvZk+iegXlGk52wEUoD5RU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4E44eZIQF8MhiMTJrkof6AdGrUsdQqHh9e/s7mw/9PLtsDHY
	t7jYofLUaIEjjor907zX6Z5fjoQnB/L8rnXR6B8jGS7ErNa7zDZelxkY36xVFUAC139vOs2RJ6X
	daxNTIXAPSSUyOvWmRCEVG0ositKpzeDR5NvKxh6NwXzft6SgADg=
X-Gm-Gg: ATEYQzwra1plcbkuX1IJzzPAmN25IZ7IXPBCqrxbtQsN6yr8M5SALS31FHmiMPqxe2D
	50HrthlbbWgf7AxJE9jF1fBEh7Ul+KDjhKDaF+s8krIawI5D4ATNwwOsaLai3H7UC17krRs03en
	RTtwfktUJiSCOvBeh4sPWxFecjso7f+8RLQN+XfGOhfWoqDdroqzVVgpPQ+RMFIq4cDkvKpAe0/
	wEDxoHQuuQHc/6+T49EJhYGbYqKZpTqyPqGCoX3IroBBjj0tdio+1MNiuzdRsryqWOFIX+fvoYb
	jfB/C9UMMPHfjZjzYlc=
X-Received: by 2002:a05:6a00:6c8d:b0:82a:6d7b:cd3e with SMTP id
 d2e1a72fcca58-82c95e43ea3mr12467518b3a.19.1774886486266; Mon, 30 Mar 2026
 09:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326181701.308275-1-stephen@networkplumber.org>
 <20260326181701.308275-8-stephen@networkplumber.org> <cf7128a8-80f2-4d4c-8c68-2c9f386cedb2@redhat.com>
In-Reply-To: <cf7128a8-80f2-4d4c-8c68-2c9f386cedb2@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 30 Mar 2026 12:01:14 -0400
X-Gm-Features: AQROBzCnwG59BIciIlocIyIEGszWFfU0bDPY6qm0X28Xi0JW_3MFhh45-jLdDfc
Message-ID: <CAM0EoMn126L20y4Pw2=6TNOE=Yy0mRPA4TfOC_fGyxJNQTbX+g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] selftests/tc-testing: Add netem test case
 exercising loops
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>, 
	William Liu <will@willsroot.io>, Jakub Kicinski <kuba@kernel.org>, 
	Savino Dicanosa <savy@syst3mfailure.io>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-273258-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,mojatatu.com:email]
X-Rspamd-Queue-Id: 29E4135E664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 4:06=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On 3/26/26 7:01 PM, Stephen Hemminger wrote:
> > From: Victor Nogueira <victor@mojatatu.com>
> >
> > Add a netem nested duplicate test case to validate that it won't
> > cause an infinite loop
> >
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>
> Apparently the new test does not pass on NIPA:
>
> # not ok 364 8c17 - Test netem's recursive duplicate
> # Value doesn't match: bytes: 294 !=3D 196
> # Matching against output: {'kind': 'netem', 'handle': '1:', 'root':
> True, 'refcnt': 2, 'options': {'limit': 1, 'duplicate': {'duplicate': 1,
> 'correlation': 0}, 'seed': 6495514880116664183, 'ecn': False, 'gap': 0},
> 'bytes': 196, 'packets': 2, 'drops': 1, 'overlimits': 0, 'requeues': 0,
> 'backlog': 0, 'qlen': 0}
>
> It's not clear to me if the causes is this series or the follow-up. I'm
> tentatively dropping the latter from PW; let's see how/if TDC is impacted=
.

We should hold on to Stephen's two patches until the skb bits one goes
in and settles.
Stephen's patches change the queue expectation which explains the
accounting mismatch. Stephen run the tdc tests and fix any changes in
the accounting...

cheers,
jamal

