Return-Path: <netdev+bounces-46073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEAC7E114B
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 23:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BFB4B20E16
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 22:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90558250FE;
	Sat,  4 Nov 2023 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQtP0qUg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E16250EF
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 22:17:21 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF7BD6E
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 15:17:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a90d6ab962so37691377b3.2
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 15:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699136239; x=1699741039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFj091NY484IatkiEQTNZzogLvWatap97+ZtL042cRs=;
        b=bQtP0qUgqMze1LOQHt+4smSIw6fTeBhSAPACNoo5vbID0j+aCDrm4bmKvwg9lyqwHu
         KwnbYcLcB9KR3W1xTctTJK2ifdyh6QJiohRzlfC3Go5fDuY3AfvgQ6ztMb6I59zcKTgg
         /lIUAd8LPy12JJOPyaaSBLVulYlqToz6U9KHgEx8YImAHxUYXVMdhoTQmexbiZoZmszq
         Cuh7oNuBtyvlm+vCmqMwZcxWNkddqPF1Z4n7AcGuNwwRBs55Ux3xFKlPD16vkuetoX/W
         XRcs5A15oLFE/dbWIuhh8zqrYXqAoBdLrOUPE4ES9WNDt20rZSvqPkLC+LXr1pNbOnMi
         bUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699136239; x=1699741039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFj091NY484IatkiEQTNZzogLvWatap97+ZtL042cRs=;
        b=bu66pq56b/pnGRqDr4+cWu4KWqrSA0+OcKoT9DfcO+7juYnw18c1ncLU02UtwLdCY7
         Xlc9Z85Y/vvUCALb2GNrnZG/XkcoE13db/aLMMyy2uR3vkZrwI7hIQ3VTe7FwRaenq0c
         SuQpjx9qYjzwJtnCdtSIcMFWjyVqQ23hrIYgbelbPg1hT4m7ssEsmZSBtDGC/TZ7iKpJ
         4k5qsDwMgmW2GoRj//2aAqF28kLxy45o1BXc1j+2NJ3eG0dXNPMoKCJNqlHOqHoV0hZs
         ns3czmKtEeVdSwEMGzvP33IJbyt/L2a1Bf34aFizeykpjvqzo5KhLwiuU/uNKDVne3Hi
         xHWw==
X-Gm-Message-State: AOJu0YwL3WjiFdMN/76cI/dLAWro9bwDM1XksDcQLcIYmv5BkSpvzT7n
	7bbQxHYRTtCMsZDbgYhLIWB1b9UwaidMB21tXtjVBA==
X-Google-Smtp-Source: AGHT+IHMsx/9Sr5/jGo9tNVECiMnGWjMcLR+eV9W9UNnHt+/Os+5LsdzN9IRgx87prnKDEtH0vwuQurH+Lp6UjR+Cj0=
X-Received: by 2002:a0d:cac8:0:b0:5a7:d412:af32 with SMTP id
 m191-20020a0dcac8000000b005a7d412af32mr6677516ywd.10.1699136238995; Sat, 04
 Nov 2023 15:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
 <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com> <20231104141031.GF891380@kernel.org>
In-Reply-To: <20231104141031.GF891380@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 4 Nov 2023 23:17:05 +0100
Message-ID: <CACRpkdaxC5kAJ3BOG36t=6J273+r7-F7z7He2Y4ihwGT0ptAUA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 3:10=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:

> In this case it may not have activated the automation, but
> I do see that the patch is now marked as "Changes Requested"
> in patchwork, so all is well.

Yeah, in this case it should even be

pw-bot: reject

because I found the real problem elsewhere.

> FWIIW, pw-bot is (slightly) documented here:
>
>   https://docs.kernel.org/process/maintainer-netdev.html#updating-patch-s=
tatus

Thanks, I'm getting better at it!

Yours,
Linus Walleij

