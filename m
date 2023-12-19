Return-Path: <netdev+bounces-58912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAED8189BA
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306F31C245C0
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5FD1B274;
	Tue, 19 Dec 2023 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xd7fiYxf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB31C28B
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e517ef77c6so19162877b3.2
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 06:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702995882; x=1703600682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW8qMLN6kBbudGYYvdSQ9Zii0efBP3aj/O+Eh7qhJyQ=;
        b=Xd7fiYxf4in1mwjHPI7ZrfuYBw/EB1w9kui0+FtEc03TyfufIIUym4rii8zqJ7axi5
         9YWzyry7hmAyENYNOf6jE1blNtUsg6FiAb4Vgwp+G32G2hihAYWk55hhjBpZ0fPDUXeX
         a85Ld27qBBn4/whx7hkdGh5BpsvKSYCdeOl8omkoPuvJqPvH8dWyeti0NKnHm01vXjDZ
         eTI53XGxEF1i3c9jJBzJ/B8JZt/VZiDfiIscRXmQ71fb+oAP0w44AqpElYN5TkHE9Ysh
         0eDpxa0kQwad/HaTT/AdBlIj91lY1KHW1+BkURr6lda0ImOzDfEBgTLQ2FkbVrM0SMqI
         WYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995882; x=1703600682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sW8qMLN6kBbudGYYvdSQ9Zii0efBP3aj/O+Eh7qhJyQ=;
        b=eoT6sinpJxXMjARtkfonZsWp1W/3tzLA5M1NI8UBd8JSgK/RNn+f3TJbCOvsZB8sFP
         Al4nlS8gQZUmRagXK6aLYtKDSuBy4YGQrlfhY+ofDFokM+8JmCLnqokD7aqPp/Om3FZC
         yfGty7lx3PeqQ42LyDJ/ctvOOP8Fz5WNHX/g1UuD7Yzqc7xhLCJQBB4lNigUBc4jBkn2
         NcOHz3/V8dDvJGm9qLXRfu+xk43hmvlBEoOBdUMvQhvUOft3SFt6hqMBRpTNNV4NWFMo
         1Uik/S1FZRabBKP5ry3ZGLLqoTLMrHnBJOJIjoP6ZUlzWaktspDSAKPwCAK6v61K4sMT
         RInw==
X-Gm-Message-State: AOJu0YzJmCBXb6ympK8I9HgKzbfH3jeBTQ0e6WViewzaATMHiC/LYlO/
	801wK6IaL0BNV+EKJlKj8yCeTyNcoWMD4/A8Ez7cKYNqIRa4Qzzs
X-Google-Smtp-Source: AGHT+IHex8sfrLO9d+yWU94UJ2aNxumxMnT3mdaZSuPeRu/1sNM4JssLMB1eZ0yor+fTKHhnw7P6WCFHahVHB4R4Hqg=
X-Received: by 2002:a0d:e901:0:b0:5d7:1940:8ddc with SMTP id
 s1-20020a0de901000000b005d719408ddcmr8240066ywe.67.1702995882118; Tue, 19 Dec
 2023 06:24:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org>
 <20231216-new-gemini-ethernet-regression-v2-1-64c269413dfa@linaro.org> <20231218152315.6d566b96@kernel.org>
In-Reply-To: <20231218152315.6d566b96@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Dec 2023 15:24:31 +0100
Message-ID: <CACRpkdYu9gisMg6b60NZos5atLSifRJj12+q4w3+hMWD6mWtYg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: ethernet: cortina: Drop software checksum
 and TSO
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> On Sat, 16 Dec 2023 20:36:52 +0100 Linus Walleij wrote:

> > -             NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
> > -             NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
> > +            NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM )
>
> nit: checkpatch is really upset about this space before )

I'll fix it, Eric and Maxime opened up the idea of a generic helper to
extract the ethertype from a buffer, so I'll fix this in the next iteration=
.

Yours,
Linus Walleij

