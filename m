Return-Path: <netdev+bounces-268300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGuLCfaEuGltfAEAu9opvQ
	(envelope-from <netdev+bounces-268300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:32:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD02B2A1849
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2525306776D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F73783B2;
	Mon, 16 Mar 2026 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU+4+DAK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078B3750AD
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700172; cv=none; b=ArDD2ZvRbBlX+3z/C/64GNHAbWCAJAu/PGVb7LkpVOmuzi+bdLNKzuVpx2FcjHOYBKJ0UNdT2ZxtZHXiadEWaLHuB8PcbHVzyg3VuepDp3KZeIhHmom7nuBbm+kb2guWSke42Hc6vb6nDGhbEsDWzsltKfRNCQ17y0yUP/jwEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700172; c=relaxed/simple;
	bh=QLmJCoIEgk7bY1Etv2KHuHMRxJlYbMdrmYRAb1O/174=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pFr7sarDE0kHDpBSBx4OXp91vvhYpbl1PbGsh/L8bCW3OBs09+LtD0HQreSSR3GMUHce9aJU6Qjy96HULondQMtwvegrMCHV9qIMhB81Axk6ici1UnbfDbhmQgdWruTLy6qtewS+tJJlKQf/q7yTv1jzQh3luf6OYbFPA4aEJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU+4+DAK; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-799001d73bdso38500787b3.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773700166; x=1774304966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGghREiBSn7MQCKj4TXr4KN+77lBvMCqoaCeBo9lJNY=;
        b=YU+4+DAKS0Xi1+S5LfgawBzAiOjfnQ1zadUoqKwnE3T0oo5zVn6j0chqDn4W514zX6
         IC7f0HDP/i5HIxgtJH44lVAe1THefFbTdXDB94DGKX2+FGi5NAjMUvYrDaMRocJfQ7Ua
         rcdkGczSUqXVgFN63quPo5fSowPBOzLFf4zUQWPv5eRYskXogfjkO+3ID5n+0ZciyBdU
         NWPflAKJ/hxEZjDKEn0p6zchzprqfIUm5EgK2kTqUmPG/ItIU5PGXMYYLa9JefgNsIQ4
         sbyMQdxlg8A5HK0E5Ku5Edg/z9DDrvH/95Yea0efpZ09SXHRBcAsw0uzfr1MvO1N4+4b
         uxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700166; x=1774304966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zGghREiBSn7MQCKj4TXr4KN+77lBvMCqoaCeBo9lJNY=;
        b=P8tnOGeewjbgpieIjbWu7qM23n7cSfden3THW/a5EzxTLWPWnBrcJJED0GOOjUFj5g
         MiGO+gF1lbqLTLsqWsEq7MyYcC4kWT0XnvbkkY0q651vmd9+IJx4tTmQGM/E5s3GM4eT
         88KFTnSOZRZld5OcYTXkgDN8cUdeiUZ8jVEz5G0lBZjqPj822vP76B3zDvIXYw9E8tAX
         kJjAbDM2dn22S0FfXeb1yX1sYgCJmVcWT8gqUeLHvmtNxqrUantxfQNEu7ZR2DYRKxUS
         UCTYLSKHkSbgutC9RMJLi4rNyn83dSLGCzumT3MkIhjcLFKt6WD5B27kxW6twljYVzvO
         5wcw==
X-Forwarded-Encrypted: i=1; AJvYcCXREDwl3CuaV4kxYlw5l0oCApbQGv9jGx+khL//Ug/590PbTgh0LLpYx/AGI+rMToJ2AMpcchQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0qyOKD5lnxCrfv6YcV0iZnk9lziYmSJuRF/npjfXRBCyxmpR
	yAW9hcHxS/AwHfQO4zZnF9loLJ2QN74Z8iTuXJrdj6lhd4q7vZVEVA+f
X-Gm-Gg: ATEYQzwwsLe54c0B9jWLMjrfpLOB0KVdCTneVUzzr9CXW6GoU4HwiTCC03WBlRGjooF
	xxpJzdkCzFudsUYgX5WYayuPudApNE60FHzxi1gKEn3yXdS8UqZ3nygDCXBUDkObzVNUeP6x5rw
	WnOdygfCVXsc9uJfsLMVXH+x9/tJtC8c1CNB1OUtEvPHoEtm1w222F/CiFXVeBldsji3uY4hRxa
	Zktzg7sNoTlvFE2UadjoYlbhcsvjbg8Z8bzhAZWtOW3bwyBJNqu4KNjIoA1ZVhF8JyHAGibnwe+
	u6g15EygCsJ9ko6P3x9ElLcp4evJsE4XbPHMO7Y/SgSgnVkpVlCCgOHmpGfkjmgKMru7zUcnt9q
	VMYS3Vy9NPymHn8Px2MvaoBb3r+NBLpzjbPK/BybTIdAOxTRRsQmO1S/WxPOE8SRCmp6eCxP6NM
	pdfCRvmsm5hrlmKpY3MRQL3Q==
X-Received: by 2002:a05:690c:f08:b0:796:6da9:bf97 with SMTP id 00721157ae682-79a1c1c002emr149829567b3.43.1773700165699;
        Mon, 16 Mar 2026 15:29:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917ee5757sm96813787b3.31.2026.03.16.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:29:25 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Mar 2026 15:29:17 -0700
Subject: [PATCH net-next 6/6] selftests: drv-net: add netkit devmem TX test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-6-b53c8cd72b23@meta.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
In-Reply-To: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>, 
 David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268300-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CD02B2A1849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

Extend the netkit devmem selftest with a TX test case. The TX path uses
the primary RX redirect BPF program to redirect traffic from the primary
netkit ingress to the physical NIC via bpf_redirect_neigh().

The actual TX path looks like the following:

 TX Path
 -------

 Netkit Guest (netns)     Netkit Host          Physical NIC          Remote
      |                       |                     |                    |
      |--- TCP send --------->|                     |                    |
                              |--- BPF redirect --->|                    |
                                                    |---- transmit ----->|
						   dmabuf

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 23 ++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
index 0a66ff85db9d..0e3c5aab6423 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
@@ -89,14 +89,33 @@ def test_devmem(cfg) -> None:
     ksft_eq(ncdevmem_rx.ret, 0)
 
 
+def test_devmem_tx(cfg) -> None:
+    """Test devmem TX: send from netkit guest, receive on remote."""
+    configure_nic(cfg)
+
+    socat = f"socat -U - TCP6-LISTEN:{cfg.port},reuseaddr"
+    tx_cmd = (f"ip netns exec {cfg.netns.name} bash -c"
+              f" 'echo test_devmem_tx | {cfg.bin_local}"
+              f" -f {cfg._nk_guest_ifname} -s {cfg.remote_addr_v['6']}"
+              f" -p {cfg.port} -t 0 -q 1 -n'")
+
+    with bkg(socat, host=cfg.remote, exit_wait=True) as receiver:
+        wait_port_listen(cfg.port, proto="tcp", host=cfg.remote)
+        cmd(tx_cmd, shell=True)
+
+    ksft_eq(receiver.ret, 0)
+    ksft_eq(receiver.stdout.strip(), "test_devmem_tx")
+
+
 def main() -> None:
     """Run netkit devmem tests."""
-    with NetDrvContEnv(__file__, rxqueues=2) as cfg:
+    with NetDrvContEnv(__file__, rxqueues=2,
+                       primary_rx_redirect=True) as cfg:
         cfg.bin_local = path.abspath(
             path.dirname(__file__) + "/ncdevmem"
         )
         cfg.port = rand_port()
-        ksft_run([test_devmem], args=(cfg,))
+        ksft_run([test_devmem, test_devmem_tx], args=(cfg,))
     ksft_exit()
 
 

-- 
2.52.0


