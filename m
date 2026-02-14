Return-Path: <netdev+bounces-258706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK3tESRykGncZgEAu9opvQ
	(envelope-from <netdev+bounces-258706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 14:01:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D67413C02D
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 14:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872DA301F487
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D193E2248AF;
	Sat, 14 Feb 2026 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9eqiJ1F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D207199FD3
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771074075; cv=pass; b=XWkGkT3QLzC26GvabPAh/JbPTn7N4kMQVXo+2Dytc7xdMp3mxp8BDSOmy3KDC0YnRUDY+fNtuFmtnnJIJniuFYPewtvjRYeyIlmqWEPB/XvCeGLfRt84OCKfbicP79KE7HnsXuiW5c9MDowTNBgVgRV0a8G7EvDkSElJtzR5cv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771074075; c=relaxed/simple;
	bh=UVvdnDRJr2kD0oYUX7odA6IoH1xTKbrRST2CqAtkRk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXOvBWrzNupUuDo/2N79csJ85ftTGtZXyP3czYceuU+l3aJhU4TNIMt0pLr1cDpYUvj6+0ws9QljodRXCvtS/m+deFs0N8JRphfPUdsmjhBQiu/dKnLEi45MJmvAAAhna02FRfVH2edOHnU0KRDJ2jGPAChS38mzo6qlBq4pUWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9eqiJ1F; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8954a050c19so22004066d6.3
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 05:01:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771074073; cv=none;
        d=google.com; s=arc-20240605;
        b=agOJzY2fk58ii7Hbk4+L2SR8pvkwCGQeWIdrB+FLaQPTuglbMrBYs1GJEI9iGk4trX
         EYXu1/koGDA9U7/u+RzQOYP5uoA7I4F75Cr1J5/zvOPVFOVMV+RS1YbMjyggy7DKZiUv
         wMD1lr43WBDXw9Ftzdo5GLb0+EOeMS97WD33yveD9NL2p2JvnKviORGRyagRaeA2duCI
         yPw81SgOyfiM6M9gmnzBB2GctdMc2Yv/fEm+bLD/AJOXyonAkFw8mw5//JgERrTCxS4z
         coSMKm9LUL/Nd69FR3uk4AGHaLpfvoRFsjeKnslME4gsJin/prf/pmVJfpok2Pd9zif1
         U/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YdUTZsFl5bpF6NmVxm8evaaCGeeYEOigAAa6PKtN++0=;
        fh=Lq+14XTYFZD8eF4SrHmDi22pvxUzBmtnvvF1vBiMdu4=;
        b=Aa4QHUEPqdr8i6iEcggKax+6yZJm/IHvzqHR6YqhV6/1Mw6nJFvTxZl+ZmBcCZRjC8
         h4/81N4Hp2KeH68oKta2/U4CMxvGLVdgOn5dbF2yechFMpVEMFWt/a30BUxVIpOQBVMg
         v3Rf6TgFI3ve0rdUZROrGP5hA3MgTHaM6hDn9jfjhTlvs+ZSNKhZbNsVA3e8qE0dw7XT
         I9L00B7aOIXAQF7s2hRvjHFXVxbu9wF3k3vyC6Mdfb56lUW9YEXf028JyVHA1077aTWj
         vlUFviPNEEKJgR0KSsT6KoU9T9+QYSoKXLiNKOyoGIJvJXNJzEUWPCg4X9evc+nPJ0y/
         MUuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771074073; x=1771678873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdUTZsFl5bpF6NmVxm8evaaCGeeYEOigAAa6PKtN++0=;
        b=H9eqiJ1Ff5IEtzebH1qgnaK99M5m9T06nea8yeSlDhhGAlC1YqOI8ftlKsG3P+KWVp
         q9YgUkrEddLt+33bccZJustYIc05rgydZC9j742oPH4TJ3zG5MUyqyHPjtoD+4fXpuP5
         PiOd4YMT87jV1dhyJU27OdbY943IF284csqmK2iFoVeKUqFYer0uYYJfKaoN6j2rINv3
         YnywUAqQwpLUhctOoPveouGkE38i6N5LZRmFGYITAr4Ps+2MfSSO7qHZU9j+oZnV7k67
         RsapFZGYmj8Lebm2qOScVFWa/3io5MDp8js3KUQwywookCWS3tltYYWkVnCz8RqjZzKF
         1N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771074073; x=1771678873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YdUTZsFl5bpF6NmVxm8evaaCGeeYEOigAAa6PKtN++0=;
        b=ZGs3ukkXfEt2FpnA7dDIjO+F8oke1mE7uT/tXoQRUBc20ztPuVZP2Pm8Jf9beEnrTf
         Q35l79nlZHbQ3N7uXQVs9zO0WOvcCQ6TJXqWzJNt5YV9OzaoCN7Vld2JEsJpj6v1CQZp
         Lf9Vkdoj1c74vH8na/qDWCVRvf12rUYjgTlJoYB4EurdvWqb6V/r3YgXiKYn+mOIOU/d
         N1m+A0jyJ0M5linv9/4dbuXFOqeu5g74aagabnPZSlvZ79Gy4Y2SUqbSf/jl4tgF4HFW
         uHryw5DhuL7ySaquPmG5XvZA8sArlUaT9+Oo3bhutqsQ2CWeWlrJJXFCqT0oWmkbpxGy
         UOuA==
X-Forwarded-Encrypted: i=1; AJvYcCXIHz9P3lNKz/OmtoIgaajIyMe/wvadyxdI8mTTntxBfZcUWyxhna5mxak8JwVWWQEtp9YGTSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNEo/HZgcY+zzjLiZ+WxS6oDRROpXPf5uZwY1teIQHiUCHmtq
	rKO2ZOJu7i1cJmXWc8wLksLH2te99O+cCT7egx+a1XXmySR6DfbTKgQQ4/+LNzyq73saseKwI25
	BcrVlNoOq7b6rshQLhO4MNmBDmIm3gSavY+oqLbiD
X-Gm-Gg: AZuq6aJ1uukRVSqNDSK8UodqeRKR5poY26SSuVP4s1OjympeyXh2Rng/tniFYJLuXCK
	2Z11PudpvSpv0TA0Bu7pB6i4XJ2WFmNn2hTOmu0QTagEJCRu081/e8gHOwDaobtdTf4nmn+AhPA
	OCRi36e9wN3SrU9wkkSMf7/8kKkEyQ3N55qCoi0jKU5AUPnTxAO0yh85Ae/5QbMNAscsftb11gr
	CR+mMA/vZQ0dIyrYMGvm/YWfOiQ8c5N98oXvfJlCL/K2ziLH0ekObR9BLqvBA6o9vNi9NP+5ca3
	m2dUqTWvC/2CBJ/muw==
X-Received: by 2002:a05:622a:1391:b0:4ed:b94c:774a with SMTP id
 d75a77b69052e-506a67fafaemr75605031cf.5.1771074072773; Sat, 14 Feb 2026
 05:01:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5F0CA7F84A4F08C62E08F769@qq.com>
In-Reply-To: <tencent_5F0CA7F84A4F08C62E08F769@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Feb 2026 14:01:01 +0100
X-Gm-Features: AZwV_QiWjsSxZ6FanKiwL54crukf1_FgVncxPwv5Xl_zSTWbwgmCxPjeV8Rpah0
Message-ID: <CANn89iJLz93=fei5hmCs7jOxFjAfqt4NXgRaJB5ZQpGpPbfRjQ@mail.gmail.com>
Subject: Re: [BUG] Potential Null Pointer Dereference in udp_gro_receive_segment
 Function
To: =?UTF-8?B?5Yav5ZiJ5Luq?= <23210240148@m.fudan.edu.cn>
Cc: davem <davem@davemloft.net>, dsahern <dsahern@kernel.org>, kuba <kuba@kernel.org>, 
	pabeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258706-lists,netdev=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fudan.edu.cn:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 9D67413C02D
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 1:47=E2=80=AFPM =E5=86=AF=E5=98=89=E4=BB=AA <232102=
40148@m.fudan.edu.cn> wrote:
>
> Dear Maintainer,
>
> Our team recently developed a null-pointer-dereference (NPD) vulnerabilit=
y detection tool, and we used it to scan the Linux Kernel (version 6.9.6). =
After manual review, we identified a potentially vulnerable code snippet th=
at could lead to a null-pointer dereference bug. We would appreciate your e=
xpert insight to confirm whether this vulnerability could indeed pose a ris=
k to the system.
>
> Vulnerability Description:
> File:  net/ipv4/udp_offload.c
> In the function udp_gro_receive_segment, we found the following line of c=
ode:
>
> if (!uh->check) {
>
> The issue arises because the uh pointer may be passed as NULL in certain =
situations. Since uh is NULL, accessing uh->check in the statement could re=
sult in a null-pointer dereference.
>
> Proposed Fix:
> To prevent the potential null-pointer dereference, we suggest adding a NU=
LL check for the uh pointer before attempting to dereference uh->check in t=
he line.
>
> Request for Review:
> We would appreciate your expert insight to confirm whether this vulnerabi=
lity indeed poses a risk to the system, and if the proposed fix is appropri=
ate. If there are reasons why this issue does not present a real risk (e.g.=
, the NULL check is redundant or unnecessary), we would be grateful for cla=
rification.
>
> Thank you for your time and consideration.

This seems bogus to me, please fix your tool.

I would suggest you stop sending more reports today.

