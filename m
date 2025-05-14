Return-Path: <netdev+bounces-190411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3070AB6C0A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8803B175CA2
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378827816B;
	Wed, 14 May 2025 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=amuswieck@gmx.de header.b="uHIiiM0H"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C3276037
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227801; cv=none; b=NAkhAN2O+FSdnpDawdXB0IzviCGZxWtyZmrL6kNBCS7yJo5tMzT1NirYpK2G6JObSzUPa3kDFajGJ87hMmHE2+By7DsDXWwsKsNMHxL3GAMFgyGZkB4GVzjy5eSTV1J7oySYByi/8ru8w5xBvBuvPnx0qdrruOtLWZ/S+4iLAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227801; c=relaxed/simple;
	bh=pdbFa07OWguMYxcwvIkKOjFAZBrQm8l5Li50PMDCmd8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=D+iNCTV9Zq7+xU+wK88wUC4WL8/qHc7yy6R9r7QkoDI0I4kQH8h/CilS45r6+h43rOa00y+q9Adg/Q5EVqDWE77QlcYECE2OocOBtdg4ueITzPSxuqcpAQTAQZaT5JoELmDDGx65o1uu3jhOPe09RVGXNB9PxlcD46tq+d/HZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=amuswieck@gmx.de header.b=uHIiiM0H; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747227796; x=1747832596; i=amuswieck@gmx.de;
	bh=pdbFa07OWguMYxcwvIkKOjFAZBrQm8l5Li50PMDCmd8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uHIiiM0HgXDbnux8ixifKWzb/JfJHjdfmU3ecl9s8hVfJU4L/M9CBI7wZQMN0x/E
	 7ncx6S6ZsdsfhG/Lym9beg1q25klELRg/7hHIhZ15FnYjTVUMgi/k0vS+8zbwtY1S
	 DotTDjqp4gXXbjNH6b4JBwIf61Z0TghAj5cDzAOmTBRG5A48k5BVwWh24JOywHvXN
	 HHWvOUS+kfBS4Of4ePdxDdciGfLF9GGarUyDjgWlw6KHwBW48JfwDhi0V4eTe/TSm
	 Cngl9xpsfNKN9MN8bO5ACpZvhUaNGA7erVVclulDO85tx/dciaRw+/d00GdBSHinz
	 jJN4ABUWlN824Gl5HQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.106] ([31.17.40.36]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1vAIaa1mPA-00tXia for
 <netdev@vger.kernel.org>; Wed, 14 May 2025 15:03:16 +0200
Message-ID: <bb856c9b-7038-4e1c-ac8b-7fc5af4ca62d@gmx.de>
Date: Wed, 14 May 2025 15:03:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Andreas Muswieck <amuswieck@gmx.de>
Subject: Realtek RTL8125
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TPRwxBfunO9pi7jLxaK0QP9rf3elPe66ZNluK3GXCiyP2k+Shst
 iDfhMccfHgn1CBGWZqmOue7bHzADgdKg9KzXnvczPxj6S+m8inA8rYspDLUVJA30NJpi1IB
 RVVZ8CxGGuczs9+bFCwg98gPCCcYn/st9OYA/sroV1qcZsSP9AhwRtMhB43STdxCVzTkfDH
 MamxOI+IAL2elsoQEcXeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j3C0CkRPVDg=;rmrhiXheKaWoKU9+ZxIDwxX1paF
 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
 nj4TMXBQhvrUKDvzXJ6qz0DmjJYzJCg=

Hello,
My new computer has had problems with the LAN chip right from the start.=
=20
The motherboard is an ASUS PRIME X870-P WIFI. It contains a Realtek=20
RTL8125 chip.
The Linux distributions Debian bookworm and Linux Mint 21 are not able=20
to establish a LAN connection. I have also tried Debian Trixie, no=20
connection.
Debian bookworm recognises an r8169 with unknown chip XID 668 and=20
recommends: contact the maintainer.
I downloaded the LINUX driver from the Realtek website and have to=20
reinstall it every time after an upgrade. Is there a solution for this?

Andreas


