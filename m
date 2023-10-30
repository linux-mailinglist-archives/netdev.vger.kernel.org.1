Return-Path: <netdev+bounces-45252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA327DBB5E
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D60B20C99
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 14:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EDE17747;
	Mon, 30 Oct 2023 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCJ/8K37"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561E171B1
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 14:06:25 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64FFF3
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:06:22 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-586753b0ab0so2524080eaf.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698674782; x=1699279582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e2w5d9kbToxgMRyjeCJPzxYX2jE8jKaScUyx8puul1M=;
        b=qCJ/8K37mYjVvT8TsaJhWcdT1tY6A7fFqcJWi5ZGanfsMIz8+iaZoTMqm+2rCcdL1+
         ovSzWn86c0ky7m+LX1zXHv3d0111A3kR4aojJDEYYhFCTH/UjkF+5Y4UiQ0LYad4GQUd
         0Uzq5trMK9jwYuUSgw1HnBpK6Sc+X9Je1NV/FcPj10Ud2/XDENlTf/bcCGT+jja5SWqW
         qxBP0B0Y2ods5x8t718xaX0qhR1BtODw9hdhg9yNfZu6BFgnqsuaHJ9aseZO2DD/0TdC
         9mhOywolpEGrOnRK1+gh9FjK23C3H6u3+hoDwZmSnJtCsCksBTG3Tuw54wEuiidpbYeX
         E9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674782; x=1699279582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2w5d9kbToxgMRyjeCJPzxYX2jE8jKaScUyx8puul1M=;
        b=OAULmuCJLMH4eybj5xx2cPrUvLbrU11sykGL5tIAdYesXJIyuDqiTntEbJm63DmBTp
         YjLJh6F0gUb/Qk+tFCWo3yPPz5n1eep4rRMnMtaOttjg5Mrwp787zJG64zhwCvoh9Mmi
         B6iEEKnhJIqosHJ+IV4uF8L4NpjwyM8oiZ8OG8evW6J4wZtoz/E9/4vtpERv/11yFSnp
         w22OjRPIoVT97xstrgWiVSbaD1Z/cfedrDLZE+vrfG21v2PXPLUWy/pVC/LgteADrhS3
         PjjwhqMBdlqupnu/v0Uol1UVgRHo5otmtBWNZAlcLc6O+w07y91SrvnOQAhli4eaO2Mk
         GYvQ==
X-Gm-Message-State: AOJu0Yx4Yc5sktzsWgx+ZMqaUm/t5jj5filgQYx+Qq4nsJVdYiN2VeLJ
	1eg1Fldvwe9yHUVOTSQtYatCldxBucrnQ/Y/kL+X8A==
X-Google-Smtp-Source: AGHT+IHXSEQn4qfDlR9cSbQ17/K1Fwe/+muut2rJnvsppQ8DlhwUyAFZt1GMM8teJhkfwTGDlpp5WRpFDdlqpU050TQ=
X-Received: by 2002:a05:6358:6f82:b0:168:e177:b2bf with SMTP id
 s2-20020a0563586f8200b00168e177b2bfmr11045770rwn.5.1698674781829; Mon, 30 Oct
 2023 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr>
 <376db5ae-1bb0-4682-b132-b9852be3c7aa@gmail.com> <23428695-fcff-495b-ac43-07639b4f5d08@alu.unizg.hr>
 <30e15e9a-d82e-4d24-be37-1b9d1534c082@gmail.com> <9f99c3a4-2752-464b-b37d-58a4f8041804@alu.unizg.hr>
 <3df7447e-bfea-4996-897d-05e66c8a69b5@alu.unizg.hr>
