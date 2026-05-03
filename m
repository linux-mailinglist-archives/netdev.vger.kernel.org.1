Return-Path: <netdev+bounces-283660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cABxFFSh92mQjwIAu9opvQ
	(envelope-from <netdev+bounces-283660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:26:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF304B71FE
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D6883008D05
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 19:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1D3A641F;
	Sun,  3 May 2026 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpAhrsiN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D913A6B7A
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836367; cv=pass; b=qvE9GvLAA/zaiDI2ryCuyFtVfCa9T8mDp73li6fwZLgWSjB8WCHg5JCkkF7iLvRzB+YntwUpfZM81In2Ma93diThqVG1FENsH1N239Ne/Xn0syuQpf/kjMwKcJ3U1nR/iLzl412gSGtcmDvms+uy/UpheDwWza4fqWryUki6JDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836367; c=relaxed/simple;
	bh=XG8UmKg83pU3wa46ae11h8XQSd0IMy9ZOQoi4a221jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBJyc/qHcMaMXhpvNn7t6ad23iPBiY5IxFzf1r+f+T7XE0Vv7v+aLOMsawQ3FMkxCaCAebFzXt1VGhyoDp8ugKPvNNTVT3Bt9UFjxjzQfuWMjRizafJZJVtngWuGwaqcszv1ca2K0GM65DAG3P7xeVxNsqjSIqBFveOP5WG1eDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpAhrsiN; arc=pass smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-50e5bea4045so29176251cf.3
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 12:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777836365; cv=none;
        d=google.com; s=arc-20240605;
        b=GRD1ydywL+i+0Emk3MYar0uHIr+VmJN+6W2ZrQxKXHDZCWDzJtAn+p/zQflDEUvK2b
         fmbdrDF+Rtsp3CepfutnodYr8Yh8RzqThAvPHZuxg44GHfHSwgHsqq0u3SarWXlhRMMh
         e1QNmqc/V/i3AC3Tv7A8gFOwzWmd8MPb3KeXvZBSlk3P5+N1Elyqx8y8+LEAtdmx6A8A
         br5/qWF8aVraF02BPFvABObf+97TafS4P8pICQWy4hSL6MDp+Q/Q9U6TP7mjQmfAfxYE
         Aewi1eNblxJ5ZKkBPpeDu4TLRP6Dg/UDccEZxRcQimh5UrgKtyZpoNpCmtB98gZNWvTF
         wM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XG8UmKg83pU3wa46ae11h8XQSd0IMy9ZOQoi4a221jo=;
        fh=VDLfP0ZPlErcz1H7fbZXN9ZBA3QJJMWtFAzq2S2SiNk=;
        b=Yg5lReDPUeXcne26TUf1jsPW0/w1yEPtlEry167T7o/T3ooDxlnSGSvnIjeihQhBr1
         Lr3KqVAi5WeLW/LXyUlWJ1th6N3nnN9HnIWeAtIr5ckz5ZrtEshqJXWJ05ErhC4ZWI5m
         5fTGuvDFVUCqO3fgSCuk8+gM74IypSXE7JCsKpBA57kEayGU9bR2m8UoTspHIg9u3Wy0
         ZwBnCqRVjjdcSYhE9m5teCs8Ol2MlaRynqy7iQiVSbmUYKx7Ib+ornYc+t46W5mkbN64
         m8I1U8RVI572IzCGO03dCTTGP+V0QbsGI+YGxy1S5EaQ+EwW1sRFQXxXRgK1Y+tWfppi
         N1iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777836365; x=1778441165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG8UmKg83pU3wa46ae11h8XQSd0IMy9ZOQoi4a221jo=;
        b=TpAhrsiN1w4MuUK/KvhoDfwpfknywP/TchZIP7VXEZlnXDUtXU2XHf3VVLtqVTdpHa
         60XqD8a0azjGaFiM5UunFpakszAQM+DNoShaQgLHdnVadbULFDu2vwbw7SASACzD19y5
         Wj47b+C9UDD+jLni9eCF0iLIXMbCHZSwK875B71D385SJqAV12dHooJzlwyv+xhqH+3J
         5byLzcj0LJ+3ygOtXEVCCwv5qoIT2a8A7x/VQwtY9YUvt9S0ge5pNxwARlWGRBKUBZ8Z
         mW0JkKuW5rAkAJx1O60fg8j0atdcwf5IHh9jW/omh1JkHBVt4Inx70wUn6b5m6HuXisE
         uUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777836365; x=1778441165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XG8UmKg83pU3wa46ae11h8XQSd0IMy9ZOQoi4a221jo=;
        b=gHBYE15+M3nI1m+jlo2aZul5sILxTBMziSdZDzkA85B+eroN1PRnpkJVx+yY+/66WO
         sKTdUkul8bbaEsIEpuUrMaE7AiikOFR/Ernfs8UD52MJr6cy1W5SoSfUlur8qgmc0RDB
         oRg8tXuxOsS8jyDTC8BY6UcsfYY4AwBikX7wAHpdy2CHpZGZQtXEEH+ZmdgQ9Wh953/5
         gdIQLQnHJch6W/YvPP1irIIEPAB5BtNChrtD3MbBoYwguQbrlGmPTvheaNmg6g072awd
         Xv9r+0xec2YwAFffmYcsOCWPhdbkzBB3Szj9P3jC8u4oPKSz7qzo0MMMhqcURPnnFX22
         /lgg==
X-Forwarded-Encrypted: i=1; AFNElJ8f5CUApE26KZRkoMdbASLKuAFICsTcCdZzDG2vuHLHprJm/61eKo1ZcoSTtqO4ui/Mr1C/i7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxir6KOncRY8YCWeGvIBDjI2K3mO7suAmqF/v1OkJWoNZ4aHLFd
	NyX0EQrEWDLk4wQ8C4ipPtLe8/Y24h4WJftr5MWRjflABNPrwxpxfqiUoZUxx1XZVTrnaN9CEsO
	nKpvGQApnZI9J6S2wo3cfVyGkYPjHP8s=
X-Gm-Gg: AeBDiesGANGBZr2vIW9c7GXZOAFiBZDRskqpa7kz/h23lhlAIpoOJ3pfPpELcYvUDLj
	bXa0hdBOkaaJd3iA2NKl8FvHUw1OZykrxSXisUJweVtZRMom4/qFPaVSh5i9BsU3JIIn4gFqz8q
	dAX0pnDv5HOv2p+2TruFjX1o+ZLf08ywoH8w9CLCKVxprsmmaGup9JkzyCEtUBN4RiSntAvujPG
	CLijHsJuuZ+v+U0SjLapdOODxYw3NZUh/P6cnBJhBiOVLp5WhcEGt3Rbp4I7A+def3zNvoUvIlB
	3x0q7upU57x4msqsdBMErW1wLDr/kiteWpa4BK1c+8CFSK5VCQrqrtq7Y0AyZ4GH0NHg1lT+FBC
	GkWG0
X-Received: by 2002:a05:622a:30a:b0:50e:5fe2:83aa with SMTP id
 d75a77b69052e-5104bdf1496mr111994061cf.12.1777836364623; Sun, 03 May 2026
 12:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503030801.14080-1-enelsonmoore@gmail.com>
 <2026050340-kilogram-prissy-a833@gregkh> <CADkSEUgPtjkKC684O3qB=koKDPwJoUj-qU_4Z_18NAU_+bBqkw@mail.gmail.com>
 <e12da6e2-5e50-4819-a5a8-2bc675da4c14@lunn.ch>
In-Reply-To: <e12da6e2-5e50-4819-a5a8-2bc675da4c14@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 3 May 2026 12:25:53 -0700
X-Gm-Features: AVHnY4Kt5s_1C8ObOd9tow1DeOBNsioFkEIF5beY5wz6dDacfl0-oSTa2HpU6_E
Message-ID: <CADkSEUiusP8WjOAPTZjAexu1hMukWugXow45hzvfFOYvO2bg9A@mail.gmail.com>
Subject: Re: [PATCH v2] tty: synclink_gt: remove broken driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-serial@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Haren Myneni <haren@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>, 
	Qingfang Deng <qingfang.deng@linux.dev>, Julian Braha <julianbraha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ACF304B71FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283660-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,garyguo.net,protonmail.com,umich.edu,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]

Hi, Andrew,

On Sun, May 3, 2026 at 7:23=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> Sounds like a whack a mole problem. I assume the recent removal of ATM
> broke it as well? Maybe __has_include() could be used?
That's a great idea. I will investigate that.

Ethan

