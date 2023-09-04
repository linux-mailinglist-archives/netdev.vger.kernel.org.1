Return-Path: <netdev+bounces-31988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B490791FAD
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 01:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE1C1C208CB
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 23:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C58ECA5E;
	Mon,  4 Sep 2023 23:49:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0333212
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 23:49:31 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECCCCC4
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 16:49:29 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a7f4f7a8easo849972b6e.2
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 16:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693871368; x=1694476168; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=abHLT3d1RGEEopUvtvKDJ6jwaSIlNgPS7xX/aiEkia4=;
        b=cfMISGZlTRtWrpxqCx5/AU7QJIphv+l3jKpryEDo1pMchXjtn15ty8Lsp7RxHYKx58
         e4C9iktAy9uROolD6ewsZHGLohlReunPKvgp8luWpe93aBljzTKTJTYFzDhpP0QtYrS0
         7nnqZ/AuuWzzRG8Da0UlJGdTqg4Nhc3cG56jlvuPXP1CNnmdzJW5MAlqV7+iVnwoblUl
         8ZS5MBT/ej/r5rBIUY4ChgeuIMZ8TSroAtwxiofs6cxx/8BKgNOE44IJHVy2R583O2HA
         2szQ8DdcfXiYfAhVPHoRauhn1hJ9QyPl04i4KiaMB2XJ0QT8hAfWcOZU+FotKO0tFApm
         G+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693871368; x=1694476168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abHLT3d1RGEEopUvtvKDJ6jwaSIlNgPS7xX/aiEkia4=;
        b=btlX6APDmtqC+AiKDM1twE4ITjirx/bcS4QuISCokW2RkC/hCxLbLUdXtffG2SUh1a
         eYlQRXRRRaTg5/3WTXMc6NTbf4V1ioMm7O685nBxmZJYoyl2qEHG1BZV5tP9dr8ExOZC
         XYqLA8Of1OfMkK8uWWTeFZcA4WP/q+ccgtC8QKVJAqyQmk34uDGktvhp05HOtnDX5Bk9
         WALSIFHfGXDFFVrd4OKvtGPG3+SXClPekug0bFuiJsEZDlBUsRaugNeRhuvmlWIhmDSo
         CqkCL0t9uhrwNEc+k6zfVyk4GyBwLPnI72OIYw93GDzwVkfGDPFXRjWHUFUyKwcNVQGo
         u16Q==
X-Gm-Message-State: AOJu0Yz/Il7tbFnrxakaX+CpS+4Yx33qmygedN6D/0PeanrIMfPKJtrp
	qiBTXuYj2FaWEgv9lpumTuc=
X-Google-Smtp-Source: AGHT+IGyhsXo6CgoIDwFcf9o+V2IGrm2rSTt1UjN4PlmEeZ04huZzydIdC8fQB4w2cdsuwl8ZdFByg==
X-Received: by 2002:a54:4714:0:b0:3a7:8e2a:6173 with SMTP id k20-20020a544714000000b003a78e2a6173mr11649145oik.2.1693871368527;
        Mon, 04 Sep 2023 16:49:28 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id bg26-20020a056a02011a00b0055c178a8df1sm7207556pgb.94.2023.09.04.16.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 16:49:28 -0700 (PDT)
Date: Mon, 4 Sep 2023 16:49:25 -0700
From: Kyle Zeng <zengyhkyle@gmail.com>
To: David Laight <David.Laight@aculab.com>
Cc: 'Eric Dumazet' <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
	syzbot <syzkaller@googlegroups.com>,
	Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH net] net: deal with integer overflows in kmalloc_reserve()
Message-ID: <ZPZtBWm06f321Tp/@westworld>
References: <20230831183750.2952307-1-edumazet@google.com>
 <d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com>
 <CANn89iJY4=Q0edL-mf2JrRiz8Ld7bQcogOrc4ozLEVD8qz8o2A@mail.gmail.com>
 <837a03d12d8345bfa7e9874c1e7d9156@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="irr8lLNCOaxgr3yC"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <837a03d12d8345bfa7e9874c1e7d9156@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--irr8lLNCOaxgr3yC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Sep 04, 2023 at 09:27:28AM +0000, David Laight wrote:
