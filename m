Return-Path: <netdev+bounces-34086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEFB7A2075
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D45282BB8
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4BF11189;
	Fri, 15 Sep 2023 14:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE410A32
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:05:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30CFD2729
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694786721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PpSIIB1mvYApP01E3iIGKXxZD7tQZq1zZDR9KGP+8mk=;
	b=KQOAUlOQc1jVk81cuUo0LZNM7s9tl8eYJ314ZTGPy2qXhr/XmGGj5ulWI9QIZ4hDPYtV7W
	wJq2zP7CTTrOl1ydZ/OUB6+7w7YlpjG2eikpfdT7geBeNV8aM1Zwy8T/O+8Sp8TzSfN7P5
	ujInfPQoRNznVkQe19za1wLhnN68yLI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-YYINLg7aMqenwQiJZbbLcg-1; Fri, 15 Sep 2023 10:05:19 -0400
X-MC-Unique: YYINLg7aMqenwQiJZbbLcg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52fbe735dfcso1481970a12.3
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 07:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694786718; x=1695391518;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PpSIIB1mvYApP01E3iIGKXxZD7tQZq1zZDR9KGP+8mk=;
        b=xDrjsWVlAElwHdV4WkYxq1yQbM7JaitPVGfjeq5ocF4hXt7SI5lFQ3lEe6sWo1Iab2
         YD52dPWNREYhPbqYrk40yoJvrHWLJ64TbFvqzgRM1z4Q2V8CCXVwgmSFFB9lcvNs9xfj
         WH3/fW5CydjsSm5kCDhblkR3KLoVGe2rvVx3JghBMm3cmFq2O4O6CH7CR+UHe2hUgaJb
         5GEmCt1qcdR0MzN891GwOKQyptvv6Wk9Hb3iveMSnDd0Mn21dFcERddLsIOscBY4oRsK
         SPRgx7mhQkIkA1QlP+0DcsmWFqS/FhOQVwqSGSxKxGsScjImkzrGT0J9Tu+sit7AIcZ3
         1qkA==
X-Gm-Message-State: AOJu0YzbkBBiyeUl1z80dhK0aMJy816j+HvYNgqYWzPGmSl+voNDe1R5
	xi/gfAUAaEO2euv1uzfLn7dZO9Ds9DV3mbTmDzje+9AFevr5CNynmK7fGVHiL2iK1yWdyq7bIvZ
	0dIMtXPBcGFvNDeiF1u8t3pynT7aP8GT6Z+Corh+3vZ0=
X-Received: by 2002:aa7:c24b:0:b0:522:1956:a291 with SMTP id y11-20020aa7c24b000000b005221956a291mr1403996edo.8.1694786718304;
        Fri, 15 Sep 2023 07:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENaUrSukINVFutVEhyltutN+3v2vUw89AHoLMRzYm50JTRklRonP/SpNHk7yTb23Zx0F5XJdth9ljX9cbq0VM=
X-Received: by 2002:aa7:c24b:0:b0:522:1956:a291 with SMTP id
 y11-20020aa7c24b000000b005221956a291mr1403978edo.8.1694786718009; Fri, 15 Sep
 2023 07:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 15 Sep 2023 10:05:06 -0400
Message-ID: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
Subject: nft_rhash_walk, rhashtable and resize event
To: Network Development <netdev@vger.kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@netfilter.org, fw@strlen.de, 
	gfs2@lists.linux.dev, David Teigland <teigland@redhat.com>, tgraf@suug.ch, 
	herbert@gondor.apana.org.au
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I try to find some ways that fits my use case of iterating a
rhashtable. I found [0] but it somehow tries to skip objects again if
a rhashtable resize event occurs during a hash walk. It does that by
skipping the already iterated objects according to a counter that is
tracked, see [0]:

if (iter->count < iter->skip)

from my understanding.

My question is here? Is that allowed to do because a resize event may
change the order how to iterate over a rhashtable.

Thanks.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/netfilter/nft_set_hash.c?h=v6.6-rc1#n257


