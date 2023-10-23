Return-Path: <netdev+bounces-43633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D07D4073
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799071C2083F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D57922EE7;
	Mon, 23 Oct 2023 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ch3OLXwV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1721C28E
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:50:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF6F8F
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698090652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=BZb3Bi9C2CsxxaJsgQZxAvcW9+sG5uBGA13Qc4GB1N8=;
	b=ch3OLXwV7fLCurTLo0AbWZTXJcCVLgvOqoCkwjaOm7vjZse1XI0lLZRqS9CammVUjRNqpq
	Re/w/BZDf0rVgniCSN2nVEDjkBREgVgTlpg9xitbm8CyQiPbW0ZYBBzyVFV0NmzyyqZyQE
	C9VNiSlLNVt4wliLeff7PTCFazPKtHM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-2IydYbQEPG-SZNGBaugooQ-1; Mon, 23 Oct 2023 15:50:35 -0400
X-MC-Unique: 2IydYbQEPG-SZNGBaugooQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-778915a0c73so408953685a.1
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090635; x=1698695435;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZb3Bi9C2CsxxaJsgQZxAvcW9+sG5uBGA13Qc4GB1N8=;
        b=vFJMKQS8QbFBPldMNirm8qWutc4NHWEXdUPnKhf7InyL2tOfidYdS5PkMCCbQnKKN0
         vZ8GIU0ikAftYtLXcswmQUo5MVb1kB7MVrLWGWab2gdVxX2ot3eMQ9RWpUWLTW9LPMkg
         zvFNWyBZHRgBGiagiYHZXA6uh6uhqbSsJYQ3wFhqCPYVQd7EsQ0EzYjLsoH4IO8bmcmL
         +UZ/JboeGJIY6EIMLxzuiM2ZH+jrTQONJri5fsWO6mJ5SJP+8BwH7E5UUyjot8qadtPT
         5C1IJ31n1EKWmLI52DYgy6IjTd53m+JU9Vf14NQ+Xyq/rMz2mc914pyvj6hvS/sUhu/u
         YBSQ==
X-Gm-Message-State: AOJu0YyArUq03r0WmepoEcUHkHoZ9+iEoPLGSEUGc7Bjh3D2P3YMFVXV
	uGbtfGj6DCs1sCxzosvkr583iUitcP6fFvrGrkyEq+V65enkJmjHJ+kgetVwHXogSwoK6vfvHpd
	Kn9/Rech0uNB7odEo
X-Received: by 2002:a05:620a:3189:b0:778:8fa5:41b7 with SMTP id bi9-20020a05620a318900b007788fa541b7mr10578534qkb.53.1698090635271;
        Mon, 23 Oct 2023 12:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqdKoOkFy85HOQxGcepY4wCuviyrgecHE5HdSiaJC1NprkLTzZPHhjSkCaS/h73ih1dsisQg==
X-Received: by 2002:a05:620a:3189:b0:778:8fa5:41b7 with SMTP id bi9-20020a05620a318900b007788fa541b7mr10578524qkb.53.1698090635030;
        Mon, 23 Oct 2023 12:50:35 -0700 (PDT)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id s13-20020ae9f70d000000b007756c0853a5sm2921616qkg.58.2023.10.23.12.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:50:34 -0700 (PDT)
Date: Mon, 23 Oct 2023 15:50:33 -0400
From: Lucas Karpinski <lkarpins@redhat.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: give more time to udpgro nat tests
Message-ID: <t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzrzkwtj@toz6mr4ggnyp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20231006

In some conditions, background processes in udpgro don't have enough
time to set up the sockets. When foreground processes start, this
results in the bad GRO lookup test freezing or reporting that it
received 0 gro segments.

To fix this, increase the time given to background processes to complete
the startup before foreground processes start.

This is the same issue and the same fix as posted by Adrien Therry.
Link: https://lore.kernel.org/all/20221101184809.50013-1-athierry@redhat.com/

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
 tools/testing/selftests/net/udpgro.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 0c743752669a..4ccbcb2390ad 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -97,7 +97,8 @@ run_one_nat() {
 		echo "ok" || \
 		echo "failed"&
 
-	sleep 0.1
+	# Hack: let bg programs complete the startup
+	sleep 0.2
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	kill -INT $pid
-- 
2.41.0


