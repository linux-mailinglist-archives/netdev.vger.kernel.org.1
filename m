Return-Path: <netdev+bounces-270011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHoqNPaOvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:16:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD0E2DF432
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797BA303A27D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B4A3DEFF2;
	Fri, 20 Mar 2026 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMfcQs6N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111583DEFE0
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030124; cv=none; b=JUTHSxxtocidCeVsUxq8Mccs7jIJdPjKAeHQQ7UBImsHmEQLKFwRXEnrbFrRtG6QrZE4UEij2iq6zhf34CITdK0dUHfItFahEwsnCPTpGP73i0oQN8lzPiU1DZmf0v2jjiRx7eyNfT/D5xtjUSslRZ6XEosJ+dZGZ9TYxWcf0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030124; c=relaxed/simple;
	bh=eQxUX+gzWlFkaXDdfeVXpeBJ0sPtMwm28h+c2N4MDbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C05Q9WRkJvVhRBgYwW2GdB2h+XXDRBtxMmz4Nq5dKHGiDEY2A/QOuljGMaXMosp9ScsKcIaZ/r+y31qQtkNECPsMjhKvm8GHL/zn9c/aLYyDQSZQqPBEc/CWd8JGom+hs0F73a2rd5n8lnA8Jq4WgW5zgID3MkGJ6BySjyEchNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMfcQs6N; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-799001d73bdso19096497b3.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 11:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030122; x=1774634922; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HxIcwAjT3BNXjqO4kOjoOrvW9GUI+JCw0ZolV134BA=;
        b=ZMfcQs6NCcX0MjYvyPXucuyoO6ikjNqC0HIuX2wvj3gUMK8gBnzNnkULeC+l8fe55T
         lN5dITPvosdwlPhGqi0ePi819CWvXIOVJK8VYS9xPTA9aXj8nnzLAjJjEaMx6K8W6j6a
         nd/IIuLZsx9s8rP2BGTHHNSSRQRhVMky32zmim9vHHSIOSUYWcoWIJYTvdFOUiauIfAB
         tUoO6Gz5IEMNKIeQ1xgeNQA+PwwX8BGtxfh1+58MYOmRl2/oDI5m7OaUcGtmfC7GbNGI
         v+W1JmadLQVesgjcoL7ccjDAg7McOfuI5bkRNBp4hRua8lA0oCTjzsyybTIeDdXJSb1b
         6Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030122; x=1774634922;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HxIcwAjT3BNXjqO4kOjoOrvW9GUI+JCw0ZolV134BA=;
        b=JL+/vwXSkyh3Uxy7zAMS2Xw6PEpgvFxHt5NXi/K+lcrZKBxIyA1QPJ0lkdz1GR0jEc
         a0iHrOSZR0mjsx+bGDVUmUlz+JH05rKohWuzydgLwplzFOOu2dpRTmBU4R8g77vSZAPe
         MLowomSttnFgZu+zRoASAkfdjCgbjZ7PR+bwBBUNwA0C33XUnsAiL+i3GCkdAVwqK9NX
         +FSdjMUctwy0rW24wTGqPs0r2YX3zpG9HIPU/lJ+ZaFA9daAeOdiPZ/sUH4A5qyb1Rd5
         KyIx0RTHB4FaZ1gyur/qKA8yVBB2yBpLcckdeINTinRcEfiQf4+QXfvBDDlM0MBesiyx
         idwQ==
X-Gm-Message-State: AOJu0YytdN6pqMAdcBvoOU/W1A+yM+eoMC+9vdI+YTBo3zBbVuiknvbC
	dXUmIRs2aK0rSZM7VzTX9b0NWH4DrKsRBhRpr+QOuxs2kmXokjwlUsmX
X-Gm-Gg: ATEYQzy/jB7fvvkfkxeGyCO1C4W+hUnCTLa63rN5kHhUotjNKlbGT+2oPXbyRLp2qEe
	9w5wGlhzN6SMSc6eqaVrvNASvJEdWCti0uj+QORsvbGTNqB6fZsTDRtm+CwKuXsmmW51GlHxFTn
	eykl7QOG3+yOeRAz2sqcfXfVaLQpbmKXZEZ3lTkYBYFyWHBFntFCmeOjqBA9F8pzsCMeZ++Qi3J
	JjPixCEQ7ogILtfYI4hNutrgSbVnE+R3xC90BU3WiMITi/pXYowaEAKPDKXX1VpVbnxf6x7NwUh
	AqvLvT13W91Tmhl2HKV9AezEYAD3hiEtH+qvxx4qw8KdtvvQHDlLil03h0raNra3aDpwaPmr/MJ
	jz2qOH+AqKe0LwkzkOxgtcEZJYt+CEGKkmokLsrMGRt9DtD/qBcEk1YHZpOWBvpHFXFMxktWj56
	Ts0MV8WxOOftSnd8hmL3JgiQ==
X-Received: by 2002:a05:690c:385:b0:799:2b4c:1d49 with SMTP id 00721157ae682-79a90bc7e4amr37281837b3.36.1774030122081;
        Fri, 20 Mar 2026 11:08:42 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903a3473sm19822147b3.1.2026.03.20.11.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:08:41 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 20 Mar 2026 11:08:35 -0700
Subject: [PATCH net] selftests: drv-net: add missing tc config options for
 netkit tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-config-fixes-for-nk-tests-v1-1-1e20ec6ddc7e@meta.com>
X-B4-Tracking: v=1; b=H4sIACONvWkC/x3KQQrCMBAF0KsMf92BGGsDuYq40GZSB2EimSBC6
 d0F3/rtcOkqjkw7unzUtRkynSbC+rzbJqwFmRBDXMI5Bl6bVd246leca+tsLx7iw3mZS0qPdJl
 TqZgI7y7/hUxXmAzcjuMHBvtodHAAAAA=
X-Change-ID: 20260320-config-fixes-for-nk-tests-64d77b7547df
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270011-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: 3FD0E2DF432
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

The NetDrvContEnv env context uses tc clsact qdiscs and BPF tc filters
for traffic redirection, but the kernel config options are missing from
the selftests config.

Without them, the tc qdisc installation trips on:

  CMD: tc qdisc add dev enp1s0 clsact
    EXIT: 2
    STDERR: Error: Specified qdisc kind is unknown.

  net.lib.py.utils.CmdExitFailure: Command failed

Add CONFIG_NET_CLS_ACT and CONFIG_NET_SCH_INGRESS to enable these tc
options.

Fixes: 3f74d5bb807e ("selftests/net: Add env for container based tests")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index 235c0a1cd21e..dd50cb8a7911 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -6,9 +6,11 @@ CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
+CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NETKIT=y
+CONFIG_NET_SCH_INGRESS=y
 CONFIG_UDMABUF=y
 CONFIG_VXLAN=y

---
base-commit: edab1ca5ec6fffecbf340e26956ce73e502901d5
change-id: 20260320-config-fixes-for-nk-tests-64d77b7547df

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


