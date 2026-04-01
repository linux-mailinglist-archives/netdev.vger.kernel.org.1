Return-Path: <netdev+bounces-273958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MAvNS7NzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:45:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F29D376399
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1A5E30D02EE
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBA73859EF;
	Wed,  1 Apr 2026 07:42:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352037F745
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029347; cv=none; b=OUnGZG99rM3Tcm1rNS7e6v/6jmux1YR0uUQSW4mb4iaxFf+sxiCu/jAgFLQFdyRkgysjkjOwEDfs7FfVkrtacp6kvS5YgE48YoZnbIVpKNc1MRqRfXcUCRimRyhv2FR5E3KGOHWMy5kC8PBmqravg0WKu0yKhXTXaHU15+1OP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029347; c=relaxed/simple;
	bh=txXUfYvaeQJYycp0fUA9LLKONMLQ2GKqQcMKym2NH8s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XZ48zWzJbSkDBxIqsKMnGMdn6x8sWAtD51Z9Ms8nYbmaOY/FyjmrmFOrE8Datlf0pxPBJbpEh81XOJTKDX9DDSgD2Cl4qMkMR21SX5t3oXXPn51B7xMuLFFKnQQHJNocj2pGND9BnGsGThDk+E5I4/6fFbzz9+khqRpS7yG/Y6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d7eb8cf3d6so23914195a34.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 00:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775029344; x=1775634144;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3gTuXpKCN7VYI+q2l2Hi9gL9Ghm548UsftJe2Z4drE=;
        b=muXNF6zhIyILMA6JlZrv2jfiWwZfZ6wgXD7l7jDV6791qPreFsx2eAipETS6i4gcCn
         BKIF4LoXMoyRF807QDNai6OmzKKpZwouS2DNSodcws1Fjcf2zb7gbfvTcrqFPAq8gE2y
         oZO9awhxEcqA8C8O+ZApn1E7lFgxedyiqWkR4FCJxx1ia+zGkUyiN9TB9bTNfQ8cd1Q8
         6j7MUL3PyrHg27GQ6TYvi6mSIWifpOSwY4MJhynnbyxYRp0fRnz+ZGRnTRFcxXaog1TM
         6t+3kneplKEuW9T0XeW5QXqH1QnVzB4UT7yc/RZGF3/Qj+kekd2W5TylD8XyDACWTfu2
         m47Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1Moaam7Ig7V1qfOl0QojBcjhrZnGToFEiwEA3K8E8r/14eV61o8NoTAaO/vjrmzt6LTpnxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFczKXSwWW6Envy3Cb4Bh8znydVf+ALCB6iI1aN5F86qyzNvzX
	0bUTwov3kWEK2xeXwXGmzv4CWqwygBJaxZeo7pgV+5ychtnzyLNkzHpCB2rXDd7cf/+BW4nlJ7y
	VAkIM9ZafOzrRe7xa44MwKsGgPvkHhJ4olJFu9uC7md3K+ENj/j3/sSbdeNE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1745:b0:67e:fbc:de68 with SMTP id
 006d021491bc7-67fabc08953mr1169405eaf.26.1775029344454; Wed, 01 Apr 2026
 00:42:24 -0700 (PDT)
Date: Wed, 01 Apr 2026 00:42:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cccc60.050a0220.183828.003f.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Apr 2026)
From: syzbot <syzbot+listb52ea0a54d3fbb4630b8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273958-lists,netdev=lfdr.de,listb52ea0a54d3fbb4630b8];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlegroups.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 4F29D376399
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 2 were fixed.
In total, 51 issues are still open and 174 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  28045   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  14590   No    WARNING in kcov_remote_start (6)
                   https://syzkaller.appspot.com/bug?extid=3f51ad7ac3ae57a6fdcc
<3>  10607   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<4>  6950    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  1226    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  872     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<7>  810     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<8>  790     No    INFO: task hung in netdev_run_todo (4)
                   https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
<9>  719     Yes   WARNING in ieee80211_tx_h_rate_ctrl
                   https://syzkaller.appspot.com/bug?extid=0d516b33238bd97ee864
<10> 619     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

