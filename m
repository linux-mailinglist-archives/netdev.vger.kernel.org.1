Return-Path: <netdev+bounces-252522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEQpFXN/cmlElgAAu9opvQ
	(envelope-from <netdev+bounces-252522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:50:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C892F6D432
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9B80300E179
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93D0346A04;
	Thu, 22 Jan 2026 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CLcLevqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A85364E8B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111407; cv=none; b=cz2miTSD5Oro6e13Q2rtf86tnoQyeWMVJ8UK8h9Orf4cxKhcnrnHCj5RvKKtwJXLwVJ6etEt+hDT8DAAdbNYndQXKpZvnooVCUpS/9Ff4ly09tOUGY5Xe3uj/z7z31URc47YCpAG+OdXaIheSI2vEFG3Oe/s7GaOHaKlQo4M1Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111407; c=relaxed/simple;
	bh=/fNroAEUWq2iYeOpNR1xUJwToHDQ6vZYkKlyRA9xQvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NhfGQdo8crFPQLQvwmO3Z4wkCzcQmFpEFq5kdyIaxWIUEO7k3G5RtcSGrbTsnDPIrkJsksvn4LRIpCdDBVnNYTQm+HMcbVWpiZmoUQrGbBbkcp7w6S8YAEE/w3J3OEOYCEn4GlWhkfWFSUxqgJjVYduHWRr/WsgTdgaxhM4FEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CLcLevqz; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-502a98c66f7so10817491cf.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769111399; x=1769716199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfJXXPUY+NfJ9Oswk/RO8+xpXIHMaqyVnQgW6Sottwg=;
        b=J+VghPrpA3M+B6tbBpjtcVbhZcHoZsxzTbOi3oDFPDvNPfutfreiNuGfupBD9hxGRF
         Sv03Z8wGWu0eA1Hqj4leBsYOHG7hKBleLe2j/JNMW2fZuOEzX3F7rVBL3Kdn+KkhyCcH
         N9/kW6LUQ1xah+jaO1C4i2pbF/3mMsI9dPdh5OtjZGmXw5jbSoLHkYFx4T+Xt6YbaMuF
         uW0hnuUt6YDtvhHukaGukp84DAbSvHjNTPs+FPdWANN0pq6TYKX8sLbX9V/y8si/xBPS
         M+EhSbfOAYQlz6po2ukIv3wcbHQLKcKw5AShgyyd/iX9j3zef3wa/zzmY7L4cJTeVC2W
         axow==
X-Gm-Message-State: AOJu0YztuGbtxUiUTRHzDQGIYcfEebOmqZv/Pu9+bG5r+4MUW0ovfy47
	PKSYCBpzV+A993rxt7sa48fNVZdEaZn5o/2WUTgjvymD8ZKOUY3XJnReAgz7UV6O3x2XJTb4tE5
	K1WN8P/M7A75vbvAQjBj2sK7DAn4ESZtRcsDiTdg0aJUwgGxgyZ6P5vkae7ix039R/H2RJl6cYZ
	O3/y0R/aQc/ZOoHpyfOVwv8nTT42bKFshPXaJOkea2Kupdqik2nnQ/kMWnQ7Q+J0DPsAvOqByat
	gx3jUoaiA==
X-Gm-Gg: AZuq6aLLKcFcJIkOsb78/D+Wps+rlZava2tKo6Rb7BDagVRqU7UvlA4Z8pfRZIO7LF2
	jXQp8C9YlzYxvTVw7yIHggnN08iW+7uW8vy2LT9FancB5HULo+BwxRS27WY/wOjjXxY5UUtzPdh
	pfNoWeEc+slVLfw5f7MrW2nNFNr1Y4RSleS6pDBPUQy1ja1KMG0lKJB0Q3lAOtI4T9eTSK0Tj9q
	xTUwwSpu2pUQAkYBwrIACtRMxkGxk0H4Lv3UA/PPur7zqnxjVNWYMAv6BVz/nGUhTts6sNAKV/R
	T9LJUD/SGBmOvNtq/6hFoHW80NVHthx7UNzWyGwW9d55v3P+5q9Xh8ib3fEIakfgCb3ryLoJkYL
	evhCmiwIMH+gw1TR1wQbbRI5lZYbas+03h10l26wsTZO3iUpqVQXk8rrb/8YuyhQiUERuZSsNgy
	rU0O/yoR4vjq5YXxcuwSvqkMkXKNelii1S29DNFW9YCnHjGQ==
X-Received: by 2002:a05:622a:58e:b0:4ee:1d0c:15e8 with SMTP id d75a77b69052e-502f781c711mr10824511cf.74.1769111398657;
        Thu, 22 Jan 2026 11:49:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8949189d12asm218256d6.30.2026.01.22.11.49.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2026 11:49:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-65f30d38617so2610097eaf.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769111397; x=1769716197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfJXXPUY+NfJ9Oswk/RO8+xpXIHMaqyVnQgW6Sottwg=;
        b=CLcLevqzVKrkt0TTMCjUDCzbgpR6dVOkO0wLMKfmO5Rk7lyLMU0ucqquvsa9Cs+qNP
         5lnrSfdiqRLoP7z6J1AFsUNzynNWENEVjPm7PGmuVfT/V0HSmFwDYmwBuH7dVFCKXFbb
         xPwKzmhExM2TYQ8FT4mTmQHh5wNrsjMKUe6FM=
X-Received: by 2002:a05:6820:82b:b0:661:1c97:9560 with SMTP id 006d021491bc7-662cabc80fbmr406025eaf.80.1769111397506;
        Thu, 22 Jan 2026 11:49:57 -0800 (PST)
X-Received: by 2002:a05:6820:82b:b0:661:1c97:9560 with SMTP id 006d021491bc7-662cabc80fbmr406005eaf.80.1769111396844;
        Thu, 22 Jan 2026 11:49:56 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af88f200sm86671fac.7.2026.01.22.11.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:49:56 -0800 (PST)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v3 0/2] code clean up
Date: Thu, 22 Jan 2026 11:49:47 -0800
Message-Id: <20260122194949.1145107-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252522-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C892F6D432
X-Rspamd-Action: no action

Clean up and streamlined some code that is no longer needed due to
older HW support being dropped.

v2:
Dropped a bug fix patch and sent to net instead so that it can be
backported to stable.

v3:
Extracted the early exit leak bug and sent to net instead.

Justin Chen (2):
  net: bcmasp: clean up some legacy logic
  net: bcmasp: streamline early exit in probe

 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 32 +++++-----
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 36 ------------
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 58 ++++---------------
 3 files changed, 24 insertions(+), 102 deletions(-)

-- 
2.34.1


