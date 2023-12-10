Return-Path: <netdev+bounces-55636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BACC80BBE2
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 16:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F9F1C2088D
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 15:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3F156FC;
	Sun, 10 Dec 2023 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLn8Ed2d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC0EF0
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 07:16:31 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2866fe08b32so2589887a91.2
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 07:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702221391; x=1702826191; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bUOhGKebMTgquZ1Ef3JsJH3ulECY6eY7Ie5uuF7eE9I=;
        b=iLn8Ed2d174KimEYSlOZr+n5YtCIPNWtXs8a87hcAfGHWAjpfFEPwS7rIrdfARMSyR
         yRVRk1QAxVpW/W5hUI6r2DzLpDHD6exu/Ip3JwVLsA/+MQ1S+HmcuMfotnLbLMgGaO4Y
         m9A9QiZLNdd1lU22Juz4maLLNejb1k9fUOVfGP82PPoP88MicHDxO9zEs5nWsruTb5Ns
         HLyTqvbQYTBxjhpRGcruYqpFgq0Mbqr9g63Oi8MzllPAq23eVaJWAeLQEVd+EhrzbFkU
         0Z11NbbaeSYNX6JYEYXgOclm/1/plcddfWDpwsSAde3qF1Ah9v5Hg4USvkRg0iHVAm5W
         5pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702221391; x=1702826191;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUOhGKebMTgquZ1Ef3JsJH3ulECY6eY7Ie5uuF7eE9I=;
        b=IOB8YvXz1meTBFAuj15xGy2KapzShB8ifwYC8yWBa1EHDREhpdUgjA1skGIQvzVx3Y
         jJMnbocNQfLmjTSdkmjcDa/8sfCeKA1VjNtcvhtCnSKyTn54Ulr7MnkxpyCgWHhKtjTm
         ZQFv8FVbik/rekPUx9t6HZvgu9PE7svM6gJWr291UHsoJuf/jYdPiAjRXy00CWaiy6o+
         t1PIG7tDh5rxfz6/DwzaPVtr00VcEE6bjKIantTmcoMKky40heseMkbwpAGblYcplAxO
         Eb6i4tiqWR1H3qifZ58PKQAkAyVocGQcdTYj7UXoXN7EDqQ4ThQOnaCcV4o0ME7QVCjk
         diaw==
X-Gm-Message-State: AOJu0YwQsJeBuprkJecJGOAOZgmpZidsdRHZa2n671SeEogK/kk0ql4W
	S3Pj0ZN+hLdw04naTiS+gFCaIhlOq3bg2eSNfXC/ydJ743iZR9hO
X-Google-Smtp-Source: AGHT+IGJuyXqKj+B+WkRnixfOYD4kaH0JeM2vfiq69XGGLTOHD9BDRA4iDgNBpUUZth5PAt/TXl06wSZRsK+umLWnDY=
X-Received: by 2002:a17:90b:68a:b0:288:9756:5da9 with SMTP id
 m10-20020a17090b068a00b0028897565da9mr1121701pjz.30.1702221391046; Sun, 10
 Dec 2023 07:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ditang chen <ditang.c@gmail.com>
Date: Sun, 10 Dec 2023 23:16:20 +0800
Message-ID: <CAHnGgyF-oAnCd+NdvdZVzhE4VZLnK+BcVBH3gQqm9v0Q1s_QGw@mail.gmail.com>
Subject: [PATCH] net: netperf TCP_CRR test fails in bonding interfaces(mode 0)
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reproduce
1. client/server:
# modprobe bonding
# ifconfig enp1s3 down
# ifconfig enp2s3 down
# echo "+bond0" > /sys/class/net/bonding_masters
# edho "enp1s3" > /sys/class/net/bond0/bonding/slaves
# edho "enp2s3" > /sys/class/net/bond0/bonding/slaves
# ifconfig bond0 up

2. server
# ifconfig bond0 192.168.50.101
# netserver -D -d -f

3. client
# ifconfig bond0 192.168.50.100
# netperf -t TCP_CRR -H 192.168.50.101 -l 3600

netperf may terminated with "netperf:send_omni:recv_data failed:
Connection reset by peer".
the client correctly establishes connection and then send its
data(psh+ack), but if the server process the data(psh+ack) before the
ack, and then server side just resets connection.

---
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8afb0950a697..630bbe78539f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6502,8 +6502,11 @@ int tcp_rcv_state_process(struct sock *sk,
struct sk_buff *skb)
                goto discard;

        case TCP_LISTEN:
-               if (th->ack)
+               if (th->ack) {
+                       if (th->psh)
+                               goto discard;
                        return 1;
+               }

