Return-Path: <netdev+bounces-269476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILpvKW8NvGkArgIAu9opvQ
	(envelope-from <netdev+bounces-269476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:51:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B682CD31C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5244E3008E32
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07A135B62A;
	Thu, 19 Mar 2026 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lcl6v7Xz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857DB2DE6FF
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931882; cv=pass; b=nn6Hxkoy+eDUYksI+l16RLdgd3Yb6fCiyXbjdgaevlPoXtvrFz5LR2seEmrxXp/i6rTG8G8wf6S/gFtJoqwInt1h0Z0QXinD800c/2hHTelBp80RBnUfO3r9mmmo+zwzEPSv20ahIcY2hqucO1Oy+C1l03XlLdfE8UN1KgnykjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931882; c=relaxed/simple;
	bh=hZ+YcdvI7pBSyjQzHPG1UsK31P4QEMl0YPmeWc1BqFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uM4ZzZSpaayoMP+ee/7OmOw/7E4ZrHsh2rHAUnO6eWtSZzZIbGkhAuhXsusIVCnyNEnJxi07baVXKmgZty1WEncU6XtTIlusMq/eeK0w4fgoJwhMlFqU3J9rBeCvjSYQh2wCkwv3dvyIS0UroOILJEcloZV9KsFbnL2uo6L3hAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lcl6v7Xz; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-509069a7a7fso576161cf.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773931880; cv=none;
        d=google.com; s=arc-20240605;
        b=YL+uRdiuQIOtxip8s6Aqi3c6rSBvvQ6v/rNYlvLoqupNLd6D1gQyOVSvdiQ+hFFjae
         notfq2HdxKJAdYcueNSTzEDVR15JbJ9D/W+iCQqIGgqpg8iTj1AaENdX0v0Z7hPowYm2
         swVnBzP0PTbOZez86hUDDae6PZd0fbWcfJxsr4jhYIdPu+M+RIW8gV71H8yNBSZHKAN/
         AH8qXM90Oe71Mm4xyFGOoeWwH4bepuYSgqA3S2ovmTPzCj2xN/UoqAFxHbE4lsnMUT13
         m4iwOWHbcPcN7/vP7fd2CvaKwanOi0MnCuWzqBCo5yhdc/49ERZaTvS9snFeL8VqXW+u
         8EWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6bg8hlmqM/XCpxC5ovJCSr3NN2SOzHsrvJ4dE+9xF3Q=;
        fh=98FzPiUd0m8Hs5SQoH8zTTpf+9dZYwDJUWi9SYJPWWk=;
        b=EE1/Vob0IZDJ+MAknN26cqae0gK7aAeiHPtM9WD0xNA50P0KpnPaDHpeEFOxNAYnra
         o0KDbviOmPyQxl6eXsM6EHwDB6VnTBXG5/zPgoDWnARVr4HgwWm9bbbORcnjSdNZgf2F
         SVYxC8PQ9CgFGKuRIBC6ZPzeIwCprzkHXvMyfyW7a6UQpEOCgDhZDpOGG513Lwuz/trk
         OKSHabX13bdTXfJRB6KRZYl8tujLpyQyjCdhq8oFh9Of1LuAvAb/PUoOvincAYeFIZKA
         fkPsr4lzy1XhRsQ6nNcvABQmRyaT35LFypS7sAoRJ43tmQFg+goA6vmLIY5lxqSivjhk
         4FwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773931880; x=1774536680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bg8hlmqM/XCpxC5ovJCSr3NN2SOzHsrvJ4dE+9xF3Q=;
        b=Lcl6v7XzYkpoGnFZ+nuYmRytYtoJL2BCyEbuO4oraYGJzqluh2g4FjZTLUhNWWN505
         rX0dZRLEVaRq0WRL5MvQ4GXxOt5Q+HF0KvM33ZePjOhGmocARXNW+G+TVaXrwq62Zr3E
         EgFMoWeA1+izyK5v7M8vHadUcw7yTmHPR+Lkry+2/qmTNrzW4mWQKJSlbvHqSAjhH2Z+
         Oz2LoaeDpbnwGzitsBc0eLVFlWbkwQNaCocbYz+YEIQrSD9+9liQ9LDHrcUdx/+cvPpH
         qlqdKtgecbr63xsqUrMCoNtNYpRB8KYmhSdYBo2QzYOxzUnuZbJCmSt2IehI7uPEKKXR
         N5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773931880; x=1774536680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6bg8hlmqM/XCpxC5ovJCSr3NN2SOzHsrvJ4dE+9xF3Q=;
        b=em7Yy/IOWtCGQiBtusCArcvhcfmE+fFwDyhAgclgPpE/OYfPqp4uoJuqQXFO+3BV7P
         usJVZXxDjv4uZbnN3cp2Vaq+5jbkgrLv9tJtLlibIZbhQbu49/odGRwVgkFTSZHkjsVG
         rISoT1YSnhy0f5vMXWrrrl8hd8W1jJ1cXyKqhQdbP11I2etp2LUsKK3vbdACDcDbIU8v
         Xtj9f4RAag1LKn3PxIUH7axSLZi81mcd52XigkH2lJVjhNAOBYsOcRUHO28AUBiZ1SR4
         87QMFbQaB6gaPHecPHiQvLfAFG21ymzWyKvANRFXL4LNdHD7hXSMoxNSGS1PEyVNI9aB
         X3gw==
X-Forwarded-Encrypted: i=1; AJvYcCXIA+NIKidbp6bn5mOxAUZ3NeIjCIcDpWesbuTdgp/Zsx4TtrCc/9yeOUb3iiyyfFMvwDw6BV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywphbf3Pn4LDmWeOgN8jxMMb+7456fGDumq/ob+IgOeGQQfpu2w
	d5PUwpIS4zXZ2C2YiEMzD5BOB1Rts+y2/EhFOl89F7lYZbE4A+0j1OCcPre6glzyoUcq0Wj9zzT
	YPEQtEvPn8PX5fJ2UO3RpCpVdHEle58bkNTIrQ8UX
X-Gm-Gg: ATEYQzw1hBq6ty+KTI6QzG0O/+L4avywdV7OE2iATk6+EGG20twxG0E1FiniLGRMEbS
	snQ/TwgxPTN0A3t0BXsNTtF+3nnbvoX+Ia4SVsbJJzLLqxyCgW1muWysqEvp0Cxbe089JUeEx3c
	cqlvg7Hy225zPUbXWqUKdehfQabi36cYjbgmh1ldXm4vWKGB1fbqcQGBOcw/+1EWWItZXB7oZXy
	Tm6IsqmM5cFcTzyP3vazvoC/LnY9U+XFyd7YT3Wi+eZa0yZLpej6csKhi/R3t9k3pXtuLaz0dv9
	YNVwr2ZuaMPyZOUj/PSRUi/M5zTFRvMOW8zTic2CvCyFen14EX9F0Qpa276YrcbbzA7cMAh9
X-Received: by 2002:ac8:590b:0:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-50b2558c63dmr14119311cf.14.1773931879336; Thu, 19 Mar 2026
 07:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317065137.1533226-1-atwellwea@gmail.com> <20260317065137.1533226-2-atwellwea@gmail.com>
 <d0ab8cc8-f734-47d4-b402-9c62ae563b4a@redhat.com>
In-Reply-To: <d0ab8cc8-f734-47d4-b402-9c62ae563b4a@redhat.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 19 Mar 2026 10:51:02 -0400
X-Gm-Features: AaiRm51mxR33jgYOwzHgEw2muxIQjYdY0oxzeNITFosPwCcA1uPkaKfbyhmFcCc
Message-ID: <CADVnQy=raqQ2dKwJZh2U-9=c_AEwoCS3i61oL7gUSASxBC1QVg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] selftests: packetdrill: stop pinning rwnd in tcp_ooo_rcv_mss
To: Paolo Abeni <pabeni@redhat.com>
Cc: Wesley Atwell <atwellwea@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269476-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 68B682CD31C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 6:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 3/17/26 7:51 AM, Wesley Atwell wrote:
> > tcp_ooo_rcv_mss.pkt cares about the OOO SACK state and the resulting
> > tcpi_rcv_mss update.
> >
> > Its exact advertised receive-window value is incidental to that test an=
d
> > can legitimately move when unrelated rwnd accounting changes adjust the
> > ACK window.
> >
> > Drop the hard-coded win 81 checks and keep only the ACK/SACK shape and
> > the tcpi_rcv_mss assertion.
>
> I think it would be better to keep the test updated with the kernel
> behavior. Having the pktdrill tests bundled together with the kernel
> allows for tightly coupling.
>
> @Neal: WDYT?

IMHO our experience internally with packetdrill tests suggests that
assertions about outgoing receive window values should only be made in
a small set of tests specifically focused on receive window behavior.

The motivation is mainly toil and velocity. We have over 1,000
packetdrill test scripts internally, and hopefully most of these will
eventually have upstream versions.  If we allow assertions about
receive window behavior to be sprinkled among all tests, then over
time we may end up requiring edits to hundreds of packetdrill tests
any time the receive window behavior changes. And the receive window
values can change frequently. We have generally tried to remove
receive window assertions when we've discovered they were included in
a test not focused on receive window behavior.

neal

