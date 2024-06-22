Return-Path: <netdev+bounces-105876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0097B913596
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 20:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182311C2124C
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E8818622;
	Sat, 22 Jun 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NiFcYDTc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6FFC8E0;
	Sat, 22 Jun 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719080311; cv=none; b=fvgHavTysCAq0df/yZV12Ak/6++qvhZJOtNNST6Ptz2zLOy/3F0RHm5/icDjrIniq7E7hW3v2SmDpfz12nA0cqMDWQvxzOOw57TgvQFrMTttOOrOp1ApUbNQWwMMLYUk0dBpPTVHP/F86Don9zuSOLsKf8pbSCfaZeaEpAVPurM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719080311; c=relaxed/simple;
	bh=nUhB3kB/P2Xw/DA3kxj07d12tzWZkOLJLe+sOllfqNE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Mo4KaQMTRkH3XVXQq4oDdI7Z0bNQDdadXeDLeJqY8HPFBr5So9nxRUzl+7NYq0h55o8fzM9ILRMIpD/P9xDhKaOGZCwf1OoildJDgGN5jDJ9zKhGZvcObW73yN6ZRXvfxroo0Q3kTslav/b6B5VkidYKopqcv16ZmCNoyuQJzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NiFcYDTc; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719080281; x=1719685081; i=markus.elfring@web.de;
	bh=nUhB3kB/P2Xw/DA3kxj07d12tzWZkOLJLe+sOllfqNE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NiFcYDTcHsehHe7y7Ir5huQoqGTSWx5E/nqMxAyRRjfAXFudLnlL+4+Fp07ZHVAt
	 us/uG43XceW07xO/sMolbCR2pRJ9/JBH58h+ezm+jFcyLjTXJN9qHdJsyAQUwWA+j
	 KB2yzb+jCgMAq3zNxyV5pgmSatg1JmN92B+AibvdmxoGgzloidWJ4nsr28RZmwgHU
	 lO1NeAnSU1wgT8HhrvgwrkswqHhqnBtD/EXrGmJNntCOtRPsgzLTVJuFN8TtLjIbK
	 BrL0ZEeG2GhT7FELRx549sYD10rOjm9Y1myUVJadH3kWdILXl3ZJZZtAju0zcolgb
	 P4NUrgSTm+oSen93jw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNfUF-1s0WPq2bBj-00Unz8; Sat, 22
 Jun 2024 20:18:01 +0200
Message-ID: <2cf888b6-f8ec-4632-befd-bf2678307a5b@web.de>
Date: Sat, 22 Jun 2024 20:17:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Suman Ghosh <sumang@marvell.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Jakub Kicinski <kuba@kernel.org>,
 Jerin Jacob <jerinj@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240622061725.3579906-1-sumang@marvell.com>
Subject: Re: [net PATCH] octeontx2-af: Fix klockwork issues in AF driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240622061725.3579906-1-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wZ+mrufKHGigF3LhXrybNsaTA5B1/fmOABj8BYuaJRESinrZclP
 tKXKthQs5SJL/oEdzs2BUOxjeZzGJxGArCQvKZh2YKTZNjdUo3MH9yGHfwTSCSO+X8E6EwC
 Q31dQf0Hg4UQZP6gr0+SUHdTy0p30Dxu4NyQTFRyHXQVvrOZOwQGk9IraRe7Cpy9QSXWkFU
 d+vwmXotGEMhDNPnsaG+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8ud2tMf5Rjg=;CeXaq4CzrQQtGpb8gnhx6GlgJv0
 FZleb0eK1x+IgUmFInj+RrxLR0VBmMPll7/NzYJS0nNBp3OLkCWTmJ/InfSHNE/NCBHhqyibK
 GffqhZec/lSKtJLrpXTeRWcNJ8tUlaIAPjK6aFdJhX18wxY/B2uBMd3xqvD9t/fHjIQvjm7wM
 o7xxiXoXvplI886ueDI+3B1nP5rkD+Wrd4uzROOM6WPI1kl5lWmyk0vahDOHOsWMo5u0htPF1
 dnLuIRUZL7OG0G9pMB4zDlYDNdPXcLSDa+uLBjUZsDHPAxLaE2t6MWJhFTgMnTv/BgUnKL1ZH
 mo2J1ICs2pTNg8/vsowt0scaVsBZEA6sbkEqwl6qDiy8XJEtaE3PzQjqjl4QKWWvqa3yQbkLT
 p13JIsEboumcW1qEGeNJxxC9+QuEk0u5wPDBNe2ECa/rASI149NBWLHAwajSpyanMgTMyr+Jq
 dgN+HLs9/RaKxC33mmSxWQ6gOoCxTN6sE9UhaiLUWG2aMy/Ajlh8rC8Ql6PFCrTdvsY2+mvM+
 4ktW1BpALCEcMW4MOcyfkxlcig37BCDHm0p9rO+Ui6pTI5+LjAchNnQvvPXmG/2wQVlWb3qVQ
 nPA6Re9O7UdtcXynJjoUR5YWBIlTiHxmlwm77TloO8wCkHjFt6HK9Zstl2z7BAtTaGgBLoG+9
 4yPAAHudcWiJ0/v9CXOSCTR87BMoIyO5de3cqqqNm6ZgRwSa/iV+zxLFFTcr+iB9+Z7GWh2dm
 O0kY6Sk5foabu1VEYzH1EArTgbDfDnhg92vrh+rqTg7+jKFYs0z3dkdTwRXlC0oeTFa5SZJsl
 wUxUNWa2ZJNVr9ov530MAeu6O+ZVMvbJ9bXYFdsTUoI44=

> This patch fixes multiple minor klockwork issues in octeontx2 AF driver.
=E2=80=A6

I guess that there is a need to split different change possibilities
into separate update steps.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n81

Regards,
Markus

