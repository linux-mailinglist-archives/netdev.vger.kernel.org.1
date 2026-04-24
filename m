Return-Path: <netdev+bounces-280919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NLZmE7Ld6mkNFAAAu9opvQ
	(envelope-from <netdev+bounces-280919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:04:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B711C459475
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAAAA300A4C9
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B183191CA;
	Fri, 24 Apr 2026 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="eFBn2lKV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93D309EFC
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999855; cv=none; b=U5hFyrxtnVgdiM3xaAwavuqBSJnNJM3hjCW9hhv9VpDr33m1v6vfxUPmJkVj6Htw4wVMKSa1wQKFDTF0NP5tIBcQ8jZMLgtPm6U8pYYppcM3otMPx6tiLvSVZ+tXg7by01oIjgj5eOv9RvoMdbiAicLmJKvP4py9kWMJJ91F7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999855; c=relaxed/simple;
	bh=hwtjZPe3kNPIuozWzzhgCt7AfHLeFa0m1BfVNrT8+ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRElIzlVUy3wIRAenv8ojOq74/nke8UV7zwFzJmdK8J/EhvZPI4UJIo0dnOHVxYVWumW2rpjI9WTPLJbFP5zVIWF1x+LBK+AljAqMmhxRRTkxuBjZhDIDVNp8DchAZ4/ta2KXx8fBUc8a9naBLUX9v8/nJWL48hYDA/pHzElDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=eFBn2lKV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 73C4A3F9CE
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 03:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776999849;
	bh=fE6/Ks26kVTyFQ0eNTbStdq7kzWJK58GKRv4GCZ9rSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=eFBn2lKVreUFfWrnDbTwASagI0zYxXvEMBpF8AxQlaJDNqdlP+rsv+SFZxj7YV2qd
	 INlS3eI0SmTGc+jEiOc119bfWdVY75w/T3vzW4zk2UY2zmRoSVD1zbXpPq6R0GYbAS
	 toncHdfHEpo9F+kZwJvNucOe3uTpOgDuSG9N98Y/dSY3AhKgUb7eHzhw2pnCzTifbB
	 nE2phv8ey3gfrpbD8HPvPL5c5fx0MfKGJFkJXygqkUOgnQjvsAUz1KnjazX3zf5YKi
	 TuGt8FmFnNka7mbOaxgyqbl0yj1s9ZhIoZDlKCusppacNLC0qF2Cs08mLiIA8czdsr
	 Nlyu1SanV1MPAkRtW5tNiW8ioNszq5DsPL7y9F2wEN/mQ1P4jwOTREsc+VtTQBg3+/
	 NN8v6eT8dJnBDVe9+bcB9w4qSdLLTU00KxJjR6gGQ+sHnnfecgW9t7YtMMYzJm/Hur
	 IpYG3LHizyd7KgRyTj8fxwm62Qcb9jmMHnwO6OYCLVdpPMdoDbjwOv+HbSY4xkD7la
	 gaddGyugrtVDk8AeKdUWLRR9MaiRXVtXqMjRHlGtMXECmSBV5CW+1Ufu6Lck0s/Esj
	 /f3X5Jj6ymbQQoZz4cI+pl+6nivpQ0jehqNsaLGH1L1Ay50EvRRVi6VFk2DtWDGi+w
	 NysMQ3q6HDnXiKxQkFaOH3YM=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aad5fec175so103737975ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999848; x=1777604648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE6/Ks26kVTyFQ0eNTbStdq7kzWJK58GKRv4GCZ9rSE=;
        b=R7rF1rf6MIeqawc9ylDzen+6HMxMP7uknwrraTnlO8sdj2GqCuPeK3K2q2p8YQ8pf+
         /fvHKYTuydg9oMBDgre6gFh7y38RNGSTlloVaLraqrgCtWJn/HNSgSOMieo3kFOolK+v
         paNpOs4wg/TEGcChUIebzT2s6z0ZVYm0gQ4IPHypao148G8d5gjb/yEy4LCYrbnUB61L
         bDSZjMHTKaXge0o8gybWwIMfztnsuNLOiNlBpFAfMMBgcpTpqUX+qblB6JhX0Fqutwy3
         WxYOTYBGQsbYoQ2i5LTtLJ+RvPqXwYcTFNCdKHgr4VxmjIBH5szLE4XIEWuhs5UM53fT
         nJEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dV3Uq7rgymFKFFo9mb9oFpRBMBh+4uTpo9cvvJ0953ZSNYQxYpXVs5uvCirvjQJWAhfn0obM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysj6vH0pg3QikpNGNmBb5HyFr61WEbW0ClFXz/eAiFdOW9TFXQ
	PWPRDTCoIHJmgtE6CKUlwQQLw6FPqMkHcFtXUsMiAaGfmcsx/P23ihDInAfwENjqzWV2V76ORgH
	Qy0JVJAiNaTbqQ3tDL9Vt5/ORr8ebqqY32WgwZZ8IkxYOfFUsTuwrWwfSZAczUX/lJW5jvNJOlw
	==
X-Gm-Gg: AeBDieuHO3ZfU3cT+X+Z9Lh4BcGx3nC3EIuUt9Lbbd4xDhNbS4vvGliNZI+USjeXpTX
	TYAfFYebqBwTk/kpdl34JyrEYKxyo0L+u2XRakjyeYOh90qzkLDHZQd1lNyGMvzHZbU5ZmvUsHO
	FjUEVoGAeodRj80DKhk5Wm7UWUCd+RTSIubxFs0mpZqjcjk2O1uojlJQcUCy7GY97emNFzHarDj
	BUBcr0Ug3i86k6TWz3CPBAwwYDDNhF3v8Eiao8Bc6emDxzgrPQdKyfepc6st8boUSoqzVVxB5ZO
	3BJwY6mZEN8Rw8J5yDRTzRaWlNoy9Uwrip5ztDHhLlyxB4Tcm6T82CmJHikscZz2mU2RNNnnn1s
	/W1GqiLJ9xGkcNBqyvfjOwmtZb+IRZhLWJyFcJUbzGAV0ixYo
X-Received: by 2002:a17:902:ffce:b0:2b7:ade8:2407 with SMTP id d9443c01a7336-2b7ade826f8mr55540175ad.19.1776999848129;
        Thu, 23 Apr 2026 20:04:08 -0700 (PDT)
X-Received: by 2002:a17:902:ffce:b0:2b7:ade8:2407 with SMTP id d9443c01a7336-2b7ade826f8mr55539845ad.19.1776999847810;
        Thu, 23 Apr 2026 20:04:07 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm206428625ad.40.2026.04.23.20.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 20:04:07 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v2] ice: wait for reset completion in ice_resume()
