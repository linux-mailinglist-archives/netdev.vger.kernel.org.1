Return-Path: <netdev+bounces-273520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPSJF4iCy2lmIgYAu9opvQ
	(envelope-from <netdev+bounces-273520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:15:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329C365EBE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAB9A30CB19C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C32C3DA5DC;
	Tue, 31 Mar 2026 08:07:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE63D7D87
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944447; cv=none; b=tFITrZWJ6ls0K5Mrm0NjYumii5ZTiqgHpGUZ8bUkTjqJgvsLUKKN6hdaM8Rnkhj4N44SPfghqNC6xsPuTfRrnaJQ3oIEbNsOh2TgzaKAYNI+P3Y8H5cbHQFqbSBOT34mu5uMrL/8DedQMpKVtTyC3QSPNZh8F4rFfIVwuMOn3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944447; c=relaxed/simple;
	bh=dgLNqVyiq4rJK7inbNEq1N31z/NGSsmDfpAVHUogY/Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zuibyqnm+5lD2hWsU1Kutet3HY17vlEsDddKru5EjZl6Si79e7oJKaOUrrUuJOexa5BcFweSTNS66lzzHusMq3fSqD1Brrzseb9ieKHQ3EQXAEEV5phyTM2wTC2ucUnrp/tkCqvutO1rN2JOX8T5SUV+RI8qT+7AoYZ5Txdbd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67df391509fso21013071eaf.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774944441; x=1775549241;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Falw6vbbyCbmrRDrjdbavA0kWxpOh6dMsGLFaJojcc=;
        b=aZDqOu/QoZstg+7tjSlcZ3F48yKgft4QjqJRg1ZYbXjX2gBrboC6StvarnaP/Pe5OE
         hWWtIb+9VLk0euk3gVlSGWMyhsaR1+3eaEKc6uN3nylUiZicpAaMDheOy7zpiym+nrhm
         OD15NP5363xAj+OoqON/J2me5PtGdNz+Tdaf87pWrPPFaJZetV4oc4np1AJWJSVvaYMb
         VDwutBI0T7S/dLGy2l71NIc1YOFfWbUMz1+4xIi7GbiCuFpD4VitWe536gKccSdKLbSB
         yPjqwYBkmMafdCDGWO7VbOowddQENcm1eqfwpZ8X9sxKkqpUkM6evxuzOUTfKq4+4dJN
         Wp8A==
X-Forwarded-Encrypted: i=1; AJvYcCWqaTtkJTkLmfCSAIQ5gpSsarj/cYOcJ+19UcCwvayVE8Apq8gYausbFLht05x2lXjEfgtL92k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyal2L/PW05r3lX60VHaLr8pPcUkoALEA76idUv4z5PDhNt5rWL
	ca4dpiCx0ZX+4HGkY9iKBmPV2qTM5ljDcJo+EKKwyRgVFLMAaYXSDAd6Hw5NlTuRBdXgT3CDOCE
	VEgYh6wdb6z2VeO46C5qNEzTBSqmd2gO6PEuaXTMb+Ky2cWQfoGSYeEYDrYs=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:179a:b0:67b:a667:f53e with SMTP id
 006d021491bc7-67e185ed405mr8132037eaf.1.1774944441679; Tue, 31 Mar 2026
 01:07:21 -0700 (PDT)
Date: Tue, 31 Mar 2026 01:07:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cb80b9.a70a0220.97f31.0282.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Mar 2026)
From: syzbot <syzbot+list2ec276fed9b7f4fd3ec7@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273520-lists,netdev=lfdr.de,list2ec276fed9b7f4fd3ec7];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,bootlin.com,datenfreihafen.org,googlegroups.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.895];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 1329C365EBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 436     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 350     Yes   WARNING in lowpan_xmit (2)
                  https://syzkaller.appspot.com/bug?extid=5b74e0e96f12e3728ec8
<3> 46      Yes   KMSAN: kernel-infoleak in move_addr_to_user (7)
                  https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

