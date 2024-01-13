Return-Path: <netdev+bounces-63414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B49582CCB6
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 13:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FC51C213A3
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67F6210F8;
	Sat, 13 Jan 2024 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGy46ab5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512EEEAE3
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28beb1d946fso6191890a91.0
        for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 04:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705149669; x=1705754469; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4WxYDAUrU/sC6N0rTZH7DO6enkzbuNnkaYVknYlG1H0=;
        b=iGy46ab5KeTB/jJ+//xXd193fD9hLFYDTomjGzjzNHQs1m29tTaMg1IuR43OOscmi1
         TmO2OI5cIV1u7KWVAjb7HtCYJDTs+5Ty2mx9NclnnNUfm2sloXD8rTh+jXkjloIzGDQW
         GZAZc1QgQSa6JM+9kFmT+zn6XcjKpJSUql4nXYXKlZ3LueaU9wjDBdbhiX5khSR+Yvzx
         mDPmHBjeVUladV3FXb1UD+o5f3WRFss1tHp+UT7k7Hm9E/pTKzLmMfTHBCq/DsUbVu2+
         UUfUDnmXD/UX3hlWmLJoTKfExUc2MGX1NAPdJbM4/jMwPS13oGKRFJc8vWIfz/ZeCGaX
         jfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705149669; x=1705754469;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4WxYDAUrU/sC6N0rTZH7DO6enkzbuNnkaYVknYlG1H0=;
        b=eYPIAWkRLAvO/C86BZ2GxYw0IRyH3wpqCzL/e3Hq62b4XZ12TWVv54yIVs2Kvqs5gk
         3kUTmxYT20MKON4EJbazrq/i0VCOud5XcWbRAwpRk+F1SUBagRJEtObDt2PZQCL70Zte
         hYU45o23WcLT/koRKqFIic3VSZkaIpAEz5qaDDwZ5NL+BKwNhU14kgU/PsJ2LhqXJ4rP
         usgQ4OJlftBi+Aaa6DPHDb4tfHzCU/Ue9mQRXgqou527tz9m0iwqNrHtSP3FVY7CjXZY
         Ib2/c9tTKMckO21IKJbPmE7YuyUlJEdNeRzVkFxu68L3XItHLAm05jpD+fwgUQXNq9RZ
         tZsA==
X-Gm-Message-State: AOJu0YymF8XOUYIfsYMvLFZGZqBrH3zEPhUi+cWZFgOvm/XCLPaizj1I
	o2VxxgetDLh7ykDBTPIZ3wounrJezBZfcA69iaXI5R0xc7w=
X-Google-Smtp-Source: AGHT+IGlbfchiY3mzgbpBm/MysX55HOCCVYLsgnc3dQUnbfw55DcNjlkmOElnc+7LPmPQAhtUsU3VdPustmGDkwAjkE=
X-Received: by 2002:a17:90a:cf82:b0:28d:29f6:5cf8 with SMTP id
 i2-20020a17090acf8200b0028d29f65cf8mr2341211pju.18.1705149669086; Sat, 13 Jan
 2024 04:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Isaac Boukris <iboukris@gmail.com>
Date: Sat, 13 Jan 2024 14:40:56 +0200
Message-ID: <CAC-fF8Sv3rEx3-st-vHWqcOGerSN66-6qv4Xv1Sh2wDLQ2yNmg@mail.gmail.com>
Subject: TC: HTB module over limiting when CPU is under load
To: netdev@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000050ac0d060ed3183b"

--00000000000050ac0d060ed3183b
Content-Type: text/plain; charset="UTF-8"

Hello,

While experimenting with HTB I noticed it sometimes overlimits the
bandwidth way lower than I've configured (~1/4). After lots of tests I
narrowed it to the case where the CPU is under heavy load.

I do realize you can't be too precise under such circumstances, but
such gaps make the module not very useful, and most importantly other
modules such as HSFC and NETEM still work correctly in the same test,
so it doesn't seem to be an impossible task.

The attached script reproduces it for me, when run normally the curl
command reports ~1800kbps for all modules HTB, HSFC and NETEM, but
when I run the below command to incur heavy cpu load, I only get
~400kbps when using HTB while HSFC and NETEM still work well.

$ watch -n 0.1 openssl speed -multi $(nproc --all)

See below dmesg related entries and tc stats from the last test.s
Thanks a lot for your thoughts.

[ 5487.205876] HTB: quantum of class 10001 is big. Consider r2q change.
[ 5514.158475] htb: too many events!

tc -s -d -n server qdisc show dev server0
qdisc htb 1: root refcnt 129 r2q 10 default 0x1 direct_packets_stat 0
ver 3.17 direct_qlen 1000
 Sent 26140201 bytes 17273 pkt (dropped 0, overlimits 6440 requeues 0)
 backlog 0b 0p requeues 0

tc -s -d -n server class show dev server0
class htb 1:1 root prio 0 quantum 200000 rate 8Gbit ceil 8Gbit
linklayer ethernet burst 0b/1mpu 0b cburst 0b/1mpu 0b level 0
 Sent 182 bytes 3 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 lended: 3 borrowed: 0 giants: 0
 tokens: 13 ctokens: 13