In-Reply-To: <3df7447e-bfea-4996-897d-05e66c8a69b5@alu.unizg.hr>
From: Marco Elver <elver@google.com>
Date: Mon, 30 Oct 2023 15:05:42 +0100
Message-ID: <CANpmjNPKn6mDUfir9bLhHdoutLZ1kkNd2bhLBqXSTg-mcbNzxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] r8169: Coalesce RTL8411b PHY power-down recovery
 programming instructions to reduce spinlock stalls
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nic_swsd@realtek.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Oct 2023 at 14:53, Mirsad Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> On 10/30/23 14:30, Mirsad Todorovac wrote:
> >
> >
> > On 10/30/23 14:17, Heiner Kallweit wrote:
> >> On 29.10.2023 05:56, Mirsad Todorovac wrote:
> >>>
> >>>
> >>> On 10/28/23 21:21, Heiner Kallweit wrote:
> >>>> On 28.10.2023 13:05, Mirsad Goran Todorovac wrote:
> >>>>> On RTL8411b the RX unit gets confused if the PHY is powered-down.
> >>>>> This was reported in [0] and confirmed by Realtek. Realtek provided
> >>>>> a sequence to fix the RX unit after PHY wakeup.
> >>>>>
> >>>>> A series of about 130 r8168_mac_ocp_write() calls is performed to
> >>>>> program the RTL registers for recovery.
> >>>>>
> >>>>> r8168_mac_ocp_write() expands to this code:
> >>>>>
> >>>>>           static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
> >>>>>           {
> >>>>>                   if (rtl_ocp_reg_failure(reg))
> >>>>>                           return;
> >>>>>
> >>>>>                   RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
> >>>>>           }
> >>>>>
> >>>>>           static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
> >>>>>           {
> >>>>>                   unsigned long flags;
> >>>>>
> >>>>>                   raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
> >>>>>                   __r8168_mac_ocp_write(tp, reg, data);
> >>>>>                   raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
> >>>>>           }
> >>>>>
> >>>>> Register programming is done through RTL_W32() macro which expands into
> >>>>>
> >>>>>           #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
> >>>>>
> >>>>> which is further (on Alpha):
> >>>>>
> >>>>>           extern inline void writel(u32 b, volatile void __iomem *addr)
> >>>>>           {
> >>>>>                   mb();
> >>>>>                   __raw_writel(b, addr);
> >>>>>           }
> >>>>>
> >>>>> or on i386/x86_64:
> >>>>>
> >>>>>       #define build_mmio_write(name, size, type, reg, barrier) \
> >>>>>       static inline void name(type val, volatile void __iomem *addr) \
> >>>>>       { asm volatile("mov" size " %0,%1": :reg (val), \
> >>>>>       "m" (*(volatile type __force *)addr) barrier); }
> >>>>>
> >>>>>       build_mmio_write(writel, "l", unsigned int, "r", :"memory")
> >>>>>
> >>>>> This obviously involves iat least a compiler barrier.
> >>>>>
> >>>>> mb() expands into something like this i.e. on x86_64:
> >>>>>
> >>>>>           #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
> >>>>>
> >>>>> This means a whole lot of memory bus barriers: for spin_lock_irqsave(),
> >>>>> memory barrier, writel(), and spin_unlock_irqrestore().
> >>>>>
> >>>>> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
> >>>>> a LOCK storm that will thunder all of the cores and CPUs on the same memory controller
> >>>>> for certain time that locked memory read-modify-write cyclo or I/O takes to finish.
> >>>>>
> >>>>> In a sequential case of RTL register programming, the writes to RTL registers
> >>>>> can be coalesced under a same raw spinlock. This can dramatically decrease the
> >>>>> number of bus stalls in a multicore or multi-CPU system:
> >>>>>
> >>>>>           static void __r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
> >>>>>                                                 const struct recover_8411b_info *array)
> >>>>>           {
> >>>>>                   struct recover_8411b_info const *p = array;
> >>>>>
> >>>>>                   while (p->reg) {
> >>>>>                           if (!rtl_ocp_reg_failure(p->reg))
> >>>>>                                   RTL_W32(tp, OCPDR, OCPAR_FLAG | (p->reg << 15) | p->data);
> >>>>>                           p++;
> >>>>>                   }
> >>>>>           }
> >>>>>
> >>>>>           static void r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
> >>>>>                                               const struct recover_8411b_info *array)
> >>>>>           {
> >>>>>                   unsigned long flags;
> >>>>>
> >>>>>                   raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
> >>>>>                   __r8168_mac_ocp_write_seq(tp, array);
> >>>>>                   raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
> >>>>>           }
> >>>>>
> >>>>>           static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
> >>>>>           {
> >>>>>
> >>>>>                   ...
> >>>>>
> >>>>>                   /* The following Realtek-provided magic fixes an issue with the RX unit
> >>>>>                    * getting confused after the PHY having been powered-down.
> >>>>>                    */
> >>>>>
> >>>>>                   static const struct recover_8411b_info init_zero_seq[] = {
> >>>>>                           { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 }, { 0xFC2E, 0x0000 },
> >>>>>              ...
> >>>>>                   };
> >>>>>
> >>>>>                   static const struct recover_8411b_info recover_seq[] = {
> >>>>>                           { 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C }, { 0xF806, 0xE00E },
> >>>>>              ...
> >>>>>                   };
> >>>>>
> >>>>>                   static const struct recover_8411b_info final_seq[] = {
> >>>>>                           { 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 }, { 0xFC30, 0x02FD },
> >>>>>              ...
> >>>>>                   };
> >>>>>
> >>>>>                   r8168_mac_ocp_write_seq(tp, init_zero_seq);
> >>>>>                   mdelay(3);
> >>>>>                   r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
> >>>>>                   r8168_mac_ocp_write_seq(tp, recover_seq);
> >>>>>                   r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
> >>>>>                   r8168_mac_ocp_write_seq(tp, final_seq);
> >>>>>           }
> >>>>>
> >>>>> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
> >>>>> functions that only changed the function names and the ending of the line, so the actual
> >>>>> hex data is unchanged.
> >>>>>
> >>>>> Note that the original reason for the introduction of the commit fe4e8db0392a6
> >>>>> was to enable recovery of the RX unit on the RTL8411b which was confused by the
> >>>>> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
> >>>>
> >>>> I still have a problem with this statement as you're saying that the original
> >>>> problem still exists. I don't think that's the case.
> >>>
> >>> I will not disagree about it.
> >>>
> >>> But we have only reduced the number of spin_lock_irqsave/spin_unlock_irqrestore()
> >>> pairs.
> >>>
> >>> Maybe additionally, on the low level, memory barrier isn't required for each write to
> >>> MMIO?
> >>>
> >> One could argue whether in several places writel_relaxed() could be used.
> >> But it's not really worth it, because we're not in a hot path.
> >
> > I see. Thank you for your evaluation.
> >
> > Using writel_relaxed() sounds clever. It expands to:
> >
> >      #define build_mmio_write(name, size, type, reg, barrier) \
> >          static inline void name(type val, volatile void __iomem *addr) \
> >           { asm volatile("mov" size " %0,%1": :reg (val), \
> >                          "m" (*(volatile type __force *)addr) barrier); }
> >      build_mmio_write(__writel, "l", unsigned int, "r", )
> >      #define writel_relaxed(v, a) __writel(v, a)
> >
> > Here "barrier" is an empty string. Really clever. ;-)
> >
> > I will not contradict, but the cummulative amount of memory barriers on each MMIO read/write
> > in each single one of the drivers could amount to some degrading of overall performance and
> > latency in a multicore system.
> >
> > As I understood Mr. Jonathan Corbet on LWN, the initiative and trend is to reduce overall
> > kernel latency.
>
> P.S.
>
> On the second thought, if barrier() is only the compiler optimisation barrier from memory
> reordering, then we do not gain much disablin git as it doesn't affect the other cores, and
> reordering MMIO writes can really confuse some NIC hardware.
>
> /* Optimization barrier */
> #ifndef barrier
> /* The "volatile" is due to gcc bugs */
> # define barrier() __asm__ __volatile__("": : :"memory")
> #endif
>
> >>> If it still uses a LOCK addl $0, m32/m64, then it still creates 130 instances of all core
> >>> bus locks for this NIC reset after the lost PHY? I'm just thinking, this is nothing
> >>> authoritative ...

I would recommend looking at the pre-processed source code if you
can't manually untangle the maze of macros. ;-)

Look at the .${obj}.cmd file (e.g.
drivers/net/ethernet/realtek/.r8169_main.o.cmd), copy the compiler
command in it, and add the "-E" option and make the compiler write the
result to some temporary file you can inspect.

