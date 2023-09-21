Return-Path: <netdev+bounces-35590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA877A9D6A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3E6282AD9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D6518050;
	Thu, 21 Sep 2023 19:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7B1773A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:34:18 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00072115FA4
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:34:15 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d801c83325fso1613327276.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1695324855; x=1695929655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr/T9kX37mjruI2YODshHpmgcsopLzBXqNS+RBfjBUE=;
        b=hU7InRML2JYYfbd+FLHOuqsZqo+WOB81a6AdqQNUvjdSw6PWDEZ2ECUn+O433v3vIx
         KbKUh/Ww4v0wkDiEitRImweROpjqqBNT2TB4F0FhhwL1CKt6eypmJtd2QKWffHf4A94k
         ulBOiU1h+oQRcc3F6rJc47b/h+BFSaNSx2Ry4Nw2AS0OsOG8lu9ceLID1c2ZKbEryvu5
         s1917Pg/TGG8HDLbS/iqa+jH2mHikBN/M7Y7cD64q3gq/C++/ccLRSruyhZ2m3qkR/+N
         6ZwG/Ouy1KqKTHrB0z2lhhIiAGgTBBPtLKPTtt6Jm2AX4zEuAtg7OFNhdGGJoLnSaSg6
         BjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324855; x=1695929655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr/T9kX37mjruI2YODshHpmgcsopLzBXqNS+RBfjBUE=;
        b=vVzLZ0d7eyKDF/z3Unq3veNAQD0jGUNPDszt/SMoHktRjKX1XwlNHkBs3LMJbVcpDm
         aBj4PdH/ETVxcXyRY9qR9mgIGVbEq5+Dzfu3ERmVwCtd4Ipmq09266S08mW7sPEeNxMN
         etwwQs07GEfTmFtB6KlxS0hhVmpoWgUSoCUQcDj3kja2tbhkF1Q0DV8vUqrcDKV/6v97
         LdKpXDypOOihm100Ljxv8fp+Pm9C67/N4lfBOPBtCh834fDYItEDUKMLpKFGXtButqy/
         wUY3D0qRGEA7AtdEIHeq42RfQk/Od5v2mYRymtaQ2u0Lz2itPHTEA68BT20YjAjSikNc
         srTw==
X-Gm-Message-State: AOJu0Yzh2jxya10ujmRO5igWoPGJ0Q3uKT83InkmLMnES1Tebjp3cqvI
	0TxJnx7i+a5b6KufUC67vnaYg2dwCCvasAGGre+3CA==
X-Google-Smtp-Source: AGHT+IE3J0hPYG3mlCf0LBXPDD4F3dt6Xy+7aUsS0fZmwILVCrE54YYcSKTbvRwSwG6maa7zoRunYA==
X-Received: by 2002:a05:6a20:914e:b0:14b:e604:9f0a with SMTP id x14-20020a056a20914e00b0014be6049f0amr5003289pzc.20.1695267460994;
        Wed, 20 Sep 2023 20:37:40 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id jc10-20020a17090325ca00b001b9be3b94d3sm251294plb.140.2023.09.20.20.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:37:40 -0700 (PDT)
Date: Wed, 20 Sep 2023 20:37:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kees Cook <keescook@chromium.org>
Cc: Mirko Lindner <mlindner@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sky2: Make sure there is at least one frag_addr
 available
Message-ID: <20230920203738.7e2c58c6@hermes.local>
In-Reply-To: <20230920202509.never.299-kees@kernel.org>
References: <20230920202509.never.299-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 20 Sep 2023 13:25:13 -0700
Kees Cook <keescook@chromium.org> wrote:

> In the likely pathological case of building sky2 with 16k PAGE_SIZE,
> make sure there is at least 1 frag_addr in struct rx_ring_info:
> 
>    In file included from include/linux/skbuff.h:28,
>                     from include/net/net_namespace.h:43,
>                     from include/linux/netdevice.h:38,
>                     from drivers/net/ethernet/marvell/sky2.c:18:
>    drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_unmap_skb':
>    include/linux/dma-mapping.h:416:36: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
>      416 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
>          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/ethernet/marvell/sky2.c:1257:17: note: in expansion of macro 'dma_unmap_page'
>     1257 |                 dma_unmap_page(&pdev->dev, re->frag_addr[i],
>          |                 ^~~~~~~~~~~~~~
>    In file included from drivers/net/ethernet/marvell/sky2.c:41:
>    drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
>     2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
>          |                         ^~~~~~~~~
> 
> With CONFIG_PAGE_SIZE_16KB=y, PAGE_SHIFT == 14, so:
> 
>   #define ETH_JUMBO_MTU   9000
> 
> causes "ETH_JUMBO_MTU >> PAGE_SHIFT" to be 0. Use "?: 1" to solve this build warning.
> 
> Cc: Mirko Lindner <mlindner@marvell.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309191958.UBw1cjXk-lkp@intel.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

With page size of 16K the frag_addr[] array would never be used, so the original
code was correct that size should be 0. But the compiler now gets upset with 0
size arrays thinking this is some flex array leftover? Or can't figure out that
in this case an rx skb with fragments would never be created.

The workaround is fine, but could you add an explanatory comment?

