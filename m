Return-Path: <netdev+bounces-299089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p6kYHhjmLWqLmQQAu9opvQ
	(envelope-from <netdev+bounces-299089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:22:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C11680072
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:21:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b=Ybx7Q+U8;
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=OuYjLuCt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299089-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299089-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9E0D300D727
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A791A37CD21;
	Sat, 13 Jun 2026 23:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-9.smtp-out.amazonses.com (a9-9.smtp-out.amazonses.com [54.240.9.9])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D3257845;
	Sat, 13 Jun 2026 23:21:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781392917; cv=none; b=biVivQjaGE/8j4WI1rvt+GNODcsTCN2/cuoik2QmEpQaezm2cftUCZAs7J059EXil02lXm1GboEAnvVIqO0wOxk1uyWN2bXfxUi7I+7i+gu0w8IJRg37BCl6zDS9uFs5O7uvqTjKKPvLmFc3OIUmO4fAme4MY6jbfHHB34/veqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781392917; c=relaxed/simple;
	bh=Fx+xar5Hg1xzTqJtSJCkN4LaVLa7C4OuUVETe73HAvs=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=Et9Ou47jLmJlGLAFy2y+QnjeGmOs8l1Ck+iAIFEwURwVA7hXyPM3xn3XFqg6SdrCgaMVXjYWq99FkWS+EBYmzgwHSY3Dnx7U2CVC3Mefna7eJlFZT80FaIuHinIyyUqSwz+/Se9A9RCKbhqXGIR1+Rxy/NNkKicM8D6BM3qJOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=Ybx7Q+U8; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=OuYjLuCt; arc=none smtp.client-ip=54.240.9.9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1781392915;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=Fx+xar5Hg1xzTqJtSJCkN4LaVLa7C4OuUVETe73HAvs=;
	b=Ybx7Q+U82+TNf1tRfiADxBaP9uQc5VzFLspLKy9Y2jrQC6iK22y7cJ9B6zuMs6dT
	4AhC8RVn1UC97Gp2KprKyicXXM3LDhJgukof+uLs9YscPcxYrhwMJDA0RGEmkkj+hOr
	/xucjot+5/d52FFOcN76tCKerb+Ohy6GhgsWeJCk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1781392915;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=Fx+xar5Hg1xzTqJtSJCkN4LaVLa7C4OuUVETe73HAvs=;
	b=OuYjLuCtoI6Ob18PrFSKK9uOhA+GVyA26dICIUWhoc2y1mY2pAUdrPPpeEdleFMX
	Z+YyzaPBE/QiZjtpTgZ/ZYUQ59MxDGrrkxOVB011bYOpXjrYZ3t1Tgt6QZyBuXAl7mS
	TxOu+6wWDumpNnkYMU1jPXSHk/llc7PKO0eJSS/w=
X-Mailer: git-send-email 2.54.0
From: Johan Alvarado <contact@c127.dev>
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, namiltd@yahoo.com, luizluca@gmail.com, 
	linux-kernel@vger.kernel.org, contact@c127.dev
Subject: [PATCH net-next v3 0/2] net: dsa: realtek: rtl8365mb: add
 SGMII/HSGMII support for RTL8367S
Message-ID: <0100019ec34ab9b0-cd42493d-62f2-4bd7-9ace-2e4f8e41bbbd-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 23:21:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.06.13-54.240.9.9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:namiltd@yahoo.com,m:luizluca@gmail.com,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,s:lists@lfdr.de];
	DMARC_NA(0.00)[c127.dev];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299089-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[armlinux.org.uk,yahoo.com,gmail.com,vger.kernel.org,c127.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,email.amazonses.com:mid,amazonses.com:dkim,c127.dev:dkim,c127.dev:email,c127.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5C11680072

The RTL8367S is a 5+2 port switch from the same family as the
RTL8365MB-VC already supported by this driver. Its chip info table
entry declares SGMII and HSGMII on external interface 1, but the
driver so far only implements RGMII, leaving boards that wire the
switch to the CPU over the SerDes without a working CPU port.

This series implements both modes. The configuration sequence and the
SerDes tuning parameters are derived from the GPL-licensed Realtek
rtl8367c vendor driver, as distributed in the Mercusys MR80X GPL code
drop, and cross-checked against the real register sequence captured at
runtime by chainloading a custom U-Boot ahead of the stock firmware
and logging the live SerDes accesses on hardware.

The vendor driver brings=
 up the SerDes by loading firmware into the
switch's embedded DW8051 =
microcontroller. Analysis of that firmware
(by Luiz Angelo Daros de Luca) =
showed it only performs a SerDes
data-path reset right after the SerDes =
reset is deasserted, and then
runs a link-polling loop that writes the =
external interface force
registers -- duplicating, and racing with, the =
link management phylink
already performs. This series therefore keeps the =
DW8051 disabled and
performs the one necessary action (the data-path reset =
via the SerDes
BMCR register) directly in the driver, avoiding both the =
race and a
dependency on a redistributable firmware blob.

Patch 1 adds the SerDes indirect access helpers and SGMII (1 Gbps)
support. Patch 2 extends this to HSGMII (2.5 Gbps), which phylink
represents as 2500base-x.

Tested on a Mercusys MR80X v2.20 (RTL8367S wired=
 to the SoC over the
SerDes), in both SGMII and HSGMII modes with a =
fixed-link device tree
description: link bring-up verified across cold =
boots, warm reboots,
module reloads and link down/up cycles, with sustained=
 traffic and no
CRC/symbol errors. The HSGMII link is confirmed running at =
2.5G at the
register level (SoC uniphy mode and gmac clocks); per-direction
throughput could not be pushed past ~1 Gbps on this board because the
SoC side is driven by the IPQ5018 SSDK and the user-facing PHY is 1G,
so full 2.5G line-rate throughput remains unverified on my hardware.

Signed-off-by: Johan Alvarado <contact@c127.dev>
---
v3:
  - Drop the DW8051 firmware loading entirely. Analysis of the vendor
    firmware showed it only duplicates the link management phylink
    already does; the one needed action (SerDes data-path reset via
    the BMCR register) is now performed directly in the driver, with
    the DW8051 kept disabled. This removes the dependency on the
    rtl8367s-sgmii.bin firmware blob, which could not be redistributed
    via linux-firmware (the GPL vendor source ships it as a byte array
    without the corresponding microcode source). Thanks to Luiz Angelo
    Daros de Luca for the firmware analysis.
v2: https://lore.kernel.=
org/netdev/0100019eb0b1822e-ffc5626c-1b9f-4c8a-8a1a-759a9e665f4f-000000@ema=
il.amazonses.com/
  - No code changes; resend because the SMTP provider =
used for v1
    corrupted the mails and patch 1/2 never reached the list.
v1: https://lore.kernel.org/netdev/aebccaad-eca3-4ea4-99dd-ae7edbc8981b@smt=
p-relay.sendinblue.com/

Johan Alvarado (2):
  net: dsa: realtek: =
rtl8365mb: add SGMII support for RTL8367S
  net: dsa: realtek: rtl8365mb: =
add HSGMII support for RTL8367S

 drivers/net/dsa/realtek/rtl8365mb.c | 336=
 +++++++++++++++++++++++++++-
 1 file changed, 332 insertions(+), 4 =
deletions(-)


base-commit: 8f4695fb67b259b2cae0be1eef55859bfc559058
--=20
2.54.0


