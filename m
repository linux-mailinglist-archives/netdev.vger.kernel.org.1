Return-Path: <netdev+bounces-252535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GElJCp+NcmlJmAAAu9opvQ
	(envelope-from <netdev+bounces-252535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:50:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 515716D8CC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 077333007AE0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F933994A0;
	Thu, 22 Jan 2026 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EfXemUnU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63BF3A5C1C
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115035; cv=none; b=lDk2KE3wSvk4zNvB1IanFJVd7r0Yv4wXLc1nNBZvGxXil6YMs3PsahA7h5MoJ1As6W65m01vCAmr2slLs+dW9c5w0eOx8Y3dFzA3LwpnjXIUUXOpVIjaA9jFbxXat8JpckuvTCBOvRGuv9GCO3rwb0Q3IN97FqbkrXBL43BjzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115035; c=relaxed/simple;
	bh=hMFePM22Q/D5j2jqVz30eL1pTcy0sBuRIblhBrwlrJk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QRy74gD+72qD3cf4OZqnlmRMx/zzp9xHMT5iUX5Pux364KiPxsJ/MIwQntGz785lR/caJ/tF1M4tjpG06PLSoCnRnUAm8731i5W1oWbTX+sG7gzljrUalqmjZdoycB5XFWgEqMPkONICsp0/BIr4sRf9jQdyMVmcIlYwHkDnL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EfXemUnU; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a09757004cso13497345ad.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769115027; x=1769719827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eOcvoVMH73kwUWaEg2Uh4CswapfzD3PM9GIt4HKH3Fc=;
        b=E2rOkXJQ8gOQVS+5NuBZgOy5y+KhvF/WPgEZ+CwDMXSCwkd9s8NF7nkrFG+PGIBQn7
         St1sVgVy71wE8DFgo7DbjPzfLha73Hcf4r+4q2js/AarIffiRsD4HD2MdDoF6XHQiyxv
         Y/HG5le2tz629t+B1g4cVxEOVTDCPA57ozpgBov5huezXjJc7BL0j3zz60dIFnBIF9YE
         ubVxlLoaxJ4eloAp58tKWLAZ1VNc5OkCpAD8rLsT3bTtQc9idSg3MxCPsssuYDZ/NbnF
         4zWfx6Rpq2bwIi5O/SYFXsNoaucVFm8KAVffqZy+Pb4MUE/pnfTroa1iZttWUJpaQPbD
         sHyg==
X-Gm-Message-State: AOJu0YyOQfrCnu9t3RUX16Stdn+IhJH+UJ43VqGvTPVV+5qa8LbIgT3b
	NtqkHrXR+d+Ct9l/GlkRGSSJxsSHq4AmwC5xlk26sVNOWJLJp4IZXoWnSeN6thRAYZjmELOnRNQ
	MC3D3Xx7vm5RfdwzgOhaffhFv1YDAw9hURVmRR+c/vW8Kh7PBXuKPDp71IVtg+RvvwTvxJp3TEt
	+hdsF/P53ai3CrYfQisXnzsvh6cgbH7GlE4+pNRYCF2V4B8/IGEFVltnbLdUvcwDTvYOLotbuY9
	6qQOj1kIwq8
X-Gm-Gg: AZuq6aLGsLHlUWFMS6fR68w6iuhPtzbD5I/7NqnggcCoFQAlzyWnjHXWdogasxZ6UxG
	QPsofjajmxOviPqm6noo65jSa8fAxeCy7r8+T3n0pC6A/eJqXJ3PomvstKTDGXxNHk20Cwik0BW
	ZHUtlz8z1LWlWuZJRbVrt8Xhl9UvnZriiY1uHhgXXG1PVcpGBR43XNCpgmV4XXYrhlWD/XdYEBd
	GjKWUAkKxJ8+q0HtgW+sIQI1ZaVu+ogTXl6V2htH7Hrz/ftfsvc0NgJOV+j2TwmkGprDDRrftJ6
	UJ8F0YBS2s8ijS0RMfY/fVbJwnO1//34mSfmZqUKQPkN2XIMiVZ0V2iBOpLQhkqy/y3PO9wtdVZ
	COda90Apd1ZjhJc+tnel8MPlijjCKNn9yS1KcRZJFd2I5N1AEg2Sj2S/F61vtoRdPvRxaWDrNJg
	GqfpL/CmJMKphelsC04/g3EGHQahrDIwblYKnWFXndpqc=
X-Received: by 2002:a17:902:d2cc:b0:2a0:9e9d:e8cf with SMTP id d9443c01a7336-2a7fe7559f2mr5836055ad.57.1769115027587;
        Thu, 22 Jan 2026 12:50:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a802da476dsm211745ad.12.2026.01.22.12.50.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2026 12:50:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-11b94abc09dso2189327c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769115026; x=1769719826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eOcvoVMH73kwUWaEg2Uh4CswapfzD3PM9GIt4HKH3Fc=;
        b=EfXemUnUzcoxnvRdhqUqM7JsmGAVBJk6V6yPVthYe/3aZ3STYrEBRIXwLE37fFgBYE
         yyjEz68ExSjr+U3Sl2BamK0q1PWPMEvUpQXzHy46vPrxu3eIrzki7PweR2HOsyZLG1By
         ToYzNqL4ljBGunCXVYdS3hkgK6xSiUmIByJtA=
X-Received: by 2002:a05:7022:f97:b0:122:1d4:28ff with SMTP id a92af1059eb24-1247dbf4e69mr306576c88.26.1769115025673;
        Thu, 22 Jan 2026 12:50:25 -0800 (PST)
X-Received: by 2002:a05:7022:f97:b0:122:1d4:28ff with SMTP id a92af1059eb24-1247dbf4e69mr306564c88.26.1769115025011;
        Thu, 22 Jan 2026 12:50:25 -0800 (PST)
Received: from localhost.localdomain ([136.52.21.78])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247dba0135sm994947c88.17.2026.01.22.12.50.24
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 12:50:24 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: netdev@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update be2net maintainers
Date: Thu, 22 Jan 2026 12:50:20 -0800
Message-Id: <20260122205020.26743-1-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-252535-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ajit.khaparde@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,emulex.com:url];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 515716D8CC
X-Rspamd-Action: no action

Remove Somnath Kotur from maintainers for be2net driver.

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92768bceb929..2d76be8d48ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9256,7 +9256,6 @@ F:	drivers/scsi/be2iscsi/
 EMULEX 10Gbps NIC BE2, BE3-R, Lancer, Skyhawk-R DRIVER (be2net)
 M:	Ajit Khaparde <ajit.khaparde@broadcom.com>
 M:	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
-M:	Somnath Kotur <somnath.kotur@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.emulex.com
-- 
2.39.5 (Apple Git-154)


