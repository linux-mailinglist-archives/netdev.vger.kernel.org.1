Return-Path: <netdev+bounces-52832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30A800555
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D4FB20D6E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8948718625;
	Fri,  1 Dec 2023 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRLFbIZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B845170C
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 00:20:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ce28faa92dso2399565ad.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 00:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701418802; x=1702023602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4zUlETjBRKMJV2SnKEGh/CF2OTNLFvzk/SPEwsphsMU=;
        b=fRLFbIZKvaez/J+2k75OeCogo53wF0Fq+yrjt3WxRYZ8o22ho5ALrNHxZn0y5Nu1jb
         jG/+Pjlo1LhyZ/wsa1+3Te6MVF+gvH2Uv5ogaZrXOWW+u3zQqramktPciLExqCb6gfPC
         2nwn5BwOMzPPdr4N5f+I+tB+txZjpBhBsOqTuBUBwXVDismh0Qvl8voFOtOCGdDHi979
         b6cEPTFq6N0nIpoa8uz+mduk57eYVj3poY4ioiCrRHGpCedks3AD8HhmJJC0+3EP3byq
         iX4TGHPycq7cEEWSYmXoBPq76fWqizJaeer25cI7I3kelAzz65LX6zLc5VioaAzcOiXw
         fiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418802; x=1702023602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zUlETjBRKMJV2SnKEGh/CF2OTNLFvzk/SPEwsphsMU=;
        b=WwZwOjAHn6x3oyujockXBWZ6B50BDFtgVK0Fd0cMzu9Ok0k7o3VShpCf2kT1fPClxh
         +iIP/UijMWnTSX5CRJQWZ+SzmwdNaB7VIpKWARQltNnHdemhZ18VCD1BL0uOhK/ofvrx
         R7w3LMpbulNm5aCd3oz9YNrquJNxEJ5Vz2NV6ZKUzUNAkC7n+wlFvOBcPGA20B1RqKVS
         N/nLo8zhXsocAubN6mLU9IzO80RgBKUDWv1KxABWFa841Looe3o7sPU5dp4Rb0C0tQFk
         dIWK1FQgbFNq1/txUl5+tx3jCnCkNhWS5ggIrZJO790/rB/n0wx2gQ5OmjthPSMcSSAH
         WRUw==
X-Gm-Message-State: AOJu0Yxq3y7Pomzcq6oPdEjUVsOX8vMA9HUBWTyrQ1cV5DP39yEydT/D
	w7wD5abIok6b3YvKRXnbSSqy1DEVK1znag==
X-Google-Smtp-Source: AGHT+IE2JPYDSdnC91XB6VS8ALR9CAAId19DXk2wcJ+rrETzGALp9s3m6m1Wb6EndIJy2wpJMovubg==
X-Received: by 2002:a17:902:7789:b0:1ca:86b:7ed9 with SMTP id o9-20020a170902778900b001ca086b7ed9mr25916453pll.40.1701418801928;
        Fri, 01 Dec 2023 00:20:01 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001cfc68aca48sm2715787plb.135.2023.12.01.00.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:20:01 -0800 (PST)
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
	Marc Muehlfeld <mmuehlfe@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 00/10] Doc: update bridge doc
Date: Fri,  1 Dec 2023 16:19:40 +0800
Message-ID: <20231201081951.1623069-1-liuhangbin@gmail.com>
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

v3 -> v4:
- Patch01: Reference and borrow definitions from the IEEE 802.1Q-2022 standard
           for bridge (Stephen Hemminger)
- Patch04: Remind that kAPI is unstable. Add back sysfs part, but only note
           that sysfs is deprecated. (Stephen Hemminger, Florian Fainelli)
- Patch05: Mention the RSTP and IEEE 802.1D developing info. (Stephen Hemminger)
- Some other grammar fixes.

v2 -> v3:
- Split the bridge doc update and adding kAPI/uAPI field to 2 part (Nikolay Aleksandrov)
- Update bridge and bridge enum descriptions (Nikolay Aleksandrov)
- Add user space stp help for STP doc (Vladimir Oltean)

v1 -> v2:
- Update bridge and bridge port enum descriptions (Vladimir Oltean)

RFCv3 -> v1:
- Fix up various typos, grammar and technical issues (Nikolay Aleksandrov)

RFCv2 -> RFCv3:
- Update netfilter part (Florian Westphal)
- Break the one large patch in to multiparts for easy reviewing. Please tell
  me if I break it too much.. (Nikolay Aleksandrov)
- Update the description of each enum and doc (Nikolay Aleksandrov)
- Add more descriptions for STP/Multicast/VLAN.

RFCv1 -> RFCv2:
- Drop the python tool that generate iproute man page from kernel doc

Hangbin Liu (10):
  docs: bridge: update doc format to rst
  net: bridge: add document for IFLA_BR enum
  net: bridge: add document for IFLA_BRPORT enum
  docs: bridge: Add kAPI/uAPI fields
  docs: bridge: add STP doc
  docs: bridge: add VLAN doc
  docs: bridge: add multicast doc
  docs: bridge: add switchdev doc
  docs: bridge: add netfilter doc
  docs: bridge: add other features

 Documentation/networking/bridge.rst | 334 +++++++++++++++++-
 include/uapi/linux/if_link.h        | 521 ++++++++++++++++++++++++++++
 net/bridge/br_private.h             |   2 +
 3 files changed, 847 insertions(+), 10 deletions(-)

-- 
2.41.0


