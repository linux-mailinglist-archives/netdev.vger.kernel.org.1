Return-Path: <netdev+bounces-45819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82797DFC2D
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 23:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1641C20DCA
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 22:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5A022301;
	Thu,  2 Nov 2023 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWjFO2g5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700761F94C
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 22:10:17 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB943138
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:10:12 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5ae143e08b1so17800507b3.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698963012; x=1699567812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jlv1B7XXwhStizLmYC3q5QyPpoGJxIV5oA/dcG7ZtIs=;
        b=mWjFO2g5wJdwpu746Un8zS1DlY199XDUqgzXgc1oz+mhO9PWmfhGaM7645dn9gnXWV
         cM8aSrcUI3tTaIXt6hz4i1sgs5aExwUnqCFKus411djGllYxvjVTNLlotqJh6Pdr8p+W
         zwz6S6CznyK8I9Y4Wy3uovaRsHmnFq+2CufbjmPhh3bhgBSaJeKpFkmF2X6OqQMhJDQ3
         AOi++kQ15HBzH6j1QB5V1F1UuZZcN5uTkd936w8sD7znEkoSO2sPgvX8G3pQ/oH5aL2B
         SJgUDpWiyDngWzKCDiRPDkvQGEPuZilA/pL9IuPhHA2kiLTwYW4FbpkAIArXoLLYw7lW
         MiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698963012; x=1699567812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jlv1B7XXwhStizLmYC3q5QyPpoGJxIV5oA/dcG7ZtIs=;
        b=LNzeFJY9HAKDDsYY9BY/dGxM8sUixRHZWxguKxQ09NevomwFFYNRiS6nJsvQzh/F8w
         1kn28aEdGH/n+BxJYGYSqPE9S+1FQ0kj5PQN/hIvZToAtfhpqNpHU6wAJWII5tUK8g5x
         xdJwEkEtIFh5e1YGkASKvQVT6zVd8t3qBaz0g1A46WmLN8CnJ7DzpbD6MZt3cuRc2ZW6
         nFmyTk+hDHJuN1GeTRzhiJtOIqNcpyp6p/2reySneRe11dw913UKaX7oLbQaUT0AEIz1
         0uy5QyMGJzpyHOuNRQdOXbyR4GVm5YenZltrWORUI3DmWfRDluar2//k+bre8W7Q1T/e
         ya3g==
X-Gm-Message-State: AOJu0YzNVaOta0N6jsVfm4ovlTea3NCBde6NlPEilqPgzYu6csW4bKhI
	7YYLydyI/DaIwYZ+8ntgLyGBML6D+SzWswvieQcBIQ==
X-Google-Smtp-Source: AGHT+IHlg3mpohF9G0EMdD8fmE7UgMQ6+wyv4TfkPfT0jY0DK7RzJ7yHRtYfN2bsl20NnqM06aa5UDWie/DuMQZ1NhI=
X-Received: by 2002:a81:9290:0:b0:5a7:aaac:2bce with SMTP id
 j138-20020a819290000000b005a7aaac2bcemr1117873ywg.35.1698963011965; Thu, 02
 Nov 2023 15:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
 <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com> <ff7e60bf-13c9-44fe-b9e0-0f1ef4904745@gmail.com>
In-Reply-To: <ff7e60bf-13c9-44fe-b9e0-0f1ef4904745@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 Nov 2023 23:09:59 +0100
Message-ID: <CACRpkdY2UiFyTvF=zuk-rSZBi+yH6cP-QRkegMgc3wf=9JD_Wg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 7:43=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.c=
om> wrote:

> Looking at drivers/net/ethernet/cortina/gemini.c, should not we account
> for when the MAC is used as a conduit and include the right amount of
> "MTU" bytes? Something like this (compile tested only):

The DSA core already fixes this by adding the tag size to the MTU
of the conduit interface, so netdev->mtu is already 1504 for this
switch.

I found other oddities though so I'm digging into the driver!

Thanks,
Linus Walleij

