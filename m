Return-Path: <netdev+bounces-277320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHC7DuPO2GngiQgAu9opvQ
	(envelope-from <netdev+bounces-277320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:20:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF0F3D595B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 194E2306E5DB
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC473A5E75;
	Fri, 10 Apr 2026 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zgy/Uwjd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DDC3A4536
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815969; cv=none; b=FcqUCpoM9wPzKizV09QLMvr0Yi6NEkLUfGGF7lRUP4i+k3T7nrYiTKV+qmOQVDn4OKX2YAkVX8X++dmILdgeVHN5b43P240rtAAKo+PL56ZtJECApSjPskVkkQMmy45dvG3yqin0CIA3W1+yNkyb2jO6bQ0R7/R2AqOZIEVF4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815969; c=relaxed/simple;
	bh=4nwKbhlnEEdwFpaQ7XRBJVCSxjtRqfAd5IDRJwFnqM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tf7fImX5ln8oShDQxUyeYn0v2eJlIqlCS/JQZnu+NyupkWh+YnwnF9EagGurwGB4yN2nyUMv+pg6THxHNOIBJDPWLclD7JH7dmDHK/UmfVNMKAY+CN4Y/A32kOBWovguwwqvtka7NGe44NArwM9ma7K8CSTgr1OX6T3MI28I3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zgy/Uwjd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d02a71526so1117932f8f.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815964; x=1776420764; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ieSs87utxjnu50289y+Ir3cY53SdDBRa1QhuyvvVTfw=;
        b=Zgy/UwjdPorZAQ3IboChP+IATYSGy4V81w+6Jy/kcPT9vAiL7pR8A4OWoBq/ffVS5x
         ENkgwkPWTjBMwkabvZZuTx5qy5/MXmA65hWxQSOmF2Ik2Ox4tmdtmqtl/ppN3R9dnQ3F
         k/6F+6sIhEktg920tH5GX4ARf2tTaq7DikSkqxpNNQgYxL0QacTbffCJCUxb5kn2IPuE
         44Q23ZW6NSFB8Lu9/7JNfp2BuY+tpmEhbwQBLvHm1w841kFQc1pdoRAHJTT+nYpO9RMd
         wZX5I/EAmDytY0vfl01ejA/OF9OoK4zyRRj9Q8ydn+AMJSrDlCdfQ6BrEj4FtcDM1EJA
         jhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815964; x=1776420764;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieSs87utxjnu50289y+Ir3cY53SdDBRa1QhuyvvVTfw=;
        b=LG6X19BED5LZh1wKHumfff2YSTKFZPkU1Px2v3FA5K04WyZ3ugaUOdDqs3NaPyDNZY
         Ty99EXPjQxPLVldCBlh4qgTTgYud1NZ+MQ4JeYyjN9QstxrOAE6NhU/zsloNzur1I9QD
         YigWLyhUkPtuQMCGVvM+DTBbCBLWH5H8UiYQSjzC6aifhXG3wcIl8W1MfMKvh0n6CxqN
         r0p4kILqGlOrMBr8TI6Fn8qF81bbWzxrpceGyGsCweJ5KbNztcAU1Bxmw6tyFjIgItMg
         ueeJ6OdijHMPTDrNGlEHbb6Rk2HouvnII8SyTwjgG1PLNKAeM4JXKxV5RiTlJbxLbhdP
         NdOA==
X-Gm-Message-State: AOJu0Yx/C0ryZYUXCMr0jYqrNwlUEd7r4jK9Ad6aoRarQ5KlawQW3HKX
	Ca73qZJF2JdHs+PTQW1lzdbeaCmUHi29CvvjAktkN7jT7xjBhhtLOiXw
X-Gm-Gg: AeBDiev2zAd4MgBuZuczEvn1ib/eqyg9l0mE9jp3aoU0/iyD9Lc9a7if3UiebYTpuUK
	+F21INJfS+ivyrdDhYkAnOl12zxsqjtLy0vJBnoMaB6AYitQzDsG+vSnhOnprlqDRxfMQUFTshp
	xZXdcpIc0BPUrW4QnQRsJ64n4QKrdfs+o7YeHwzEUiryhbQYBRC77WA3qL+MXj/i1N3BFQ9yScT
	5VsLUmevOIbbrBIZ36DCnRydmfBSGh8LcHj9iHPX0n4ofVBjZTyQSZJNtk2805YpAj1XBSIjKrp
	++VNWXXEfZYJ8T4GZFtxSLBvAfJaLrbGeljaV5mRRwJsoya1gZlN4jpe7U1JGqd3NcuiHuu3wvg
	xkQABCMXb2OyOb1y+EcPqqD7i1NTsCUngKEZ11FYxnIwS/DTiBZeNl/8g86eYZZpPEq1Kb+0UMD
	5O3M2nTWs+Q7qmiX2cR2A=
X-Received: by 2002:a05:6000:4007:b0:43d:1dec:d59a with SMTP id ffacd0b85a97d-43d642b4f4amr3601717f8f.34.1775815964174;
        Fri, 10 Apr 2026 03:12:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63ab84cdsm6408729f8f.0.2026.04.10.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:12:43 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:12:40 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] octeontx2-af: npc: cn20k: add debugfs support
Message-ID: <adjNGPWKMOk3KgWL@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277320-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CF0F3D595B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Ratheesh Kannoth,

Commit 528530dff56b ("octeontx2-af: npc: cn20k: add debugfs support")
from Feb 24, 2026 (linux-next), leads to the following Smatch static
checker warning:

drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c:257 npc_cn20k_debugfs_init() warn: 'npc_dentry' is an error pointer or valid
drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c:263 npc_cn20k_debugfs_init() warn: 'npc_dentry' is an error pointer or valid
drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c:268 npc_cn20k_debugfs_init() warn: 'npc_dentry' is an error pointer or valid
drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c:273 npc_cn20k_debugfs_init() warn: 'npc_dentry' is an error pointer or valid
drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c:278 npc_cn20k_debugfs_init() warn: 'npc_dentry' is an error pointer or valid

drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
    249 int npc_cn20k_debugfs_init(struct rvu *rvu)
    250 {
    251         struct npc_priv_t *npc_priv = npc_priv_get();
    252         struct dentry *npc_dentry;
    253 
    254         npc_dentry = debugfs_create_file("mcam_layout", 0444, rvu->rvu_dbg.npc,
    255                                          npc_priv, &npc_mcam_layout_fops);
    256 
    257         if (!npc_dentry)
    258                 return -EFAULT;

This error checking is wrong, but instead of fixing it, just delete it.
See my blog for details:

https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/

    259 
    260         npc_dentry = debugfs_create_file("mcam_default", 0444, rvu->rvu_dbg.npc,
    261                                          rvu, &npc_mcam_default_fops);
    262 
    263         if (!npc_dentry)
    264                 return -EFAULT;
    265 
    266         npc_dentry = debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
    267                                          npc_priv, &npc_vidx2idx_map_fops);
    268         if (!npc_dentry)
    269                 return -EFAULT;
    270 
    271         npc_dentry = debugfs_create_file("idx2vidx", 0444, rvu->rvu_dbg.npc,
    272                                          npc_priv, &npc_idx2vidx_map_fops);
    273         if (!npc_dentry)
    274                 return -EFAULT;
    275 
    276         npc_dentry = debugfs_create_file("defrag", 0444, rvu->rvu_dbg.npc,
    277                                          npc_priv, &npc_defrag_fops);
--> 278         if (!npc_dentry)
    279                 return -EFAULT;
    280 
    281         return 0;
    282 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

