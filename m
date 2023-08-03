Return-Path: <netdev+bounces-24186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500CD76F1D4
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB87A2822E6
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130DE25913;
	Thu,  3 Aug 2023 18:27:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376A24198
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 18:27:02 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB1110
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:27:00 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40ddc558306so9504831cf.2
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691087219; x=1691692019;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kaqrtAo9BWFvY2Y4BDvIC05wo3mNKGFTiPpj7X/mn8=;
        b=sNXhkLyXSg/30aLT7XyXE4bn77fc1RZqg3imuId8x3k0N4u0/u4gfsFpYJzz8+VWOU
         1ZOchC+1NMeAO2q6gwcLwBIuZhg8Vi8GjZCH37O1Wj5qiezm5Vr4T95YwRfCZIRSwu7L
         C0sPrUpaz0xsV9Day+xwUwaDGNYO6IG29twq8jigJkr4Rf+CzNWs0x2qFWf0qSLICHuS
         GwUMLsIFEkYa0g3dM3uDu902D+6F2wNmA3YIenxs2TnjKIlbF8Qd7YQo7vzJkJsoaL3M
         fEQKBC69AOp5YE/mD9OkV+KStPLWH8Dc0XIoad3xPoXC9TuhVQAaJKzk1tAzcwS7srWx
         IUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691087219; x=1691692019;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7kaqrtAo9BWFvY2Y4BDvIC05wo3mNKGFTiPpj7X/mn8=;
        b=CBR66JZd9FgyH1OmBV8EsrY3pv282ClwwqAK26BWB866c/l07/7oOpayY24vSI7fBQ
         Ij5OpKYV8cKHpFHd4L3ppd9mWjzKPKIt6WK0xiN+mBwVzRY9RSft7d37n9An9UZewjRU
         OhDMVt0ttUXLf+sjWWlSVIOMsGQiLd6scqw5WcGWMiECXJ5HmK8D5YFMtTfZicyATpS4
         742ht/vlXW89GvRUOm5982s0Tk/Styu74nT60jJ9VtcV0i3l9zNJ/Tx/aY7HhkFiQtGu
         cmhR01PMLT2JFpe94EVX1xwres87M4aOh8AFu40QRh445JNg+R9yiVsn6TYM5dczrov+
         J3hA==
X-Gm-Message-State: AOJu0YxXa3VZsFc1e8Jrnk/6msava6Qs49JL9BpwNEoKeMi7jySe7i4/
	QS0hAkw4HhTfDhAWifE6q+Y=
X-Google-Smtp-Source: AGHT+IGWpzAtiLpIqiIecMRM36IVwCE9fqA4YQ6xFv+5z8VfVXKRuKzy+R3Hxt70i55ISfmYQM+7GA==
X-Received: by 2002:a05:622a:170c:b0:40f:e8af:80a6 with SMTP id h12-20020a05622a170c00b0040fe8af80a6mr3978754qtk.40.1691087219244;
        Thu, 03 Aug 2023 11:26:59 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id ou21-20020a05620a621500b007671678e325sm90358qkn.88.2023.08.03.11.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:26:58 -0700 (PDT)
Date: Thu, 03 Aug 2023 14:26:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot <syzkaller@googlegroups.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <64cbf1725afac_3445be29429@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230803145600.2937518-1-edumazet@google.com>
References: <20230803145600.2937518-1-edumazet@google.com>
Subject: RE: [PATCH net] net/packet: annotate data-races around tp->status
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet wrote:
> Another syzbot report [1] is about tp->status lockless reads
> from __packet_get_status()
> 
> [1]
> BUG: KCSAN: data-race in __packet_rcv_has_room / __packet_set_status
> 
> write to 0xffff888117d7c080 of 8 bytes by interrupt on cpu 0:
> __packet_set_status+0x78/0xa0 net/packet/af_packet.c:407
> tpacket_rcv+0x18bb/0x1a60 net/packet/af_packet.c:2483
> deliver_skb net/core/dev.c:2173 [inline]
> __netif_receive_skb_core+0x408/0x1e80 net/core/dev.c:5337
> __netif_receive_skb_one_core net/core/dev.c:5491 [inline]
> __netif_receive_skb+0x57/0x1b0 net/core/dev.c:5607
> process_backlog+0x21f/0x380 net/core/dev.c:5935
> __napi_poll+0x60/0x3b0 net/core/dev.c:6498
> napi_poll net/core/dev.c:6565 [inline]
> net_rx_action+0x32b/0x750 net/core/dev.c:6698
> __do_softirq+0xc1/0x265 kernel/softirq.c:571
> invoke_softirq kernel/softirq.c:445 [inline]
> __irq_exit_rcu+0x57/0xa0 kernel/softirq.c:650
> sysvec_apic_timer_interrupt+0x6d/0x80 arch/x86/kernel/apic/apic.c:1106
> asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
> smpboot_thread_fn+0x33c/0x4a0 kernel/smpboot.c:112
> kthread+0x1d7/0x210 kernel/kthread.c:379
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> 
> read to 0xffff888117d7c080 of 8 bytes by interrupt on cpu 1:
> __packet_get_status net/packet/af_packet.c:436 [inline]
> packet_lookup_frame net/packet/af_packet.c:524 [inline]
> __tpacket_has_room net/packet/af_packet.c:1255 [inline]
> __packet_rcv_has_room+0x3f9/0x450 net/packet/af_packet.c:1298
> tpacket_rcv+0x275/0x1a60 net/packet/af_packet.c:2285
> deliver_skb net/core/dev.c:2173 [inline]
> dev_queue_xmit_nit+0x38a/0x5e0 net/core/dev.c:2243
> xmit_one net/core/dev.c:3574 [inline]
> dev_hard_start_xmit+0xcf/0x3f0 net/core/dev.c:3594
> __dev_queue_xmit+0xefb/0x1d10 net/core/dev.c:4244
> dev_queue_xmit include/linux/netdevice.h:3088 [inline]
> can_send+0x4eb/0x5d0 net/can/af_can.c:276
> bcm_can_tx+0x314/0x410 net/can/bcm.c:302
> bcm_tx_timeout_handler+0xdb/0x260
> __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
> __hrtimer_run_queues+0x217/0x700 kernel/time/hrtimer.c:1749
> hrtimer_run_softirq+0xd6/0x120 kernel/time/hrtimer.c:1766
> __do_softirq+0xc1/0x265 kernel/softirq.c:571
> run_ksoftirqd+0x17/0x20 kernel/softirq.c:939
> smpboot_thread_fn+0x30a/0x4a0 kernel/smpboot.c:164
> kthread+0x1d7/0x210 kernel/kthread.c:379
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> 
> value changed: 0x0000000000000000 -> 0x0000000020000081
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 19 Comm: ksoftirqd/1 Not tainted 6.4.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> 
> Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

