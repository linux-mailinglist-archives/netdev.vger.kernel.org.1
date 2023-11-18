Return-Path: <netdev+bounces-48878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DABE57EFE2F
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 07:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851971F23348
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 06:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A563CB;
	Sat, 18 Nov 2023 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/SGTLgL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8980E6
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 22:58:14 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso2538167b3a.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 22:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700290694; x=1700895494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S4So+f19Iw9wK9Z0NOg4xqdd1JDG75Z0QdBaz25kwqg=;
        b=R/SGTLgLub+5U1NrXdh5djKewA2YSfPLgUzfAJkqgFAekLp/wpn423+OPGZa2Oqjb0
         dZwGFM64uJ+ur2dC2ycMkTFoZ5Wkpo6xWa5+yRiGIfAIuSSwL5iY2LK42DXdw5pNazw8
         fg+ZPhrYv2EzCpIT4zmCFhFzoyxthUkGzJJkrqRFUyP9a8OsUdih9v4Tzewa8o+GzTKQ
         9k2LXwwYL7HVsYiYotMSbZ1sI8bOuBI9zdb9xybmpIAY5C45soM9XBdOATb54ypLeAfi
         9v6Pr0404UP2b6vphS++upb34jZgRwkPkRtxGvrUkyVqF1dYHCAoWFKkXO7EU6+PVaI3
         nVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700290694; x=1700895494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4So+f19Iw9wK9Z0NOg4xqdd1JDG75Z0QdBaz25kwqg=;
        b=cNRwMJlpcGaHDgnIp85Pqsei6YQnGq+UbBJ7xMbz++ahiASg/scuNCajibbw4SodWW
         h28cCOyjx1iZaT5LVWn773RkwHkv0hbFVXsJ4GU10qmMPL1dfCswoAiFyBUp7330sGk/
         HC9BWikEizq0y6TSgBO7uUE5rjOyrb9dVNK0sDoKVh3LLK6zmvldVPcpyHY9fU3ay5zl
         /axuGaZrjvPVHPwOINSA3v1cTT6TdxyXwp8Nz7gv1+hvr5sOl5teLzLux4MWK3YksvVP
         Vk7yw/9QcPIUopVXodxTGJQ4hamiIUngASvt6J2C4rOaeD4N+E7CPB3XF1JR+2SAB3sk
         TaIw==
X-Gm-Message-State: AOJu0Yz9vU8V0wKSqpFei7hRtgdbiLpCsWyJ6njDzORp02g00Pq6IbGs
	XLMK2kuXB4xSrcnlrFN4iBY=
X-Google-Smtp-Source: AGHT+IEj1kGsLQ9DOvAx+VA4nwX1ijmHK0/Z9ZOECzWQyxZdyk2ihYBTkuW4vgk/Sif9RlKyFEYrLQ==
X-Received: by 2002:a17:902:904a:b0:1cc:1ee2:d41d with SMTP id w10-20020a170902904a00b001cc1ee2d41dmr1461936plz.39.1700290694167;
        Fri, 17 Nov 2023 22:58:14 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902900200b001cc3c521affsm2364045plp.300.2023.11.17.22.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 22:58:13 -0800 (PST)
Date: Sat, 18 Nov 2023 14:58:03 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v2 net] wireguard: use DEV_STATS_INC()
Message-ID: <ZVhge4HBkuqRKo+Z@Laptop-X1>
References: <20231117141733.3344158-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117141733.3344158-1-edumazet@google.com>

On Fri, Nov 17, 2023 at 02:17:33PM +0000, Eric Dumazet wrote:
> wg_xmit() can be called concurrently, KCSAN reported [1]
> some device stats updates can be lost.
> 
> Use DEV_STATS_INC() for this unlikely case.
> 
> [1]
> BUG: KCSAN: data-race in wg_xmit / wg_xmit
> 
> read-write to 0xffff888104239160 of 8 bytes by task 1375 on cpu 0:
> wg_xmit+0x60f/0x680 drivers/net/wireguard/device.c:231
> __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
> netdev_start_xmit include/linux/netdevice.h:4932 [inline]
> xmit_one net/core/dev.c:3543 [inline]
> dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3559
> ...
> 
> read-write to 0xffff888104239160 of 8 bytes by task 1378 on cpu 1:
> wg_xmit+0x60f/0x680 drivers/net/wireguard/device.c:231
> __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
> netdev_start_xmit include/linux/netdevice.h:4932 [inline]
> xmit_one net/core/dev.c:3543 [inline]
> dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3559
> ...
> 
> v2: also change wg_packet_consume_data_done() (Hangbin Liu)
>     and wg_packet_purge_staged_packets()
> 
> Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> ---

I respect Jason's comments.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

