Return-Path: <netdev+bounces-275078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMIiLjnNz2m50gYAu9opvQ
	(envelope-from <netdev+bounces-275078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:22:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA5395293
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1412830C9C71
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97226382F1C;
	Fri,  3 Apr 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYk2VQQY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF73793B1
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225682; cv=pass; b=JCcxopY/97Ia6k4Fno7IHUsIbek+ZaA78EbMC7YnZiGiNroFnU05KX44lR+lY0fQ1MPgDM+wvIL33Gr0y32ZkEJ7K1YDX8/90g/Mxo5mrIIrtstoGFfZv9B3gJt/oPW2aID9mIM2dn6cTmpJEExeZeujuLaMjegxXfaJFsX9aNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225682; c=relaxed/simple;
	bh=HEacSVc9WrOj9fxcQ0JXEuYZe9qAhULgVPS4OSDH1eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQnR+6wzPtq32g4NDBQb0hdqat4jp9PCCQ+F+z0zeXgl21JLlTomG8dq6giOvTRAIAO+hDO85DEZR31e327ZwmezdNDxE4H7rjQsL3D5LLWTM4u2yd56XkbYn1fxY52YPK8luX7Mv52uTS16wfaSeMJRz/PJ04CV1VyCfN/Kq6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qYk2VQQY; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5091ed02c54so350111cf.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 07:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775225680; cv=none;
        d=google.com; s=arc-20240605;
        b=dBY+tkPdleP0jFkAwmdj3nqlxBjxjpJoQXdqXne3Xx/Kre5mu5XViYvOX9STka2leo
         6iKvu5QHekeQXy7kkWYxGftfcAv+20+BTj6KQZDJVU5hSX1J/maszztD6Fk9IbdllCGo
         OLlNmFYT2PPDBO40TNwtzOqcYeytXM6zwFCZi/7muVrL3nzIGMB+yjAyND9FrXCX5n/T
         vTpGnZG1XwSzHerK5TI0wqGqwaxq/Oo5XcPgQCVi7/HLWqwEqr70d1FDl9CeQ88UOb0D
         YQ4jWtFPVP5o6UNuJiYxA8bpbePsQec+v6M+wqxxm891VP4H3jk4awF2EyOGYxxTvsVL
         grAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zVbn7vKK9p+rq/cW/UuzyJsNfCtCCLh7vBkZv525ri4=;
        fh=x8Hq+cbrWE8g7vYg+5MzVWGVeo+M8OeYtneaJFy4PGo=;
        b=UGgFbSIrjFrd1t4IMlv5/C2lmX1NqG0vaTJTBX6YcrWXX/j2GuUKH6G/ebfLcUJwpK
         BJ4TFSb7sIkvYvVpJd36yHjk2HdkwveHT4wOQCzoOCwH7oPz2ifNyVdgGd4UbWXL9d2z
         c9oyUub3N2tbrfOWwZ5RePvvGn3E0wdfNkqywMzOqyB18oCBh78kknWhBSymb9omRqbs
         t8S3asp+oUBUTs7G//wbLnQq+JutVox2TPdT9YVgDjlJEQl0PMeNqDGslQzeQWCczY7c
         6AlLUE0ivW2CvkDvM1trrUZvfaeje18sSsxKmykeVj3nR4EiyqTLCtLcr6aGMxUOSd0t
         ozxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775225680; x=1775830480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVbn7vKK9p+rq/cW/UuzyJsNfCtCCLh7vBkZv525ri4=;
        b=qYk2VQQYRURZak98VdVPmqTuh/gnSjJejxCMjIbTumWWW4rl9sABtIQ4eg7cTHalfy
         ZAPiHxsvyYyqMvV6gEvBjBym1EhOGDjOM/d7MZUqAto1c39GA9r3sa8BMEnnd8wMbtdA
         W1n8v0FHMjIW/HimtAV27o6YKEnVipXw6/mwWw4uIqF2IjdO8Puwr3fzCo1Cq+Km9gz1
         pKDeTxgKFThg1xyz9qaUaxxgAq/GwXzHZeVGAkMORyvm78cejRT80c4Vp+5yRPVaE0Fl
         144R+Q4xzyATJPKvdOY5aJATAiYAdtaaMlzrCb26kTzhw5cHZwXNsc5tBxCuq0WLIs6t
         oewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225680; x=1775830480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zVbn7vKK9p+rq/cW/UuzyJsNfCtCCLh7vBkZv525ri4=;
        b=MkRgaHY9awuc7bG1HqsDIz39rCL2rrymCfcS35aaEyY8pQfkMyPZ8XhZJA/fICg5hU
         AmadeUQwqYoo61uS8x/82TNslLj9Bp/6d3yZicGdJaubC2vwRuEsFway4I0NCM959Npj
         ErHp0fiXkPyPY+TvRrqqf7zkC727RMViNxOIKj2m9F+DL8kAb59DOWqtGJ1po9zHULDh
         HSYPHoDupLQUazM21yDC6w2pj5AUMJksNpTIX48GDwvZRby1aOgRErYJk9QSJQMpwtQC
         R/lRoGzSO+xsGbBnunp5D/cT+nytNWp2rPhX5HYjJgOzLsk8aVNiUBAH+z0zv9xo6qU8
         GuSg==
X-Forwarded-Encrypted: i=1; AJvYcCX8zdd4fw++Y4B9cu18Gu6I1kBh5C3cIfsLS88m1U0EiQOZw3/HwIWCKokFSc05jepu2TkCZCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hha5GRxYhqyPoaZlM2B8bRqaPy+kygkdJATCt04i+2sCLLX5
	iqlqePzuDVlKSV2CZC4wJ127bByi/CcWt+lUO3dolTg2b1xQhCo5w19TU/zSzY0KlCPFxjAja/r
	2YcpCuVfPAhnKJJtVWcgBXNMQVrwIcS9av6xeREPS
X-Gm-Gg: ATEYQzzFgdsipnpLNJbtQ3FE3tqjjISS801kwjvsg4CopqhYKUryN/cUGskMMCR578K
	+gsfFXFSjLyQniqKK0E4AVBM8/BCbs4/sTXapv/SQJ6h4UE8Wv5kGUqjnXEERqEyEwgzFjpqUfO
	mk16DMBmyXhb0GVQARyfeQup1mUqSfyUJv4O01kbCaN150k7sPuYX0jgaNzRYo1FPvej2w9mHJt
	IjN+7C+PnPHCmUBoPIqdfKRSZJmdFe3F32Y5/P7J3Vdo6mgTs5CB7X+VZtQYLuG+2U1sb3Qx0fj
	Fp7ybVDz3u/LPxw95TEIvIBz7aGm+ZcKlnqqs5E=
X-Received: by 2002:a05:622a:5a16:b0:509:174d:3224 with SMTP id
 d75a77b69052e-50d66420317mr9892601cf.11.1775225679632; Fri, 03 Apr 2026
 07:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403102309.338648-1-edumazet@google.com>
In-Reply-To: <20260403102309.338648-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 3 Apr 2026 09:14:21 -0500
X-Gm-Features: AQROBzDGXDLtFvv6DkrkAfg3z_nd-BJS4YajNFL19JYHW8WJfeYgtCaJia1dqss
Message-ID: <CADVnQyngfZKuufzQd+oReHL=YyEiiefypww5gPzQ2HWkyW+puw@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] ss: add support for TCP delack timers
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-275078-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 11FA5395293
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 5:23=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Kernel commit c698f5cc940d ("inet_diag: report delayed ack timer informat=
ion")
> added a new enum for idiag_timer values and support for delayed ack timer=
s.
>
> Change tcp_timer_print() to use the new enum and display "delack"
> instead of "unknown":
>
> tt -to
> ...
>    ESTAB 10     0   [2002:a05:6830:1f86::]:12875 [2002:a05:6830:1f85::]:5=
0438
>
>         timer:(delack,003ms,0) ino:152178 sk:3004 cgroup:unreachable:189 =
<->
>
>         skmem:(r1344,rb12780520,t0,tb262144,f2752,w0,o250,bl0,d0) ts usec=
_ts
>         ...
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

