Return-Path: <netdev+bounces-94232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A18BEAD5
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E9C281E55
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF24316C859;
	Tue,  7 May 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aKRIcrzc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70A16C854;
	Tue,  7 May 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104321; cv=none; b=usg2c30oY/0Ga0KUMv2weD8OfQ1Sa5EcMhJj+gr4p7SWjYmDioxAm0FGuoJFM22/pqBXkiZJ+DpQcYSJqhLsF3nnLKo00Z2JNNmT1wavbdWZJ0jBf8s/Qj/fEfsQoO+UG1yuCiqaTHAtrk7evSTd2q8uEFA+TDlpBBqPZHcbMSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104321; c=relaxed/simple;
	bh=GY3MBfwuO10L82PUAiXJzgv81jWZBClNChn/m41ZtcA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=eMBOeM1ZNTVBwz2V5qafspAaOHt4rUgpCOFsqVKIJBprBDzJ/40UXWsE1LGTghyJLnQKokRKd50f4fuhiUh8TLuxE+S6rDyahL8enD8NRpNhvofYYvnUGBPgY4/fWoKapIEWmQP5JHymW5ZsDaHK/6Vdxe/IX8Sb09IGRIP8lug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aKRIcrzc; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715104288; x=1715709088; i=markus.elfring@web.de;
	bh=xvGl9zg4bC/oN/5QMDwRD8vK477Q2XXZGmLCg9b9k3E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aKRIcrzcx8N58iwithOFmR/DZtGvGfJKN11C2CUxVlWKN02Oca8FViV8VZMeD6js
	 GnUoC+10QjWG7uXDJ1TG65uLRfu4+3Cbx/axJ92j5snYH7e4Q17hsjw25LYzupOlL
	 z3S67MPg8cbyQQOCRt4y1dJzz37ve3cgvwb8AJwl6BLTUxY73Fa8jsjwfZhxTlTxc
	 2FI3BqZhL2+bVt0pLMxi4Vt74SFOPHiz08mmlI4LTowdCqQFBzf5ea9njs8C6fBCi
	 PN+aumtvT+6ONm7f4Y2qxrc5r4wvM2pp3JXV8Ve8gNbvQ/BhPvYnfyzxKNs6Pk0Gu
	 lk7cXrQGkpqwTBt9ww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N01Zk-1srRCA17Nm-00vSKI; Tue, 07
 May 2024 19:51:28 +0200
Message-ID: <1c3856f2-94dd-4947-a3c7-e011181283c8@web.de>
Date: Tue, 7 May 2024 19:51:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jijie Shao <shaojijie@huawei.com>, Yonglong Liu <liuyonglong@huawei.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Paolo Abeni <pabeni@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 Simon Horman <horms@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Hao Chen <chenhao418@huawei.com>,
 Jie Wang <wangjie125@huawei.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240507134224.2646246-7-shaojijie@huawei.com>
Subject: Re: [PATCH V3 net 6/7] net: hns3: fix port vlan filter not disabled
 issue
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240507134224.2646246-7-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sftMbWoZIxbDBpbVsIOYNDzevExKQuQKOfTM9MBs3QdgTtma/kv
 9oITSvN4DvQi2An/EEt1hGI/F/JWaKUyyiNegkOsR9FEz9lbPQitxV1xkXAVB4fs4JG0cTp
 Oz5+NKFx4d7LTNOxwFnuiGr2zXLk6PRt9VTJvU4hOUBJ1HansZBWN7kOSfIG3ONDZKoNhhQ
 SDtTQC/uBt5eZ46nvk1lA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b40jeLTvkj0=;FvF090lHEDLVj+pkFpO+hodhSbJ
 zyinFBXQY7ZbhZyNq1XlnSsaadG++YLmBX30Y6f0q6Fwkz3Gbu+409dsYx611B9flLC0Q5slY
 77Y0lla7GwX5rWOYtOGqIPoLPjogk8ZfeE1Pj4xeVc3G9e/ErH/QoTunomfmSY5Q/flc1ac3J
 IDLPHZUA40MZ57DpkCBNsbIHyEpEHW5emXR7nfS3R45I6nymJjgi8vZ4VQGT+R884X+olU1an
 cdSHu7P6OI0pTRCix8fPD3PZZ5cBYJ8eup9tJKoVHl7v9G2rQ1J0c0YVX6mB7Il5Y7E7yFqYT
 wZmQ8rK5dXUN2mbUyySVWqPUTU+LoGKYlM8Av7qtUZjwbGARIQ4gpOd+sF8prqF1Sue2rME8j
 mCDouhReBHqa2FnC1H9udDHmhlmNO+412+PA2yOk9508BJrAa1h+T4gJzGVyrAkYpdXCvBn/j
 lSyUFCLq2lWAXXGDofVooySWFDLtEiF3mGQYmrOcZSXnWcqPzDF+kB4Xs5bUUQxk/Mr0MFWzp
 KVOOJY70YjrIZCmp/b5UEY9gepwIqLVgdZWc4CL2s1RuSxw1BA8QDf/uBpkNCN2fFa7AWPooQ
 CZShpnfZJhSx9MaysTNSwBo2J+WN5wHQc4e7+ZA/lEp7+h4K8nPjac6tA2yCknjTr/fnD7iWs
 d/qvy6DbgWNfjboUHynFPj2RGXjAVhLiN2ezK/cCLKsNesL1HvJEBzV3ZVlF2A5dP/dQNxlPB
 BZhYa1BnBvO6SXpJlN12WjuF7xd/X0KSVoe0sqtf17dAQcaBNiTKDkHtoRfCSGOBEo/V20++l
 GtsW3Kapw9haNLbF4vit04qLxybyMuwbNaIa5saGHQ4zI=

=E2=80=A6
> will not update the VLAN filter state,  and the port VLAN filter
> remains enabled.

I suggest to use more than 64 characters in further lines of such
a change description.


> To fix the problem, if support modify VLAN filter state but not
> support bypass port VLAN filter, =E2=80=A6

I find a few wording adjustments helpful in this changelog.

Regards,
Markus

