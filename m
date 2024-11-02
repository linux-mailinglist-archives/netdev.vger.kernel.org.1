Return-Path: <netdev+bounces-141188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7499B9E3F
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 10:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A17F282C91
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A69E15B14B;
	Sat,  2 Nov 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d3hYGRbn"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909C14A630;
	Sat,  2 Nov 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730539946; cv=none; b=YORZXJQU92hnthN4Oc9NBzHK7PCHnFAkKWt+MJyNt0Bz1URPjQ5yhAGdpVD/xByXmu7y0PcairppOoR47q2v1hs46IpnC3SQg7/HE6ntjVcOyfRu5rdlu/A4LPVm7PunGz4GYkhs8uUxZ2nNA9FHFmFcK0wk9RvYgIJwRzLCT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730539946; c=relaxed/simple;
	bh=L0p512+wKnI/6xaTCdQVunEfviAqYTnZfB36zigJnrs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=elHO9hOSiaKFncU/vLIwIYt4aXPYS9/7FnuX7ibmao7XVxbmFQnwBYC/RuAsmraFZTCckxRwPjkYFqzvXQOoM5K2SNYchT1Ry5UAF9wosEJ4qzYvGFGmItY8Z4TBeM0YrRgDbXkV3QKbrWcFAoPKTvTfe4e+BadwprK0vI4zOiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=d3hYGRbn; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730539896; x=1731144696; i=markus.elfring@web.de;
	bh=L0p512+wKnI/6xaTCdQVunEfviAqYTnZfB36zigJnrs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d3hYGRbnxdsWEvnBfogKvBHHrIAwTgmrvCn0/aqIpnvLaOmPap4ACPnOdBDkKa++
	 btVt4RCjX6uZgsoAWMBfvYWdQdAhF+aevv0FhpwM1PE3UEMHGr6RsQGIXoSE62Uiu
	 GHPDUOsG83t1OyQlfdU4prAVVsp4FQJXhOdEQxTAPSY2ODtBY36NMd9WvWSc6CQZK
	 yDiYG3GzQw7MVX+vlxIiBOpofmGsKHswAM9WL48DUsg/yjeobQ/y5X1NiXafxdkpA
	 6ghtGQ+CBIx3RSyOwrgQgo27liV968gIHWIztnRMNP4mygYfLmYuV2na8bbgakmT5
	 RnRkH57aVNE6yPUYng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zns-1u12su21n2-013w2J; Sat, 02
 Nov 2024 10:31:36 +0100
Message-ID: <736ec702-32ba-4dbd-a16c-b6d9a3ea99d8@web.de>
Date: Sat, 2 Nov 2024 10:31:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jinjie Ruan <ruanjinjie@huawei.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Liu Haijun <haijun.liu@mediatek.com>, Loic Poulain
 <loic.poulain@linaro.org>, M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Ricardo Martinez <ricardo.martinez@linux.intel.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241101025316.3234023-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH net v3] net: wwan: t7xx: Fix off-by-one error in
 t7xx_dpmaif_rx_buf_alloc()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241101025316.3234023-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wcGJN4f4NEfZvSdXi2sdemW8FWLyhKS4aAh8DIJ6XuvrIylPzme
 Ay9c6x6GD+iCx5aYv48DFAdRpHe3T/w+8KVx+S1GbHZS+h6Hb4s90HSx1OWQQLnv8nvsPgI
 ZbhCCP5NqakPFPK6bTFdM4Y4e66uTR4NL962JXGF9fZotL+pMO7Do2mXJgeWodWfQ6OaDLh
 KRDPG66IT8qCuhBIXwikQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WjRNz/H5N7c=;0oKgx6M5GVDCtQEbVyX1/cFXwlO
 3YdlomJnNwpUFNXFwGSGnm0v4RrutYbu5MjN0+lYoGsD2Mf78QFxKbbDwUyhXWAN6QXreVwOP
 xv8ObKnn3nh2eZIWkNEXSYEYrv3EcEKLFhr8se8LoP82FZPLM2/10XzoGWiKIcbKoAp6w3YIk
 BzCzbbG886JjagEDCSWY8nAkcmXwPqF5j+Kk+T6AGhS/wyDXyDC2zkm1SjsFzPIEqlRF178af
 ra7dCMjQ74UpuHtRl7hkm2oykUGa+Glvlw50/qH60IqtYR7HSQe/M4/RRoEPmB9BbJ4N6MYHz
 cWRJxVVMcpRt9hIkoRbayRUTNJyOxXF8qd499cDIoDqPrRJwXMVXCjCKohIzralq5rU8Ioioh
 aid/euEcEe7VPQ1IuPZf6X14yTM/pQPoTWQUX55cPzLyZ0o3+GtmiIVbN3OROAwx1honVD84z
 3XNmxEVZj1z/JZmaF6xHMj+3uL8edOakayZoPcFroufg9ULeecHgeUprNAgEdYb0erOLAvx7R
 sjMArAH5gFHKGca/B6/q5dJ3z2W5rrFVGVFEkRJ/4NO5LlYE3fdvWNq0Kg6FPfXwqszf4dg89
 /hf5uGCu+uVPK1RvnfjFSd8zWxptzKq584atIfYGF/6kWxko6lFtdi7MMAJssQcGOVRwLkDrP
 9279Zfzege6Lycr8sSP+U0jCBWX1L2NvDK5t955AfOlI38hOVXZh1J+LJw0xMeUE3MJwYCV84
 wt2I0OLQ/RFkZxJYj9SdawdgbZ0pO468/T+52u/3piY2Xw0FUwuPKZZjzHcVQ3dK694EXHrHa
 wcxqB0eqE3Ar/JD2KJkxO8kg==

=E2=80=A6
> Check with i-- so that skb at index 0 is freed as well.
=E2=80=A6

Is the same source code adjustment needed also for the implementation
of the function =E2=80=9Ct7xx_dpmaif_rx_frag_alloc=E2=80=9D?
https://elixir.bootlin.com/linux/v6.12-rc5/source/drivers/net/wwan/t7xx/t7=
xx_hif_dpmaif_rx.c#L384

Regards,
Markus