class htb 1:2 root prio 0 quantum 200000 rate 16Mbit ceil 16Mbit
linklayer ethernet burst 1600b/1mpu 0b cburst 1600b/1mpu 0b level 0
 Sent 26140019 bytes 17270 pkt (dropped 0, overlimits 6440 requeues 0)
 backlog 0b 0p requeues 0
 lended: 6539 borrowed: 0 giants: 0
 tokens: 1964 ctokens: 1964

--00000000000050ac0d060ed3183b
Content-Type: text/x-sh; charset="US-ASCII"; name="htb_reproducer.sh"
Content-Disposition: attachment; filename="htb_reproducer.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_lrc21b5u0>
X-Attachment-Id: f_lrc21b5u0

IyEvYmluL2Jhc2gKc2V0IC12bWVFCgpIVFRQX1BST0M9MAoKIyBNdXN0IHJ1biBhcyByb290Clsg
JChpZCAtdSkgLWVxIDAgXSB8fCBleGl0IDEKCnRyYXAgJ2VuZCAkPycgRVhJVAplbmQoKSB7CiAg
ICBpcCBuZXRucyBkZWxldGUgc2VydmVyCiAgICBbICRIVFRQX1BST0MgLWVxIDAgXSB8fCBraWxs
ICRIVFRQX1BST0MKICAgIGV4aXQgJDEKfQoKaXAgbGluayBhZGQgY2xpZW50MCB0eXBlIHZldGgg
cGVlciBuYW1lIHNlcnZlcjAKaXAgbmV0bnMgYWRkIHNlcnZlcgoKaXAgbGluayBzZXQgY2xpZW50
MCB1cAppcCBsaW5rIHNldCBzZXJ2ZXIwIG5ldG5zIHNlcnZlciB1cAoKaXAgYWRkciBhZGQgZGV2
IGNsaWVudDAgMS4xLjEuMS8yNAppcCAtbiBzZXJ2ZXIgYWRkciBhZGQgZGV2IHNlcnZlcjAgMS4x
LjEuMi8yNAoKaXAgbmV0bnMgZXhlYyBzZXJ2ZXIgbm9odXAgcHl0aG9uMyAtbSBodHRwLnNlcnZl
ciA4MDgwICYKSFRUUF9QUk9DPSQhCgp5ZXMgfCBoZWFkIC1uIDI1MDAwMDAwIHwgdHIgLWQgJ1xu
JyA+IHkudHh0CnNsZWVwIDEwCgojIEhUQgp0YyAtbiBzZXJ2ZXIgcWRpc2MgYWRkIGRldiBzZXJ2
ZXIwIHJvb3QgaGFuZGxlIDE6IGh0YiBkZWZhdWx0IDEKdGMgLW4gc2VydmVyIGNsYXNzIGFkZCBk
ZXYgc2VydmVyMCBwYXJlbnQgMTogY2xhc3NpZCAxOjEgaHRiIHJhdGUgMWdicHMKdGMgLW4gc2Vy
dmVyIGNsYXNzIGFkZCBkZXYgc2VydmVyMCBwYXJlbnQgMTogY2xhc3NpZCAxOjIgaHRiIHJhdGUg
Mm1icHMKCiMgSFNGQwojdGMgLW4gc2VydmVyIHFkaXNjIGFkZCBkZXYgc2VydmVyMCByb290IGhh
bmRsZSAxOiBoZnNjIGRlZmF1bHQgMQojdGMgLW4gc2VydmVyIGNsYXNzIGFkZCBkZXYgc2VydmVy
MCBwYXJlbnQgMTogY2xhc3NpZCAxOjEgaGZzYyBydCBtMiAxZ2JwcwojdGMgLW4gc2VydmVyIGNs
YXNzIGFkZCBkZXYgc2VydmVyMCBwYXJlbnQgMTogY2xhc3NpZCAxOjIgaGZzYyBydCBtMiAybWJw
cwoKIyBjbGFzc2lmeSB3aXRoIGZpbHRlciBmb3IgSFRCIGFuZCBIU0ZDLCBjb21tZW50IG91dCBm
b3IgbmV0ZW0gdGVzdAp0YyAtbiBzZXJ2ZXIgZmlsdGVyIGFkZCBkZXYgc2VydmVyMCBwYXJlbnQg
MTogcHJvdG9jb2wgaXAgdTMyIG1hdGNoIGlwIGRzdCAxLjEuMS4xIGZsb3dpZCAxOjIKCiMgTkVU
RU0KI3RjIC1uIHNlcnZlciBxZGlzYyBhZGQgZGV2IHNlcnZlcjAgcm9vdCBoYW5kbGUgMTogbmV0
ZW0gcmF0ZSAybWJwcwoKY3VybCAtbyAvZGV2L251bGwgImh0dHA6Ly8xLjEuMS4yOjgwODAveS50
eHQiCg==
--00000000000050ac0d060ed3183b--

