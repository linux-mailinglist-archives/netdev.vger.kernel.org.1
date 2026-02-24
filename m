Return-Path: <netdev+bounces-260312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEgBM3sQnWnoMgQAu9opvQ
	(envelope-from <netdev+bounces-260312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:44:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBAE181162
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B1DA3059A90
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870802609E3;
	Tue, 24 Feb 2026 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvMVMf+i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AD23EAA0
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771901007; cv=pass; b=au9M2qWdfNK7D4YljrxLNn3CjT28cRUQ/mrkzI1FANWc21ZhFNBa/64K6RbWCrMqtvYEQ5UgBg28N9GRZK3whprQ5aThw13lq4dlzwJ5VUpj1xCdhZkHwATq0jN9vH4TSW96Me7GCwTMu/5hQcrub0mqQ0JzzcTAtAUswyfsmG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771901007; c=relaxed/simple;
	bh=nXBvGOfNSt1H2LHuERmtCnhuO3EyKWr3OKWW1rux2EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cA52imc0cBbouql3CtsdmJONTCEQxoFjYVHxPrgaobU+Kf1eEsEwLg7q9XOk1B+v3hCypE5FCZXO++5uzE0K8RPJ/WzSHmn+YZsIzUZ35jTtvOMZbeOFM1mFxPgKhEZyN+Rf/vIjyq1/ecilKFvjG0NpOBHsYJQo05TPWWEWisg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvMVMf+i; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-797d509a2f5so52791867b3.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:43:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771901005; cv=none;
        d=google.com; s=arc-20240605;
        b=GMG2cukttIobsxFhMGIg7FhSpj7w9yan62CWQhtbv5GuhlUq3qOYS1a7+BfQL8ehyy
         FRZz5DRWhsjtEYeZnrN/DVWi1cv4c4iHD1PpeSjFKHt6+HAuw3lJwNh3CVZOVJVUyOg+
         DTLwOIP/Q2roxHmNWYALIGqvbyutiwqPLWH288QVS3JVUZ974ad4MKQXS6Q95IIbvXYC
         vBoQlLPGPypdtYnliDztJiZ+w3NR73SExT7akzLHvUlyNoNwTRCz/lhHrPTHl6XzZRXP
         RfP01mS7jLdXWUNXwo/I2zvtSHpYKGJji8mwXgFkwdUvhwzo+pIBrAFxU6LgD2lwyH8i
         iUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nXBvGOfNSt1H2LHuERmtCnhuO3EyKWr3OKWW1rux2EY=;
        fh=PvJVxCNbFFRYpNQsur12BVPmc71DUI2s4fs2whmQKDk=;
        b=BKWK8HRpBEjK9IrbLXgbWXPqTZZzk5Rsbboxh4CPlbg+b6mSjxEuKiDH+NntDJ3KtH
         it+ztCuE6ivFtb7tJvygQEDNn4IFSlD97b0RRFYIxyoL3pb9JeWSkSPrENtVJR4aTWCg
         Q7gi3teWt2x21hQ7zVVRbTJ9irAqhZB9X+kpttt3UCRBVHG//kZzKGDFT519g7pKSb/x
         SDys+q/3dTgLEZNWGFS1iBZvCK9JQC7GVol2r5zKTJD/DnGJTKxp0xFVmJIoETKYvOYR
         XBUFapql32i+NqZl9wjbjNmr6ONhHJHA7/GratbuPXAp8xaxGivGLbeS5Wpf4Ucn18nB
         sjAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771901005; x=1772505805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXBvGOfNSt1H2LHuERmtCnhuO3EyKWr3OKWW1rux2EY=;
        b=lvMVMf+iOXn9Q0RB7clQPgRQy/xh10/PgI+6doPAIC2wfeAcWDrsxLNgNgIWdWIt0w
         YZ6aYiNPW5SHO2wrcPTW+NjFMisg24T8jXn7VUSTwSxulcKIV6e6t2V+rLOccQvupTJd
         yX1T22iBL7r8hYJuE+w89KkyJBeRzcuWNjpgKoZHqByxNPLRPeACIFmEStjloaG/HI2S
         rZvVeV5XIrgKWPOb5fhsaB75JCbzl5xbXkbImQKv+0JHNceg6T+6ay+5yIr6MxfHe3CT
         UP86CR3VXrFYZGabmhCPAkHumN79esDQPFQ2zvlITUE68Z/q1bPzgsR8aQD9ueDfTK9b
         HjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771901005; x=1772505805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXBvGOfNSt1H2LHuERmtCnhuO3EyKWr3OKWW1rux2EY=;
        b=wb3vORAxtNuHCyXYiYGqdBlgAzHchEb3DyTRl2igX+4YqqDiaZSPk5N9oQiZOpTMfK
         NTaW/ASm4r0tZWytrV/6OCBjkWS5mjPQ8ydwyayOIXZ58GPWRYR4sRe0+l6xsSJUCUjr
         0JLTrP+MgVoQVgpZZ2LCm2FtizhupAJ1H9zxL7JZx1KAZZ9fJ+fWT6Ks/yQjRI8UnbAG
         E6IgGAl6g51Q4YV2uvVJWCF6Oyh9ktIWH1zgXbfveZyXUowBtRdOWfiw9a1qkj7Sz4k0
         eSrxuZaJuWapm1TP76FjV+emqYB4WghgCAcvuVepQzp/PS0vbBF2LQOkD7+MuAkLSFEe
         B5mA==
X-Forwarded-Encrypted: i=1; AJvYcCWF3R4DifP2FcOsAQ289gK292dVOERdmx23zDrR3JawsdNNqijT55DM2XpD7h29rc62pk8tbQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdMjcAggGaZypW++kWCANdgTO/9NQ1QsZKmtQtf6pPOts28o30
	Yj0SJz+PXsSD/DgEULNnPHF1trrii8n7sbNEuNvPEIyip0ZeKZJTTHpO6UxpnLLIX/HI2FWlM7Y
	fVPeSabikKzDAW4YqUy1x531Cz3z3QmM=
X-Gm-Gg: ATEYQzxtUPKUVxsXPF8tJC1OCWNDxUCIHqleWntd8A7CfEExC4C6m0fNQa5mjRQ732W
	7J1qVuFTviIg/t4XT5fGVYtnmVBDjWC4k0ODa+AR9137DZJ9aqDhqVPLX4aMll/gJQ4323UK+fW
	GFv5o8BKJJKsObUQvZxOUIoLti1rhlYf7FWiRApIB/uN70TrB11r0BLsGDpKcgnGuIaNzbDK38Y
	Ru7+5Zswnc0mo/MHeV1P3Uc9XXGccJRz+GEJzP7EHBUQQoAgr7q1brdFb0O7R29PLGtVnqe3uTa
	g8rIcSB1mIMreLk=
X-Received: by 2002:a05:690c:48c2:b0:794:6fa2:a037 with SMTP id
 00721157ae682-79828cdf910mr84748807b3.8.1771901005394; Mon, 23 Feb 2026
 18:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222111847.692325-1-sun.jian.kdev@gmail.com> <20260223172214.5d8ddaa1@kernel.org>
In-Reply-To: <20260223172214.5d8ddaa1@kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 24 Feb 2026 10:43:15 +0800
X-Gm-Features: AaiRm518ATEfeBlaofi-GL5g91T6-ZWo8gkDvecCreb5EzR1QmwNkdtp0H9CXXw
Message-ID: <CABFUUZEuMCYYfi-SapTLT1BhYOWBk1e-OYh+h9fOZcfoSP06fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/harness: fix XFAIL_ADD matching when test
 metadata is not initialized
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org, kees@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-260312-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3DBAE181162
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 9:22=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 22 Feb 2026 19:18:46 +0800 Sun Jian wrote:
> > XFAIL_ADD() registers expected failures using constructor order, but th=
e
> > associated struct __test_metadata pointer may not be initialized yet.
> > As a result, xfail entries can end up with a NULL test pointer and neve=
r
> > match at runtime, causing expected failures to be reported as FAIL.
> >
> > Store the test case name in the xfail entry and fall back to name-based
> > matching when the test pointer is unavailable, while keeping the origin=
al
> > pointer-based matching for compatibility.
>
> This looks a bit inelegant, what compiler is this failing on for you?

Hi Jakub,

I hit this with clang + lld (LLVM=3D1) in a virtme-ng based net selftests r=
un.
In that setup the XFAIL_ADD() constructor runs before the corresponding
_*_test_object is initialized, so xfail->test ends up NULL and we never
classify XFAIL/XPASS.

> Constructors seem to have a concept of priority so if we have to,
> we should probably used those for the fix.

I considered constructor priorities, but I'd prefer to avoid relying on
toolchain/linker specific init ordering here. (The harness is userspace
and we already see different behavior with clang/lld.)

If you prefer a cleaner approach, I can rework this to avoid adding any
new field and avoid priorities: keep xfail->test as a cached pointer, but
populate it lazily at runtime on first use by looking up the test metadata
by name within the fixture=E2=80=99s test list, then do the original pointe=
r match.
That removes the dependency on constructor ordering and keeps the matching
semantics pointer-based after the first lookup.

Let me know if that direction sounds better and I'll send a v2.

Thanks,
sun jian

