Return-Path: <netdev+bounces-180860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E9DA82B52
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C57B5138
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556FD26E14E;
	Wed,  9 Apr 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PphQyRZr"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D226B96C;
	Wed,  9 Apr 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213701; cv=none; b=q84Zk1EG6wD4o9oXXqlNYadOfQ4yaC52tKk94Meuv/EUpu9GZscDBYwKrICDlqPY+Oa14mhnBzYQcnmF7rTOPqjnI8CjQ4H//q789kHErFE28c5+G0JTgWAIYb1mPmfKr4Pbx7KbrkMDaAMWleTIHlmbR0nBM4JIGl6O9O2Z9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213701; c=relaxed/simple;
	bh=j0V1wck0xZxzCc/1mxSTxnQIbGt4ju3zFjXLX5tgr00=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=F5DmYSJGAqKa1AbyBSL1nxJItVy94nB0WGZ9ZMXNtxBxDJIBmO2SFRigLEb+I+F4M575WYxGuq153SjhCMzuwXLoy7aTUOfK27x/8fhjT+0T/8cw6DCo7Nisa8pBJ5CkfcrxWYuWh9GfXIU1FMttsB3aRlizMOWTA96UHhbOCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PphQyRZr; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744213668; x=1744818468; i=markus.elfring@web.de;
	bh=ib4IhZGD0jDk7BbJKX7gsQ/I7ag9tHI6LBdrJijgTZw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PphQyRZrLM0QJHWznf39jSzf6Rilc4KAvbHUs7zYJgtsz5wJaR4X50gETr2jWLNe
	 j7GdHkUeGfHCSakW7TV/H4TkA0R5SJohjqZC60EoEgOgDNbxnk7m5hN7WKnXiW6dL
	 K6DhDKIHDknR1yRa0GkkFvdCJnHIdGduwKqqpfsfIkufHjhcBRRVnaDPxCVyKXuci
	 wf+4ypFqU/1T+MalFV7rFE/eMRHTAsZhUIElfQLcOypEpSfWyC4+TxuFyMtFDsiLF
	 ta7H6N/nNqjbiOzrcnB03HG+VjkPRTsx/1XjohTlTM+w2HhS5I20nki94yW2ONfKd
	 D8Z1wZ+l+/y0QGvUOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.27]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myezp-1t8dib0fHR-015vDX; Wed, 09
 Apr 2025 17:47:48 +0200
Message-ID: <5cb34dde-fb40-4654-806f-50e0c2ee3579@web.de>
Date: Wed, 9 Apr 2025 17:47:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abdun Nihaal <abdun.nihaal@gmail.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
 Vishal Kulkarni <vishal@chelsio.com>
