Return-Path: <netdev+bounces-209427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5A1B0F8E7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30C8566A7A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8545B20E717;
	Wed, 23 Jul 2025 17:21:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBA519C54E;
	Wed, 23 Jul 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291260; cv=none; b=RH/FG/qo+F007U1E6Q1GxgSdpO4D9J0s8AqUO0y9ZQIhWGAxiL3Zs0G7sD0ifaJevBVrEJsGS/kJH1z7j5Pss49r42aHW34Fu34BrrZsTNoeTQYTwKnXx/WD+GfGwN5FSeU/u0aw3BOTISdEKSTg8h+K5E7P81U7lnGRoLASgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291260; c=relaxed/simple;
	bh=iOsorm+hWRL2X8GoIw1EcHy1Zn720bFkkp/gw+4IHFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CoXmDpS3MUR6DAw6gay/pyEwJ1R1KrN/TuzpH5WdXfNhToDI+kP6+xjE+OXPrVPqSNXyPm/qs8DogTBhHFTLlHStwDk3QeErwX+gy1xmUusZ1nX2T4ggc9+qEh7CzJ1NSkOtBO4ESdeSa6rUfrxwIrbVSje3RIzj7JLsE+yCamE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so243546a12.0;
        Wed, 23 Jul 2025 10:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291257; x=1753896057;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ap+YYbn2vwAHVV4xi0ikUNaFEK9zJtyyvGRtVPjUuBk=;
        b=C4Ee6yoK2UZtze7NSpoc+ECF4rNQ8mKzB5Fzgafn8tYXgtLMflK2fxe4E3YaT2EbG2
         WPDDYFBOyK5Mnr25l2hoZMXiwmW4RnK5m8pEvuKpVNVfBlg1+HtVPRmTgjtSeRSi+P8c
         J9d8FkxUkQKlHVohNRfrZYL774GJxtRFUTReQqWWHLSqJ6iLxNzfQmxpWE0og3N+mOxM
         0WURzVv8VhQOaMNBUQ8r4NK9Vueerbt6+cR2fD9kz+C+PmaX7l9ZtXVJzufySJ9PMqfo
         dKRD2jXS7vTe9a8C6frIqk0RoFWLPM3UyNz7ZPCnqq7CzEOxxUhI2DGndDicc2rGW5o+
         rFog==
X-Forwarded-Encrypted: i=1; AJvYcCUMeExT84qB384sBitsrjde51+xd8dAYSv4ZFVqmq+HNn0V4Oow5D9KTXI6VZf+3mN1wWEDrc8F/3isKM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylhwxsj4VKToI5t9ifQI1Xz8ClfSE/x5psPH89hq+LsKVHwRsh
	tvf00iyFwG0Mjba8VvBg8ee46hptUpxwT4dItXBdZ61sibv9Ozh5cEac
X-Gm-Gg: ASbGnctql2qj/GsLCeZn59tM6PZJTIhBMRdWBaDnRMDew8VD4dpTF9FD61+d4nPE7d2
	p6fwnKfrYL7B/jkWj0QKeidcVAqdz3g8WzRpzXHgcf58vYsEmb+j6HUp9Hgmwej9ir7X+fgUyV0
	DmJ82JolY4Wi/m4yABwd/aXpXO+dir6Wtx1i2bsjtP2qhwMd3T0dSebTIYkc7+J8yZNonQHp6y5
	E2bHgkQh3j4EsTtqcpJ0b20wHHWTlyZVxCH61wp7NzjxGeG+BgmCt3ifupgKBKD6RuYnaGj50se
	HTStFeGWjF1lYQ1PH/Yz4rNMsDYDBs288UXI8Ly2KwfJSw1W9oUwG/rFg3aqBCuxKphwRY91W5O
	LtbZSgsuuBA==
X-Google-Smtp-Source: AGHT+IE3j1KPJjAnmXIbc50rI5Q3PPC8V9+e49LvJw7rb1JcR5iNRg+y2hJTfrDD+F1RMWEZMKrv+g==
X-Received: by 2002:a17:907:3e9b:b0:ae7:fc3:919d with SMTP id a640c23a62f3a-af2f705ecefmr389449866b.25.1753291256565;
        Wed, 23 Jul 2025 10:20:56 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6cad0feasm1070582866b.138.2025.07.23.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:20:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/5] netconsole: reuse netpoll_parse_ip_addr in
 configfs helpers
