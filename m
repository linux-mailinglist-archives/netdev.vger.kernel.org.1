Return-Path: <netdev+bounces-51626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160FA7FB6FA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39F8282A91
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5D4D5BB;
	Tue, 28 Nov 2023 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxP9Rk3n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B18131
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:17:04 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so7503a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701166623; x=1701771423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSU7RiW9kWBySWNiApnuifnrREcbeWKU+jp6ylDsDY8=;
        b=pxP9Rk3n1G6JKdm2gTnTegccDt2874mVCg5qOudKJYHXhe4caA+XcYKc3scvBWLmXA
         6SQrKOjD+l0VTl7U91SmldI+WOG955eGR5cfT0w/w3GXXenepMMHO0bX86PmR0c3Zepp
         3OURCBe2/n2CMVBQHT2xJefzDncPUom7+lvQP7vJFw5GUlnX7THCsHdQOJQyaIVj6Eux
         iQmryZXEhXARRAD4wUFgpKyakiw4XDp8R6lYm0cNjyGRTFRYyO4AWORrgTjV0VcjXN3+
         paFGrxrDuOyuTdWrVgl59/7Qx6oiEYVUpgGsndVX5nXM30HtHh2f0nVcTIju+zM/r+k7
         b5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166623; x=1701771423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSU7RiW9kWBySWNiApnuifnrREcbeWKU+jp6ylDsDY8=;
        b=VqKecTf/DliRZQiBrkhCYIlOBrd8+tTfkKPPsTpaDMzosaFoaWOUtCHlMh5ivqHukT
         7sq9KCaupvf5KYaoppOrQVo3lu6JPaZXfkQF/v8JdD96MfvT8w2uHe/q+xn0LVHTjyoM
         IlkBJ4gWq5rXTphdpSIQjRg3rdpLBt2MHxYYtlulM1uXo6XXGsz1+r3d37Wn9hpvUybN
         fKX7WpRhcPZkg5JiEZR6D7NgWmChuh5pI+RJ5v0oTdEpOjLaFT8JQPn5EbH79MWsWHaP
         mQFTGsARwWj4ICOUnMralgywOnCV9Zjp4zIUITN3FupmeCGIwtKuE6a9dPBQVRCH9RYL
         RMkw==
X-Gm-Message-State: AOJu0YwbJisqRJAEV/YZcj5J5COiIrdm8Ec1Oo2E2r8jUlxTnn88kURs
	yC4PlFfUJVk3xlRg2wnFE06nYuka1ma1IPwQmz0qHA==
X-Google-Smtp-Source: AGHT+IHT21jrQA74w70vM2ZUlNPGfY7/KwZ2rB5qBpso7Yf59WKnCAYV1L8QVi/xNhNSJ9geHs5ZQxAFG/36oypU70Y=
X-Received: by 2002:a05:6402:3510:b0:54b:2abd:ad70 with SMTP id
 b16-20020a056402351000b0054b2abdad70mr366833edd.7.1701166622845; Tue, 28 Nov
 2023 02:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125011638.72056-1-kuniyu@amazon.com>
In-Reply-To: <20231125011638.72056-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 11:16:51 +0100
Message-ID: <CANn89iKyna3dhjaJ2fGaZtdd0JooQQ8j4b7r0Oo2g_axiutJ3A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/8] tcp: Clean up and refactor cookie_v[46]_check().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 2:16=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> This is a preparation series for upcoming arbitrary SYN Cookie
> support with BPF. [0]
>
> There are slight differences between cookie_v[46]_check().  Such a
> discrepancy caused an issue in the past, and BPF SYN Cookie support
> will add more churn.
>
> The primary purpose of this series is to clean up and refactor
> cookie_v[46]_check() to minimise such discrepancies and make the
> BPF series easier to review.
>
> [0]: https://lore.kernel.org/netdev/20231121184245.69569-1-kuniyu@amazon.=
com/
>

I am back to wrk, and will review this series today, thanks !

