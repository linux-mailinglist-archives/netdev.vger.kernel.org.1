Return-Path: <netdev+bounces-290023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK3KHegZDmpT6AUAu9opvQ
	(envelope-from <netdev+bounces-290023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:30:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8A1599B4F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B03FD31F33A2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF323D6673;
	Wed, 20 May 2026 17:23:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86F36A376
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297819; cv=none; b=XKMQVBrMFX/g/Dp6FNI0klAvqbAjmdgIC8zFDF5KVT1yeanxCJcUAqjuiY4otIeXN3a14oYudP51rqRcFeTydBHPVKPM5WnIqfKwdTrG2WlXZ5kTS1Gzr0gHwfoPDCLMESfpD965cnzwMS9QHz8CKCQe+qElSlZ7hgcCJrpwjoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297819; c=relaxed/simple;
	bh=SPD46zMf+vaQ0dKfzawI5VFezCApZmoz9FyM0dieZKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sgkDB+6JbaZQ/ZMVDMbHMnk5NTykjCGjyXeR0em7UT6xJFiFBcoJxH/LSwiZkvPu2UZTt1rr6BQG1FGWhViyqwVHEPiKFcNrlzaHb4qcaxUxNlagu5mcGGdwT6anMZmCEK0U0ePvtJJzn9n0tfuq/6NIPiNtm5NmSVeGhw4k6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so4221683f8f.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297816; x=1779902616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIvRpJlug7n9+LmRFfk3DPM4edMme0ZuT6gdm05cYBg=;
        b=M/T+hB6iDJjx2r7QWFsITAGlOXF4y131TLdVZglR+5aKMtHzIRoealufomtlrpMD8E
         x3d/XfSQDfiy22lNLAo0ROyTXFfV7eCeAEjPxNGf028iRwzZu43QWA/xjCPk5ENB4rhW
         6IsaqDzJTdm9WO+uZ3bx4lhYnM1ZRhrn0Gr6sxiqls1a74hc5IczhXfPFzHSU3LingRS
         v1MFmJQxIkpeYh/HYDbNdPG7/+RwGuXypslAoUq/f3U2MLJ1gAckK5zlAZ3rMnAnmevv
         Ujp6JfQqAlK3LsuOeyoiwJLZSCbnWO5VSYDAyPYytuwlbXij+AbCz8DM/+cCPpv7OHJ/
         Zv+Q==
X-Gm-Message-State: AOJu0Yy/SLd/31992iqvlCxvQPqJ5doGkjHxtD9nR3MHv/HKpHOMOgHC
	zghaQrTPyMiR3MJjE0kKl/zyfl6PK1RTjL/BH1gJTgWpo6UX5hysEH8lOOrXCXNI
X-Gm-Gg: Acq92OH5HNfVgWLbWCFPYd754k2EZvBZb3F8n3vC72dVpKu4QjGcbwH91ln3AJ/5T95
	QOB7eLIj4yEfhRWR+0X0bf+t/2V60Cw7P4KpsmfVbjbDR26EBBngsfMerWgGQzpJ7bk3RoP/Wfp
	trvR53uC770xvyiy5NxVLiypl83PsGu4wuDywYnDIQ8dO0CaAcRF8P+4NiOTtM7YyYe4Fq1I1mw
	QWfDp/h97bwiVjdYUkOGNAxXF5ZGwTNO4pPDk3z0Nm2O7H0y5aVYkSPz4E6irFiQf8hl1VDVpFl
	i3gtctoSk7eWsbLBQiggVzLLeDmnQwsrTaoifNm5VlbwvPQ/z8cmkJR6HK3J1Lv5VTjtXQoTqyE
	GLRg94oLVVrF2oBO3/JIPTNXh3sLgTv5LoYvle/hqr4HvkNNNSyFXaMAPjEwZsmvbTtV8hXhcic
	/bnS1MXgpvdAYTCvuhmc8PF/Qy18I5a6qy53tWUCHSFjhs/Z4D2g/ITYsSzy0=
X-Received: by 2002:a05:6000:18a1:b0:43d:78ae:b785 with SMTP id ffacd0b85a97d-45ea0d89f66mr695485f8f.21.1779297815622;
        Wed, 20 May 2026 10:23:35 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm51125580f8f.26.2026.05.20.10.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:23:35 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Jiri Benc <jbenc@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matteo Perin <matteo.perin@canonical.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net v2 0/4] netlink: fixes for cross-namespace nsid reporting
Date: Wed, 20 May 2026 19:22:34 +0200
Message-ID: <20260520172317.175168-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[ovn.org];
	TAGGED_FROM(0.00)[bounces-290023-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,vger.kernel.org,canonical.com,ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ovn.org:mid]
X-Rspamd-Queue-Id: CE8A1599B4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While working on some new features for OVS and OVN we discovered that
self-referential NSIDs get unintentionally allocated in the system as
well as unexpectedly reported for local events on all-nsid listeners.

More details in the patches.  They change user-visible behavior, but
the current behavior is arguably a bug, as it makes it hard to use
all-nsid sockets without a decent amount of extra unrelated work of
tracking when new NSIDs are allocated for your local namespace.

Tests are added to check the expected behavior and YNL is extended to
support all-nsid sockets in the tests.


Version 2:
 - The RTM_GETLINK change is dropped for now as it is not suitable for net.
   A fix would require an opt-in flag.  [Jiri, Nicolas]
 - Added a fix for 'nsid_is_set' flag not being reset between sockets. [Sashiko]
 - Refactored the ynl code:
   * Moved recvmsg call into a separate method. [Jakub]
   * Added doc-string for the ntf_listen_all_nsid. [Jakub]
   * Mentioned it in the Notifications API section.

Version 1:
 - https://lore.kernel.org/netdev/20260515201937.2813983-1-i.maximets@ovn.org/


Ilya Maximets (4):
  net: netlink: fix sending unassigned nsid after assigned one
  net: netlink: don't set nsid on local notifications
  tools: ynl: support listening on all nsids
  selftests: net: add a test case for nsid in all nsid notifications

 net/netlink/af_netlink.c                  | 11 ++--
 tools/net/ynl/pyynl/lib/ynl.py            | 37 ++++++++++++--
 tools/testing/selftests/net/link_netns.py | 61 ++++++++++++++++++++++-
 3 files changed, 99 insertions(+), 10 deletions(-)

-- 
2.53.0


