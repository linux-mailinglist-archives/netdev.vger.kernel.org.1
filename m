Return-Path: <netdev+bounces-286454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLMEG2l0AWr9ZwEAu9opvQ
	(envelope-from <netdev+bounces-286454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:17:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E149D508719
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 826CB300794F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BA52C027A;
	Mon, 11 May 2026 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0HB33fV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27122157B
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480178; cv=pass; b=PJvSd2qawgUCyUwROKut2XCl4zgy2reDTZjsffiYswmWrgT7CEWT9L9R9HKTYno+hVH1Iow8mYKcpZvdWOErExIhHNlOl4HzpMGaf0bjFl3nsDzTdBOqZ6tWG4mIvJDu3ZWI9xVJ6NurK8UA2qry81sWV8vbOiKn8Akm7DCfYGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480178; c=relaxed/simple;
	bh=eQDtrSQ+EEuMKW8PiS95FUISXJKq/RCO+BZZHIerMDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAq4WHL7YD7Pcstt0HREkrARQ34UNeAZPcp7AIJ37qggQ+rCB5+Cn0UOYbAaUrNkcZ4wBvyASqf2Xb4wXzSkEOqfq6FBMFfyLC5xmmzDEfEMZQ/40PD5H1aF4z6XMhOE2IgIG4ZtWuCCVWKUhjPAbMRQuzO7zv70Jgp0W6VJtkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u0HB33fV; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ef0ba61d46so452076585a.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 23:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778480176; cv=none;
        d=google.com; s=arc-20240605;
        b=XmyyyLqHlGZM41YLrgVujbu6qqCdcrOYbPxAHkgSD2HmTCr21gWoaRuGMlMa8/B/tx
         cKQTs4jP1eATrGZK/Glb/CchymQvC9mj4pzq52+tWQQrcL8DrxN/a2m991FfsGJPR3Z3
         9OXbT01HpI6ULrMnoey5DfJ7d11ErS59CuShfEFhKEJxN+Xybz8o0b9im/dHz0aZ2VDR
         fRQeZm8Ze7Rvmbj6MxqXEEpzzsdw2Oi/lEC2agEpKsfr3HwO/0GjVYjciJHQ118Lisiy
         nKDbdNl9XpvbN9zbdvqjy1tQnm60rWUuoizbIDyqOJJxEVNDByKNrRHCRXFczaR//uga
         ZVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4q51TCt/Hox0+nCaWJ6/zJB5WM/wG+F661fL4WPLVPE=;
        fh=FsUhJyQkYcyNBv7PGFoIQT94JAe25rZjTFIfiv9GtHI=;
        b=RtuR6gy/bUwY8Oz4MOzl/D2WtyCCoUk6YK9B2N/b+H3Kbd44BZGBZqi0akTRVPbtTX
         pSN0BtifheRYrSuA6gZEDX2IeXPrj3Jy5hBXwO9b1eDgSk+xyt0sF3AWLXGMwi8RA0tB
         R8MJ09w5NsG28ooC3PWqCWvwTpYi/aOyzizW9FNFuxkS8IoNiEhed8ph4ouHlK/0yZV9
         CMCY+PAgoRXmRhEOdBoJ80F6NJaWsIHTTST0Vri9Oed5191+zi4PG+VJlogSv7ZBExWu
         /z0H2aF9BYtEfazkkmtVd7EwpjpfUjM7juS3RZYGEV3PBlQaLiqCf4jtqg0gGYE/igXC
         FJYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778480176; x=1779084976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4q51TCt/Hox0+nCaWJ6/zJB5WM/wG+F661fL4WPLVPE=;
        b=u0HB33fVirZzvboEETiGI31aBtSCd7vDrBzBQk+eabCn86yIGfeXCyJwXT8foIBJRT
         LuqNqMOhTX+/2412WOYKbnw81gOaPmNNwPLNP1JlsnxFEtXX9dAe6wfUuvC4qApG2Inu
         xBDIwwnV263v2EFyzUKX1GlEQfLWpcsoVZnkB1Mhl449PpOyX+IzLQwIVQLOlF8Ite3J
         Pa6hvm3rwmTcTJIxYukcEPcmRV5mNZD6TB7Sx2KTb1xvgpS2JeuNPXgmu/bPhYive6oM
         akXGOCMtr18UDZA5DtsKxvWApbiDEzZ0R4K5QrGgmTkYxnY/aqTsP1FryOZBXlMeSEg1
         Z8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778480176; x=1779084976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4q51TCt/Hox0+nCaWJ6/zJB5WM/wG+F661fL4WPLVPE=;
        b=qe5GqBsAIAiXDfrN4dxut/M9/199P03actbKwEOoBCLdIly0dMIROCTr7fDq4IiMWy
         7q9jWN02b1FGJjS++w9tTN1y+HZX+deSdz/vzwHpXgeDmSaCiuc2hLxzaYTWqQRO37+r
         saHDbgRjLxQFhCt1v6+uhM0V+M6aL8ahZfEqAUyX4V6g3cQdSmEcc/Rrx9tIuvPSrBH5
         GX4WW/w8ZB17yr1wlRQytLQDXsbg9amQtT3q80EipaTUYLpekvSdddmB2GcMi8mUIm/x
         uD1y1YcsVU8HI4cI1TPoEFLVdC/e0q/qyP8wDJewLydSOdbEwZTPnk27BLqF5ASji0J3
         q8tA==
X-Forwarded-Encrypted: i=1; AFNElJ8kQ4Uhu6x/1Ob1nVwCBJDOLMMdh5yVfLGXWFF99/HGoytO412n4Xk51QFFZr5kZPz6hqn8MMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMuFkewjG61DnVdbjVpmpr+Inbl4mQK0NQIj4QEfZTNU4PUngv
	XV/BBrzi/n9Xqmcwp2fxg2oVgpJBiYsdBYLVJkCp+isGUUPGiOMeNxK0jQio+2UTrG+x10UHuqS
	v84Fx1xUBuUPrVNJimVmrCgPlfF0vVFlRyjgj5695
X-Gm-Gg: Acq92OEJQHnbNb1PJXNsG/CL2zWJjpPrbEqVgEb7Nzhd4H/eNL2frWLfDhMP7/Jnjhg
	N5Gd2eYkNx/tHSxQlXPqrlzg3K16SZ/SSMh2JyBmuFZsIMan2vcRAKytohCEMdFoczJyeSLac6x
	QIyhSFZb02eVxyrVKCl4a6NDZC/YDxkXEz4H6yl4zURflu7hk5O9cLA+aRTxW+pVSXn/8VzQR08
	oXwE07gVc9YedsU8ScQbeWTJRxu4rqWPlr8xA7HEUyJapMLvqzGaNwFCjwg5g2W9qQh8UJMNrNG
	fwH2TXzwzlhyc4a2mg5aDkBCzzAPEZU4GvFOV8iPaRtBYctqiMSZvl4cTyvuBND2TP+cChBCgBQ
	K0YiYUPp6N4lFinaPLLXm3yIHpTrm
X-Received: by 2002:a05:622a:302:b0:50b:6a79:45c5 with SMTP id
 d75a77b69052e-51461e3ef66mr327866871cf.22.1778480175379; Sun, 10 May 2026
 23:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507174547.4125412-1-edumazet@google.com> <20260508161827.15b114eb@kernel.org>
In-Reply-To: <20260508161827.15b114eb@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 10 May 2026 23:16:04 -0700
X-Gm-Features: AVHnY4JVhUEOcmAZqNHFcTwJnrTRlPP6AFXqrLe06tiupRW-TLbRo1W3L0sJHaI
Message-ID: <CANn89iJTjOH6usbeEUuishWTtg8kk2HdDY=T6da9z3QDUCFa1A@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: add RTEXT_FILTER_TERSE_DUMP support
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E149D508719
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286454-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 4:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  7 May 2026 17:45:47 +0000 Eric Dumazet wrote:
> > We can later avoid using RTNL when RTEXT_FILTER_TERSE_DUMP
> > is requested, as none of these attributes need RTNL.
>
> Since this is uAPI I think we need a better name?
> TERSE_DUMP doesn't explain much, my first thought was that you'll just
> trim some ancient attributes to make things smaller. Sounds like you
> want it to be lockless. Also GET will effectively support this bit
> too so _DUMP is a lie.
>
> Maybe RTEXT_FILTER_LOCKLESS or RTEXT_FILTER_NAME_ONLY ?

SGTM, thanks.

