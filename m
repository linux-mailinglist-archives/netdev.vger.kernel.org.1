Return-Path: <netdev+bounces-44553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1C17D8952
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A12281F50
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 20:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC623C098;
	Thu, 26 Oct 2023 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsmWBBXY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D823B7BB
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 20:01:27 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694781B1
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 13:01:26 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1e9fbb7d88eso864737fac.3
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698350485; x=1698955285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ep6Y3gvj4hh25AytLxfNhWqQLOhOYY7X5MdSy24s3I=;
        b=XsmWBBXY6QxB1cfXEiXE4Gx6C73ycgcFBhVckmx3/7+TofnRiN1qYBD/suaRKcmpW3
         VQw8gNopf/ZNmgcFWwUBvnhIWKpfMBZRNfeEKmGfNNYdZzYvGb7usNote5lc5TevHekc
         tb3R9ngHow5LGbbYyCspgJZTdgg8gIb0hQNnNykZxOy6UVgUKTCU5w+mxqH+RSa2ZJVh
         B6W5Aclq1jYcxAOladpF62+34Ta2vkOr+D/FvJZ61pRITl8rrGB+CAtnGMpOgpauiRFq
         XfafXgzyFuy0+ktsChmIlE9zPVx0KRF08TGIpMHgGxn59m9n5JcsHMT7ZUUiwSU8cB8b
         z6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698350485; x=1698955285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ep6Y3gvj4hh25AytLxfNhWqQLOhOYY7X5MdSy24s3I=;
        b=UvPwMskorpaWCaSOLYpW8KBVxKEsdDDjzDW1eYRP+1RCTBI6QCFKnUkBamNxbjBx08
         DAFVQAG1ZYbQzUPGafx+MpViqL7dS36TVeZttLuoLtCGxfAPkzD9wjvQBFgE+smDmY3k
         ts6X7DUQTXgWQOyc1muXUTFmLD6HumO88dICvuJUTdoniqyWefiQACWi7aWc+qcC30Hz
         ORZnqvEUFllxwmKgIAe1WRImL+CW6O8ZfgrCkDCVpOn5ySEZpN7pd5eK1hBiX+Y4XJMb
         gpO/XXQIOKUva2e6P4cszood/PO/chYOAl8c2MZtcAwZ7GJj3wItaeQsRDZ9Y3ipqDt3
         Zqlg==
X-Gm-Message-State: AOJu0YzcUsFTEZG4c3bLPJCcs9j4wyI1OIe/iohM9Vq20c3Zdl8JO1+8
	ztJCOGx1AprNu2ZrapEb5Pcz8atuIOgy2DtIcmI=
X-Google-Smtp-Source: AGHT+IHFE5WPB5pdE2G251/sxKnsy9s0rjePghk9uCR2NrDnY26fXHLvdSLzccREBIVNfXZ3PIgZqBZEf0F2DoYFdV4=
X-Received: by 2002:a05:6871:448d:b0:1e9:ee04:d25 with SMTP id
 ne13-20020a056871448d00b001e9ee040d25mr478937oab.59.1698350485595; Thu, 26
 Oct 2023 13:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026190101.1413939-1-kuba@kernel.org> <20231026190101.1413939-5-kuba@kernel.org>
In-Reply-To: <20231026190101.1413939-5-kuba@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 26 Oct 2023 16:00:49 -0400
Message-ID: <CAF=yD-+5__3PZcqucPeaM9+oUHGLbfn8AYciEMSyTXn+kYhgzQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net: fill in MODULE_DESCRIPTION()s under drivers/net/
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, jhs@mojatatu.com, arnd@arndb.de, ap420073@gmail.com, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 3:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Willem de Bruijn <willemb@google.com>

