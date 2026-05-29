Return-Path: <netdev+bounces-293109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AbQFpGKGWoJxggAu9opvQ
	(envelope-from <netdev+bounces-293109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:46:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E1D60269F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D5423007539
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1B618FC97;
	Fri, 29 May 2026 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA/xLD7K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A115175A99
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058765; cv=none; b=gBrspjHH4yZU9BULSqJkZ48BPjbk0HeoOjanVHcY1cT95a/7SXryeUbJSZycRaQ+2kJkx8fJ6s4uhNeh+277Y3hupRaigW/hHHmYnESusRivHAoRtUl+n5cRVKsEEs50s22z8dnn9JrZr24JqwkDOtXF0JYVPRkUYAuxR06zBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058765; c=relaxed/simple;
	bh=NSn5sR6O4Rt7B3/YqbAiK3fq+qyObIB738wGJZL72Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LRD1TKKIFKy2/7QcLWV3DqCGFinamg1z7fTZcNskddQbdxEP7N2J19unWXwZWG9CdBiwqw1GrVPc/GRdpACcKfyzFo8DYhpThiQkVb+eq6H54UgeEq5aPr+G76Gta0FxHu/cS5cCreWQOLL7hhmH5TCFHn7djWJ9xFyY8Bh4qFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HA/xLD7K; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dd73b7c757so6453407a34.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780058763; x=1780663563; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FOaj7kJy+BccHhWOj/+aUOc8E/TW5v19gnCmqaTZgac=;
        b=HA/xLD7Kwxrz+AgsGk+FAdm4QhMyYI5zcD0Pm8uvJNUOekol1Je9GOhQvij24ZIZHV
         nWireIuGELyORTSD5VCx8W6jE2hVHPLi2x3zxD9xP/Yv8Nnhb7Ywsyxb1RGb42xrgOQj
         AttW5+XFRYMmBAw+oLFQOm7mkMJnwZDTe5jIFd4y+KGi0MrdfBZpQfmXw4YUG4vAgaMU
         IorllKx5RhgUVMYTMmgLlupKRIWlNDY8Y+o0hzyhRaIwiTF6Uyddb29/AOXBNQtyDkr+
         nLgjsAdoS4m8BgCfNseudmmuu3VB8GZ9USOX2MR668Bua42WLQRVTVFwbwQx+uU+FEHq
         5UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058763; x=1780663563;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOaj7kJy+BccHhWOj/+aUOc8E/TW5v19gnCmqaTZgac=;
        b=gq25T55aNfLHEToktt5llaFBiURs0G4f+UBBg+hW7O494DXag4VNsqFXwq0DtYc397
         3h9oOop/SgY5ESoBahqy2zRY8s/0zIsm9a3rXRobtJYdvFGeBMjnUOUSatcGj+nMiEZM
         V1v5xKhwT1c/HRSnIWjCfBoPRAVlbXBg+95fqVTC1Ce4UbWb/VrDrF319oHX5BFqQRLE
         jxepv0Pz4OOKlvVZxLt+pOPeyli7jl9ikvJE0ljx6RNF4g0EujrvY0rrzDuYaZflYPls
         iMARYD0OqDSKmYfGF8Yv1Y3399m5AQZ6AVMZ+y2IAXvQIm/+MXCIQzug/2ktyFgZu8WM
         CC6Q==
X-Gm-Message-State: AOJu0YxiYsOli1byKstJ6bqwNa9UWi9e03vPHXFkiN2cWEvfpUsaq2tt
	21WSx8yra0TceRjSDmsQbfS8TujndBBYQNqvsf/rKFDENbwiU4kcKGUg
X-Gm-Gg: Acq92OE/azeeCXTHXQUe8d0Uq79Yrrsb5Jp7BENctQP/LZPQdzDyptemE73ggIQ+DT4
	UFKHWaqsocqbZB1ZwWfV6wDXx2BMK11yCNXD7uXxnpEGYBehYkDyt0lBRAtPkmMYDg3/Z7Tmhhg
	EObAgq4tyCE+bdTkHwAM52EPSufHUifPZJC++yMpVrN4m5RQ5e5GS2CDndq1Pr0ax+3u5t0WVPQ
	njpg2OZAVtvOVi25v0KmYudbvUNjnANAee3t/kp7NwumbIHGdfkD4UNRH9YtHspTuKcgFqtmYmN
	PhhPj2D5p/ehZt1RGrR6NGNJRohzZCqb492KW/z7xvoCD3/wo/RcvY/DkSDnqYK4yHn81stZMaH
	hickf/LyCKYXDyIz1Eau8PUfMVFu2YXHRXakQHVH4+4z+8+Q2mA1n/VrYWBmI+CcLpvVcJAD+ME
	SUqAOlvzXdKjCv5e5rW4aHjz6Wvq47lg==
X-Received: by 2002:a05:6830:438d:b0:7e1:90a:97c2 with SMTP id 46e09a7af769-7e694e4bf8bmr1720403a34.23.1780058762922;
        Fri, 29 May 2026 05:46:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695bd9c9csm1381119a34.11.2026.05.29.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:46:02 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 29 May 2026 05:45:55 -0700
Subject: [PATCH net-next] selftests: drv-net: tso: add new tests for
 ip6tnl, ipip, and sit tunnels
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-tso-tunnels-v1-1-3771ee9eaaa9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIOKGWoC/x3MSwqAMAwA0atI1gZqRaVeRVz4STUgUZoqgnh3i
 8u3mHlAKTAptNkDgS5W3iWhyDOY1kEWQp6TwRpbm8o6jLpjPEVoUyz9UIzOm8Y4B6k4Anm+/1s
 HQhGF7gj9+37rKQKAZwAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293109-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 04E1D60269F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add new tunnel test cases for ip6tnl, ipip, and sit. ip6tnl supports
ipv[46] as inner l3 header, and the other two tunnels only support a
single inner l3 type.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Example run:

  # Detected qstat for LSO wire-packets
  TAP version 13
  1..18
  ok 1 tso.ipv4
  # Testing with mangleid enabled
  ok 2 tso.vxlan4_ipv4
  ok 3 tso.vxlan4_ipv6
  # Testing with mangleid enabled
  ok 4 tso.vxlan_csum4_ipv4
  ok 5 tso.vxlan_csum4_ipv6
  # Testing with mangleid enabled
  ok 6 tso.gre4_ipv4
  ok 7 tso.gre4_ipv6
  ok 8 tso.ip4_ipv6
  # Testing with mangleid enabled
  ok 9 tso.ip4_ipv4
  ok 10 tso.ipv6
  # Testing with mangleid enabled
  ok 11 tso.vxlan6_ipv4
  ok 12 tso.vxlan6_ipv6
  # Testing with mangleid enabled
  ok 13 tso.vxlan_csum6_ipv4
  ok 14 tso.vxlan_csum6_ipv6
  # Testing with mangleid enabled
  ok 15 tso.gre6_ipv4
  ok 16 tso.gre6_ipv6
  ok 17 tso.ip6_ipv4
  ok 18 tso.ip6_ipv6
  # Totals: pass:18 fail:0 xfail:0 xpass:0 skip:0 error:0
---
 tools/testing/selftests/drivers/net/hw/config | 3 +++
 tools/testing/selftests/drivers/net/hw/tso.py | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index 8c132ace2b8d..b9f406dd7282 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -10,10 +10,13 @@ CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
+CONFIG_IPV6_SIT=y
+CONFIG_IPV6_TUNNEL=y
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
+CONFIG_NET_IPIP=y
 CONFIG_NETKIT=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_UDMABUF=y
diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
index bb675e3dac88..1b789fea8929 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -239,6 +239,9 @@ def main() -> None:
             ("vxlan_csum", "", "tx-udp_tnl-csum-segmentation", ("vxlan", "id 100 dstport 4789 udpcsum", ("4", "6"))),
             ("gre",        "4", "tx-gre-segmentation",         ("gre",   "", ("4", "6"))),
             ("gre",        "6", "tx-gre-segmentation",         ("ip6gre","", ("4", "6"))),
+            ("ip",         "6", "tx-ipxip6-segmentation",      ("ip6tnl","mode any", ("4", "6"))),
+            ("ip",         "4", "tx-ipxip4-segmentation",      ("sit","", ("6", ))),
+            ("ip",         "4", "tx-ipxip4-segmentation",      ("ipip","", ("4", ))),
         )
 
         cases = []

---
base-commit: 8415598365503ced2e3d019491b0a2756c85c494
change-id: 20260529-tso-tunnels-3fa1b9f07099

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


