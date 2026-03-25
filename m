Return-Path: <netdev+bounces-271622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPV/GNMGxGnOvQQAu9opvQ
	(envelope-from <netdev+bounces-271622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:01:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A3328971
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF3D63473FBA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92053CD8DC;
	Wed, 25 Mar 2026 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wzimcalo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5F3BC670
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451675; cv=pass; b=TA/9QVCrj0kbAQuD/CNDoHTSDVpWJ3EW1NhwyoF7uan7xpyNE3lw4cwdJ/j9UsMOy7HheFVHNA+4TS7chNi7w6+tpTinrifsz/ZOIwYd4TLq0d+tLjbC2qGnG8u8agTthSM7Phyf/3tUfAo021p6UWoQdFLmf48Mfmh52bzN50I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451675; c=relaxed/simple;
	bh=nFXtsQYitzxNyDBIP91p1FAZ7YRHXcxqC5D2Yp0z+J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4DkxsC3fYm8WCG0PE2PhwQDau1Lqe3QSukY/XU+TMftzWZzy8ULg97Jx6v1vmsJHffqIQhRa1P5yl8xRl2/2uuPf/vjtRu37d12h5eQL7ct4uginu+BxOZfX9sj0y8mvKnh0yuaeqa5YnbaN3e2NimqkIUJcUcW/RTIou4FMAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wzimcalo; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a3ba1653fso55068267b3.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 08:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774451673; cv=none;
        d=google.com; s=arc-20240605;
        b=DwSsjXaf6UUhmAJIRUVVGqUJOA4dUfZxonRL/izNKRrRPPJLHv/22z7Fj2Mc55BM9s
         kbXyaENgs3TkFM37WKZtQm/FFesHAStpXSfqiCRXuQ6hOLkqvU9UDlSHjrxU+ZM7fkSb
         EAPYn8Sm3KYD+sTjis0agp4p4eIcwqqmNe4AqtaMhetel6QUDNPT8qhqATDFfknglBTs
         2fwqNCrCdajS2Tga2owq9MtkJxlGdTu9+r04qqLJ507mfTLLUMg/aDLFgeSwVupzlwSb
         h3yISEsorpiyGBlYnBcBBNIPPlXHZQoXYB+w9c3maFHPgVARmSH10TwfgGLj2om8JwmB
         kKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O66S96rEOTvUqlZiCU3x9vYPPQp/Mje+bdzAnxQr6SY=;
        fh=JAAjS04vnrLrAEuaPKO1Ly84CeoMIE/oeY4MXXPeGwY=;
        b=hmb4R/Iit/8GPmy1X4GuDm5+5faaU1OkaCKrKsVUVMt+MCHv7r4s81050U5gxqrunv
         E0bOPiAiZOcPYKLcH0XR89unqHvWYIc5Dm7H8V+QyDUOU80DkuA+bZnANj2KcLjcuEwD
         JIEhLjgKhQhO3kv3rUVeDASrjKG7r0S48bzX3hhO5kAHZ7/5Qbe5f6URZtpu8TDvL5vX
         Jcyi1UfaOlsAC2r0pYgDZFSf1rhptQ334Gwucqmx1D9U0o8ilmlChjq24MCS2BHhxYqS
         st1LYnpEqylnjW35QmnCaSfruxcY23gOb0ZJSpSvpoCp0tPKQQY7L914MDyq5sKPsRHz
         MzIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774451673; x=1775056473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O66S96rEOTvUqlZiCU3x9vYPPQp/Mje+bdzAnxQr6SY=;
        b=WzimcaloQIGcJR9h7bWHg5NReDB5v0Bzx0hDSMiqCsUVm2gTvjzPdrceLMof4YdEFm
         Wyu6CEnIxBjwGCPRVV6N5mlyi2P2BGQZYo0cYo/uM7yJjWGzLOb/0gypYmL0BeadSBAC
         88HqA/56bAzTjI36SpgKIXCpcg/oT/iXsS+f8LzZft2h4ctDoHAVhBDoH0ZpGGKFapl8
         P/GgiypsSZxI8zYbhS5ZFvhc37DI78FHTjNHXvgKdunAWl07yNd3dIn++Qca0OBEOP6A
         id0N8VLQYvTgspsoummvTIXqX8XPuVyNJWToY9O1XxEiyPsEZxFWjH4Y161pq0FnR5qi
         ZI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451673; x=1775056473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O66S96rEOTvUqlZiCU3x9vYPPQp/Mje+bdzAnxQr6SY=;
        b=hiL9lvcjGv+tRnOUGGenIVVxtmQIB/ILTPq5q6tBExuTTiSEtX5mITwm9pC9wlmp8R
         XYCHbKKJoAws0FRG7lIGCc+Kx4EahBPmjN4JtAPITk3MaP9H4NeLCw4bdy2Mg1UtMjR4
         NX13VJ84XizyF+AboMvfTTCHW7xLNjld4TGbmRx4DDW1r+7zMWsWL/APK3qJg6YbiEB2
         HKnIMJSOeXqRbTmuCTBmrrDNDCvPgMXnlE/G3fcAedT2lhSrcDve+9p35/olC59aiHp2
         zJiH+EmYwAA7+Jv6TTtpu/EOFi7o6gYnbMaWHCMP3RSILDQ9fgbkdkmfRkYKUYQ4jYHR
         suZw==
X-Forwarded-Encrypted: i=1; AJvYcCUf51voXx2SFFKx0mAy1KxC7dzcvyaOjaWhqM8vJBOGPKNMOJy8FA72HsRt1qmfdygt/eXFEzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8eDudcQlq40Mbyu8r48iqlM+oKX3kbjHjtDE2kQLSydEb5oi
	cvKp4reYFUu72JK3pErAhRGevKyHnELL+u4hx+KvXBq1mvpyNUS957MLEFUtPyxkNjtmjxMk9Uy
	i4ZQdEb7d+64UUAShxIsbBFMiqENGKhSLNkNdRu2r
X-Gm-Gg: ATEYQzwDqrWrmpEGKumF/TEVqFahnif1ECFcivgxOhwUZ3beweR6TSdRNLymOC8aqhI
	tQtzBh+0nP+1eaX+FN+ZmEvocXn5A4agyTJqRy42LTKroPh8dHIMW7N4r2iHVbyIOKjIYXukQdL
	pXOXZmarzJkBsLpfRtgq5jKekf+aricpkLsAhGTao7dwbMkdmcNeGuNbtLYfadVRrxOqvnn4bu1
	ECTPDKkgoKW9UxM0qPcJuaV4UYu+PeVO5iFrU74Ld2/xKagr4Pas19AFfa1+OVFzzsrA5xjFMqk
	0AguznPZpbpmp5legopl8cpAf89hUCtSa5zW
X-Received: by 2002:a05:690c:6889:b0:79a:668a:b6e8 with SMTP id
 00721157ae682-79acf6f01ffmr40430887b3.61.1774451673004; Wed, 25 Mar 2026
 08:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324205301.1361608-1-atwellwea@gmail.com> <acOVlten_N_5evGX@gandalf.schnuecks.de>
In-Reply-To: <acOVlten_N_5evGX@gandalf.schnuecks.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Mar 2026 08:14:21 -0700
X-Gm-Features: AQROBzD8224Q9HN0xgDwAcBw7dcRtTDRPO2HLV_Z6A8nB6U0lDUy4pisitfdkEk
Message-ID: <CANn89iLJJ3EF2-qe4AWJN0teh05x0PPJjOAfB0uG9rNZuJUZUg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] tcp: fix scaled no-shrink rwnd
 quantization slack
