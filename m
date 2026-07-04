Return-Path: <netdev+bounces-304682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i9GKHOqMSGqurQAAu9opvQ
	(envelope-from <netdev+bounces-304682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 06:32:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C72817069D0
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 06:32:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304682-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304682-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A2B3300A13C
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 04:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E19388E74;
	Sat,  4 Jul 2026 04:32:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72E381B1D
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 04:32:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783139554; cv=none; b=NG5V4EKmRYDVWwDmvKwv/CKe30r+/MAA9hxcPyVZ0Lw9YOsp+yBNTRBx74kkW/vo+gZsQJdYVEY+Rl2Fqros8kmTN152N+SHZKg6drl67NxjuFtNrjLpqPT0n1duc9VYxS0I4pDQzDYrU00P6aOFOVUX7JG+TKZn8tLrIh2ztkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783139554; c=relaxed/simple;
	bh=DVZrScrCHFw0e9W9NPMorP7NbJVBjjcPdL3WSxs98rA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hsi6fC5a61NEZkLDByXrbXfRrcpMigDWk9y0Ik9IZMCoz20kB+2qrPM/Gt+r4RkrLH3lzPvBJXe48TT/i32Km+ZIoflfv04Yiv8pmtYIdOcTnmq6wDty7yi+eJMZG1aHIX85bFSb1FeKrYdDW9McjBJViG5YDb55r6UbUsAlBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e94dffa918so1401570a34.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 21:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783139544; x=1783744344;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KPiNMJouXk269z6DwL82Ol478mu/GZzWA83cGd2gkyw=;
        b=CTRKj21DSUhI8yKBOD1IBhTPZM808mz4dIJgH13T/KOupK/6JDetT7D8GJtBlwlMpm
         agm7UUOn8QicS2XEHxnHEhi90eQUsVyKpCB/fdCbm/RohfbhUQv2tamUdZvL9Dk/Zi+c
         p0uKh0L6CNt09DUT2f4EZ+iPfdRbI36c1Aw8TaVzpl3cAplTwOQbGcT1Ig6isW+C1XLE
         +qi0cXPCDYFTNVJ1n/IQsrWmccP1aoS0mkhuUmGZeRAbRKZ83/hSETHSfTde/3FGpgAe
         Yz1N0RxG+whNxfRGnqeeu7rCDrRks+MOCC4jMxcYvwwpFPW1d3ggUOn4PHHXtf++5SLj
         fhKQ==
X-Forwarded-Encrypted: i=1; AFNElJ886Iu3H2Aav55AYh/UPFkgDT+QH1lc0NYMPMGuf1ONkW2gStmCl6BRjGYgaIngISD2m8GhpAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkl2NMaAwlxyJCWnTZI69C14JHQj72KqDe2wLXb/NJH1K9CWK
	+eZccX1GPPwV+UOnHRIlNeyf4Tpknp7wz7nQdR2ejCL+H1CWaUliiY5PQPk//bbCKiOShUb8lE3
	cDLrW4CsbMLon6kLfnzR8OmxPkZz+wMy/0LEbnDaD+7kcvqdR6b5vmYaEz3w=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168f:b0:6a1:44aa:86ce with SMTP id
 006d021491bc7-6a32f4c1cbfmr967723eaf.22.1783139544198; Fri, 03 Jul 2026
 21:32:24 -0700 (PDT)
Date: Fri, 03 Jul 2026 21:32:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a488cd8.b42ede87.8bd1.0008.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Jul 2026)
From: syzbot <syzbot+list7ac59e6c13deeebf868b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304682-lists,netdev=lfdr.de,list7ac59e6c13deeebf868b];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C72817069D0

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 3 new issues were detected and 0 were fixed.
In total, 30 issues are still open and 178 have already been fixed.
There are also 17 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 6964    Yes   WARNING in __cfg80211_ibss_joined (2)
                  https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<2> 1243    Yes   INFO: task hung in reg_process_self_managed_hints
                  https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<3> 327     Yes   INFO: task hung in ath9k_hif_usb_firmware_cb (3)
                  https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640
<4> 65      Yes   WARNING in cfg80211_scan_done
                  https://syzkaller.appspot.com/bug?extid=189dcafc06865d38178d
<5> 42      Yes   WARNING: ODEBUG bug in ieee80211_led_exit (2)
                  https://syzkaller.appspot.com/bug?extid=e84ecca6d1fa09a9b3d9
<6> 1032    Yes   INFO: task hung in reg_check_chans_work (7)
                  https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<7> 204     Yes   WARNING in ieee80211_free_ack_frame (2)
                  https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<8> 44      Yes   possible deadlock in zd_chip_disable_rxtx
                  https://syzkaller.appspot.com/bug?extid=0ec3d1a6cf1fbe79c153
<9> 21      Yes   WARNING in mac80211_hwsim_tx (2)
                  https://syzkaller.appspot.com/bug?extid=435fdb053cf98bfa5778

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

