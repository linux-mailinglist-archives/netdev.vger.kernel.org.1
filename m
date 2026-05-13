Return-Path: <netdev+bounces-287392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFR4AB3lA2oRAAIAu9opvQ
	(envelope-from <netdev+bounces-287392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 04:42:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E618752C523
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 04:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4F5D30071F1
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 02:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3258B35DA55;
	Wed, 13 May 2026 02:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="EP+tYA3g"
X-Original-To: netdev@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933001EA7DB
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640096; cv=none; b=Q5jEEaR4qaSqWqtmWZ98SPk4ir34WXsdksoMnBmJKZnGj0xFjY0NdKSzZIgeLMD//EFIe78dN1V30z2iUZKTT5ce8J5BZhHKpqIzW7wYDcpKarl1LydU1U3s5OWLAzGw9DXgOcpAhFlm/rBOf6HGzqq25x3FHYU2qRe2SlkMw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640096; c=relaxed/simple;
	bh=1mhpvweEuvC1qmquIvbyseT1tmctLqLlH0MSE1j3GJA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dzTpFM4bOE5NEVqPJqOyCxf6ptWYDtZAWHs5vFrSzMBXbUTMKwp0qbCgGtpTAimpewEPW0DNj+hlLEgYPR2e58s5yZCcLQjaflBTVnBU6QHUBqp57tJOqKWB21Y00XluQbr5R+rHI4IqR4mo9v1LkCBtuD2LDys2yHvwR9fsxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=EP+tYA3g; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778640090;
	bh=WmK2zD20CENFt9liQTaBLnpOLexRN/pxML6fuKKLXTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EP+tYA3gtg2tOhAtcHFMe8bGbkJQMP0+9HZpX7+S0gK84geFiaw5Y/SX+qxtkDnp4
	 9LpEDS2juxQJcLDTp4+O4aT7OEbPviUFJJAVTGKNpzIDL/xH36kadsbpOdUUTLq4N4
	 dQSEwzi4ahhqIJ5mnp691wyNz1jRhSHlqaXZgYnI=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 98BA4C0A; Wed, 13 May 2026 10:38:11 +0800
X-QQ-mid: xmsmtpt1778639891t0uemor3e
Message-ID: <tencent_3798BB6EC69DCB45BBD25D7CF1C5CDA8A806@qq.com>
X-QQ-XMAILINFO: MStTOrhA1CLVaRSBH305IXsZaobYd6KwaSW3XUDY24KyuG7vD0pH4RwMrIjlIq
	 o3oRkkmkEACPdVinAapm1SGH0+o+K7vWfdzVp82ODu0zq4wFlQv/PFqOW85LMd0qVEd0VelOWqIp
	 2JxppSSfpArMZ+L/tXN5TGdSLzYUO7Fg4oqErrub3zBKufC7Y6cGjswfojhOvCbtX5Y33nlzxmpF
	 GI8h8zKgxuRNxrYcY5rpxyKCW1l9MSO2jnYFP6ZVztWavgLvloPtcnueOPUvCtvQBjKkFs376Zo2
	 6g29ogjsmQBTp9zUfTXb1CHCYPRO2Bbur8GuZehEClWwe4R/1U8p4Z+GjZeRQzYDTcwLApX5eFv4
	 uc4unZU8H5wk1w68Ae+bVa1I5wyuMTB8z+ce5n8WdBrJsKXMnRT1yXY6Jd7GG2QfdO95lZfa8xqz
	 BMgu82rRi0pydmek0yxuHYNtjCqUVWwiZxDH0mK51sHSoKMwZGHnVy3KjVq+DvxKFE/qn6u6ZPcZ
	 Q48e+uT+GQWB7+B8LAeGmh4yy4+KEJaGw+mMGMgQL2RY2nSZmaIn3hYUBG6z7fUHHw+JzYqMnVvi
	 IUXyNTrhQte8aP+j1uplbcNRysnDSO2GOZcRq1nxGB+DViSrN3AWEfo/ZZiy79V0UmNSScP4/+l6
	 oLwuJMS8ZdP9jfDefZO4Nnvzhljm735f9bm6PWSKmp6QHvYvmIAC2Si7JOM6YVhvy1eHdzCX1NTP
	 F8q/L7Wx/rkhbsXZpF69C5NaGZpMVIvBpH5g3IMQC0iWbuItkSljoVA61toiLfMb+jiwrc5N2wwK
	 AvxZfvMjE6Ihq8eXEYCO16VXBR5NSNWAXj9knvuqCDordfza7DPrPdwf7SKrt5po/DFRYQwH5leW
	 uPsM4b7PR7nYZVM1tO2ogFUAoA6dTATyTchgxdvO/tDARWv7SS2Etvpwh40/zuCf5lrMDwDmh5Zy
	 xcB1NBLxcN+oNUAsoNiH0ZFGyL6VrGvGu3xU8yUjrB5Dmhfr6drw81RSfUoY4m0A+JRCxzKwTJ9J
	 ybPT9fEgu/7O5kO9fjqtuM2oYFl9Is3hGIyjqtnw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Zhao Dongdong <winter91@foxmail.com>
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	winter91@foxmail.com,
	zhaodongdong@kylinos.cn
Subject: Re: [PATCH] net: mdiobus: add mdio_c45_bad_oui_list for
Date: Wed, 13 May 2026 10:38:11 +0800
X-OQ-MSGID: <20260513023811.99362-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <031a1fce-259b-4b1b-95ed-2917a6b81659@lunn.ch>
References: <031a1fce-259b-4b1b-95ed-2917a6b81659@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E618752C523
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287392-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,foxmail.com,kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:mid,kylinos.cn:email]
X-Rspamd-Action: no action

On Tue, 12 May 2026 14:26:48 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, May 12, 2026 at 04:25:21PM +0800, Zhao Dongdong wrote:
> > From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> > 
> > Added the mdio_c45_bad_oui_list to facilitate adding more PHYs that
> > do not support C45 scanning.
> > 
> > Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
>
> Please make this is patch series which adds the PHY you have which is
> also broken.
>
>     Andrew
>
> ---
> pw-bot: cr

Thanks for the review.
The PHY driver hasn't been upstreamed yet. We can bundle it with this patch and submit them together once it's ready.


-- 
Regards,
    Zhao Dongdong


