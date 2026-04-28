Return-Path: <netdev+bounces-282080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGFaDdIg8WkhdwEAu9opvQ
	(envelope-from <netdev+bounces-282080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:04:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE4848C2F8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50672303388F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0B379EEC;
	Tue, 28 Apr 2026 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="SiHaxxoU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC26037B03F
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777410163; cv=pass; b=Jsb0YIzzL0RAIEoIEGFyY3Qs49kMcuFt3rU6XkMc7Awm2qvQJghMddYiRjNerifzSp6ccuBG/ZD4OtIqMeSB6FO+oMltLeie/tIHSIL/kzTCKPxSP+UZeEOZ46gRbppV3tIvO0EQY+gOW/dLwFh1ola8B3Xgf8iubqgV+TBdM5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777410163; c=relaxed/simple;
	bh=QZ5g0rywRPmTuJ69hvkprtR7MFhY68sDBLhcgw0FtUk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DzHoTN1xYtp/jkbcn9irhf6txT251CEjhLUQeCIe1mwe7kMGOlqA9qGn4hukzmUI/sfo6GsqsJDZvs8I0Bc9vWFqZgAsiMtVUkPMgDUf7t5YqkTn235KL3zGQmTvo5DaFQAiv5FXPRiY3NUCeWgCItKok72nPp2CKraMor4bX7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=SiHaxxoU; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c796163fac5so7345261a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777410161; cv=none;
        d=google.com; s=arc-20240605;
        b=DHw4wIaZuv1opjnpFu2Bh6M5IGaD+0i8W03edJHAj14/iEUKMxW/0XxAWvNlJDCCzb
         rXyIh2fj9sav3Vo6kQeDyLu1PNNzITmBlq/JlJkRUprwLbYTJNpdSBfNYcIzLHHg2mz8
         QOd8xMKklAn4TmzoWfHMl1mVI8cmVCJzFEen6QS6IcL6/lk1zTNezk3Eax3E+w0U38n0
         qnmlwe0XDG7qciBrngtQYKNCS/rXqb039vedFzzKesXTVpnDZFb8wV/0AbQFTuWzvDa8
         ljjywQi0vo64LP5g1mNQh3NPFNI3L0Xf9x2xz9h8g8pakkEJCTt44vkFvlvlkx+YybbJ
         r3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QZ5g0rywRPmTuJ69hvkprtR7MFhY68sDBLhcgw0FtUk=;
        fh=6USPW7ZsXFEiyB6kqq4iMzortJsQZjNSoe0Hmp3CjqQ=;
        b=jF5ayaayFVp3meqIX6pp1dyj/DwWFPRCeFIrUM5aKWKMdJ10Dl2Xm7dXb3kCV3EIoj
         qnHX/5U0zZEHjp3s7ksOcolo+4C29hOzuuqsRLBOqGg+32dLwl7reQ27uQEmI8d68COd
         hFa8zFStXddQN0H4HlGx5p3oAC6cxXbSmwt4jhf/pxPoTPCXNN9YzBnEzy8livXNDQi3
         3OrUtGck7CG/9C8BIGE5t857QQIVfrQlIqwoA69Mo0ruf+DiAkU2k9pegcH0KDK0Y+92
         PpKwW4h5EvnYz7SD06jSSWjsPYzZ+XiwwffkyKTDZp/t0WxM1WVJNocDMIetAhP2YJ/P
         p49Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777410161; x=1778014961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QZ5g0rywRPmTuJ69hvkprtR7MFhY68sDBLhcgw0FtUk=;
        b=SiHaxxoU4y/Y2KPdUjP5E1imfmZialfvd/cWpcEqFEvAe6q3YrReObRIgOm9QdUgiy
         omiqDXA3o/pcWVR+w37kVsh6xf8knA3bem6ruW96/fx0y9GK13FQYckQ0Xfgf8csyMeJ
         +jGoNoiBStSHfXyEmqgiG/1AU7yw2n0mXS/i1Cb9+BKYfT7Avt+AaDwmvcSBJWjJNkFo
         bBm3+8EEQdw9J3D4NJtM5b6zDYQKLcfZpz5AsGoEbqyuEoyJqvNatqhJlYuhBVikR4+t
         DQ7AJ7MegJq48WX/jfB5brsaouFW7v4KMXHm5pup3XvvZbS9HPuKaKyZifysD0lUkB02
         YNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777410161; x=1778014961;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ5g0rywRPmTuJ69hvkprtR7MFhY68sDBLhcgw0FtUk=;
        b=FWEr5qvYKfyMCl14eGBTrGb0dRoIbJPWruaJR17LWfpCMlDYM/QggmBqO1AXXwGKRc
         avURGqnrUwZciP0JEsf8Zl/ZjjxXGeRgovb9mkF78nmLYNoae/N1578cbtHLuf2OLXAj
         Q7eA+KU/YBC+4KNjhdiQrlLUe0x1gZl5n6cflo4nJB1Gq7cn5KqKGPO29ZjSH1uunSBT
         meER+yaMMFRj9bx1/7LpP6S8n0KzVrjHZDJozZlAzI/LUtLcGBXe/n6dTJWeIUaXeTBT
         kvKV2gNk136kQdPq4xmOHN4+2EEDCKBMZGaVSlOwCNCUr7saCmAwUDY+arhySEG061g2
         GgYg==
X-Forwarded-Encrypted: i=1; AFNElJ/x9Y0XP6qOzZvsf+nSAbjE/C/rjAnScH0YAAN9ywS593zDhlR2jumfNHO8RnFRjgEW86e4vNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJyA0hzKvcck/1NgZgGc0PhDvNEdfipwlgWz1ynfvh3s3Yia7
	Ydhd68rqWFJhZoWBGqRtim58EVXm7/ZYZvrEawklTvnT2rr+L5yvZVFqBFozHdn1yYu02hitud8
	IdZRBmukeITDr7GVT9OwOOBB68rA6CxBOxx5c5ZJ1
X-Gm-Gg: AeBDiesphGXXjk7ed47goERe5izgvbOgfVdC1v5kUdFcAbTITFdL0EsuD4vH5DtV42U
	DV2I8E50FTrmyobKd47XH80deS6oNt9rxCMNJQ0xYT2D/2GNhiGWkytrwfbtwBb1MPimjqDYbvp
	fI93s7bRb4IIlkxY3ylZfe4YFu2ybthZApCi+QlphFAyt9xCLL2xRVMzvywACXMAY20klJU2shN
	qpf+ZZ6StxzI4qF4pTedrWRGA40vgzPgM5fppRQsy2KsJvwzizFlV6f9fod494TgMbOSyJPIbZs
	eBhOWQKUwZVE7YGsX+DtJx+XZ4FjOw==
X-Received: by 2002:a05:6a20:9146:b0:3a2:df61:50e6 with SMTP id
 adf61e73a8af0-3a39c3da898mr5265488637.47.1777410161237; Tue, 28 Apr 2026
 14:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 28 Apr 2026 17:02:30 -0400
X-Gm-Features: AVHnY4IPbL50MGY9wUIpXRQqsPuw4TFCQyKCgR4OtAo8xSoWCQRt5lBPiF8oDqQ
Message-ID: <CAM0EoMnv9ZDWFSDGMK3iX9dXjXNLs+v30ak-GgsLBq3EQ+hQsw@mail.gmail.com>
Subject: 0x1A: Call For Submissions is now open!
To: people <people@netdevconf.info>
Cc: Christie Geldart <christie@ambedia.com>, Kimberley Jeffries <kimberleyjeffries@gmail.com>, 
	Stefano Salsano <stefano.salsano@uniroma2.it>, lael.nasan@gmail.com, 
	PJ Waskiewicz <pjwaskiewicz@gmail.com>, program-committee@netdevconf.info, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9AE4848C2F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-282080-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[ambedia.com,gmail.com,uniroma2.it,netdevconf.info,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_ENDS_EXCLAIM(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,netdevconf.info:url]

We are pleased to announce the opening of Call For Submissions(CFS)
for Netdev conf 0x1A.
Netdev conf 0x1A is going to be a hybrid conference with the physical
component being in Rome, Italy.

For overview of topics, submissions and requirements please visit:
https://netdevconf.info/0x1A/news/netdev-0x1a-call-for-submissions.html
For all submitted sessions, we employ a blind review process carried
out by the Program Committee.

Important dates:
Closing of CFS: June 1st, 2026
Notification by: June 10th, 2026
Conference dates: July 13th-16th, 2026

Please take this opportunity to share your work and ideas with the community

cheers,
jamal

