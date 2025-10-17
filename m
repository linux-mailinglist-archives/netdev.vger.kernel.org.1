Return-Path: <netdev+bounces-230468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 927BEBE874E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 13:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88A719A0B89
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA227B34D;
	Fri, 17 Oct 2025 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vFjIM6/x"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC2192D97;
	Fri, 17 Oct 2025 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701927; cv=none; b=l/oqPl9158i/KFtYnKXI3YpwHyOQyQHVmQX5Edk7JwBwSAt/oTVYX81k9wcrlMVaxc28NUKj78D1FhSRPD44niu4RmyMO3Xff3sgBK4Bu/X/X+SlvMNxrEwPqk98D5mpl3ahe4MDtigLvIGpXKIYLcXbMgc6YEWHTG4ojs9GXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701927; c=relaxed/simple;
	bh=npN2sTmrdA84Qttr4PuvN1djQIP/axEMHf/joC/gBq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdIUyWh9XJSOTpzjr7cgZdb2WT/TWn4+f5aagHM4DYmUQgKc5DHWYn7pyWbEV1AdXwdNQUQTe3JKUF/nDs6xdQ2hRJSsqfrn6KnmDiUL1CcoLIV6Vz6+49a7rJEXrqzDfUATmXnbLqpbpx2r+uNrpHXWRHi1ClKXjoeguwoblQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vFjIM6/x; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760701870; x=1761306670; i=markus.elfring@web.de;
	bh=7rn+7qH9YNbNWqTOkr3IRROK3XrCxy78RXXFl+DKfCk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=vFjIM6/xJSP2iCkVi5wZSSBkqaey7xM1rU/IkkpLD6zCsx8IxA/7lvYgljAcxJHF
	 D4EDmRqs1LOkWtemanXX4p4z1UxAKjz+uPCFYcxGVcfT5SJIlPkngHJhkpA247DBp
	 lfpgKyGim/2v2kjHpASxuKUmUVngHBGfGetyo3VEDNbyYwpOcpzZk+LsSUMgbBCl1
	 ppjKFRAliEkGF5eRCiWhKVpBajs8wyofoiMXJO3IeOOLzKwHLiugM0fyEAREyPTFi
	 QcQUAG2zm/N2aRz8i4XEi33BlQV4bCnWexJgLuPDlFqKsfaBd2mJDN0t/xZlEztj6
	 svhIE3+/SLkX1yBAHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.195]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M76bb-1v8M4n0S2p-008KXZ; Fri, 17
 Oct 2025 13:51:10 +0200
Message-ID: <e8b52cf3-9f77-445c-8ba6-d8ac402841b7@web.de>
Date: Fri, 17 Oct 2025 13:51:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v02 4/6] hinic3: Add mac filter ops
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Gur Stavi <gur.stavi@huawei.com>, luosifu@huawei.com,
 Luo Yang <luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>, Shi Jing
 <shijing34@huawei.com>, Wu Like <wulike1@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>
References: <cover.1760685059.git.zhuyikai1@h-partners.com>
 <dccaa516308f83aed2058175fdb4b752b6cbf4ae.1760685059.git.zhuyikai1@h-partners.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <dccaa516308f83aed2058175fdb4b752b6cbf4ae.1760685059.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:exNDUQUaDYXGKgkdCRGIVwXzj/G3jScmhEVC2XTAPYg6wOjZJ23
 ZoWVwlZdTOW/tvflJdfVZY+Z1ET3uo/gRsLzldvMtjOEtgeF0zTyP+MmhdefgkPikqkfGkm
 8peYMi64jMXIQNxkz3VlBgLXU//+85SzDaaZYD1963pMYqqrht6MddmHkj/HeFuBMLPumpj
 CL1hx9BuAVCW6B6d2W45A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:09fI+3qVlno=;6vIopFBdm/viI7iYqBoe+7tFCi7
 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
 KONt6PvctI27GIklo2rR4hvA8D+Zb81ERdU=

=E2=80=A6> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_filter.c
> @@ -0,0 +1,413 @@
=E2=80=A6> +static int hinic3_mac_filter_sync(struct net_device *netdev,
> +				  struct list_head *mac_filter_list, bool uc)
> +{
=E2=80=A6
> +		hinic3_cleanup_filter_list(&tmp_add_list);> +		hinic3_mac_filter_sync=
_hw(netdev, &tmp_del_list, &tmp_add_list);
> +
> +		/* need to enter promiscuous/allmulti mode */
> +		err =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	return add_count;
> +
> +err_out:
> +	return err;
> +}

Is there a need to move any resource cleanup actions behind a more appropr=
iate label?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.17#n532


Regards,
Markus

