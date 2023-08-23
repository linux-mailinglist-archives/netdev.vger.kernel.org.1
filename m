Return-Path: <netdev+bounces-30037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C86785B33
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F821C20C74
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C43CA40;
	Wed, 23 Aug 2023 14:54:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DECC8E3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:54:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E603DE78
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692802443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKCuiHdQBzYj0WQ4tg6o4MU6GBwpJn7fnEEut+9ftSM=;
	b=ffWexfYg5WC5F5dT4vO01ux1gIm4rJPRxQ9jRC3KQXIBDGGREv44DVAEldc8sQs+FKhfiU
	pfDEC/XDHgPL9s84Z4RGe7bXPliI19P+SBxKtq+lt6efLM0vOrmecCyUFxv0qucIKzr/0y
	ckEch8JIlP23XZh9NPQOSMrGK6J6OUY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-QJ6qGAZUPnKIyOcP9jCyBA-1; Wed, 23 Aug 2023 10:54:01 -0400
X-MC-Unique: QJ6qGAZUPnKIyOcP9jCyBA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-997c891a88dso409504766b.3
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802440; x=1693407240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKCuiHdQBzYj0WQ4tg6o4MU6GBwpJn7fnEEut+9ftSM=;
        b=AfTUfwQsF2wrcb5jApwnJ39frSQB/gzcUDCNJb7yofAw/EHTb0/3fwLKMOaRN9oZ0O
         C6qJ+8XwXGQmKYd4ivQRQ5THtGQAgyrYzEuoXoq34shlyzKTxlV7dIjOTPiRBQQKSPlD
         ZJgTBclqLKfk8urflGd2fLxMD2WXCgMefBwhDxfiBxLUSUhsseE4o/UyNYbInf8e355P
         QTPDvkEh4YeCTRaRRrT9oQfSrcjJAQfe0RT2F6MdTSZ0ltTUe3TNwgBBdW1UeqgyI+R4
         JtKGd9K+Cf3qwV9xwhDJzh8CJS2gSGILPhyP7cFPP/dUj+wbJQZqjf89gSHqNLY2gvJ0
         D0wQ==
X-Gm-Message-State: AOJu0YyAezYfaNW/PU4BLEijPkc5BMIHKNkEqB15f662JhAznmuYqCDn
	FA7FAMCsY7x6OKxoVm40KDgBaJ0hVi7ewjcbqO1qshXA7TTd03ICjihtr6gHY+DVQAlLBRnQnbg
	s1HH9YZot2xL49ErT
X-Received: by 2002:a17:907:2c57:b0:99d:bcc6:12f with SMTP id hf23-20020a1709072c5700b0099dbcc6012fmr9740529ejc.48.1692802440527;
        Wed, 23 Aug 2023 07:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNokp0gSGu5JRhO0cj+u0ZyE+cKg6d5VSQcUvnB6oR8p8taKAI3I5kSTZg/uWs47gqj2m97w==
X-Received: by 2002:a17:907:2c57:b0:99d:bcc6:12f with SMTP id hf23-20020a1709072c5700b0099dbcc6012fmr9740517ejc.48.1692802440280;
        Wed, 23 Aug 2023 07:54:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906084300b0099cb0a7098dsm10005473ejd.19.2023.08.23.07.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:53:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 64B32D3CED2; Wed, 23 Aug 2023 16:53:57 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 6/6] samples/bpf: Cleanup .gitignore
Date: Wed, 23 Aug 2023 16:53:42 +0200
Message-ID: <20230823145346.1462819-7-toke@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823145346.1462819-1-toke@redhat.com>
References: <20230823145346.1462819-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove no longer present XDP utilities from .gitignore. Apart from the
recently removed XDP utilities this also includes the previously removed
xdpsock and xsk utilities.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/.gitignore | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index 0e7bfdbff80a..0002cd359fb1 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -37,22 +37,10 @@ tracex4
 tracex5
 tracex6
 tracex7
-xdp1
-xdp2
 xdp_adjust_tail
 xdp_fwd
-xdp_monitor
-xdp_redirect
-xdp_redirect_cpu
-xdp_redirect_map
-xdp_redirect_map_multi
 xdp_router_ipv4
-xdp_rxq_info
-xdp_sample_pkts
 xdp_tx_iptunnel
-xdpsock
-xdpsock_ctrl_proc
-xsk_fwd
 testfile.img
 hbm_out.log
 iperf.*
-- 
2.41.0


