Return-Path: <netdev+bounces-23227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1076B5E0
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE62819AF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D555521D4D;
	Tue,  1 Aug 2023 13:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA833200A3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:31:09 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765CB173F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:31:02 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-407db3e9669so257521cf.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690896661; x=1691501461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsO+Zl7CUnASQXP0pNGTsohTGDW6byIjsx/QqCHb86M=;
        b=5gjWQUE+sGzZJUk8GTBNFCY2Ukgx6UJk/M8SSHTXcRt2509TjEJ/WjPI5RKsHCVNAW
         2LTuYOywqRolGqGCuu54wlTDlrslWqzjzb7KGVcAKKZ7ywpgaaZTliSPzNSsTHl+ats7
         RJnG6m7Z+lnsV6GjWrrXLjbtjvzFZxLTDU81zurkRAvr8eH6/dIYOQgJKkgpnSy/dOtR
         5+OHad0k3vx830SWafnBRC7ggC0olu4NBZnUn9VnLw+HCOQ2+x81tIvz8Srgba/ZFmfY
         TB0kPhcvZd3hhF5KxmSe+4EmBftUaFowGjRHIx0D58zrLg/zIpoS6Fl0h2oGe0ZGSeaQ
         bZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690896661; x=1691501461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsO+Zl7CUnASQXP0pNGTsohTGDW6byIjsx/QqCHb86M=;
        b=WVl8I1nHdEuTCTEzQxQyrxPcSkLbD7/8ayiukcnVBfqQgYlYqZ4Uw/1bKOgyI/ta6c
         KoAgXgn55pcAzrgxeOzSBJwilUYvYeRDBZpCwJns+iajqtajyjMf53KuQeCuJ++R5vV0
         fVOL20l9LLI6SHkg0bzvz+bt22fB3tVYTYH27ZF97Q5CxvzqhLpe6DsLdRj6nMJXixdN
         E9LCub3gQBy3GVJVQCXrVsmKmKcGUQ1c7+eRE+oe3AG0dx4KMsWDMR6gCQ5Yt/onUeWu
         DKKE+douuoOo0MtpdaIGT1LhvtbtnWQt7JdKy+VCYe5it4QzeDWVVO1yEShjAVyJS3B2
         HueA==
X-Gm-Message-State: ABy/qLYVtkZc/RPm3GsKWJ5bPkEByrXnh5X58qDw84H2H1sL0bLOdAWF
	Rg54ypWvcFtGBK5m/Pexcs9Qq9qUbsDxsUQYF2fq/A==
X-Google-Smtp-Source: APBJJlEqdUmI77KcWGZOQ5yXmFTXtucrwvbdJ6vPrG+TQqRszduBf4M+gW3Q8Pzz3v+94F5oF0OgckOE+YZTgaO5ZTE=
X-Received: by 2002:ac8:7e8e:0:b0:403:b1e5:bcae with SMTP id
 w14-20020ac87e8e000000b00403b1e5bcaemr812745qtj.10.1690896661367; Tue, 01 Aug
 2023 06:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230731230736.109216-1-trdgn@amazon.com> <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
 <CANn89iLghUDUSbNv-QOgyJ4dv5DhXGL60caeuVMnHW4HZQVJmg@mail.gmail.com> <64c905205b2f4_1b41af2947@willemb.c.googlers.com.notmuch>
In-Reply-To: <64c905205b2f4_1b41af2947@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Aug 2023 15:30:50 +0200
Message-ID: <CANn89i+-CQy3T-uLebzszGBv7m_CQ4DVeC2OORYn-6GpKgPZQA@mail.gmail.com>
Subject: Re: [PATCH v2] tun: avoid high-order page allocation for packet header
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Tahsin Erdogan <trdgn@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 3:14=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
>> This exactly same allocation logic also exists in packet_alloc_skb and
> tap_alloc_skb. If changing one of them, perhaps should address convert
> all at the same time, to keep behavior consistent.

Sure, I can take care of them as well.

