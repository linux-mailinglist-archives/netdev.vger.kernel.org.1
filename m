Return-Path: <netdev+bounces-106623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A7791705F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDE52844D1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8A817C22A;
	Tue, 25 Jun 2024 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EEwzxnfX"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913417BB2C;
	Tue, 25 Jun 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340657; cv=none; b=H6sRSqPwa5N3ZDJyyUW/jv8nz00Bv/AwgEol2X8u2DVYXp9ks3qsCRf3+VaGAw77+D5MWQSBvLsP0uMSLei1+6huVcXgoKxlIqR0AsfAg7CCq9hRtVShcksvtDgwjO5iaCkSKZx7Q7s7i/7E3q/xOfY5WE/OOptHGvG/PI2qrS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340657; c=relaxed/simple;
	bh=BcNPqhdX1Jezx47Nm2DHVvZlt4TXAklF0cVVOknZOAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=AXopq2akhrMMw/zrfLu87mo9nCvUVLxDeEi4lUEZFxq6pjvIcPiercUxg/N3uthAwPWkTxldlzqTncajTyLNUSTfeSiAtPGMl80fV+tt3L3TzYgH3SFUMXK0rkPdNCncSGnQCsV1wneXjPRXHZOdfOnO4rehMKRbcIzeJp0UdUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EEwzxnfX; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719340631; x=1719945431; i=markus.elfring@web.de;
	bh=4FeUMM41rBgZTT/36ibhfoknQQkhU5GwynYwSWPeRUU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EEwzxnfXFB9eRWf5Y7/oJ6mX4Sh9+1zSm69ip3KnNTJ5aua1HTfO6tCFLvIps9Gb
	 iSzBaaFqdetVvULFS8vd+CQ7X+7K8SXc5teDStoy6j+YYYVOuHcUTNmLb/SjieA/2
	 Mkdvv7I8XIvqEcPV7Nq0vnjjInIxUhDzMoIE9OZlY4C5xq9AJA0i97V/w132ebFXi
	 XqCzkGFOpRcvZupYP6TBs+U2v00//5liJLfiDKK5m+cUYME8CNL0dsZqfi5sQEhGC
	 nns8tJY7CI45XmzOOGKrajI0y88IqEU+aV9cka8YyeIjnq297R1EvozU7BHKPEELT
	 jozLfqne81XFzO8wuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1aDp-1sJ8u41eQd-009WO3; Tue, 25
 Jun 2024 20:37:11 +0200
Message-ID: <1bee6344-cc98-4746-921f-31454a9c3008@web.de>
Date: Tue, 25 Jun 2024 20:37:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 2/7] octeontx2-af: Fix klockwork issues in
 mcs_rvu_if.c
To: Suman Ghosh <sumang@marvell.com>, netdev@vger.kernel.org
References: <20240625173350.1181194-1-sumang@marvell.com>
 <20240625173350.1181194-4-sumang@marvell.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jerin Jacob <jerinj@marvell.com>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
In-Reply-To: <20240625173350.1181194-4-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gjsARz0OXTzGo09X+uY9zbdeX+i9ULc5X99l7Y26zZmPNTkqT9X
 ounZnHSvO/ZJ8BFJ/y8p+fV0tFzsA4npi6M71NXHrmuXaFviMZnCQf70rYhYMje6jDl4FYC
 troS5BHz0JYtaFu7EkrZxJKCauK08ZZ7/O5N7fzzVLmnc9edLZjG72lWrqiJau0Ge4PNGx6
 uE/VpS4YP85Aoh6oZoG9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G4ISI3yF0CQ=;HVZzIVT24a58uqzOjvHPMI7ckAs
 leN1ngfHBbKVFuWv9Ce3UgCzW/F9VCVTHfMKvSjYI2lM41nSJe5RgjIhvUpZLXde9COtwHnCM
 v/vwOA0PQra2aNkRxATwyTw4LDYH9zay27VSz773nMQEBK2Src9nXACg+NqfVkLQQ7veFUoMk
 f+uwfpcpvLlmWqiB3LvcvyVmyGTsKm/r2/iO/1N0AElSGS/SAIUiwsF0o2Co5fwfNLDn5S4Cj
 Ew36PWr9gZz7fhhnqVPZw45OSpHC75+fnYlEAnNQNx3QhLu1+Vgb4yBGim096jIj41VUPPCQn
 j4QROYkxMn3TVgcieMgX50uFygDPybRamb3ckXC4MsPeOR7aiD7K9X4RPQEmYnnMgSC9DUojm
 x2Nki7kPlzPrgAXax2TcMDEVgn9yBT4ukUMWGzq+X36lBVen++grnutp3gvzBOJIi+NqPqKzp
 pkbPiMcbfpO4rWpHEkew9qEmBSZwRXedxTmobCmtleiPHTvwNAXal91c7/yNooIzZEjOVtoNv
 VzDi27Bkz0feSWPhOPa5t+3ZdNEFJcpPQj3S5pEaZXV6JLzJ9SyhYk4zcLlG+c83uWxl1p9fj
 VUio6bDEqZnsZBXYiFzsoTIpiloEWhhqTQm5HTQNnTF/2I3GLX4JA91HF8P5RwMgU+DDO0PBS
 5BmY6Uy60RuibJfnqyoErCJUvPTRCPVbjaaao/os1krJlqLMnXhjFmb+lECZAefepzuXSg5cF
 c5gOKvPDRZTI/XlxjclTBPhRMzwml0WICnMk53Te59v40nlt3z1yT/N5s7VMt87HoqiNGntpS
 VzpW15iBXirGJSq8wxC2jvtPhSPlzD1q/PUYqDnIxcI3E=

> These are not real issues but sanity checks.
=E2=80=A6

* Did the mentioned source code analysis tool present more detailed report=
s
  and special development views?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n45

* You accidentally overlooked to specify a corresponding version identific=
ation
  in the message subject, didn't you?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n668


Regards,
Markus

