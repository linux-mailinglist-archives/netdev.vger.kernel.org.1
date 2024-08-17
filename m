Return-Path: <netdev+bounces-119407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD169557D3
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 14:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7BF1C21109
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF6D14A4D9;
	Sat, 17 Aug 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FB8a73Q8"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9963A145FEB;
	Sat, 17 Aug 2024 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898380; cv=none; b=Ik+ldk5rUGyGV9HKKtAW8cc9Vb3Rr5S10d+rDEQKu387wJdnEe4Q85r2ksqz+E5T5FgbGdYoGrFZty2mKfzmE+YzczeXitVeHH+a7R9HGEgsB0AB+5erfg7UTWIf5/RZXl5w4ExEpXm68aspov5knJ7d6ALC/Lb3nDgToWoF6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898380; c=relaxed/simple;
	bh=yb1MC3sZ0+bn1v4KeNzIeMZUq/Bsl19ztRJ3on5qf2s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=O39F3BaPT1PjWZuon+ssV97yUCgaTo8/FeZeKiqOEZgJi116iQCTHF8Fb4lMwIQTxHKvVE2lWcZJFxIC1aBjX7R6BF7MoywEoW2oYM3SziCIuw56+WP2EIlAGcid/vrbRiNBzxSHrMolcVofCuVfwlEeNgyb+2cFHEcDshgaeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FB8a73Q8; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723898343; x=1724503143; i=markus.elfring@web.de;
	bh=ICf7bpj+6uOFRWx1JCGajxQBSh+2HY/zNayuuHrMFdk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FB8a73Q8hd1x8CsNhgMzL3OtYSyns5C8vkIsmOU8OhjTo6Dv6trfRpYRDbq4EmJu
	 0DvTSdDrhA0UZaGSigsumGvy4oV9m5LkI80KN7isLO7Q+FsnkiXW7MvCpaYos3+SL
	 9+LkG/S0zaGNhZS815Vxdg53A3qq4Jc3x80Iqge7Ktz5gXq8F52nUDvcjNdjBBj9o
	 GtwEKwPfumSKVKWUBZa443v5m69pJ27dUIgz4dWZfgVUp0+BG5cJi1uO6cFVCmyBK
	 nbLK6PXBlsbdBppxRrtJGrxKkqx8eHxz2bYcjj2ZCbjJxo9WGGvgXt1lK39+Ew4/Z
	 lqpY5mxbg8dp8yUQ4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWQyX-1se0J21YjL-00HpcF; Sat, 17
 Aug 2024 14:39:03 +0200
Message-ID: <5fb96c5d-aac0-4cb6-8a1b-8d13990b05e6@web.de>
Date: Sat, 17 Aug 2024 14:38:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frank Sae <Frank.Sae@motor-comm.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Hua Sun <hua.sun@motor-comm.com>,
 Jie Han <jie.han@motor-comm.com>, Suting Hu <suting.hu@motor-comm.com>,
 Xiaoyong Li <xiaoyong.li@motor-comm.com>,
 Yuanlai Cui <yuanlai.cui@motor-comm.com>
References: <20240816060955.47076-1-Frank.Sae@motor-comm.com>
Subject: Re: [PATCH net-next v2 0/2] Add driver for Motorcomm yt8821 2.5G
 ethernet phy
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240816060955.47076-1-Frank.Sae@motor-comm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d5v5anlRpvsE7RK8ekGSmQo54K/g++GqAOQcA6rKXx6TUGqK5cD
 ynCVfYyDJEZoiKRIlz9eOFj2KeqcZUsimU5252Ri63r8bWmpXOHUiAIglmBSoH+xwy/1es7
 Fc1F7eCsPUUppBPQ4Vfq1l47RB4jGcl99J25EpdJFIJn73gKHt7UehHMruDoo5q5A+ea7iT
 J90yc6CpfmOr4KO4q00Dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:63GSw9z2n44=;ADBvyoDFe2U9JPPYdKpmAvxmmEm
 U4Wk6hnVUxWhmRYxe1CKN3DcVFtvmGORm0U9SnYcanDBPF7kReVmUYZVwKqvZ49FaWFWSTLpf
 fvP6IodIVKtKIL98cTK/ZWM4oCZGfOsTqKkLzKOHnhikNSurois0gMW5aPV/QPOucPPvMTnny
 oIPE8mRGTCImri+aXdmVJgk2jBoKXwj4cZ93B+nC1huvXARiaiVtRFIraHRY7Zrp89DqWTBb2
 J2xp37cpDd5aJjwweOFZGFv4bVNLv0ePLyp50442eRbqQHPBiJ5m95EtZISglPFQstQlFIpkT
 hMwFjYz8IKEbQa8XOP0XO9BVoJcjPG1sUBnAoHryAawe88KYYKKvavGFUrWtvHknuuE+ToK3v
 bQNcK7aLNyp9/oZRvXj8OTXfFsgMuqs01vQj/ZHAObFgW2BIUVonK7zHkzx+/81fajddzu/ha
 Co8qa4bTBHyfZ3s8wdIgc5DSlKXZeR8tBPNnnWWhcP7Ij09WnMBxPeHMKlvB0JSU7tGbUn65N
 WHLfTXKysV/yo2uYQIpQJaQTRiSDzRind+I39+qAkGBwNgZFAtMGeUQHgz+EgWoT1w38EzfbJ
 Ko/moXYqxFjtKTI8pIgMdb/wxE61DvPbhHVXTY1vSWRo/3FA5yI7WWBwsR5BlkcdSWxy9nRuz
 Ij469y3MYRs4K/C1bPOXbVc+EG1hgyRaWLdSn8uX/Q9yAxN4ELB+dyqjnVQiEy8gHRPGMkpy0
 HA20He0kCEk0z6Y/foOTB2UCIyWhk66N22qPeUSVwwAh0KExzIKlncdZ0d2SuY06QsViQQhGG
 ZJLzCXOpSo/CDI+xoJaVV+NQ==

> yt8521 and yt8531s as Gigabit transiver use bit15:14(bit9 reserved defau=
lt
=E2=80=A6

                                transceiver?

Regards,
Markus

