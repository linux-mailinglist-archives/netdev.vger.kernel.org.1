Return-Path: <netdev+bounces-47771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963C67EB576
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9523D1C20A38
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1292F4123E;
	Tue, 14 Nov 2023 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NPWzNIPp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E141773
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 17:23:45 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EF3F1
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 09:23:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso7184928276.2
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 09:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699982623; x=1700587423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XLp+cLnpx4AkuBROnD4LiPqhOdet7xp/xiKF9z7w4l4=;
        b=NPWzNIPpvAKwrTciaGSmDnRE8RstCNQgLhD1cnCH3Kk5IgQJr4FEWmZ6L8tYEP5mYU
         7CJ6cVzXw+EVdwXf0Wm7ODzjUVVp7kIwFDlHtXvOICX3Xna1oJ68eVhZt11LrJVgnCg5
         qzB5iIdsCKdfC9jon76YDLpqlC19pNRWLktHmKD6zR2XCBVdPqmZYiKQ4Ep0ynNZfiD9
         hZq06Wq9pCS/792gSmlGPruYlGP53sZsEH6pPLIZTiQECahZsWfMsixz85SlXXbMeEK7
         CmjcMhY8FL2pa+KLSbnd0Ih2mKV99KYyj3SKnJlczHIZTo9fYjf6gvrhHX1AB1NLYODu
         y3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982623; x=1700587423;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLp+cLnpx4AkuBROnD4LiPqhOdet7xp/xiKF9z7w4l4=;
        b=BPqMBkc0VKqqZKYkyzuSIErLZcPdrc4OoBrWVJZSVCK+xnJGhnykengZl85lj2Y584
         VkjfsrsSgkLanFQnHW+BV58eQQcuK9SmpjIWJXoE5GJxIqllb6NkdulLt/gPDSJ4154Z
         DnOx/oMOjqAYQd7IKcoHyi3yN84to3i9Dv6N1xKFeCjPBgYNP87XDxv04pc5gryYSk5H
         r+130fThGdWJ3XplrGKepNHkBcX9BYM4CWbKj03SFsLvkLUJ6k1JohN6jQFquEx/YJ99
         Cp1t5EdcoNOtsttWYDsPA2/jeYzMKo67BJY+742d9lsWam8W26zpExA2ANu3rDUmuhaR
         7Zlw==
X-Gm-Message-State: AOJu0Yy67v4juWTiNhgGTIoybWw1wjJB4YcbfVXoXr50I39AWUxqgjIi
	BRKlQuOIgILbEUIn8pknpscJlM66C8dZcw==
X-Google-Smtp-Source: AGHT+IEKP+f/gaVd9lya213YvgjkP+Npdfe/9rGB7DNNf1/wyz4aUkidALINVA1uc5We4eisqwO2tqPoM0W+RA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:43:b0:dae:49a3:ae23 with SMTP id
 m3-20020a056902004300b00dae49a3ae23mr239424ybh.7.1699982623670; Tue, 14 Nov
 2023 09:23:43 -0800 (PST)
Date: Tue, 14 Nov 2023 17:23:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231114172341.1306769-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: change reaction to ICMP messages
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	David Morley <morleyd@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ICMP[v6] messages received for a socket in TCP_SYN_SENT currently abort
the connection attempt, in violation of standards.

This series changes our stack to adhere to RFC 6069 and RFC 1122 (4.2.3.9)

Eric Dumazet (2):
  tcp: use tp->total_rto to track number of linear timeouts in SYN_SENT
    state
  tcp: no longer abort SYN_SENT when receiving some ICMP

 net/ipv4/tcp_ipv4.c  | 6 ++++++
 net/ipv4/tcp_timer.c | 4 ++--
 net/ipv6/tcp_ipv6.c  | 9 ++++++---
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog


