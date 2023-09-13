Return-Path: <netdev+bounces-33498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6679E3A9
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A26B281A80
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833941DDD5;
	Wed, 13 Sep 2023 09:29:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485F1DDCF
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:29:07 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DE9DD
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:29:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf7a6509deso46094235ad.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694597345; x=1695202145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/lBcmNA7i15qW5zLJ8tMUr6bvoRP9rRztBDTtvY2qO0=;
        b=AZEChLRgDrSms7Cj+9QFcXUk40F5kFt45nRMiaucy6odH2ZVigAOsxqMCtj2SUoLRE
         3x4UunimnLdkXXk6niyxvKKL53p6mpHzYwQLRnetDpTq+I6VUJH61IRVkcOiSPpYHzUl
         rHA8oxr83FQ//L7z+5nY2Lrw9HmyRTWfiAjWRghPf/grf88oCeBHhV+nEPpoh1kWUfxi
         OiOBNwC84evbLOhXzXYV4GGJfqeTktRLLvNNxTpEv9X5kklhBt8365HFkiCIhuZKP2Xl
         wRON/IdiJ3JyEvhaOSwDoxmLhYVYycq3FMI7b2ixkqhNtpdc3rgiJiuk58V3uMUUnx1f
         GFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694597345; x=1695202145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lBcmNA7i15qW5zLJ8tMUr6bvoRP9rRztBDTtvY2qO0=;
        b=mTvusWbFNr+Au+ZhLNJ3mS1PQxVf1cJKEmzmmGXdkxkD216U2g/xV+PuH2VJtYoYz3
         fnuWzutUZdd6vSXmiXH9v0B5losSLjQpxdQ+qERDOMdUZSmke93Mi4OLe1p9Vbf1Xtw8
         RD/LCUm7iRPYWOyHB2XEo8We1fCC2HdVJg9gX6lHZ4F9HZWG2he7GhuW9UI0m98MWOhD
         vL4CmdMra6bPEH0yJ3IXm7KZXf5nbtvbGJIHKf+LCAmTwgCNkGLf6cHBC1Cv6MzzNmei
         quqMDi9kd1Dtwublfu91T9/F5SbTb8OBRiMNFDWmFftkxmXExwHp32NgoW0pMSsMF1Zx
         ozEA==
X-Gm-Message-State: AOJu0Ywpx+Wm3z6XHzbyn6HTvx4GzFNWalB1Z+jDqIQQ/h7hUQFyFc49
	QTRriU8u3j8EwHxRydMAPCrSIr1pqaKRazae
X-Google-Smtp-Source: AGHT+IFCk5tFGeGId8Aahg4vxJ6Y6GysfZYhAtAwa5z2sMQKOTgpq1I63QNBao6vvvnAyIQ4zEy6eA==
X-Received: by 2002:a17:902:e80f:b0:1be:e873:38b0 with SMTP id u15-20020a170902e80f00b001bee87338b0mr2075429plg.59.1694597345496;
        Wed, 13 Sep 2023 02:29:05 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001bbb1eec92esm9951481plg.281.2023.09.13.02.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:29:04 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC Draft PATCH net-next 0/1] Bridge doc update
Date: Wed, 13 Sep 2023 17:28:52 +0800
Message-ID: <20230913092854.1027336-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

After a long busy period. I got time to check how to update the bridge doc.
Here is the previous discussion we made[1].

In this update. I plan to convert all the bridge description/comments to
the kernel headers. And add sphinx identifiers in the doc to show them
directly. At the same time, I wrote a script to convert the description
in kernel header file to iproute2 man doc. With this, there is no need
to maintain the doc in 2 places.

For the script. I use python docutils to read the rst comments. When dump
the man page. I do it manually to match the current ip link man page style.
I tried rst2man, but the generated man doc will break the current style.
If you have any other better way, please tell me.

[1] https://lore.kernel.org/netdev/5ddac447-c268-e559-a8dc-08ae3d124352@blackwall.org/


Hangbin Liu (1):
  Doc: update bridge doc

 Documentation/networking/bridge.rst |  85 ++++++++++--
 include/uapi/linux/if_bridge.h      |  24 ++++
 include/uapi/linux/if_link.h        | 194 ++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+), 10 deletions(-)

-- 
2.41.0


