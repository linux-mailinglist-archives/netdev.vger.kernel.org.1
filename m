Return-Path: <netdev+bounces-262198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIfvNG9ao2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:13:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C81761C8DC7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4558131B25E8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F03D6CC1;
	Sat, 28 Feb 2026 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="lBdXVjg8";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="QwJXKr3J"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101833D6C7
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304791; cv=none; b=JaC3IkqBe7zFSNxbDQVJIqq2XNQbvyqi5YxL8m/on48PtS5PgAfhhjc2Zir54Ev6rn9St5h/TiPTpjxB02r04XH3TMxwXWBSW/eipASOmrsfHcfvsgqHEmuucXub4DLb4ZvL0dzmG4/BxEm/XiPbi6ok30JGYNiPsr3efKBR/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304791; c=relaxed/simple;
	bh=r1faAqlegnle6ygT6v+cDGvhStd/FtTIi4WqdMR/iKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bxw2anoy2StnwGhgbWUn/2VV39/X0r79zIpoBi1NjdYFJHZqaJaIrSmVLMuLnLVakdrMufAo2FPv2+pB/JMHrkxqkmVuz0tgJdQzfy7GIGiPXmfY47Qgl7smPbZZzCSQKbgB5DVJQtouHLrlBSaDcjxgSyDluXAczTcQSV8ztog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=lBdXVjg8; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=QwJXKr3J; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=lBdXVjg8AabtYOvlKJydfIXIFqty3L1AzXSFKOw1co+S3ij7ZmtC7Aq8aKXTK3uT9kmWdLTlpSAEujUXpherBCTTjCf5FWeaur0nQnRc2nNiDXb5jHuxEYBVheEk2uM7EC1gFAyqIZwSZAKzFqR2GdiwwwkuKBwZ5KNvPFX+c+nN2IcFlNssnVSFG/1YwNuKl/dENOSx+7/IWleLPx8V3YKasmtkfUZIUcYapGxpMVAyEYt07o2RXfEDz1RVb6ExvyXQBFbAeI3NwY+wzfylEbQpl4qRsp1xf0BKu5y+AhPQ7dRyZYANNlA29XcQ66YW8Qwb1dhGhkVxXOmv4O7Ncg==; s=purelymail3; d=tinyisr.com; v=1; bh=r1faAqlegnle6ygT6v+cDGvhStd/FtTIi4WqdMR/iKQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=QwJXKr3JPa1Jpz1N1us7keadKwGvHCCrBinWBc64e7s8BclnF/mRUkbAX9YYF7MnC+Toi4AvFg3SrQdy+l3wGHfE84RWJH2y+WQOl5ERd1o4b6Iv9Mt9MGxpi9RwJuIM3CUqPGeveg75b5VbYGWUOulQhnkT4QVjfAbghdJTYEtOyVrSL2+15Yy8NnR9QXHTpWJz3KROrf+AKxkNk7DFDkVRwLUybxIOvTR+PCQrvSlgtXOmEfNjbJKU5GnbXMc/x2SMszTQNIPz0WQTbNiP/cOmM2z/4lXAt+IqmmnxqmyjQPqXmy8q3OLcgwLhoQ5bkYMCHgR7FSBBF2P7g+dIqg==; s=purelymail3; d=purelymail.com; v=1; bh=r1faAqlegnle6ygT6v+cDGvhStd/FtTIi4WqdMR/iKQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1487390422;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 28 Feb 2026 18:53:02 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [RFC 0/2 net-next] net: dsa: MT7628 embedded switch initial support
Date: Sat, 28 Feb 2026 20:52:40 +0200
Message-ID: <20260228185242.800836-1-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,tinyisr.com];
	TAGGED_FROM(0.00)[bounces-262198-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tinyisr.com:mid,tinyisr.com:dkim,purelymail.com:dkim]
X-Rspamd-Queue-Id: C81761C8DC7
X-Rspamd-Action: no action

Hello,

This RFC adds initial support for the basic functionality needed to
operate the MT7628 embedded switch.

The driver configures the switch to isolate each port and does not
offload any bridge functions, so all of the forwarding is done in
software. Bridge and VLAN offloading are possible but omitted to
simplify this initial patch set.

The special tag currently overlaps some functionality with tag_8021q,
but it enables precise TX handling and (more) precise RX handling for
future VLAN offloading.

Tested on MT7628AN with 5 100mbps ports. All 5 ports were tested for
correct forwarding with two devices.

# Request for comments:

- What would be an acceptable way to present the undocumented phy init
  in mt7628_vendor_phys_init and switch_init?

- Should I aim to set all register default values for general switch
  config or is relying on the documented switch reset state acceptable?

- I am also looking for any and all feedback on the architecture and
  coding style of this driver.

Thank you for your time and feedback.

Joris Vaisvila (2):
  net: dsa: initial MT7628 special tag driver
  net: dsa: initial support for MT7628 embedded switch

 drivers/net/dsa/Kconfig  |   6 +
 drivers/net/dsa/Makefile |   1 +
 drivers/net/dsa/mt7628.c | 567 +++++++++++++++++++++++++++++++++++++++
 include/net/dsa.h        |   2 +
 net/dsa/Kconfig          |   6 +
 net/dsa/Makefile         |   1 +
 net/dsa/tag_mt7628.c     |  85 ++++++
 7 files changed, 668 insertions(+)
 create mode 100644 drivers/net/dsa/mt7628.c
 create mode 100644 net/dsa/tag_mt7628.c

--=20
2.53.0


