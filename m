Return-Path: <netdev+bounces-34053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E37A1E38
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D05D2822FE
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FBA10780;
	Fri, 15 Sep 2023 12:15:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CAC101F5
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:15:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 335AB1FFA
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694780099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ACgwXt5WGrX2j4PYTtUkL9OiFfodaBbXHcP278ZXTG8=;
	b=SlUSTXxQG1bJORk4zKqhla+ANGBFJlt3STXme7m+xNBj5uqtVohahoxtI39QTO7u4nf5fA
	TSIns3a00/e9o+/GG1HSJFN/oO4GtTcjim+QUTVY98Y6CvqASN8/xagxR3NqbkW9+EL2xA
	NRr2RuDwqEKQyLZLg4xOMvAfqkzrmcw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-Gdra5J81N1O0VdJGGgkLvg-1; Fri, 15 Sep 2023 08:14:58 -0400
X-MC-Unique: Gdra5J81N1O0VdJGGgkLvg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401db25510fso15588795e9.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780096; x=1695384896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACgwXt5WGrX2j4PYTtUkL9OiFfodaBbXHcP278ZXTG8=;
        b=NYegaJMZi93pywMWZMofNzSIQ9AfFD8w6HQzzt5/d/BQ61KH/X3IQ9qVCw4rT+LHcw
         8Yl8N2NR9vX7VyS8M8sAs5fZM7R+woYIkBXfOxzjV+FeFMHj77WTpDS6eLzbeUTb2QPT
         /mdVL+SDCN4KX8h1v5ihfO6OkclvtRtzAfLt4PoCjsGEOG3r63tFmxmmBwD5d4iMcn/x
         zU9DwJcj+i/iG9N1SXAyL53KltD+DnZ8BmS3avKvyoWstxIcpgDrzwnDiiyCB/FVTCjs
         3nDt+F9DGmPAE39BB7HXu1D9Zz+amnE7aoJh9M1vmi3mjiTgwyvyodC0gRL6wwDzlI3k
         OdCw==
X-Gm-Message-State: AOJu0YzdDdmRx/fvWiqT3zs/B0qIjjOxtfSOYyJL8/ds1kIYJnumNBA+
	IQqSsK/365T3qnWiDuBvsSMEzDDMEZDONEvvsKr0kvnoMyu5Lh/lSGClNtInlLfVlA5ePVavEZo
	bE1BCx1ITSgypFji1O7mAAg/qLEriRAiOaxCMwBKNqpXEm/OnyygbEh3jRMU728vdAaz9+GjJj1
	Wgm1I=
X-Received: by 2002:a1c:f204:0:b0:401:73b2:f04d with SMTP id s4-20020a1cf204000000b0040173b2f04dmr1397146wmc.14.1694780096531;
        Fri, 15 Sep 2023 05:14:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExJPtI+IYCLPfbbQVatowLO2RRsokfIvzSgGwESxjINV6nsoe3beRRdwbN8e/jUfKrdJ6G9Q==
X-Received: by 2002:a1c:f204:0:b0:401:73b2:f04d with SMTP id s4-20020a1cf204000000b0040173b2f04dmr1397124wmc.14.1694780096124;
        Fri, 15 Sep 2023 05:14:56 -0700 (PDT)
Received: from step1.lan ([46.222.72.72])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c11ce00b003fee8502999sm7333595wmi.18.2023.09.15.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:14:55 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	virtualization@lists.linux-foundation.org,
	oxffffaa@gmail.com,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net-next 0/5] vsock/test: add recv_buf()/send_buf() utility functions and some improvements
Date: Fri, 15 Sep 2023 14:14:47 +0200
Message-ID: <20230915121452.87192-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We recently found that some tests were failing [1].

The problem was that we were not waiting for all the bytes correctly,
so we had a partial read. I had initially suggested using MSG_WAITALL,
but this could have timeout problems.

Since we already had send_byte() and recv_byte() that handled the timeout,
but also the expected return value, I moved that code to two new functions
that we can now use to send/receive generic buffers.

The last commit is just an improvement to a test I found difficult to
understand while using the new functions.

@Arseniy a review and some testing are really appreciated :-)

[1] https://lore.kernel.org/netdev/63xflnwiohdfo6m3vnrrxgv2ulplencpwug5qqacugqh7xxpu3@tsczkuqgwurb/

Stefano Garzarella (5):
  vsock/test: add recv_buf() utility function
  vsock/test: use recv_buf() in vsock_test.c
  vsock/test: add send_buf() utility function
  vsock/test: use send_buf() in vsock_test.c
  vsock/test: track bytes in MSG_PEEK test for SOCK_SEQPACKET

 tools/testing/vsock/util.h       |   3 +
 tools/testing/vsock/util.c       | 124 ++++++++++++--------
 tools/testing/vsock/vsock_test.c | 187 ++++++-------------------------
 3 files changed, 117 insertions(+), 197 deletions(-)

-- 
2.41.0


