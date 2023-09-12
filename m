Return-Path: <netdev+bounces-33003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D1D79C2FF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD29281664
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBB8F5B;
	Tue, 12 Sep 2023 02:33:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB35246
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:33:25 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3357ED540E
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 19:33:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e5e2e608so57210727b3.2
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 19:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694486004; x=1695090804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QCoBLkriLW/toIPEVHuhdGrd0mSi5M4JDxPsfYpdyfM=;
        b=eYHmpPoKi9EwGg3zrTRrNxNsxaitB1q5S1w998nsucEQvZ6qeZZiP4fZg9pR0lhkll
         UqgdTXQOF/Nr2vohIWXAwXxBY7JmAHdz8PnK04SuANFltDcQc69653+z6D/lTerhCKvB
         G0INxeMcX1YJJtWp2DXPgU/F1UcxrUEIGmq8gGGC7q0ogg6Manc+y0DzXty3BNlCWhgQ
         gxgvJ3xaLx2IJepR8HrJ6LN8UzyDb5/cFvbBwiY0mq/dFz8ch0eISLyDiUdmtSF23TAT
         oS6deMD849WnQhb5EJRqTGPCgHM5r0pbZIl5+02hJq76kaTsPcPWV5+XyJBLADGGN94E
         eI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694486004; x=1695090804;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCoBLkriLW/toIPEVHuhdGrd0mSi5M4JDxPsfYpdyfM=;
        b=XXZNydqjkL6Nf2X1yHBhVr9rQYUI4zWGyFOGcGvsSyaYmmKM2saU0UXcxHqx41Fj9j
         hmAzrGanvKu0AG8DxjykHeKc/AcGWo8GPIzy8zcLQytysBpMoT90hBKq7Ck0Z//Tt5aJ
         htwr9Bu3q4yJUCa8Vnk2PnHKsA3A6EdiVp7rnho+dWP57ctSoHoDK4HDv/jIQtI6KFNZ
         cr80ttddG7qJFQ6W8S3bUPoiHzMEssyO83SCVixPgvJBkrbOFqoBiehvZyRiL+yxRuaC
         Fdi2Q6Km+qvOTLk0uxRZOGMSB/B7o9snCC1RcdevVcB3CvrGaamB1Pm0hFpWa2m/MESU
         blPg==
X-Gm-Message-State: AOJu0YzKfI40s9ETkBxXrlHKFH82FKQrPPbZX+s2venpE000CNOm1XDv
	+ultXyvWUrM7RzgSi943BgiQHIOJJnC1Nw==
X-Google-Smtp-Source: AGHT+IEaMWQhp180NrGNIPKdc9qEn/tW+TPMTK8LU16wqXs3YLwEqim448RA4gMbK59RiLVEwsA8jiNks0dI/A==
X-Received: from aananthv.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:44a6])
 (user=aananthv job=sendgmr) by 2002:a25:84cc:0:b0:d80:2650:57fa with SMTP id
 x12-20020a2584cc000000b00d80265057famr247448ybm.8.1694486004487; Mon, 11 Sep
 2023 19:33:24 -0700 (PDT)
Date: Tue, 12 Sep 2023 02:33:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912023309.3013660-1-aananthv@google.com>
Subject: [PATCH net-next 0/2] tcp: new TCP_INFO stats for RTO events
From: Aananth V <aananthv@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Aananth V <aananthv@google.com>
Content-Type: text/plain; charset="UTF-8"

The 2023 SIGCOMM paper "Improving Network Availability with Protective
ReRoute" has indicated Linux TCP's RTO-triggered txhash rehashing can
effectively reduce application disruption during outages. To better
measure the efficacy of this feature, this patch set adds three more
detailed stats during RTO recovery and exports via TCP_INFO.
Applications and monitoring systems can leverage this data to measure
the network path diversity and end-to-end repair latency during network
outages to improve their network infrastructure.

Patch 1 fixes a bug in TFO SYNACK that we encountered while testing
these new metrics.

Patch 2 adds the new metrics to tcp_sock and tcp_info.

Aananth V (2):
  tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed
  tcp: new TCP_INFO stats for RTO events

 include/linux/tcp.h      |  8 ++++++++
 include/uapi/linux/tcp.h | 12 ++++++++++++
 net/ipv4/tcp.c           |  9 +++++++++
 net/ipv4/tcp_input.c     | 24 ++++++++++++++++++++----
 net/ipv4/tcp_minisocks.c |  4 ++++
 net/ipv4/tcp_timer.c     | 17 +++++++++++++++--
 6 files changed, 68 insertions(+), 6 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog


