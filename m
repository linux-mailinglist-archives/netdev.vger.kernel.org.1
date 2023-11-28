Return-Path: <netdev+bounces-51717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B0A7FBD9F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90B9B20E72
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0D1584DB;
	Tue, 28 Nov 2023 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BX0kvlCs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4348719A7
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:02:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b4fac45dbso20225e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701183731; x=1701788531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfZqAfnng9q1Ub5AUgJfpewVHPray9107z1f3h+rAkc=;
        b=BX0kvlCsP9P8eO20cskyU4MmPGMwzcURijUl956tmMI25H0uaNt5TVHzxJnSX8ddXJ
         mk4/cfafHU76XZ2xrdOlqfMGXdPrwGn103cLvDLu7vy8GR+zjvMXJphZIyrsxMrCsmDg
         5yqjB13rA1KQ1Qqz6Xxpz3E9c1ZNfLwtFuM+nilo8VNzKobtZCs6kCHBf/8H2MqqKUs6
         9ZyCO2QTEW1xCbs99NJ6OJS6HmmSjWe22W50eMorUDwQJW6lhlQEqXmApYbvP8mBpHMs
         dV+77xAW1Ur8RdZv7Cj4+j0Bo68TEYns88LJphIC444KE0Z4rqS4BA4w14N60WLziC/b
         D1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183731; x=1701788531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfZqAfnng9q1Ub5AUgJfpewVHPray9107z1f3h+rAkc=;
        b=ZLSMi8n3VDq8BE5SPYeSTJ+sgI/ANKYfEwbPKCPDYv4SOFYd1wGEgiHmwJJn8CK0zI
         zzG9PlZFK93hb+WvuECxfCTOfs9oneha4qdEDDaj3qvOy+au2/NzV9gmHa1lSJKL/d5D
         VVLO6FNG34G4xGLq3L2rp31rhFKkhKShJSjdbgWRkn/HlkFNuvLXI422t3M9IleDfJEJ
         J9YXta4CaUSGIeoZimXRPG6ebNWMYt5d5FWU3illzFbmh2aNhRJ6m3HKc5UpejTnCqyC
         8ogsu4RfjFprj2x9D7j3pAUAXimq4pVvCwezfFXyWxJiuwTyPEwoNHXFeJcSGUzwfobv
         oniA==
X-Gm-Message-State: AOJu0YxvhE+lL3Zr9FW2voxQL+j7xAgYE+mHhSrM1jGDnBIOur100uKW
	Eo2uU5vVjGsOe3pV6yWgjzEgiULC4VzPctpYxKhApQ==
X-Google-Smtp-Source: AGHT+IHg1J/eUuMXAGVdOOKH1uR5DmaLvFGw1h/PPEyUEwXPFfz92sV+mfZwqJsSlxrJjSUxT80vpuNYjiZAW5sEAao=
X-Received: by 2002:a05:600c:818:b0:40b:4355:a04b with SMTP id
 k24-20020a05600c081800b0040b4355a04bmr334051wmp.6.1701183731386; Tue, 28 Nov
 2023 07:02:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125011638.72056-1-kuniyu@amazon.com> <20231125011638.72056-2-kuniyu@amazon.com>
In-Reply-To: <20231125011638.72056-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 16:02:00 +0100
Message-ID: <CANn89iKLABAG2OgtseuE8pHicmeO-kWe4kzq8ythurRUkGwX0g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/8] tcp: Clean up reverse xmas tree in cookie_v[46]_check().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 2:17=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will grow and cut the xmas tree in cookie_v[46]_check().
> This patch cleans it up to make later patches tidy.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