Date: Wed, 23 Jul 2025 10:20:28 -0700
Message-Id: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANwZgWgC/3XNSwrDIBSF4a3IHcfiIyYho+6jlKLmmgpFi4qkh
 Oy94KildHz4/rNDxuQxw0x2SFh99jHATGRHwN51WJH6BWYCggnFRj7RgMXGkOMDbwkdtdyNQvX
 WGcWhI/BM6PzWghcIWGjArcC1I3D3ucT0ak+Vt/1ftHLK6DSgE0qaUY/6vKDxOpxiWlurig8v+
 I8XlFHTC8cnKdWgvv1xHG+xi6WF9wAAAA==
X-Change-ID: 20250718-netconsole_ref-c1f7254cfb51
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2023; i=leitao@debian.org;
 h=from:subject:message-id; bh=iOsorm+hWRL2X8GoIw1EcHy1Zn720bFkkp/gw+4IHFM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBogRn2L4UOJ7JZgzbsbg3zs1TIi5xdLjDzCmFXz
 VL3S+mqmyCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaIEZ9gAKCRA1o5Of/Hh3
 baBGEACcX24Yn+4pKuYXlTd0V98ReoIhGQ7n0v9m0UyzswN8KE6WpfxY43JsD0lotMEoqr/f/V6
 RSREbKFOXw1o6a7nd3AvJozWjJ1vcgh5Gaea37MhKF1DG1Pio/RdWyHOsF4W0vT9t151BlwfEyj
 3S4yb+fnmebsm0N5q/Dfqmnzm8TXt/Pib4tgYeZPkJOfWXckNDPtCv3tl3yAKvOMSyoBH/Q6TC4
 EE5/S8KtgAgAsEm+xrGGJS2JuXA/2KvW3CqlKaUXPfJZZ0APbzwexBgGPX6h2kSXynjxLo0Kq5z
 vcw+PtbxdEsba2wckBdl+STeXFLg4acm98hEfSn7uWX5liIo2pD3flnYsSo0i7k+XqiLgRC7kRg
 SNHSft71BIWlEffdwgTZ0Jhfg50Fkc1kyFRG0+7S0gHSI7TvpWgegrTMfuG4IZL7+5qC9OFXRza
 Fppyigsfm2AMA0eFyftjiHIwwErJUVq4lMgukiRetyrgFR+Z8XhUKfwh+Hf8pT3ZHXfc1GjRkI4
 gNwBbORhJcS3PCjE+QhAZ7id/M/3FyBlmIgzIOjDLqbflS7ULPdBgYjIUexS4M8i6p6y1nhiGjD
 Znj4+SPnR7hxrXQyLWdk57rzS/KOVmJRWbBpRlGfv+Jrnd2Pm+1pbCqwpvIeRbn1JWW3c2pLguH
 1t0hjrYTSy9M1dg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset refactors the IP address parsing logic in the netconsole
driver to eliminate code duplication and improve maintainability. The
changes centralize IPv4 and IPv6 address parsing into a single function
(netpoll_parse_ip_addr). For that, it needs to teach
netpoll_parse_ip_addr() to handle strings with newlines, which is the
type of string coming from configfs.

Background

The netconsole driver currently has duplicate IP address parsing logic
in both local_ip_store() and remote_ip_store() functions. This
duplication increases the risk of inconsistencies and makes the code
harder to maintain.

Benefits

* Reduced code duplication: ~40 lines of duplicate parsing logic eliminated
 * Improved robustness: Centralized parsing reduces the chance of inconsistencies
 * Easier to maintain: Code follow more the netdev way

PS: The patches are very well contained in other to help review.

---
Changes in v3:
- Avoid #ifdef and use if (IS_ENABLED()) instead (Simon)
- Assing an int to a boolean using !! (Simon)
- Link to v2: https://lore.kernel.org/r/20250721-netconsole_ref-v2-0-b42f1833565a@debian.org

Changes in v2:
- Moved the netpoll_parse_ip_addr() to outside the dynamic block (Jakub)
- Link to v1: https://lore.kernel.org/r/20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org

---
Breno Leitao (5):
      netpoll: Remove unused fields from inet_addr union
      netconsole: move netpoll_parse_ip_addr() earlier for reuse
      netconsole: add support for strings with new line in netpoll_parse_ip_addr
      netconsole: use netpoll_parse_ip_addr in local_ip_store
      netconsole: use netpoll_parse_ip_addr in local_ip_store

 drivers/net/netconsole.c | 84 +++++++++++++++++-------------------------------
 include/linux/netpoll.h  |  3 --
 2 files changed, 30 insertions(+), 57 deletions(-)
---
base-commit: d61f6cb6f6ef3c70d2ccc0d9c85c508cb8017da9
change-id: 20250718-netconsole_ref-c1f7254cfb51

Best regards,
--  
Breno Leitao <leitao@debian.org>


