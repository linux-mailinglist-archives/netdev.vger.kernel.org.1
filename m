Return-Path: <netdev+bounces-276676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBKKC0Cb1mnDGggAu9opvQ
	(envelope-from <netdev+bounces-276676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:15:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A64573C048A
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1A07301A433
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510FA3D8918;
	Wed,  8 Apr 2026 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbpXPtmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F21A683C
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672044; cv=pass; b=t695sHrWZ9JVx/8iAMk3w7MOFt7AWa3d3WcjQ7gh39R4ALT5CqdGd9WggLi1nTmJhWcDlrBORbkKyBjXK0flzy/hG/wKOyh+ISI+cy98otx/kFTO2zzQ9VuBFy+ol7M0E5ZwGHfddiBPTXmp0831CCu9aVNjwXjx+N5LNB8okcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672044; c=relaxed/simple;
	bh=AVnN8EQDQ9TTvsXZFeydMopr4OYTShlVgfYzvurVxug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba+tOe1/+thjugUHkVfzwNZhWlJep7sh9Yi3XCVC/sTywBC0/ym7GvNPHT4GNEMnq2wHHddoN2YI+LHbrH9Fp8dBL0uWplqpc8N906VSFqMuOvCvSp1I6BZq6aLVBRO6JfqBg+7v925WOk8HgUOyr7Ssbqo7ePgal7b3KWuz36I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbpXPtmn; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b3488fb31so16743201cf.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 11:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775672042; cv=none;
        d=google.com; s=arc-20240605;
        b=Q8E+ryd3e/5CeElskAYbY1QjJWtGCZ+iCb43FQ/JKMUVrehIC1YacXzY4ue49RMPcT
         FwqeLn2GLc6BPN2PNuVGzBzEFqUlxZnRDYUeDRMWBJYngBsd3PFZCrvFRbpfqrTpAA5V
         osO7JPfpPZnFqRj9KT4uh5RNJBRGij8hufat4G1cScz7qixGjiBUiZXitUuzhe+DDn6F
         Li4wQ0QL9XWHefXrRDc/atUapJHViJdObuMEWnipy9dS1UBn/PCz+2tTHKvt5ets8eDl
         fvCQmqOPwDfVpFqmz/JBcefB1nyjBDiG2XzN54xfJdMAiQOEaVDD+OxF2v3Fz5KVjb/x
         i6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rGFghDoqeo0HqYRDBP7qhMCgZN/IcrebNIzU2yd6VOE=;
        fh=94v5OkcEHEBNbeSdZ9IrJagn1ackxp+XCu5KtEFsyI8=;
        b=db5cKD/WJtjxwQ45fFz0nKyjdaFw5cn8aCOC8z31Cpe7LcEcgW173h8BsUhYUsLYLj
         NoVt45Q0EvhcM6p1y3PdX58HFk7f/fFikhutAhLqFdU1KMYE28q2ZRge3PdHpwhlMUVn
         NCy034L28jmO1TctwePXe6ijRgrihSIxhktpR1Z+S/0QP4aBUrkbdC6mH+zmTE10g/pm
         ZBl4q6br/MTlHgQZ4JIuixioU/TBDFdNWhzRISFgwoIxv/gRIIk/IcCBWi0L3ILRgh7B
         bFfP1+TVY+e52g75toYWWov4Ax8EGrE7/R1xIRYp59WIyKy6f4D4/TGBDVyzh/djYF9V
         xKDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775672042; x=1776276842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGFghDoqeo0HqYRDBP7qhMCgZN/IcrebNIzU2yd6VOE=;
        b=KbpXPtmncrUSgBA5walUjj2PIYNEj12vcSbvISFzuVxax3lq3A8sYkGKc5VwZtCnt7
         bO1p/q+N7z+t7CkwXDb9INhZ0Bp6hfLyMRuegbZlfuoxTI3lrb9hhiZhmz4cwCgR6Tjx
         XByNqEdQ8G3zduO2JK3MPPLG0ZzgH2wbMJHDBq0w33/4ubi19cVBhGe3C1s1WhYq3IQn
         ZHjIFhcw4oIOmSXKZ7xo8rt0liQ1ulwkJ+N0yj9qVQ5YRnOW/ngNMuruvXQ9lMEKmDiu
         GTuQqNsoESQuTtXpu9xkV6VR/qfaZHah2QLaaNaGo/lCCk0vJcBQC3e1p3MOMRyrL8v0
         fzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775672042; x=1776276842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGFghDoqeo0HqYRDBP7qhMCgZN/IcrebNIzU2yd6VOE=;
        b=NXncsfbNlAyaE4i2gi8gc9gStsfFJSQwaMkfhEAJFHhTdOu61/XVKL7kPRmz9sExY2
         bSZC6g1/dbBjJNIWU13fOE73srkCwP2xmvRtcdip/Ho6incdhD2A6ZD8Q9AiTQmwVUkl
         DosQ7pbXOUcEHzLIURD43iAmj/dCoy2sMuHOFzlMZVjw5OQxYjM0mhDdlWIElS0u3lj1
         cBpDjMlShgTfhahEjkkwYAob5W6jpWjHUSrB5zxzQhAnLkccBVh/xvMIL5dl0NTh5vJD
         Pq47XjScX4gbEac/LS1TJcBmERIOAqjFp5+a63HTKIEU8CiK74TL9FY5iF7Xk06Q7YlF
         P98g==
X-Forwarded-Encrypted: i=1; AJvYcCXLS7p+rrDpHknnE2XdCaSWboEBzh1UWeuD24huoQHt69JRqCLDqA/lcWKXJu0Adg7oCMbf/l8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SYckzC5WeauQ08qx+gW3WWKUF/sDElV6wfHCTdn1/ZvDEvSG
	a3I32grBdL1vkySKtSVohsyb7Gqxp+y7LQiLjTNYLHv21lvEdC9h7idsnfVGcOM0TUKY74zHck7
	WEO+1z3E63rEQD/uOWle4pRISgMf1pq5A+t/gRIKf
X-Gm-Gg: AeBDieuJB0BiIsr6/DC90akpmlyl7gR019yNXJBb/dhau8fDLJXk/C/XxJCLfbVBDgZ
	tarM7djAeGAPZBXMPkchaat98g08N20d7efraAwwvgVcy2b1MBlYhQ8zH0RxX9FfCt57JzIfQRK
	i8meU5FM0mOsZxNrDdailztc+v+abx8X9Fbk86jgQQ0sSPh75DrKgsE+UtKO98SbalS6OvEssdW
	2kfW3wh2fEwAcWU7XxjITBrW1Wp0w7c6gj9+vm3q8a+FDA+m1+LkFNnRSwaMCZUvBzBeTik1kHN
	XzlJw1w=
X-Received: by 2002:ac8:7e86:0:b0:50b:8676:3cb7 with SMTP id
 d75a77b69052e-50dc19b1231mr7160691cf.1.1775672041114; Wed, 08 Apr 2026
 11:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408001438.129165-1-kuba@kernel.org> <20260408111107.077659c6@kernel.org>
In-Reply-To: <20260408111107.077659c6@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Apr 2026 11:13:50 -0700
X-Gm-Features: AQROBzCcOW2-aUWpD6nEuz9W8GZl804bG5afvRY1DxSL6tY4OCzmAB1lNwFv9cw
Message-ID: <CANn89iLEeHNUFz6tzcCHvkDO+x_zFmJYBfT8muiU0iYO8E_tdg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: update window_clamp when SO_RCVBUF is set
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, willemb@google.com, dsahern@kernel.org, 
	quic_subashab@quicinc.com, quic_stranche@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276676-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A64573C048A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 11:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  7 Apr 2026 17:14:38 -0700 Jakub Kicinski wrote:
> > Commit under Fixes moved recomputing the window clamp to
> > tcp_measure_rcv_mss() (when scaling_ratio changes).
> > I suspect it missed the fact that we don't recompute the clamp
> > when rcvbuf is set. Until scaling_ratio changes we are
> > stuck with the old window clamp which may be based on
> > the small initial buffer. scaling_ratio may never change.
> >
> > Inspired by Eric's recent commit d1361840f8c5 ("tcp: fix
> > SO_RCVLOWAT and RCVBUF autotuning") plumb the user action
> > thru to TCP and have it update the clamp.
> >
> > A smaller fix would be to just have tcp_rcvbuf_grow()
> > adjust the clamp even if SOCK_RCVBUF_LOCK is set.
> > But IIUC this is what we were trying to get away from
> > in the first place.
>
> Hi Eric, any thoughts?
> I always assume you are displeased if you don't reply within 8 hours :)
>

Not at all, I simply missed this patch. Too many emails to triage.

I will take a look asap.

> I should say that everyone has obviously discouraged the team that run
> into this from using SO_RCVBUF. I'm fascinated by how they decided that
> it helps since it clearly doesn't work. AI sure makes it easy for
> people to "try things". Sigh.

