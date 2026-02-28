Return-Path: <netdev+bounces-262163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGaaK7cVo2mJ9gQAu9opvQ
	(envelope-from <netdev+bounces-262163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:20:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C165B1C4412
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5F59302BBBF
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3262E424F;
	Sat, 28 Feb 2026 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OVfhk/FP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF382DF6EA
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295602; cv=pass; b=Va9xgeDiUUvhVTwwhrI7ZeAHnnsrnxOseuztYzx73V6VhanusX2oHfK6VvoSNfO4HG58h2sc+f/pR8uA1Z4b9PO4YixipBgcGbjJX7hkVwKqhqZOsRmnGxzaqjrVQqrcT2v1jToeHTcAA42nROXFOjkfPk89H8OmBJaUAi7F+us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295602; c=relaxed/simple;
	bh=i+0bD5jaj0rtGiFTewJRAOE2xK+2r3ZqxEp4ZrxNpQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsC/gJN7JDWg/FIa5B/gTED8QCF39aYXJ+tJ0LkXLHTN9SgsPZkHqx3SLQPS5t7xadGKTTWFvd4X2DyJKGqh1i8dwqen4Yvlv9dXnxjWKPunTJhf639yR6MihK2lZ/66V8X3qFcmMkjSFKnS21FjHEDaZL28uN7wFdBoPJxbFng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OVfhk/FP; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506a019a7f3so39266471cf.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 08:20:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772295600; cv=none;
        d=google.com; s=arc-20240605;
        b=Q4ik4OashXfn15qthLlZ2T16yBhw9UhwaOqeTqfiV9xBp+x3qQMs/tE9v+Bf9vE9HZ
         kjJQiTyxg/amEGQNKkBsfDR0rZ4vKuPFs7T+6eS4Bc4dU5uZ9TRa65K+9WxDx7gPNgBb
         jQLwznhhqtPMbO2Ctaifpc0mlETEn0yGk1z+RTbMzcXV4VbNrOJfi+k3udv/IZgHo4i/
         cuwZHsQ0OB5J6yCPnZu9fSz9SrbZFyOSyhBvG8E7UQP1hh0SXtNYvZf96SVyZlEa7pz5
         CaiOc3dytC0MXFmIPduSRYsSXdAH2pRZsR6CdEASnIsn/4hWPyb8tzt7mOCZhPRDZZtR
         tv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i+0bD5jaj0rtGiFTewJRAOE2xK+2r3ZqxEp4ZrxNpQ4=;
        fh=hoTzEdr81/gE3MmSv6oR086jyYFq70TKwjiIqHW3qWA=;
        b=RTet8kAGirwPBgmukg9ymEha5H7SSzoHqYXkcKnXdo6tr0thmCx57T2uS04OWaYhO6
         +tFsCWzb8esFvYI63eBmaFQDGmqLu4/aSeDNs3i5ccxPeJX4kHIaSn/1dOMMVF8XhKkf
         h7Q1UqddfR0EBAvLvKDlTjbwXS9o5zJyNKp6Cy752E0Jvtw+jZzGwQgJlirsUdoEUzxq
         3H9gks1yLLqkfTnfuzpnQGaCy5bWGH4oQbaIqFoJONlOnme0aZDEvwanwxaOwIcngBpm
         tFCc6mIDFlyWZIqiPaYPYGTH0AGBXbmmhqr1X0mIAy04lmL1kIMFu5xX847OYQPRZJsD
         Ekag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772295600; x=1772900400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+0bD5jaj0rtGiFTewJRAOE2xK+2r3ZqxEp4ZrxNpQ4=;
        b=OVfhk/FPjXinsNQ8rbNDemx+ofDBlESdsi4JYHkqhE6O0RpPy9xmOyRNYdzycacVeu
         kuYDCO4exV4a+L7ECulq5gLg2FRH3r4hbTAn5NSsyvtJTS8gBE1WGlRzteuvclNIF5vJ
         C5drQkDBKYnvZVNUGPG9yY3KHqWlFDFPBD/EW7p2AJiLi1Pa1SowsoJWavtvDh+Ek3tU
         IwnVIob5dk9EkUiImX3xD2WK3q+WzS9laoTH8uKwn+WR2ltfDaiP2e1VY/CQZg5Q7S90
         8sq02j5da91YpumA+zIE73x3juvbF4GP30tGJEahLGpb+djSOWC+QZD3/3ojsQ6WmRrO
         2ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772295600; x=1772900400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+0bD5jaj0rtGiFTewJRAOE2xK+2r3ZqxEp4ZrxNpQ4=;
        b=sQ/d5M6rFIR8c2ot6kmoFltB4BcwaUtYXRjC3ch+jCchakonRsZm8LYbz/vPbaldT7
         ONOx44BJTXCmHtgRCBPmIq+AXfn7bzs1W1xN0KEaap+/i3fqcCdAxfj1UPChdGbnJwLM
         9cBfna9mIwzmc3BFI1JKGo4Mv0VrlJS9io+xSjs3pBbvgPuuGGZcuRfTHMHTzg0KCWDN
         5xd7nTvbGUvkHiArr+eRL91qSd8ayup9Asx+VxdJHYpAJECEiWxoxePvB64ZxR6u/Duq
         cw4oO+huV86Wdi3I24otbehopxFpTFozsRO/ByjtQfHWhATGLVZOS2SFrSt4EgedCw3t
         0AdA==
X-Forwarded-Encrypted: i=1; AJvYcCWoM57rpsMv6QiC2DVLK7+7qVOp8sZzDKS5RJTXcBEtl3Esrzz85BjsHvDsLSaCoukAMeazRAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKW15YcSc2tS7u1fN3XsnDq/WF6xu1nNp8xtlAjNfSwzMLT+n
	vyZg4Ry64pDRvteO4oP7gqZBO/Sk1zkxwunCDzZd7hUMfTxmNd2kk1k/aFxjeec3W9cLbQ0imnA
	Q2yOOyPQjC/1pnHs5TA++Z589pI8y9DX4sHaR0zKc
X-Gm-Gg: ATEYQzxufquWVgcyqMKEAMY88lduzPD0ClQloXs/d4hQp8q+4HgiBLA4TR4fu/q8idn
	lFQWlIuZkJmayyQQ4zrm++AlzTFP2+azb6K+8kkSbCBCcdR3Elqr5lvw24c3sEse4lK2pmxNhZs
	ph43BTeoKZT+brxaJSuOSwX+OLjTuBLmtwr1DIcpRmn3I2MF1fvhTk+Aj9UFIuIbVqIiP1p80l9
	YovsFu7tRG6fgoP7Vebs8PCv6oYHW0yv/EkgoYOaC8uZ4vMYZfZ626Bp5nYEsNNtDJg1tFdCOCs
	rsYivqs4CsSup9kK9sw=
X-Received: by 2002:ac8:7f8a:0:b0:501:4420:62d1 with SMTP id
 d75a77b69052e-5075288c88dmr89701821cf.48.1772295599888; Sat, 28 Feb 2026
 08:19:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-12-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-12-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 17:19:48 +0100
X-Gm-Features: AaiRm50_E2vhpo3As_dwDGlTtjbTlCwrsy9S2mVx_Rbf6NVmj2W3ykC3CZgB_oY
Message-ID: <CANn89iKhCrt=8=4uLp1dLWPrTo_F3zxLxkYc59AuoMuDxO2p9A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 11/15] ipmr: Call fib_rules_unregister()
 without RTNL.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262163-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C165B1C4412
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> fib_rules_unregister() removes ops from net->rules_ops under
> spinlock, calls ops->delete() for each rule, and frees the ops.
>
> ipmr_rules_ops_template does not have ->delete(), and any
> operation does not require RTNL there.
>
> Let's move fib_rules_unregister() from ipmr_rules_exit_rtnl()
> to ipmr_net_exit().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

