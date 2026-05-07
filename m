Return-Path: <netdev+bounces-285409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LqXNHK1/GnVSwAAu9opvQ
	(envelope-from <netdev+bounces-285409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:53:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9B4EB7E0
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5D3C301AA4E
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A1044D02B;
	Thu,  7 May 2026 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gxruH3tk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844FD44BCB8
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169096; cv=none; b=fqgZ8+aPAkASQx28DTJFHQp2xgwPiRwEQ7rKhx6PM4rXYV9ZELnIcCjG/E7xnZxBi58/CzXFnZWuzp+IhfXW36EgyzUOcFOYG6lyYpnprJ6jSfQPzltmXBbb6fwgHYUGDIBsLNeoWgrqrJWNOkCA5daRa1lDzRU6uc6GwUITdLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169096; c=relaxed/simple;
	bh=T1es+NUo7iUHfYNW7MbhVaFEpDoDjGvfl8mP6hP0Drs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlZ+ZdXtcwuNv1168SFwelKRZIEvMZOsUJ3rcN/CJ4pzi7jkHV0u7r84FKlvMM6WGcO56t8GAxxoCzqxB06M8r4EfElha50tNhYbibbRZ/GT+UU1RKoITX7Mn95hfADELuxn3J2H4u3rLHfCrTIp2QM2XWwFCMr7cVVTx74Ecu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gxruH3tk; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-365cb1c2209so139033a91.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169095; x=1778773895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ax1Aa73Yhe1dRK53NtIJp2y9KXXpNOfAjqoEk54yGok=;
        b=TdheeVMSvRSN/DOOLV3pbraqb+lMkXtaEDWn5Np9OKxCkRUZyHvKKxzNn2k7opRV+3
         Y21i2V/7RsNJRR9/9A0nROp3TAo4Q8akCWxbWfj7i3j1g7QZQUxZCPC2s0Jzcdm7dN73
         5CLIN65qaO/KM9FX7Rf1cMEDAjGF9mVS3fFfbH+RoWa4+HJWHjeIqUuT/VyaSqZ6nHbX
         wn7Q5hF10SY2wY6yiYJnqiuPCjU4RHsY1nH0+dQwFLVL0nlhyaLL6A6yeBARmDtq8TfC
         bsG0jgyhX9AngmCxlXMD18gYRF0zCNXPIxAI0tp6SP/acP8A1sL0sE40j4wspJVBaPdy
         V9Zg==
X-Forwarded-Encrypted: i=1; AFNElJ9p5Vq7fZmj8cG9FUbSBgXOCQwR9pJzmK1DD7Za7bKAIN6wg8vBc/O/YLKdn7Eu+LVy/RJNvN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hK/KC+i99M+nsPMAieoQmZunPialXicMtmEfYXtiaPzzcV3j
	nVDoqhrjwfkmcfjqfT9h1YG20bH0uGBWBmUP+R76ReEJV6pfRrITgCmDEkQp9lZjjbybg/jwoo0
	aGpflp/yCCxqliyRc+T/dWO4NY7EjRWs/DUik6PMmV3E9lfAuOwa84Zxtrem+ru3YOxh3V+sYSp
	Xho5cgmK+A3n+obO3PcO5hoesDw8LzXJVXxeXra4ZelokE3POR6rJ6sFt6Bg10iKG1SF2xEetXJ
	8Bqo0X5nOHozxg=
X-Gm-Gg: AeBDiev+4eKxijUPpKHrsH+lkPQfvZjMW2tkHUIjjfnEfgUYMvbkBfHfvmpdptTd4R8
	YLMhlaW+0KNs4+Kwv6HFntf8KSDUJ+pHazUKML+D+JtawepYJymSo9W42TbcXClY4Oi4oNB1Skh
	m4P0CLT5anvPbFgFKLQGvj7k9rzQYFH18XHDiAqiYfRRxTB0lk3D10k0CbJuaLZqWNsRt0WNYQj
	fGLVDsYVUBXwR/H+kB1CCJHcdFd6pjr0qXE+3MX3NILAUQ0FCR8WGP9yhDyMD0EYe7nSjBTrH+x
	Y/aWmQ848fdAsPK0tRSAxuEWH0ZixftlkOSUTYX9gc0JokH+60mUItKVqY+iXetRlixSfuaVwpU
	FOIM0oNXkv18xGGiCssKVK6TxKRzLWf4lL1hK+Zv6NuSflNAqlLPGIuNMiTAhoSUsU70HNubYCD
	YCgy+NnoNxl96a677O9HGS1ChhQMuC7eYLdD6kOyXlK3A1gYNux9wX+31Sow==
X-Received: by 2002:a17:90b:1649:b0:35f:b893:35f0 with SMTP id 98e67ed59e1d1-365b4ccfe96mr4734754a91.3.1778169094591;
        Thu, 07 May 2026 08:51:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-365df809d52sm376048a91.2.2026.05.07.08.51.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2026 08:51:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8ecac841eecso19591385a.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778169093; x=1778773893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax1Aa73Yhe1dRK53NtIJp2y9KXXpNOfAjqoEk54yGok=;
        b=gxruH3tk/6ZLQp3HaN3RH6W/SfXEH8kK8jNBbUMJtKVjNqLhJI7V30n1needsmEKWv
         ghMeZ5dxY4lGadYDV8TEnsqIK6SyY4l9T7fjqNWC/AMmJQRuwhGIMD8viTMXCvjj1Lfx
         K2rNAfTQvTZh3A3mz9i4h7tLywlbB8oOq7VtI=
X-Forwarded-Encrypted: i=1; AFNElJ89A1X8PDbN4G+2c3MTnf2klk4e8HeBJAYcJursNy9yEPLCQhZtRAN4G5p6a9nmclwp2keC4Co=@vger.kernel.org
X-Received: by 2002:a05:620a:1726:b0:8d7:ed38:8189 with SMTP id af79cd13be357-90517dc628dmr724172885a.0.1778169093298;
        Thu, 07 May 2026 08:51:33 -0700 (PDT)
X-Received: by 2002:a05:620a:1726:b0:8d7:ed38:8189 with SMTP id af79cd13be357-90517dc628dmr724167785a.0.1778169092652;
        Thu, 07 May 2026 08:51:32 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90642b76d39sm240711885a.2.2026.05.07.08.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:51:32 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: edumazet@google.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Ankit Jain <ankit-aj.jain@broadcom.com>
Subject: [PATCH net v3 0/2] tcp: protect locked SO_RCVBUF from Silly Window Syndrome
Date: Thu,  7 May 2026 15:48:04 +0000
Message-ID: <20260507154806.18635-1-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 93A9B4EB7E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285409-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This patch series fixes Silly Window Syndrome (SWS) for sockets using 
locked SO_RCVBUF.

When applications like Tomcat lock SO_RCVBUF, receiving small packets 
causes the memory truesize penalty to drop the scaling_ratio to 1. 
This shrinks the internal window clamp and leads to 504 Gateway Timeouts.

Patch 1 bypasses this penalty for locked sockets, except for GRO packets.
Patch 2 adds a packetdrill test to validate this fix.

Link to v1:
https://lore.kernel.org/all/20260427152756.1205-1-ankit-aj.jain@broadcom.com/
Link to v2:
https://lore.kernel.org/all/20260504144945.13477-1-ankit-aj.jain@broadcom.com/

v2 -> v3:
 - Changed GRO detection from checking tp->advmss to skb->len > len 
   based on Eric Dumazet's suggestion. This correctly detects GRO 
   packets even if they contain tiny segments.
 - Updated packetdrill script. Removed the ad-hoc mss 48 configuration. 
   It now uses a standard 1460 MSS and sends varying packet sizes 
   (600, 700, 800 bytes) to naturally trigger the scaling_ratio 
   recalculation.

Testing:
 - Verified fix in a live Java/Tomcat environment (504 timeouts resolved).
 - Passed the newly added packetdrill test demonstrating the clamp bypass.
 - Passed upstream regression tests: tcp_rcv_neg_window.pkt,
   tcp_rcv_wnd_shrink_allowed.pkt, tcp_rcv_wnd_shrink_nomem.pkt,
   tcp_rcv_zero_wnd_fin.pkt, and tcp_rcv_big_endseq.pkt

Ankit Jain (2):
  tcp: protect locked SO_RCVBUF from Silly Window Syndrome
  selftests/net: add packetdrill test for locked SO_RCVBUF SWS

 net/ipv4/tcp_input.c                          |  7 ++++-
 .../net/packetdrill/tcp_locked_rcvbuf_sws.pkt | 29 +++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt

-- 
2.53.0