> From: Eric Dumazet <edumazet@google.com>
> > Sent: 04 September 2023 10:06
> > To: David Laight <David.Laight@ACULAB.COM>
> > Cc: David S . Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; netdev@vger.kernel.org; eric.dumazet@gmail.com; syzbot
> > <syzkaller@googlegroups.com>; Kyle Zeng <zengyhkyle@gmail.com>; Kees Cook <keescook@chromium.org>;
> > Vlastimil Babka <vbabka@suse.cz>
> > Subject: Re: [PATCH net] net: deal with integer overflows in kmalloc_reserve()
> > 
> > On Mon, Sep 4, 2023 at 10:41 AM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: Eric Dumazet
> > > > Sent: 31 August 2023 19:38
> > > >
> > > > Blamed commit changed:
> > > >     ptr = kmalloc(size);
> > > >     if (ptr)
> > > >       size = ksize(ptr);
> > > >
> > > > to:
> > > >     size = kmalloc_size_roundup(size);
> > > >     ptr = kmalloc(size);
> > > >
> > > > This allowed various crash as reported by syzbot [1]
> > > > and Kyle Zeng.
> > > >
> > > > Problem is that if @size is bigger than 0x80000001,
> > > > kmalloc_size_roundup(size) returns 2^32.
> > > >
> > > > kmalloc_reserve() uses a 32bit variable (obj_size),
> > > > so 2^32 is truncated to 0.
> > >
> > > Can this happen on 32bit arch?
> > > In that case kmalloc_size_roundup() will return 0.
> > 
> > Maybe, but this would be a bug in kmalloc_size_roundup()
> 
> That contains:
> 	/* Short-circuit saturated "too-large" case. */
> 	if (unlikely(size == SIZE_MAX))
> 		return SIZE_MAX;
> 
> It can also return 0 on failure, I can't remember if kmalloc(0)
> is guaranteed to be NULL (malloc(0) can do 'other things').
> 
> Which is entirely hopeless since MAX_SIZE is (size_t)-1.
> 
> IIRC kmalloc() has a size limit (max 'order' of pages) so
> kmalloc_size_roundup() ought check for that (or its max value).
> 
> The final:
> 	/* The flags don't matter since size_index is common to all. */
> 	c = kmalloc_slab(size, GFP_KERNEL);
> 	return c ? c->object_size : 0;
> probably ought to return size if c is even NULL.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

> It can also return 0 on failure, I can't remember if kmalloc(0)
> is guaranteed to be NULL (malloc(0) can do 'other things').
kmalloc(0) returns ZERO_SIZE_PTR (16).

My proposed patch is to check the return value of kmalloc, making sure it is neither NULL or ZERO_SIZE_PTR. The patch is attached. It should work for both 32bit and 64bit systems.

--irr8lLNCOaxgr3yC
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-properly-check-for-integer-overflow-in-__alloc_skb.patch"

From 034ac600c639bfa93c54e317ea3712538c749de6 Mon Sep 17 00:00:00 2001
From: Kyle Zeng <zengyhkyle@gmail.com>
Date: Mon, 28 Aug 2023 17:53:40 -0700
Subject: [PATCH] properly check for integer overflow in __alloc_skb

kmalloc_reserve may return ZERO_SIZE_PTR(0x10) when integer overflow
happens since size is controlled by users.
Make sure we handle this case properly.

Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a298992060e..f219fef5a16 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -642,7 +642,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 * Both skb->head and skb_shared_info are cache line aligned.
 	 */
 	data = kmalloc_reserve(&size, gfp_mask, node, &pfmemalloc);
-	if (unlikely(!data))
+	if (unlikely(ZERO_OR_NULL_PTR(data)))
 		goto nodata;
 	/* kmalloc_size_roundup() might give us more room than requested.
 	 * Put skb_shared_info exactly at the end of allocated zone,
-- 
2.34.1


--irr8lLNCOaxgr3yC--

