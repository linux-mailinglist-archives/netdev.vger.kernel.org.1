Return-Path: <netdev+bounces-94228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBD28BEA88
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDEC1F25BEE
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE2216C695;
	Tue,  7 May 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JTAX6YfG"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919713C9B9;
	Tue,  7 May 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102852; cv=none; b=AmDbmRO7hXgkbswFF1pYi1ZJywEPB+pNtq/BDNyQM6CIrL3LzTcBL2JriHnd0g7i/E5WmM7i5fVPxPC0FvkIJY2vzlbAOA/thDm9m91SfkwtL7TwxVSAIoDnMvU6UFzQD40i3N9hdVejpDKwswRzbzLXabDtXloGGYIU4maLpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102852; c=relaxed/simple;
	bh=jD6uYVx8rbc/98HDA4ZpIZc/J2IavGiZtfdo5MM55Z4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rNKC9S7ReC9Vf0dmpf9WwWivQgmSJGOkUP7LSEc0jj7uf8M7KmUS9v1hY+jBhLLd4H6WlG0sJULHqGN05IHFbwlYPw2TtJLQJccdRUkB8qsaYnIB+2mYYSBOoH4qky/m2fAoSRBNQ5e4LJgZYd1O4w+EofkiK6iqu/79Lvw6SDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JTAX6YfG; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715102811; x=1715707611; i=markus.elfring@web.de;
	bh=C+kLGBnJNEx50lH3P5EWi8k9Rwtm4zhAx5svv7hYxmE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JTAX6YfG4221tvYVuORg9Qks6qzlzqYrIpBkxhL3CoBim/NiacKEeHx/05sShm/H
	 uJ6b5np4XfnbDUmYRFsSxNuQr+OHkvfnCVFA1R5zJTAKXmc3xDrLFlvZ6EiE0yKxT
	 FFwgI2WtPF2slNoMHwoQdi9R+AE8n0SW3M1GLpn5FNBAWe8F2XTtnHTYS8mDmPZ1V
	 yK1ydzeyCN+9YeX6tS5KHddlxkyfuFboltvT2EZ+/uzZXJB37DGfQabr/HD3JShz8
	 9Jhh9nbDdHM9HGj22eKUkz+tYiDD2XgOwx/sEKJBVDAlRO0YeQDIRyS5L7FY6JZ0W
	 X8+6sMhnRcpaM4WkVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9ISr-1s0pwq1NeJ-004jB4; Tue, 07
 May 2024 19:26:51 +0200
Message-ID: <dd2fbbd3-9d14-4040-b5f0-a07da99339ac@web.de>
Date: Tue, 7 May 2024 19:26:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jijie Shao <shaojijie@huawei.com>, Peiyang Wang
 <wangpeiyang1@huawei.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>,
 Salil Mehta <salil.mehta@huawei.com>, Simon Horman <horms@kernel.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Hao Chen <chenhao418@huawei.com>,
 Jie Wang <wangjie125@huawei.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Yonglong Liu <liuyonglong@huawei.com>
References: <20240507134224.2646246-5-shaojijie@huawei.com>
Subject: Re: [PATCH V3 net 4/7] net: hns3: release PTP resources if pf
 initialization failed
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240507134224.2646246-5-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Hw9s5sYlQhOn2cEZWzIg4hsX9x+raV9DEjiYxo/MYl1g1cVGM4
 y5YzKwsL6ArzR2UqaipP1soGeCluBn+hLlGseB/yOKxSxz2bKA6CjBZmPdfWD5oEqWJOgaG
 /+ZEyIq6Su+lO9eBzVahq5/poR26TICcZun4VLY9Rqx2IBu3v+WtgTkRMt7/vDzETmb6c30
 1vfQBFj3hy2oAjfJrfIgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TAdli9LW03E=;qK31+OwneJw7czSvxXtU3Pgjjv8
 1wIg3KHhaZaq4YPd7ugU1jy5+s1N7q4CZuNNhQXD6lZDNO0PjVyTN7uDQf+vt3SY4Gqz1qyYu
 XPDxL2nXbMInt4LeqdGgrII0OcRSe/Trm1boQ5xhLdXMz/22+kEY7xhyeSE9JGZC30MicZCTb
 Nnn1CHvjX2rWE58DkQVv8bslrBitYTNFz/uamvzahJ8TDZbvQzTSPJ3CAxglainfDuf79GFeU
 cEPzG+5zcc3kF3in3F5P5dZZ2Vy/mD+FUu+Ol+5r2edAa7gORDdpGyDRpqPr/gwRgwBfks8hJ
 s6jNeTnqLLbIChBZ9/Zbic0LNAUhpnpXbt3hj5HPx2ycuR92uB8NSuCgLbtI/SjW7R/D9ITAx
 7YCet0KNFmJ1pCbKcXIWzEgegUVG5iUgaasMlTKvsDbJri1av6fdIh0IJQo8p0SCLLGgDUCY7
 rnKzij2syehPZKmYUkas9f5eqXudnS+2gOpJv1/TkEcrhVrUMcLA8iU5I35w8oVcVUNBCMJaS
 HWPzau6ofEvJiBNlSiw+0Xh/tmNsyfnq8FRriypQQw8qt8ziJ6tESJ9rfyc1wzbnI20rkTN+M
 TqUY8XRJchtV32I4o6v4W123VQp1MSUx809VJmYQkJI9RPZQZsAa1LN0uxfciJl77iFrsI965
 qheH/VImcNxM3NePNmwXAfLjSWLkn2rzywkFwwifOCDGdfNoWivXiqTiTL5CmRp8DVHIqbXR5
 VnlgGBF0yFe82xeZK50U+AtKwjtlMzALR3x+/qhwo0PQqzWcyAERyOTPiB7KHkysFIny0cYc5
 BahnTBq1NvAjRfffHyrXZ4NFHgrtxdwSZ9QPLA2wJO1lw=

=E2=80=A6
> code, hclge_ptp_uninit is called to release the corresponding resources.

Wording suggestion:
   Add a jump target so that the corresponding resources are released
   with a hclge_ptp_uninit() call.


See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94

Regards,
Markus

