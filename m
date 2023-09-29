Return-Path: <netdev+bounces-36982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51F57B2CD9
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 09:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D80C11C20B07
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 07:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32289C148;
	Fri, 29 Sep 2023 07:07:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642BC131
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:07:03 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B871A7
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:07:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c3bd829b86so112313495ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695971221; x=1696576021; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qPnruVOPtCURvIrKVgV1Gzpi9qZsBOOnAtjdNN6W7U=;
        b=foNv2W8MBOqsX/gYUQ41DRPbIyhHinyjxnTg5lMGJMRtJPZknx7GaM+d6k0JVZR+Id
         Pxl75y4ZwfCNp4te06NQkge1h0r7TyQ6yhQT+CvMZqM4TbaPfgvOTBjQslhgcsKsxITF
         a/SPccvuWvhFQzx52dOKCTaYNnkk/zk+MblTi3cggxyHho6Yj7S8PECLBrVM6b/p40f1
         YeE1PiUNUQTcx9N+3Q7NpPhi+C7Fiyup00u6Sc9kwD5dhECFX8C5ggu3/CrrWzo2Pu4n
         TFDn+QFN9lRP5u155ES3Iu8ErY/q8xDazJZATBLhHfoBwPsHpXJJC5jtkcESWl5DTiSp
         Janw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695971221; x=1696576021;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3qPnruVOPtCURvIrKVgV1Gzpi9qZsBOOnAtjdNN6W7U=;
        b=gCJXQ3udC4cUPFpg3LnAUtAvL5jhEQQLqnZkWnHXGSbFfBmJpQo2oBvO1jbPlyUs9m
         VTqaoPzFJmmJy+kGOld4+TGe5iLj8PKQNn1FGW/ql3dm3IyO66Kqz1sR9rNxtORrdFN6
         l1zX4M84AFRqBh81uyG/3NzqP85wE9nfMB8d19WWDKfyKmL8pKA2SzWIjQXpRGFJ/rDS
         1tnJmmAbcz98Ql2dLIOkX/lYEVIZQHLYF1LzE6GAm9PBOw78u+3ekNo5Zz4iBSZ49ctO
         cZOwJ4wbeSmqVUbqPNQUYy3HR2xtYvOzDx38vjJwhgnHuAqSDuSsrz5WXBpYi+O9IvJD
         j65A==
X-Gm-Message-State: AOJu0YxqLmoLRt+C/Jdeof/Jf4nkc+l52EwxvCubluqlEQUNSXwfXcdL
	5XQHWtAUiVomTAzfiLlfpY4=
X-Google-Smtp-Source: AGHT+IHQPJ7Vv4zgtrz0Z2FmrQUAlxeRl+P+3OrVG437HodLr+8+XPCSZrClqAqrA8smUNC+YR4Lvw==
X-Received: by 2002:a17:902:c94d:b0:1c7:4a8a:32d1 with SMTP id i13-20020a170902c94d00b001c74a8a32d1mr266165pla.28.1695971221085;
        Fri, 29 Sep 2023 00:07:01 -0700 (PDT)
Received: from localhost (58-6-231-19.tpgi.com.au. [58.6.231.19])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902eb5100b001c611e9a5fdsm10247571pli.306.2023.09.29.00.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 00:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Sep 2023 17:06:53 +1000
Message-Id: <CVV7MBT9C7JY.5PYBOXU9NUDR@wheely>
Cc: <dev@openvswitch.org>
Subject: Re: [ovs-dev] [RFC PATCH 0/7] net: openvswitch: Reduce stack usage
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Ilya Maximets" <i.maximets@ovn.org>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20230927001308.749910-1-npiggin@gmail.com>
 <a018e82f-5cce-fb81-b52c-901e106c16eb@ovn.org>
In-Reply-To: <a018e82f-5cce-fb81-b52c-901e106c16eb@ovn.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed Sep 27, 2023 at 6:36 PM AEST, Ilya Maximets wrote:
> On 9/27/23 02:13, Nicholas Piggin wrote:
> > Hi,
> >=20
> > We've got a report of a stack overflow on ppc64le with a 16kB kernel
> > stack. Openvswitch is just one of many things in the stack, but it
> > does cause recursion and contributes to some usage.
> >=20
> > Here are a few patches for reducing stack overhead. I don't know the
> > code well so consider them just ideas. GFP_ATOMIC allocations
> > introduced in a couple of places might be controversial, but there
> > is still some savings to be had if you skip those.
> >=20
> > Here is one place detected where the stack reaches >14kB before
> > overflowing a little later. I massaged the output so it just shows
> > the stack frame address on the left.
>
> Hi, Nicholas.  Thanks for the patches!
>
> Though it looks like OVS is not really playing a huge role in the
> stack trace below.  How much of the stack does the patch set save
> in total?  How much patches 2-7 contribute (I posted a patch similar
> to the first one last week, so we may not count it)?

