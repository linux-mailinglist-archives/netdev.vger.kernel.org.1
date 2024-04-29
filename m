Return-Path: <netdev+bounces-92082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C88168B5524
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84232280D16
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B83612D;
	Mon, 29 Apr 2024 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=radisson97@web.de header.b="pbMIGjSI"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A6513AEE
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386277; cv=none; b=h6GiUYqzfK/HIVBWMDetfdjrFyKGF4a5JvVU+EQqDdPdZnRmsTS7B1h+TW9E5XV8xKh141Qb5gkQvhCVBZ7nQYipec0/7zf0iihc+Ga8adBkooPw6h1aUv9j2wRnTM8isgrLoYUplG5qqwYoUiTAbq2iNDbfT1PuDo1VPoARtPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386277; c=relaxed/simple;
	bh=V4eDadk1krfDjdq5JQaf1OoNc1a/sn4DuaHewdZv+V8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=N8a3bP8R0UGbalj5qae8Im9qLF0uDz/t3sYeotK6xGj77xlBBlAl3fmUwyE5Q8hd0j/5M8czITviXym+5KU9C2K5cMGXOqemH064EiZiazcXmsIj8cZ4lM1POFb+fp/TVaSeqUzVK1uNhjqDjZ51jYKfWBUbG7TueXYAwluqln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=radisson97@web.de header.b=pbMIGjSI; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714386272; x=1714991072; i=radisson97@web.de;
	bh=V4eDadk1krfDjdq5JQaf1OoNc1a/sn4DuaHewdZv+V8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pbMIGjSIxtnYqTw5wG1JPRoaCJVzS9MykEepMg1Ok6FQtNpEO1RpqI6cIoaKsEOT
	 w0MSGUXzOnId7DVaFGD2lB0SheK9xxH7SWQAemD7mmcPtb/25YuQx2FIKuFeMg5oI
	 bNrScgv4YiryOExTyryGXi4NZZVFA4hOjQSWeSZpF7YaS3jEb7BL7JEFECTCJqy/g
	 kyCz9XfjJzjjOeM2YhaY1zwGpt+3EJlgFlh0QT5zBtIPcB8SGa6gx/g5W0IlmnFwh
	 DnZVsCpLpdgTETtL136gMKya3u1ZLsFGJkiztpFBNqSo57EwFM8ZZPtCYDjYuFZuA
	 cbJptjonV4hcYp33Ow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.186.0.33] ([193.174.231.69]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFayq-1rt5v40ysw-00HIbm for
 <netdev@vger.kernel.org>; Mon, 29 Apr 2024 12:24:32 +0200
Message-ID: <a2ef46ba-ba3a-42ea-8449-3e3ae773fa1e@web.de>
Date: Mon, 29 Apr 2024 12:24:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Peter Radisson <radisson97@web.de>
Subject: patch device tree and AX88796B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Y3cKgiC//jupaTbWH3W05dAvlaiQZR4HcbZhFEPUQ0zdrqEHkuA
 yiprFOMcljwSPiudOlrLfhLkRlhDExpIWHIVgpGkJ/7wWvrxFUbAqZ7yrALzkBTYXyfO7Nr
 iHwzXtm0jifWU1QDcbrkl1y6bv2mH97ieIF5Q/D9utWDdHnobNFWU97zN4OT8mYO+4m7Nir
 tv2jyp4MLl5Row1ek7V4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yt50ee55NmI=;DEjuHsvhrk6//b9fSDy/USVdFtO
 JK0BKJmtl0swMl6vNTj4Z9Tb/FrrSQNnkiDIHul4Xo18gpMOHLAdNd2LD/NqzNXHxB0Yzim9W
 /2BGdpDqpvjNz/Bal2i+yfqMyDKrzf37gWKilE6kJy27+xy9Xb0/gQ4GpzYp/nH9DnJ5Cr+TA
 YDiqNvBC1XgDV8drSOsmWv32Afpv1QRBsyM4SBQ717/QUqnI7dMMaIpApAxdXPgvWrPECJqsf
 PbOT2j8PMnEhMb3xdNqW3x1HmjcrZ/l4NHTaiqJlDxnjRb7zTw3IHmVZ+efLGE3EbMFQfLHF4
 ef6k/ZInVF2ZoE6R5LWB1oNr8ZZQ0gtUEJRT1gMEs4arGwDvuEZCWrLuarrmZzjhOTs1Jbb8f
 ngqRjGnsRsU+8J9nwMDUgM8DAp/OyhOebSMqQT9ymkmtsg3qZtFejaFPYBz0c01j6UtVOgGqS
 28A/hNDlkBFajC+eEc089ONrLQoR4Xg7t9UrHHmbN4pUwM7KnDVd4G84EpPrrxqYB1Y4KrS/f
 3tOVct+KZ8l0WcJ/EFEey4YLgDrJMzFKd6cUF0GPh6s6zGPTpzVdYxh9Y/ejmu1N/btVqR7Do
 /EoCjK5AsdSIDVqHqx7CWq2cTZgoVg3pIZ1pIY+30+gdsQVbM/MllxpU2bAp72CwmxoZirDYg
 lAjNcRtUOlKEyztQuQCGoKRGLXuHghrYlHSb+OvKMysCNDw5wCLfy+opbOYbKhKMh9WokKaY1
 iDHgSXHsAMs4cOX7nkZFl/lsTqLdHNn+H/q+RYm8SqbwKKBaneivGpshxIZw2CLp0Y2DuWiTp
 8vMqZG8Du7ixdWTVccSmkN45NhbnDnJaTvC+fCGihkuYE=

Hello,
we have a custom board that has a AX88796B on board. We have a company
that wrote a device tree mapper for the driver (actualy for kernel 5.4).
Is somebody interessted in picking that up ?

please reply directly, i am not a list member.

Note: i am not a kernel hacker and i may have easly missed that there is
a device tree entry for AX88796B, iff i would like to know.

CU

