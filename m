Return-Path: <netdev+bounces-36075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 789AA7ACF36
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 06:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2BAEE280F98
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 04:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FD10E4;
	Mon, 25 Sep 2023 04:36:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865715B0
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 04:36:16 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59809DF
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 21:36:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53368df6093so9681a12.1
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 21:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695616572; x=1696221372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utpCVSnKwmUjnI78nqFvLGOx8w1hMljEMO2FokBLE1I=;
        b=ybr6RM4CPXpwC9LRY3DBeFzRR8xUW4feAfauDPvuNqGD1XTEgTZJ6PysV1BcIGUkUW
         YpPV4a1uIofNpKwJGKIAfmzVso2/MAKtqv9JruN5CBBgnotdlr2lHuyMX1lB71iVsovG
         U/DSoEXgp/YIsyIPnhIsjH8h0SsTWPfJ/j5TEABPMYSUa9VXHeJObZ1U//c60mvSXaAg
         Uyzfyc0JGX5Df0HeGB5VSwYoZ02krp79yhq9F1wpQIqpxGAD/zrR+ITeyQmSJ8xE1pQY
         5wKjCRB2yRF4+Gi3Kaxg2BbJo8xffQCdHyjmzOzzwR9xP8YYllbzMcnr9xwnj4Azy0LH
         qYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695616572; x=1696221372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utpCVSnKwmUjnI78nqFvLGOx8w1hMljEMO2FokBLE1I=;
        b=tpJxjrMKjc4QHZWr/J/G3r8mn21zkmtsqJC7/ZEvQvT1kSDHwB99q+LBY3/Yot2i5M
         uR49U2AqPTWsa6EL6MtkzIycn1+5i5hXHt7COhHjR92L3X9Jx9rk+PZZvWZxPDJG6iAn
         uTX8mq16FX3Bvbd3MVF6+zBy4jSodZRt/lNoA8kQ6uhLVIfN21NyEqwf/5qikxtxvPOf
         YO1VRUuQlzTdUE2/9GZIAAR+WSRvZ3H2ZYuY2sDAfWG8EsPsAw4Foy/kiPNmLoibqlrd
         X+YpPCUJAVEADwW6xJ0EqqU91h3m/GzWxlTZ4EeC92sztLBLhN22eroOoCVKfAGgB/Y4
         pRiw==
X-Gm-Message-State: AOJu0YwYt2OZGBk2+xYttMzjvbASX8QkwKfvLcjIU0nF8qRbTxSy7adq
	VPnoXhbEX/j60azUU2CmM1QD09QxRYhzKVXmrz5lVMxDB/4wvN6DuEc=
X-Google-Smtp-Source: AGHT+IHKR23zBujhctNddZ7OKF7KZBJFI4TepLmmMkO/RSku8CnURNUbVfdbS2tNLuBfQcREKCgWH/+nVYtyPrKezTY=
X-Received: by 2002:a50:9fc5:0:b0:525:573c:6444 with SMTP id
 c63-20020a509fc5000000b00525573c6444mr23731edf.1.1695616571593; Sun, 24 Sep
 2023 21:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922210530.2045146-1-i.maximets@ovn.org>
In-Reply-To: <20230922210530.2045146-1-i.maximets@ovn.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Sep 2023 06:35:58 +0200
Message-ID: <CANn89iJgeCvJbcapir8WkJv6nYop5CcfxgBrx3BoxEuwp0WA_w@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Madhu Koriginja <madhu.koriginja@nxp.com>, Frode Nordahl <frode.nordahl@canonical.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 11:04=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> Commit b0e214d21203 ("netfilter: keep conntrack reference until
> IPsecv6 policy checks are done") is a direct copy of the old
> commit b59c270104f0 ("[NETFILTER]: Keep conntrack reference until
> IPsec policy checks are done") but for IPv6.  However, it also
> copies a bug that this old commit had.  That is: when the third
> packet of 3WHS connection establishment contains payload, it is
> added into socket receive queue without the XFRM check and the
> drop of connection tracking context.
>
> That leads to nf_conntrack module being impossible to unload as
> it waits for all the conntrack references to be dropped while
> the packet release is deferred in per-cpu cache indefinitely, if
> not consumed by the application.
>
> The issue for IPv4 was fixed in commit 6f0012e35160 ("tcp: add a
> missing nf_reset_ct() in 3WHS handling") by adding a missing XFRM
> check and correctly dropping the conntrack context.  However, the
> issue was introduced to IPv6 code afterwards.  Fixing it the
> same way for IPv6 now.
>
> Fixes: b0e214d21203 ("netfilter: keep conntrack reference until IPsecv6 p=
olicy checks are done")
> Link: https://lore.kernel.org/netdev/d589a999-d4dd-2768-b2d5-89dec64a4a42=
@ovn.org/
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Nica catch, thanks a lot.

Reviewed-by: Eric Dumazet <edumazet@google.com>