References: <20250409054323.48557-1-abdun.nihaal@gmail.com>
Subject: Re: [PATCH net-next] cxgb4: fix memory leak in
 cxgb4_init_ethtool_filters() error path
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250409054323.48557-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1xqDJl4bH+XFPfuPRah1CtMfk+/ByhWXB5sJOzItbSfnuvd0Pzv
 UNaF+GjwpBNyJftGdjrggJKgW1f/10Hja17KXE2HA2Lp3jHjIZbb+v3cDo5r9g9W4ibgxz8
 PSBbvthRJzf3UMZvlVEJp8K7FOKjqESI2tPOcZ+56N85w8H5x/VMrSFpcmRhBLf3FdpLj3R
 wmh/lVNrkM3kjwM0l805w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D+BS8iXSyUI=;xhZPwpxhixT66Q2KZJQn0Iv+V81
 4HIoqNLoSbdWHkOFD9s6QQMRH9UGDl12ZPx/xGSFQmZXClVYM6S0x3wVjFqdY8aMNy4yYjszA
 pYO+aEJxeMECjkKTV2Aihtqnj+mQqDIVFByYZIMNjyz1QBcn1d5V+uSEt3seE8paeQlBJi9ET
 VNZ6QRQSQ5wagBH+uT0PVaObSB+uKIts1T2dRNODeUmWXyi46Y+ptLo3SHbbuwE3+qY31aJtD
 KeoE99Nt8X26vQLsRXzWR4P7+MVKMQUzW210u3rGQ7idtRemZ/J+BboQKkWQhsCHnzGZFooU3
 VEQaAV5XUC2h5gcFUDW6YUi8rvhIdqhgFGyALM59/R/hrkBWC33UtBzPPl9g5zu6YUUL0YD53
 ysWuSgRRMp4xdMfG8nS+JnXWJK3w/TSc9XUzA8VeF7LJrellyo1tfTsV5I6CXNSj8So8S1lpG
 2Gy7BM3eh34L7ew52vLypD6GaFdEAoNZRIhFvoLJxR/Zf+Or1X9NtpbXzqeuEVLvH+Qs5zZnC
 Yi74BRrF4+Rbncl+/o90IjTz7rguekR4BQ8ixFZa96UhikvoMRfcVkB2iJqvzthb+DWqrDx7K
 eWwo6LVLmQkskQP27wLfOtmY90znR4LUx9pEfLnOOCGZx8iemkWDbOBi/qzhm1+itoZohVOg6
 TbQXY5eWOjChW/CHrf+vmLhKgIPR4Bs4UqxT5CMqQZvnfPuC01WRl5ZTJMupGJQF2RlQUknLP
 VGX68hn87jCFGSg7gQYnRKL2LHR3fUuOIc7biIwp2xPdvmbEHITIEaXK4eP3J+FEaCxkvk2KO
 BNha2Pta5ddpotcGKL77Q9TeiukmbyV2gn63w+C8UTNeXIxGgajB5Ej0DmatBaUAxyFxOc9lW
 QYyRwNTDLP1XaGvDGoPtGxzFHp9XIghvTZaYXOBkpGwL2l9ryh+q17+UrEkT8OLqU4v+ttn3I
 YFtwfCez0m9VjIrYvxrZAZ1Xaa7rOGiL0WbH5RODy4D22LGTLTQ3hO7k0JX/5ypq4oJ3B170v
 TrW58OPPYsC7TTbNIfJeJeVx3iHGHp4U89ZVsQq5uUDtG1GGFS2L7tZV741ed/ii+x/89ezT9
 3uSFlNnCiMwiGubK7ahO/B4QiQorRu1JUJCoa9ErzUOF8LqjjY+/yS6uk/Zp4wi6h51JggqYm
 TentKtqRpzsSai/qogjV+pd9eecj6Pw9RC/OTpm9kRxqZBmGD32C4erKgWUPEK99+2d0cLJnF
 FwC13RJPWGFZaDubV1GlRUg4X6UVXvSVKDzS+4MFeDBvmk14J4nANrj8btECCCLCapUSMpwff
 i9OflMJfzzCKNxYD1+JECjzr4zryJocuEYYBJyJIrb77ZkRrQpgOzJYDUROYz61ZLXoy1bjUI
 dBHnC3DyzjVz1wEua3M/B4/jqWXHnamt22eg/vGzbyXdPh203CFqn6tRjR+UINPfYaW6tI1bs
 vscc9ckHHk6vWLM3BKOAq6jEXUSmgQWSF8xfZNhTrJqmYgWfQazJpRPs7Z2P9jkgOiKacDS0A
 JeDzrdVzL89lxj32ucA=

=E2=80=A6
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> @@ -2270,6 +2270,7 @@ int cxgb4_init_ethtool_filters(struct adapter *ada=
p)
>  		eth_filter->port[i].bmap =3D bitmap_zalloc(nentries, GFP_KERNEL);
>  		if (!eth_filter->port[i].bmap) {
>  			ret =3D -ENOMEM;
> +			kvfree(eth_filter->port[i].loc_array);
>  			goto free_eth_finfo;
>  		}
>  	}

How do you think about to move the shown error code assignment behind the =
mentioned label
(so that another bit of duplicate source code could be avoided)?

Regards,
Markus