Stack usage was tested for the same path (this is backported to
RHEL9 kernel), and saving was 2080 bytes for that. It's enough
to get us out of trouble. But if it was a config that caused more
recursions then it might still be a problem.

>
> Also, most of the changes introduced here has a real chance to
> noticeably impact performance.  Did you run any performance tests
> with this to assess the impact?

Some numbers were posted by Aaron as you would see. 2-4% for that
patch, but I suspect the rest should have much smaller impact.

Maybe patch 2 if you were doing a lot of push_nsh operations, but
that might be less important since it's out of the recursive path.

>
> One last thing is that at least some of the patches seem to change
> non-inlined non-recursive functions.  Seems unnecessary.
>
> Best regards, Ilya Maximets.
>

One thing I do notice in the trace:

> >=20
> > [c00000037d480b40] __kmalloc+0x8c/0x5e0
> > [c00000037d480bc0] virtqueue_add_outbuf+0x354/0xac0
> > [c00000037d480cc0] xmit_skb+0x1dc/0x350 [virtio_net]
> > [c00000037d480d50] start_xmit+0xd4/0x3b0 [virtio_net]
> > [c00000037d480e00] dev_hard_start_xmit+0x11c/0x280
> > [c00000037d480e80] sch_direct_xmit+0xec/0x330
> > [c00000037d480f20] __dev_xmit_skb+0x41c/0xa80
> > [c00000037d480f90] __dev_queue_xmit+0x414/0x950
> > [c00000037d481070] ovs_vport_send+0xb4/0x210 [openvswitch]
> > [c00000037d4810f0] do_output+0x7c/0x200 [openvswitch]
> > [c00000037d481140] do_execute_actions+0xe48/0xeb0 [openvswitch]
> > [c00000037d481300] ovs_execute_actions+0x78/0x1f0 [openvswitch]
> > [c00000037d481380] ovs_dp_process_packet+0xb4/0x2e0 [openvswitch]
> > [c00000037d481450] ovs_vport_receive+0x8c/0x130 [openvswitch]
> > [c00000037d481660] internal_dev_xmit+0x40/0xd0 [openvswitch]
> > [c00000037d481690] dev_hard_start_xmit+0x11c/0x280
> > [c00000037d481710] __dev_queue_xmit+0x634/0x950
> > [c00000037d4817f0] neigh_hh_output+0xd0/0x180
> > [c00000037d481840] ip_finish_output2+0x31c/0x5c0
> > [c00000037d4818e0] ip_local_out+0x64/0x90
> > [c00000037d481920] iptunnel_xmit+0x194/0x290
> > [c00000037d4819c0] udp_tunnel_xmit_skb+0x100/0x140 [udp_tunnel]
> > [c00000037d481a80] geneve_xmit_skb+0x34c/0x610 [geneve]
> > [c00000037d481bb0] geneve_xmit+0x94/0x1e8 [geneve]
> > [c00000037d481c30] dev_hard_start_xmit+0x11c/0x280
> > [c00000037d481cb0] __dev_queue_xmit+0x634/0x950
> > [c00000037d481d90] ovs_vport_send+0xb4/0x210 [openvswitch]
> > [c00000037d481e10] do_output+0x7c/0x200 [openvswitch]
> > [c00000037d481e60] do_execute_actions+0xe48/0xeb0 [openvswitch]
> > [c00000037d482020] ovs_execute_actions+0x78/0x1f0 [openvswitch]
> > [c00000037d4820a0] ovs_dp_process_packet+0xb4/0x2e0 [openvswitch]
> > [c00000037d482170] clone_execute+0x2c8/0x370 [openvswitch]

                       ^^^^^

clone_execute is an action which can be deferred AFAIKS, but it is
not deferred until several recursions deep.

If we deferred always when possible, then might avoid such a big
stack (at least for this config). Is it very costly to defer? Would
it help here, or is it just going to process it right away and
cause basically the same call chain?

Thanks,
Nick

