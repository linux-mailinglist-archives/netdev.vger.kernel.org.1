Return-Path: <netdev+bounces-145711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4330D9D07EA
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 03:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0049B21DBF
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 02:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4B02AC17;
	Mon, 18 Nov 2024 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Cd0k8Q0g"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF51EEF9;
	Mon, 18 Nov 2024 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731897075; cv=none; b=cSzz2/cTOjbkjFXTCL/Lxx/LgaEgiYrVyCVQqOBHfDYgins0rFlE8OOYed+LI+kJXYxjpAEfygt3vbSHVVlfkgtFDefboKj0UqPseZDEPWqGVI67dscju4iJNfAqw4Biy9HoepAVfwqKy7GBt9Mzy1MHIrCjv5PhePm/g5wSPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731897075; c=relaxed/simple;
	bh=MpcA1Fa6BX7Wln9D1Mz/k90qkx70jn848o2sgz8m86w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SEYXlkyuwu3QyLdXeZ1LlQ+xXLa/cLmB63b5hnDQGPbDHkFKVzsJt+l8whN3peFQyEBsb00bZdt3C5jsA5J0n2BV+he0MKwyGouT/ZVbvGD9sG8FPn2oYC2D88JeTVKqFNvXVe+m11s+ZMjcgTbJEWDQhxNQBDXH0IuWyjtDXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Cd0k8Q0g; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI2Un4jA4174098, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731897049; bh=MpcA1Fa6BX7Wln9D1Mz/k90qkx70jn848o2sgz8m86w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Cd0k8Q0gzezuNjM2L5UQMBj/tv4LpU8GQ7bVWjhH4q/7dG0HJIuaCIY3bs+J1mx/c
	 G4OEDjJKRuRh23P0wINKAniMJygdthrAai9WH8akWYeBJ6TLh9R5QL1XfQ5VIzLk2m
	 K0WiUkKkuH4T5rNpqM6pKTkvzNeBpFaMp7mMCBzfdCkI6ySkY3Uu9dSlrDlgtG3hgE
	 Ib3m+spttsXKJ7BkYkUQhiAnKxuwrToVJDrSCib9zkvgQgyZ8N/QSBhgEcTuZdl7YK
	 pGjdD+OEKTGwS0pI36tjPToyYej8/iT5j4vwzdmxFlLUQeh/ROsg8psQfDVWMa81ZH
	 d5lkxcIGLJh+w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI2Un4jA4174098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 10:30:49 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 10:30:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Nov 2024 10:30:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 18 Nov 2024 10:30:49 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net v2 3/5] rtase: Add support for RTL907XD-VA PCIe port
Thread-Topic: [PATCH net v2 3/5] rtase: Add support for RTL907XD-VA PCIe port
Thread-Index: AQHbN0SFfyRIafwEokSyyOXB545urLK5wOOAgAKTAUA=
Date: Mon, 18 Nov 2024 02:30:48 +0000
Message-ID: <a0280d8e17ce4286b8070028e069d7e9@realtek.com>
References: <20241115095429.399029-1-justinlai0215@realtek.com>
 <20241115095429.399029-4-justinlai0215@realtek.com>
 <939ab163-a537-417f-9edc-0823644a2a1d@lunn.ch>
In-Reply-To: <939ab163-a537-417f-9edc-0823644a2a1d@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>=20
> On Fri, Nov 15, 2024 at 05:54:27PM +0800, Justin Lai wrote:
> > 1. Add RTL907XD-VA hardware version id.
> > 2. Add the reported speed for RTL907XD-VA.
>=20
> This is not a fix, it never worked on this device as far as i see. So
> this should be for net-next.
>=20
> Please separate these patches out into real fixes, and new features.
>=20
>         Andrew

Thank you for your response. I will follow these guidelines for the
categorization and upload the patch to net-next accordingly. I appreciate
your assistance.

