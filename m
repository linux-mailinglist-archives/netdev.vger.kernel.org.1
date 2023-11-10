Return-Path: <netdev+bounces-47115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E217E7D23
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 15:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3512811A5
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890D11BDF1;
	Fri, 10 Nov 2023 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eTP4MkX5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5E1BDCA
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 14:48:47 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF6539CD6
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 06:48:46 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c3aec5f326so662980566b.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 06:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699627725; x=1700232525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaMy0qRFyEah4E1tWT+kGJHayhlqeA9A26QIZGygrDo=;
        b=eTP4MkX50Nv1sjGkxsiFyTY7RggFMXAJ2uHFRKkhGu+9IxCOkEBZObzGgfc91Pk2qW
         jbj0QWJZdybtBEVNve6dm9MfUQ2l848oGNn3gBJdOBIMKYXrxXQP5z54cyvCFUMlqp6G
         x5BwtPqLk8pQbC1CBaRcytDDVs72mkjEFXY7n7SqrsFbdKUZf587Ujh7RxKSNRll99+R
         64KQtd4zyQgXiTRZ3HkRCtbj1uR4vKoE7bqonm7Gw9ZG8DIP4bFtplXdtDcZtSZ6Tz7f
         y3aJhS10j3Z28n+DnOQkJYogVKvRRvbaIThdtQaGmV7vqi9X0OEFIPgNKI4I7+BOvxhG
         4yNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627725; x=1700232525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaMy0qRFyEah4E1tWT+kGJHayhlqeA9A26QIZGygrDo=;
        b=s2+Fl5Wb7kpn9vRcfnnJoHftyghnQpDUywiSAa7/IHN3xl/az//E0ZBz97Xzv8b6m6
         SpMw/YnVl9swuQQgrjPaBnqJ56HwrUeUir4oCFjXd16VX17SaOqtiHw9j154R483zO+4
         4JOk+P5chXB4+YwAXyDHz+O5t4lKOkQgBmsxtt/ShjRAnZVPfi2lFBZn/66yZnvt9fvj
         G8krSlV6eCYUZQsfcCSZiHkF5PEoWZsCfjPzr9aa0pzf/0TVi6gauQWLgLVx9/FwyQ7d
         7kdT2EfMtrEJgV7DIyc1ZNVRdr8NfieHesVzdyGRtA7CXfvHtX0NtV2VELvxTVZIIEcY
         YpoQ==
X-Gm-Message-State: AOJu0YzYRxBJfzK9Dxri9MUmu35eSfxc90ylnWDn2oPRO0mWXTIB57Kg
	XHpUwx8bmnBdUyqqTVuTzX3f0l7ILdahBGykYI97gA==
X-Google-Smtp-Source: AGHT+IEqVdEpCw1dHu9v/q6rlF1qRuIjQPsHV1exJOC+CBiyhmcWiGrAtpbfM0YsO9SbbBEtC4wUh7b1tJ46lUlLexU=
X-Received: by 2002:a17:906:f259:b0:9e5:d56d:d455 with SMTP id
 gy25-20020a170906f25900b009e5d56dd455mr2553996ejb.1.1699627725137; Fri, 10
 Nov 2023 06:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZU3EZKQ3dyLE6T8z@debian.debian> <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>
In-Reply-To: <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 10 Nov 2023 08:48:34 -0600
Message-ID: <CAO3-PbqSXjMrYKovoUJK5FhfD=zpkKosVbK2UtAARa0VEFzuGQ@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: add a generic drop reason for receive
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Weongyo Jeong <weongyo.linux@gmail.com>, 
	Ivan Babrou <ivan@cloudflare.com>, David Ahern <dsahern@kernel.org>, 
	Jesper Brouer <jesper@cloudflare.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 3:31=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
> it is time we replace the various constructs which do not help readabilit=
y:
>
> if (something)
>      consume_skb(skb);
> else
>      kfree_skb_reason(skb, drop_reason);
>
> By:
>
> kfree_skb_reason(skb, drop_reason);
>
> (By using drop_reason =3D=3D SKB_CONSUMED when appropriate)
Will send a V2 when net-next reopens