To: Simon Baatz <gmbnomis@gmail.com>
Cc: Wesley Atwell <atwellwea@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A78A3328971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 12:58=E2=80=AFAM Simon Baatz <gmbnomis@gmail.com> w=
rote:
>
> Hi Wesley,
>
> On Tue, Mar 24, 2026 at 02:52:58PM -0600, Wesley Atwell wrote:
> > Hi,
> >
> > This v3 addresses the follow-up review on v2.
> >
> > Eric pointed out that 1/3 does not need the added packetdrill comment
> > and that 2/3 compared signed free_space against an unsigned
> > granularity.
> >
> > This revision drops the extra in-file comment from 1/3 and keeps
> > the scaled-window granularity in int space in 2/3 so the comparison
> > stays type-safe. The overall approach and reproducer remain unchanged
> > from v2.
> >
> > Simon was right that the original 3/3 only showed the explicit
> > rcv_ssthresh-limited ALIGN-up behavior. For v2, 3/3 was replaced with
> > an OOO-memory-based reproducer that first grows rcv_ssthresh with
> > in-order data and then drives raw backed free_space below
> > rcv_ssthresh without advancing rcv_nxt. In the instrumented
> > old-behavior run that shaped this test, the critical ACK reached
> > free_space=3D86190, rcv_ssthresh=3D86286, and still advertised 87040
> > (85 << 10). With 2/3 applied, the same ACK stays at 84.
> >
> > That follow-up also clarified why the broader 2/3 change is required.
> > A narrower variant that preserved the old rcv_ssthresh-limited ALIGN-up
> > behavior was not sufficient: earlier ACKs still stored 85 in tp->rcv_wn=
d,
> > and tcp_select_window() later preserved that extra unit because shrinki=
ng
> > was disallowed. Keeping tp->rcv_wnd representable across the scaled
> > no-shrink path is what lets later ACKs settle at the correct
> > wire-visible edge.
>
> So, you are saying that 84 defines the "correct
> wire-visible edge"?  That's a strong claim.
>
> The test in 3/3 adds OOO packets until the window calculated from
> free_space is 84.  But why stop there?  If I added further OOO
> packets until the calculated window drops to 83, I can claim, by the
> same reasoning, that 83 is the correct value and the initial 84 is
> wrong.
>
> In other words, this is a very synthetic scenario that can be steered
> to arbitrary values.  As stated in v1, I would really like to see a
> packetdrill (or real-world scenario) where the old behavior actually
> hurts (after all, this series claims that the current behavior needs
> to be fixed).
>

This series seems to be a social engineering experiment.

Could we have the prompts that were fed to an AI agent ?

I really do not see the point. RWIN is by essence advisory, and TCP
cannot accept
arbitrary bloated (small skb->len / skb->truesize ratio) anyway.

