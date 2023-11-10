Return-Path: <netdev+bounces-47064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC317E7B2F
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE68280FEC
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8AD134DA;
	Fri, 10 Nov 2023 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3M/lv9W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815BE1079C
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:16:00 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD027B3C
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:15:59 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c431ca7826so1793971b3a.0
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611358; x=1700216158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AT3doJZvC879QTC/Bt3FX7q9lYasT04k5DHdOOrUOQk=;
        b=X3M/lv9WbBzkmSBFsxM5xLsVx8q0CEadJ0EqZmKfivCA2YZcg5MRcd0wtQiI9OU3mM
         aCXTbDzMjNsqjAZ1v17wbMg1OnY3bL7edZ1MonnPuNL8650782awbuuMHeTi/kY7OyHc
         4QCyp1og3iEx3ytTgD3SIEE0eRt2GUixEtyHTAiN677nOjhPOtncCd6wSp/C8etrjcyE
         fGEia26RL6GvF1TVMqCEf3u18Qq0ehfCsYxiaM8mplgcfcFlNPjhIMJIPn21m639t/Yg
         /7aKATHS35qDzAaJC8FdAN9EnKTw2qOdJWMV+liHChq/Ydhet9sHhtsac+a2Xk66AisF
         MFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611358; x=1700216158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AT3doJZvC879QTC/Bt3FX7q9lYasT04k5DHdOOrUOQk=;
        b=S8ZQWlVos1hLfNt9DqRVS5oMImZEBH9aLy4k92CRcO3UvMhBHE0FuK/ipfC4KfcIcY
         ICeoMhFqJ9ctcI/p1raz1JDY8i3jTKeBhRkMY4QWr2oR0/snVVXqosqgbbH5/VqTFNeE
         m6du7Kdu5Wt5+AoCfe3/KV4lP0mbiJ4Bz/nEEokdMgkwVM9XjQNFAjw/51XsTtmmibcn
         77cOOdUIIg80s2g0DKd46BdFrN+IfmBiY1ndPzEFv05Mqid3kUEvF+NdpwFl8ENJ0MLQ
         8FDvQWnJJvsOE4RkNVNqe89O9pSdYfvrLrb19aiLctvwFOgksSHkFAx5RxZz1VapZbuI
         bJ2g==
X-Gm-Message-State: AOJu0YxZeRYsHaYXDyL0khEVLL8nyTl4cw3PrXaGoKtU4USzBY66Ri4z
	r3FFMw6IyPtq7zcjadhDt2jifzFUyV6ifA==
X-Google-Smtp-Source: AGHT+IEOiccQuNOcajhD5UCJ4KCYtmXlL8aCxQbcV0qyzF6ytMQksq685uh+W5R5kwLu6kr/mwGZIw==
X-Received: by 2002:a05:6a21:78a7:b0:125:517c:4f18 with SMTP id bf39-20020a056a2178a700b00125517c4f18mr9398965pzc.8.1699611358218;
        Fri, 10 Nov 2023 02:15:58 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b0027d015c365csm1244631pjb.31.2023.11.10.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:15:57 -0800 (PST)
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
	Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCHv3 net-next 00/10] Doc: update bridge doc
Date: Fri, 10 Nov 2023 18:15:37 +0800
Message-ID: <20231110101548.1900519-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current bridge kernel doc is too old. It only pointed to the
linuxfoundation wiki page which lacks of the new features.

Here let's start the new bridge document and put all the bridge info
so new developers and users could catch up the last bridge status soon.

Something I'd like to do in the future:
  - add iproute2 cmd examples for each feature

v3:
- Update netfilter part (Florian Westphal)
- Break the one large patch in to multiparts for easy reviewing. Please tell
  me if I break it too much.. (Nikolay Aleksandro)
- Update the description of each enum and doc (Nikolay Aleksandro)
- Add more descriptions for STP/Multicast/VLAN.

v2:
- Drop the python tool that generate iproute man page from kernel doc

Hangbin Liu (10):
  net: bridge: add document for IFLA_BR enum
  net: bridge: add document for IFLA_BRPORT enum
  net: bridge: add document for bridge sysfs attribute
  docs: bridge: Add kAPI/uAPI fields
  docs: bridge: add STP doc
  docs: bridge: add VLAN doc
  docs: bridge: add multicast doc
  docs: bridge: add switchdev doc
  docs: bridge: add netfilter doc
  docs: bridge: add small features

 Documentation/networking/bridge.rst | 320 +++++++++++++++++-
 include/uapi/linux/if_link.h        | 497 ++++++++++++++++++++++++++++
 net/bridge/br_sysfs_br.c            |  93 ++++++
 3 files changed, 900 insertions(+), 10 deletions(-)

-- 
2.41.0