Date: Fri, 24 Apr 2026 11:03:45 +0800
Message-ID: <20260424030345.1140665-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B711C459475
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280919-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron.ma@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:email,canonical.com:dkim,canonical.com:mid]

ice_resume() schedules an asynchronous PF reset and returns
immediately. The reset runs later in ice_service_task(). If
userspace tries to bring up the net device before the reset
finishes, ice_open() fails with -EBUSY:

  ice_resume()
    ice_schedule_reset()          # sets ICE_PFR_REQ, returns
  ...
  ice_open()
    ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
  ...
  ice_service_task()
    ice_do_reset()
      ice_rebuild()               # clears ICE_PFR_REQ, too late

Reproduced on E800 series NICs during suspend/resume with irdma
enabled, where the aux device probe widens the race window.

Wait for the reset to complete before returning from ice_resume().

Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
v2: reword comment to clarify best-effort semantics (Kohei Enju)

 drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5f92377d4dfc2..a81eb21ea87c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5635,6 +5635,15 @@ static int ice_resume(struct device *dev)
 	/* Restart the service task */
 	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
 
+	/* Best-effort wait for the scheduled reset to finish so that the
+	 * device is operational before returning. Without this, userspace
+	 * (e.g. NetworkManager) may try to open the net device while the
+	 * asynchronous reset is still in progress, hitting -EBUSY.
+	 */
+	ret = ice_wait_for_reset(pf, 10 * HZ);
+	if (ret)
+		dev_err(dev, "Wait for reset failed during resume: %d\n", ret);
+
 	return 0;
 }
 
-- 
2.43.0


