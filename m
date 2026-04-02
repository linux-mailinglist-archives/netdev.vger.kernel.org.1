Return-Path: <netdev+bounces-274330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJxlOO/XzWmOiQYAu9opvQ
	(envelope-from <netdev+bounces-274330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:43:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF2E382CBD
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D468304519E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82173126D6;
	Thu,  2 Apr 2026 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="qdN9SLrm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10119EED3
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097835; cv=none; b=LPW0rkFQJDG+SoGd3cilPO/GPOIZnJb/qyZTvf7CsZ4qsQ1pGWDVCsx93OK32pMVayuMfwytjOEopsT0Wn4bTL+0opPCHMDZxcOGwBSuC0XAc0sAukVnoCHCmcQfKKc83tlEnP3GMSPSkiurR7KHwUjyW7NwML4AnPDy+NafUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097835; c=relaxed/simple;
	bh=Y0UG1OsLycTx+bVH/SpiZBs1sBMufl393V7tywTjRWE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HkZofdQ9e2Hn+iggYkQf7CySEnEL2geHlKQiAgbEUgsZVZnMdEvaNx4+EMN2fl9o32lnBbKGuAma7yGi02gTZ4JBqUrHBO04WvHjUglvDmINdJRVfL3d0NicaDMQf+gTcb+d69TdIRe+DR5Gi5eY2a8oh0QLLrvWTsaTW6Asj94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=qdN9SLrm; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 18FD03F613
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 02:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1775097825;
	bh=XFomWPLR4XXzI7Zj27H5KA+iS+Ba7CQLfQ7lYNFWxMY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qdN9SLrmNsk3b5YmJhT6gpKm78K+c6JmqGN2pEDe4JhNa+uKHARRNcQkDL+mPzj15
	 jUZ6S1Qquzsm+1eq7r4RsKxHIysGm6DfhCGE8ZMwhnEuDVuA22hZw4imxdXCzkoXpF
	 4SqiybD3z+cKX7aZXbznfR2+V9HMC0xdsQnJhn40cEpWKKkDbqtuZiqCUnsbPkefFd
	 yNEOdt+IHJ7vBa2YZ87a85XKq24OXNWCyBnmcr1f7K3TzEGMqBCE+XKV45y8RB7d/t
	 QpY3r3ss01NZmoJB2i1UdUFQVBaeURpLgtqqcuLFL+r8k1qCGWUG5P1UK+y8257F5x
	 xX4fWMAj6P4ePwy3F3eAMVnz2QH6ouTnlIkdwzmm2eXSfLqAk8JgrghNd/JosNEFMh
	 vAmiSYmOf0nOCWjE56NlzKJvt1IRBLkBrmdkb0pozweOnU6WUpWzp4UTOkOchJjTZq
	 R+LPdVln/tAtKXCPBTXu7MsfM11/CsWHSXHBMb1u1eLchCs17naHt+WigrEVTSnhyk
	 FolK2nAGJP//8Tv9ANvw2ej8EaIXDUQQwoWp+B4HGs+LugDrGM6ZQRP/j84fkruJuY
	 uA5mThpCwyt7KozwB+Fj6mz05mOPj3euTvVg6Ks317q3fV8Z0iEMhPwPq8a6sPOJCg
	 FVvVUOd693ESGuF2ZA5Yeg/o=
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82a77f807e4so570904b3a.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 19:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775097824; x=1775702624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFomWPLR4XXzI7Zj27H5KA+iS+Ba7CQLfQ7lYNFWxMY=;
        b=dBZLEGdyDOMJ/vqm1vZizZTiB4a7RNwyqcwq8GJ3QOh4jUCowXRGhcWMsc0bWPyw/a
         63NvuAUMXFXR1QjTMgncmdfUPHmUwEJFay19i+dyeLL7tUTP5Kta1U/sMLoNXLtE6bBs
         vOkypruvF5fOWyN0EqgnlhlV6achsUuJWyE5D6amrXZlMrGu+7w/nuFuGtpW9JTh36f4
         6B2UXpYObfbWWG8lKCfkHqRnHeb7snHLVL88Oh03acxhyXcRsUMRkBwjkn/61H7f9mxJ
         z7rDidcXeAyGO5M/IXM4OcLAoRkifc+Cy8W+1YWAdZwtyapkkD5VAzAjZewg2YbUFAfF
         O9ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8sKO/eaAnVuYLX0bUzB0hthO5JvFrIg3HlDscHrYcxY1aHR3cykRAK9aiiafcfcmitLmMxVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUpjYfLQcxa4wxCh7vasIhcqChmYICM02kyYYjCMFGPebawLB
	Gt9jE9snr66hXkWBYXsylkMXywj1toOVMi9R3PnB6zVpAFaHiBsL9KOJmnPTSpbtBGyZKb6eEVX
	D3C05npjEwH8uyfR/1i5yIBXyzGucvQhJZVbLXaIuIF8RlLr17wmQ2/IpJ1v2ZKzssmrCLfbdeg
	==
X-Gm-Gg: ATEYQzwcs7sCenodzx9+crGgFS3haSYoUvV+mn5rJeuJ1KuqouIF9uARnHm5Y4JQKqc
	3lhcviyQUx4aQMdpHMLD+fAYMDv+ciTnHtSISst7RpRVcVcTtfbENYKhyqoTu8x4GkAsB+sTp79
	1MvBS20MysqI7Ds24pVzQIAaCQAcCsS8AuUpF1EyjqJOEbVWxD9Pg4gRucA6LPkKUWRe40oqcfo
	YLrT1oFc0LxV/+42hJATQTQgCi9Zz2K95I6bmpcOz/dPOcsYkekvIrVNDkLKL1MtpEiE8vXIcZY
	XvEVIHTAS4Ve3Lj+OkOuQhagXKmNkvDFkL3H/g6mMYI24k1xtvL2VNaUS0o6DRFqoK5wVaaWvIx
	POXaf+BLjC7En0nXPd9R1rPs6HaddoWeOMrVdhw==
X-Received: by 2002:a05:6a00:b86:b0:82c:ef0e:a547 with SMTP id d2e1a72fcca58-82cfb95ec55mr1766659b3a.48.1775097823740;
        Wed, 01 Apr 2026 19:43:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:b86:b0:82c:ef0e:a547 with SMTP id d2e1a72fcca58-82cfb95ec55mr1766640b3a.48.1775097823370;
        Wed, 01 Apr 2026 19:43:43 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3d439sm1293798b3a.35.2026.04.01.19.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 19:43:43 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ice: wait for reset completion in ice_resume()
Date: Thu,  2 Apr 2026 10:42:20 +0800
Message-ID: <20260402024220.210466-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274330-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron.ma@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AF2E382CBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3c36e3641b9e9..a029c247510fd 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5702,6 +5702,16 @@ static int ice_resume(struct device *dev)
 	/* Restart the service task */
 	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
 
+	/* Wait for the scheduled reset to finish so that the device is fully
+	 * operational before returning. Without this, userspace (e.g.
+	 * NetworkManager) may try to open the net device while the
+	 * asynchronous reset and rebuild is still in progress, resulting in
+	 * "can't open net device while reset is in progress" errors.
+	 */
+	ret = ice_wait_for_reset(pf, 10 * HZ);
+	if (ret)
+		dev_err(dev, "Wait for reset failed during resume: %d\n", ret);
+
 	return 0;
 }
 
-- 
2.43.0


