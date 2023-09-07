Return-Path: <netdev+bounces-32489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6952B797ED6
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 00:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8142D1C20B5C
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 22:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FFC14271;
	Thu,  7 Sep 2023 22:53:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E229A8
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 22:53:55 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED091BCD
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:53:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf5c314a57so11909965ad.1
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694127234; x=1694732034; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tw/rCGtK366XeodUhFoL+9MhzcffDRTkb0f987EC2rk=;
        b=H7Lm1N5Jq72wEyv0FCmZE5TmlOlZ9m2uBK5H7qST1dm44L1m6JFQQvCsx3FT8CdkTg
         nZ3XwupT+08wiypfyG33PYW/AjrZz9066idal8aj/qmgwuMrZmxPs0Zg0YS6v1sX8OHq
         xwiH2BTpoqhSmuQliSvuzpgRzcX/kgKFzbOAse3OKpXOO0nzGZJw6W3aTmKm/hW6x2C/
         hlaANUNfnwaHvymWLNGr5LhbmEXDWdMTJXdtp4C3XwLgQwErdVP03QoDYkjxAMAX4ju5
         bTTELw5hdFj4Gyf53i4DR0iemXtxNnJ2elwRsRkQOqbvmJTaXWvkws3QSrlMAPuBHsgg
         O7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127234; x=1694732034;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw/rCGtK366XeodUhFoL+9MhzcffDRTkb0f987EC2rk=;
        b=Ge5ii+Jx6Ut8gXnGIN0tWPgI2q96JulGg8WyzLd1ZEPcIfah6FGfrYFkZCU9Ihebde
         Vy6Id+bYFCl4dtAL1/LI8Ihn0PvC1maShtlydxXuaoCXUQV1estVsytlOAWr+4IAUtvt
         9TzINUPLxRXrOt3cdJXdZu/yOV7lbU5/zMm+5AvWxQ4BZgUfyyAnO2Ehhe3g7zkPDlTp
         pJRAq6grOD/cIbtwoGSbZuFMc5QabtUcGmgu9EILZWu08SSXPB1YZnmK3iGpzsRlsIKK
         KiLYtkINHSqy2bu2X78exEnX+JylfpMHKb2y/ZDbrNfqfQmpuguSYJGOG7s3QpAn50Uc
         1G/g==
X-Gm-Message-State: AOJu0YwvsEVV5qWRSGLzDe8vkVSvIYjTq5a9lQZLF4C3HVWSQy4ndios
	9M3gwEYQ91SutZl7iQczF4M=
X-Google-Smtp-Source: AGHT+IF8kYX75/ije8gHfr0McbME6t5bSBGTS1bvG1CxCF6OHZuW4cv111FXdOw/POpl5ZEJMXbUbg==
X-Received: by 2002:a17:902:d505:b0:1bd:f71c:3af3 with SMTP id b5-20020a170902d50500b001bdf71c3af3mr992446plg.32.1694127233674;
        Thu, 07 Sep 2023 15:53:53 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001bdb8c0b578sm248770plb.192.2023.09.07.15.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:53:52 -0700 (PDT)
Date: Thu, 7 Sep 2023 15:53:50 -0700
From: Kyle Zeng <zengyhkyle@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, dsahern@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, ssuryaextr@gmail.com
Subject: Re: [PATCH] don't assume the existence of skb->dev when trying to
 reset ip_options in ipv4_send_dest_unreach
Message-ID: <ZPpUfm/HhFet3ejH@westworld>
References: <ZPk41vtxHK/YnFUs@westworld>
 <ecde5e34c6f3a8182f588b3c1352bf78b69ff206.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TdKnvOL5LAdAXmmY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecde5e34c6f3a8182f588b3c1352bf78b69ff206.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--TdKnvOL5LAdAXmmY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Sep 07, 2023 at 01:03:52PM +0200, Paolo Abeni wrote:
> On Wed, 2023-09-06 at 19:43 -0700, Kyle Zeng wrote:
> > Currently, we assume the skb is associated with a device before calling __ip_options_compile, which is not always the case if it is re-routed by ipvs.
> > When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
> > Since we know that all the options will be set to IPOPT_END, which does
> > not depend on struct net, we pass NULL to it.
> 
> It's not clear to me why we can infer the above. Possibly would be more
> safe to skip entirely the __ip_options_compile() call?!?
> 
> Please at least clarify the changelog and trim it to 72 chars. 
> 
> Additionally trim the subj to the same len and include the target tree
> (net) into the subj prefix.
> 
> Thanks!
> 
> Paolo
> 

Hi Paolo,

> It's not clear to me why we can infer the above. Possibly would be more
> safe to skip entirely the __ip_options_compile() call?!?
Sorry, after you pointed it out, I realized that I misunderstood the
code. Initially I thought `memset(&opt, 0, sizeof(opt));` would reset all
the option to OPOPT_END. But after carefully reading the code, it seems
that it only resets the io_options struct and the `optptr` is still the
original one. 

Do you think it is better to do:
`struct net = skb->dev ? dev_net(skb->dev) : NULL` ?

> Please at least clarify the changelog and trim it to 72 chars. 
> 
> Additionally trim the subj to the same len and include the target tree
> (net) into the subj prefix.
Sorry for that. I'm new to the Linux kernel community and I wonder whether
I should initiate a different patch or send another patch in this thread
in this case.

Hi David,

> ipv4_send_dest_unreach is called from ipv4_link_failure which might have
> an rtable (dst_entry) which has a device which is in a net namespace.
> That is better than blindly ignoring the namepsace.
Following your suggestion, I drafted another patch which is attached to
this email. I verified that the crash does not happen anymore. Can you
please advise whether it is a correct patch?

Thanks,
Kyle Zeng

--TdKnvOL5LAdAXmmY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fix-null-deref-in-ipv4_link_failure.patch"

From ddf42a72bd2aabc7b66529ddadd90df420a73610 Mon Sep 17 00:00:00 2001
From: Kyle Zeng <zengyhkyle@gmail.com>
Date: Thu, 7 Sep 2023 15:49:46 -0700
Subject: [PATCH] fix null-deref in ipv4_link_failure

Currently, we assume the skb is associated with a device before calling
__ip_options_compile, which is not always the case if it is re-routed by
ipvs.
When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
This patch adds a check for the edge case and switch to use the net_device
from the rtable when skb->dev is NULL.

Suggested-by: Paolo Abeni<pabeni@redhat.com>
Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
---
 net/ipv4/route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d8c99bdc617..735a491e1ff 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1215,6 +1215,7 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
 	struct ip_options opt;
 	int res;
+	struct net_device *dev;
 
 	/* Recompile ip options since IPCB may not be valid anymore.
 	 * Also check we have a reasonable ipv4 header.
@@ -1230,7 +1231,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
-		res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+		dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
+		res = __ip_options_compile(dev_net(net), &opt, skb, NULL);
 		rcu_read_unlock();
 
 		if (res)
-- 
2.34.1


--TdKnvOL5LAdAXmmY--

