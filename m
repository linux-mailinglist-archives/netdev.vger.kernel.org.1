Return-Path: <netdev+bounces-285887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL+4C4v9/WkdlgAAu9opvQ
	(envelope-from <netdev+bounces-285887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:13:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A61CD4F86BA
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35B2831734B0
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3063FB05C;
	Fri,  8 May 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grWAkI1q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE80F3F7AA8
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252714; cv=pass; b=aY32B2YGVkETQYlTfKW5ofmqhuHij/+e5MIJgBxNy0XJdP6o8B8NETCe8wA9eEsvKuUJjrhSnfue5VYFaB3vWUp/dZg13W5gbg83ThMaaS4pTIhn4MGddnPxcz/4id/INKMS2AdwsQHFdv4mhYK1z/5Kis4t7X8/GufMNmxjPiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252714; c=relaxed/simple;
	bh=esEINkzvSB49gsksDVIw2zRIWf4vuy6hPfr1s3Qeky4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqYPxt7s7bnmB8meYzI1YHzL1jBFusQsrKy9pb48OYFB3uJRfDllKXK1Jdu8FpPQPDlF4m8dLC8kBMep/uD3r+Odflxpkd/Lpa8yRHr1ZUR3VbX5g+zHYo26LmeC6siBxqUI7UlsMdV7h6r/xSQ4Ga6E0FoueAq2Qr7OA4Ne/eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grWAkI1q; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d736211595so143474185a.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 08:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778252711; cv=none;
        d=google.com; s=arc-20240605;
        b=YCIyFUMKx6N7TJPbMAkyEBRFW4p1cEm9jgaZLhVUXnYRqZQp5tDCDy9KGoFQ2c7mb1
         o621X/JwT8527114pbCEDcTfFYgMUecIrrV06iFDFvnY5MTtPChnnjJ4voNNmkeudzgW
         txKUIq9Klw9x1ptP035mJmBvMGUFQrjXgKEKONffI0jkv8zLO3dCPMfo1SysImxALK3y
         ndIklz5fnJ4EFTbdMGLsgkMHkHnVeFjztPbq85+xx99XByn3dI0il9fhEOZHIM1s8V25
         I2mnplKweeRJpljrJMow99fYOusu4mi2h3I7i7aDIwA6dhCXsqYH6iaMgRLPlH3e1rYr
         BjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BejpGG+/UBbRK0mUXcv1hKWa9Az21UAU0nYYlKZz9LE=;
        fh=gbbvWiqb8OuKkHm8OzWLr1GGbOHaz8zVDJBd9xkWxX8=;
        b=YKqYSah1UWsutlWrxJu1h+AoiCBf/ImCYUdr/bcXL/nHrBr85CK15tSM7yq01Loj8L
         PDOl8+Y2Zwr7sRxaBa80JaLX3qI3cm1NFJ5dZyWgjcUuFtww0ebUOwLXIevsQj4r56Jm
         ChEXI/NB0e/PZzHz+1wIJkvLubX6ZH/DaoTYfopTUEHHClMqG+/EndJ1rLRaopLWzfsk
         nYqaQcPF6hugcqrMOCz2/Rwk6lvj5Yqlvujl68ZuMQ65W3IIa336Ztyb3KbUmyJHs/nv
         bWHetgSbWWk1zwzAbUpKrxx0Fw8LlmnvMcidnznI6zVWZfIaIL6foNgp5ubHhPcBsKWS
         zAAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778252711; x=1778857511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BejpGG+/UBbRK0mUXcv1hKWa9Az21UAU0nYYlKZz9LE=;
        b=grWAkI1qgNTIpWQgLVroctkdDduuCBpMRNYRmnpgv/k4jbI3HKZZjALKgOrIsBFhiK
         eOBxRrzVFV2dQo5ZqdMKK+1faqEeaD4ztHU7jZfgWkQEdI0btW1Cbs4Ft/fUdLYu4wgt
         f+HO0iGs9z4rhiqZUYzXfNb+5f4xj1OZ9wGQFQMEUrNYrdOyffDmHREdsGokCBFIpKMs
         KQrvwoVqdneFHfc/Rs3xJYGPrQ+1BOxEyeczMusxiOS9k3/LePfKcfjnYzGyQiAMzo7Q
         SiNpCqKZVrX1WEtHzaPEavpWwIE+BbGw9flepKGYqi3OZZ8ygU2y+jur9GzGfqHhJPrk
         Kkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252711; x=1778857511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BejpGG+/UBbRK0mUXcv1hKWa9Az21UAU0nYYlKZz9LE=;
        b=UqE4ZpBqnM5gksPkYcGUd2s0jqi4aeM1g277msAoZoykloxUOcBQ+I/KW9QNnXjEnk
         NHh8p1jzPmDMKjLxdJ/yvkHe3JePfGishR+GTEQZYWs9who7gTS1CJNzixG18w4s/Dqe
         wF7THkRvJr8QGMJv3BTMEX1HACs2iEjgGZPQ23Y8fZ19lBoVSg2WSmxYoMxSsegzPGiS
         tEKk2BQ7zKMBL+jCEy9f8TPySELk1WHc7Di6s8+VmUfXiN8fjULISKzDO11sMxRWJftB
         Me2SvNP0utCyWYTjxq8VXX5wBOtV7jBgdREAQ7GmZh35FZi3vw/zsw/2GYgO7q3NY+45
         dxDw==
X-Forwarded-Encrypted: i=1; AFNElJ8lvJo6tSY8XwTSfrwpkC+9QIEY5p4xzcsyNZDk/+GpabHYY/5sLD/J58tDEQl+MzxfVv5PmUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU4Kcs4mGhB3duR1jw63LC7TbfBmefENpMv1hmx9cbYUGKgwKP
	jwAtQNUDANmCLZGa/b/d3xMR1/yKrBmOYqeNLrqY9KHDBsTv64eh+NFrQzriWyZw3Gdn1jk/pLK
	3CTlh3DHlOv9ta/UYli/w5AiuPQ8Fca0ZJCMYL9WQ
X-Gm-Gg: AeBDietixg7flOuJuYiKA5+x5aVQaLCq2vIJ/1rhQJPrPq34v2RZqWuCQLVt0NJ6Eo7
	3LIZz+TLs/qTpQ7iENR87SAixdiDDybXCovLwTpnwR8JV3ax1gmfOHkD33w9zDaS1g4xC/O+bzB
	GSpJCCBa/kkBqRyKcdFbHSdWtHUTcDYrMnJ2GU4S0W7HwRmXRqhvXscxE7HvWZVBV8v9k61lUWv
	b0YUdM0DjmKEd+Mko8JDY/1kZX/VcNSPWYC4MD+8lbxeEN2xewm6NkgMxgeY+Kbre8K4X7cxSKH
	d8PFLqvq1/gNpvVkmM5XFaz7uWNPbVSdgWuFvFvdLZKgWztY2FA+B3/Zbx+uWncGhOY8onpC4z+
	s+di0MpbAFK9fVhf3fKe7bPwD7RzTRA==
X-Received: by 2002:a05:622a:5148:b0:50d:83a4:2995 with SMTP id
 d75a77b69052e-51461c304d7mr167772841cf.21.1778252710759; Fri, 08 May 2026
 08:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508120853.4098365-1-kuniyu@google.com>
In-Reply-To: <20260508120853.4098365-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 May 2026 08:04:59 -0700
X-Gm-Features: AVHnY4KlbI1r6I4i_WJ1P1H26gGPDkDe6ur22AbtilTbZ3EQnfcTjfUmoSIySKE
Message-ID: <CANn89iJcZ9PpOeqnU6RAhwxoGVGWKPQxiRk74KuJvNAm-XyjVA@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: Fix out-of-bounds access for twsk in tcp_ao_established_key().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A61CD4F86BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285887-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 5:08=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> lockdep_sock_is_held() was added in tcp_ao_established_key()
> by the cited commit.
>
> It can be called from tcp_v[46]_timewait_ack() with twsk.
>
> Since it does not have sk->sk_lock, the lockdep annotation
> results in out-of-bound access.
>
>   $ pahole -C tcp_timewait_sock vmlinux | grep size
>         /* size: 288, cachelines: 5, members: 8 */
>   $ pahole -C sock vmlinux | grep sk_lock
>         socket_lock_t              sk_lock;              /*   440   192 *=
/
>
> Let's not use lockdep_sock_is_held() for TCP_TIME_WAIT.
>
> Fixes: 6b2d11e2d8fc ("net/tcp: Add missing lockdep annotations for TCP-AO=
 hlist traversals")
> Reported-by: Damiano Melotti <melotti@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

