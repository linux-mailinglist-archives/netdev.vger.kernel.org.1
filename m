Return-Path: <netdev+bounces-272586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOW5M4uPxmlLLwUAu9opvQ
	(envelope-from <netdev+bounces-272586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:09:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347AF345C88
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19DAF30488F3
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C66530DD1C;
	Fri, 27 Mar 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UOAqZg//"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21FB228CB8
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620184; cv=pass; b=Y31/u/Nkqux4S0w3EzMOg5MVFjwCL8ULFVcmFJj8iTsmcECANMSTnH2eFKDo0YWx/tc5DKqWvVDkPmOYJqi0uRzu7Domt6opbgJ+D+Z+30P6JlKKbxI7Yg3lo0jvfIw2jwQPdp9npimgdJ1ArziK+/WamVQ3WkB66hOiPpU3fEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620184; c=relaxed/simple;
	bh=EdiHbzs7tbbxZdiNznL+MYlm/9pdXHEs10SuahVsaQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjyWcSJTrZc1J2Wb/MfK3QfjdFpW5Pb86zQcdmWmRKtOz3YcpKlDQEyWMPzgeJRaMFivSaTtDxFItDyALmCebplTjLbzI74K5qLctjvFC1Wn9gOAvcIbwP47iLbfO644IEOi25tWjlokChZXsZYkhY5jNUQj1fseWrcKUXyyliw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=UOAqZg//; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7986fb839f5so21071107b3.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620182; cv=none;
        d=google.com; s=arc-20240605;
        b=TyWv2o3rbDLo/ZSL8ILXFqGndPXmgLM//1dTrfB6FoSVJavN4NrgBEQaPuMQ4qBM1m
         5HztvxvQTTFIecSy9BnE1lv6udxglKH6HKbEKht+e9EsVHeP8LYl+G6DZV09PNQjmDjx
         SIcwXdy8UMLqEZyG/SpUSBhpbGrYPu2ficd0+NO86j+rF1CvqRHImF3jKP0rcRHiDbpB
         VIzkeqxt9XQec2TBstS5+idMU5HnDBYUi0LqgvLqbG9rjaP/dLGh/ilVC6L8e1xxf+xt
         FAqNA6mD60wlAGPw7DksNZM3hqLsfnwg1GfgwOEtmNPAryy9wkMPo2jv1W3/xWuUPjuI
         TqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zAAf+Z6LkyD+nZwfs2syZ/0+ZgMwxk2t9xbPv7Rweck=;
        fh=ZwAb6q0ETvmwS8aeJOKH8d+5gw2m2UPC2vV2DdTxxQw=;
        b=brbYiJ5ou5ry0tlhjmFVESeGO4iZpFuLDGd/B5NrSGrFOg4kLjio40sjTCAKyZDerk
         SpgksHrd+CwJv4LRTH6MSHPkZ5oSomF6Px6g1+dNw7XxRO+0WNLY4nCE6dOhYXEsRg0q
         /6CiGc8XikuZfabT0QuL0oM2L0j+mzp9ZTDuj694m0C7d443e/YCTQk2g7dB/l/9CIRx
         Lh7wjnSJgy1xa/5OjUDOfsxumsEHCWqP/bRaPeeoCN5JWnhZ3K2GQnHZkWwqlyfF9foX
         1EV6DT7E/8aiN2UvRNJV/ZYOjknEFTGifnfhe2FcZl99Y8yXVHCTCORe4M2sX97YYfGy
         qq3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774620182; x=1775224982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAAf+Z6LkyD+nZwfs2syZ/0+ZgMwxk2t9xbPv7Rweck=;
        b=UOAqZg//wdBLoqXL+w/BUBsDZwg9ID5mqLTEYZtFWTYA924h/+EAVinmMxSpPligsV
         x8xghW82T6m0mCpTDBYTwyn2d9DwIPKmiV6sYpAjQoGC7mQvMCDwZBHjWHJxxe5ae7YX
         GRLEJkPFsYZuB423L0+gtJ47oawQArTPLTU61EPEO1r4EruqunGnedFmyENlt32gyjZK
         fkodAAp7mCsJR/XeLn7Z7Uz/e0yPwouNevqs9o/xz0XJ9vDwZzyiw9HlZvg2rgzWnP8j
         vsImctNYomwlplZC3TduX7MXzlyuWeEYvsdM5flgpH6dzwGiG+nckFCul/XB17RDehGY
         097Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620182; x=1775224982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zAAf+Z6LkyD+nZwfs2syZ/0+ZgMwxk2t9xbPv7Rweck=;
        b=c2cImN1MYkA5IthKZuaE3EQazBFwcfFoGeEUWzcHqczT5fhL3va3828XjBrT4Uy1mB
         Rv04Evz6SY4+Pgy80QYgxDhLjuuZa1qon5oSlMgsPsLDDCuRgQE6KAc7exSaNPok0VOx
         /1w5RF1YkQ/Dbg/ZDTROKujVwPX2i3QPIZLfq40W78gq9kuqksC+bNm/X40sLjbQRjxq
         DzDZxp81/VedTqqctMyIY7Axz5TlqFY1AiZ2YHA4J3iRVlF+0YT66+0DliR1Zk0RyrvP
         zsc0+uGLmmAepo2FK7sZxanhjbOWfJw3xeJ/WQijT/cxFjx5nPAcyjtsTWXU0m8Nozqu
         pZ4g==
X-Forwarded-Encrypted: i=1; AJvYcCUlTzr5w3pag0ZQSNzBYf34zBUyNoZ5ll59dFyYvjgmxN5CvePn6ZZC5rECSomsQgfqs9RNluY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKlPn1oaWSdbh9D2vvrnYtho/pFcL5Adtt7o1FGRmfhc4Lm765
	gDzJiH1r5PseAPw5MO1s6IpI9u2kFdY944kPxOzuX356pNuk20JCKCxIsKmtmVoe95bBJ9Ek4rZ
	FLvHzOQ5Bns1FiI1jBvLdeCe2ArDziuCghZXPE3hp
X-Gm-Gg: ATEYQzzOiSX24T2fZL4IH/Z+XkMzUs4OfQ5EVpQQ7J5b2GdrDFaL3ZK1sWeVKhCfwOZ
	kFbzVXZa41YX6LNPyS1DiMkdZOH36QgCuXOISBgNSRjm9p9MCPsqPdmO4AnkOyj5tceMvxw4Rle
	5N3v1fzjA1zzTSn5Q1tTMQWtvn27wm42ycDgyy5x6Bs5dO52bEBlKeD6ymBgR37OolYrRd1MMwC
	2RNbeJFhcNIyQ6yKglQj8bYOj2qj43tRei8DhLe0z5nNMsir5a7Bk01YE4hllZ896Kf0Ea4rt1g
	tEeyLft1xnBWHDIXjDM=
X-Received: by 2002:a05:690c:60c5:b0:795:294c:fd4d with SMTP id
 00721157ae682-79bde00d296mr25567037b3.37.1774620181785; Fri, 27 Mar 2026
 07:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326204310.1549327-1-xmei5@asu.edu> <20260326204310.1549327-2-xmei5@asu.edu>
In-Reply-To: <20260326204310.1549327-2-xmei5@asu.edu>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 27 Mar 2026 10:02:48 -0400
X-Gm-Features: AQROBzBaFJaQnMSfKHFfnNTA5QSRFAlr3NXSV-PWAZbQ_eaJsjbvhR1j7LDtrz8
Message-ID: <CAM0EoMmZ5GWY04empRdR6C-qg_L5Yrdnetg-CrWxC9JNwN_qFA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] selftests/tc-testing: add test for HFSC
 divide-by-zero in rtsc_min()
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272586-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,resnulli.us,davemloft.net,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,mojatatu-com.20230601.gappssmtp.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 347AF345C88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 4:43=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> Add a regression test for the divide-by-zero in rtsc_min() triggered
> when m2sm() converts a large m1 value (e.g. 32gbit) to a u64 scaled
> slope reaching 2^32. rtsc_min() stores the difference of two such u64
> values (sm1 - sm2) in a u32 variable `dsm`, truncating 2^32 to zero
> and causing a divide-by-zero oops in the concave-curve intersection
> path. The test configures an HFSC class with m1=3D32gbit d=3D1ms m2=3D0bi=
t,
> sends a packet to activate the class, waits for it to drain and go
> idle, then sends another packet to trigger reactivation through
> rtsc_min().
>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Thanks for doing this.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> v3: append selftest in 2/2
>
>  .../tc-testing/tc-tests/infra/qdiscs.json     | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.jso=
n b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> index 6a39640aa2a8..1e5efb2a31eb 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> @@ -1111,5 +1111,30 @@
>          "teardown": [
>              "$TC qdisc del dev $DUMMY root handle 1:"
>          ]
> +    },
> +    {
> +        "id": "a3d7",
> +        "name": "HFSC with large m1 - no divide-by-zero on class reactiv=
ation",
> +        "category": [
> +            "qdisc",
> +            "hfsc"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$TC qdisc replace dev $DUMMY root handle 1: hfsc default 1"=
,
> +            "$TC class replace dev $DUMMY parent 1: classid 1:1 hfsc rt =
m1 32gbit d 1ms m2 0bit ls m1 32gbit d 1ms m2 0bit",
> +            "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || true",
> +            "sleep 1"
> +        ],
> +        "cmdUnderTest": "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || tru=
e",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC qdisc show dev $DUMMY",
> +        "matchPattern": "qdisc hfsc 1: root",
> +        "matchCount": "1",
> +        "teardown": [
> +            "$TC qdisc del dev $DUMMY handle 1: root"
> +        ]
>      }
>  ]
> --
> 2.43.0
>

