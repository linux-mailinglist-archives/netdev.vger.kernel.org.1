Return-Path: <netdev+bounces-273036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMzVEDu1yWlO1gUAu9opvQ
	(envelope-from <netdev+bounces-273036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 01:26:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0730354689
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 01:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE046300C25D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 23:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A84366DB5;
	Sun, 29 Mar 2026 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SfvyeoRt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC612E62A4
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774826789; cv=none; b=Tp/TiMdPrOTToDLeuHpJJ5kvofc2vAY9nf21Wtb2Vwp8hS6PCdbURwQ0uToa04M/S/UFngafz7nyXisj0LLCtcINJnD2KB01+Uc3r1eswHbdjs2pg+mbmjHx7tF7BIL14lR0YVnksk87hKvjHlc2I5510Ei6yHLRymUPz7itCgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774826789; c=relaxed/simple;
	bh=OT1MSLt0jyIwCwanXRCg8XHd9yM0oIgBjYiuKiBfpa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvjnHdsUT0A2Fkdr2DLB1J5e5EA24mlzgaYwFv/MufeDaorQd8xeoibjqeNsf3e2ToMd1fflVhASxgz6WHia77qjJumn+pMVJvI8I5lRE5E/IgT4lO9QFJlwyCUM3Jc0ZN7G0FvzVsURQYMnQP1pJJwjvIynpF1HrF5Um34WnsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SfvyeoRt; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so63633a91.1
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774826787; x=1775431587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihhBGHTBAGFpvcur/rj4YS7YBXT2Xq6mNCrTSjO+nM4=;
        b=SbGiSRIo/pqybkLn8yYstXoNmwUiGdEMcWSEReyHyStm0KCJcE3fdy4yH+WqmOY2Xc
         ECz5KwhzXRItYt076zvZefo13SLHQ6GkbEXHhvZPpmzwcuObLil/qrAyYEosx7XdMjeH
         ooytotCfmY4MboUl2kVPbavs3BP2p0+geQTmNuOEV7Rf3ChPLnc+3G8gQLErba0hfj40
         xNEXrDgqA1G6PjJbnChM4wrJxlZOElENJy2SelO4D2cRwzutnyDlII1bCViB1TsGMU9F
         7XGW4By2CZoJYTE6FWn38jXXnOV2/15anlCx17O75vwcNQgQjk4eq5J7fhv7LBqRMiWL
         TXzg==
X-Gm-Message-State: AOJu0Yy4Cya2ZMpezLT5VpsLMSWMoFvS1oTnjNjCc7BbSbqRcYkY93it
	ZlyFFMhGVrfXkC8+4E8VSgRb70RefhHvfmV2K4PQTnxbKr5vqii42JG1xMqYSsviorCEJyJ3Hjp
	zLS+6rJ6+4/PObP59ZHkEzTUVXEchis7D0LrQXxKHW7a3q9BcyOQE4PkLgjlWIV5+fcw+uCWIYn
	PV8qDtoJuKbd38NesR0ePiXNIWCjIWHWq/oWiF3uzMNireYX1d5ro2FICYUwc/gTPbCFZaie56p
	FrehumCbIc=
X-Gm-Gg: ATEYQzxw3R480Eow6ULO9zhM0c7X0yPKVMjOOgoFG1H9ZH2IsusadXHBPdvaS16xuhV
	agDsN7lEF0VFgFLks2F5RG1Z1JFUKlPhCwr5xJHv8YcikoX6VHbnOmozG4f08JECvCCGid/4Zq/
	SLSv03PqAG1xnTVrFyrr0YbdJS2O6UORe6mykwEn2yBTKHzL1jk5KiGp+A9Z//MhMCXOhmpZtLL
	8aDPlEGn7usHdEz8j+S2VswtnszxZUrzTngPp3KSdXcnmXQSvB33bckHS/SeQHJs3VC5o7/OpeD
	2e+80tE6d7Se3FI3goQBOqhtx9ty1GPKj7MbrOrfsFe/6PR1RpxiARNmU3lU8KXpdsS/BQxZN0S
	bHabGXWQjLsromxoAxqPtEjSky7YL0por1pHFLNlJbbW6iUjCAUGoGBoz3GwfSzJGLFvHa6lbXN
	ktrcqW0PJ+Jy2ifbEr0uW0zJMMfk12l91zAjqdwx30O11T8vQlqn6FN+oj
X-Received: by 2002:a17:90b:38c6:b0:35b:a656:a60e with SMTP id 98e67ed59e1d1-35c2ff7a844mr9929406a91.10.1774826787103;
        Sun, 29 Mar 2026 16:26:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35d8d593dd6sm811437a91.2.2026.03.29.16.26.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2026 16:26:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50925fed647so129115261cf.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774826786; x=1775431586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihhBGHTBAGFpvcur/rj4YS7YBXT2Xq6mNCrTSjO+nM4=;
        b=SfvyeoRt3Thj//eLJFNUlxcSO9divcqLw03dK5xQ6O+pHUa1CTjTZxbNyKkS1KUQOh
         eXGHS8K1feqLYYObzczVUH9R90eP8/GyUMYBRFSzk+MGlJqsSGGlVrm9LXaUcc5lmlqN
         esyTtEaKTmGPeWY33UpvjvN95PN5OWlogLFL8=
X-Received: by 2002:a05:622a:1e08:b0:506:bde3:1dea with SMTP id d75a77b69052e-50ba395d2bdmr141516891cf.36.1774826785803;
        Sun, 29 Mar 2026 16:26:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1e08:b0:506:bde3:1dea with SMTP id d75a77b69052e-50ba395d2bdmr141516751cf.36.1774826785349;
        Sun, 29 Mar 2026 16:26:25 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb7729698sm41601531cf.29.2026.03.29.16.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 16:26:24 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 3/3] bnxt_en: Restore default stat ctxs for ULP when resource is available
Date: Sun, 29 Mar 2026 16:25:28 -0700
Message-ID: <20260329232528.870637-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260329232528.870637-1-michael.chan@broadcom.com>
References: <20260329232528.870637-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273036-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B0730354689
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

During resource reservation, if the L2 driver does not have enough
MSIX vectors to provide to the RoCE driver, it sets the stat ctxs for
ULP also to 0 so that we don't have to reserve it unnecessarily.

However, subsequently the user may reduce L2 rings thereby freeing up
some resources that the L2 driver can now earmark for RoCE. In this
case, the driver should restore the default ULP stat ctxs to make
sure that all RoCE resources are ready for use.

The RoCE driver may fail to initialize in this scenario without this
fix.

Fixes: d630624ebd70 ("bnxt_en: Utilize ulp client resources if RoCE is not registered")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f7be1084b775..5cef54f3d179 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8045,6 +8045,8 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 		ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 		if (!ulp_msix)
 			bnxt_set_ulp_stat_ctxs(bp, 0);
+		else
+			bnxt_set_dflt_ulp_stat_ctxs(bp);
 
 		if (ulp_msix > bp->ulp_num_msix_want)
 			ulp_msix = bp->ulp_num_msix_want;
-- 
2.51.0


