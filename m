Return-Path: <netdev+bounces-153657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6FB9F90F3
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 12:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DB9169AA4
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A681C07DF;
	Fri, 20 Dec 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ACfFDmYu"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26D1BD00A;
	Fri, 20 Dec 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693047; cv=none; b=W0QV31+iwmd9o3RAU7w5J09UbnUcrk5l9wYBk11nK7Fn1HdYEDsCICHtkaB/e6yQBofZNJB4pPjUwWaG/L9NWytV91NoVzZe2+yj/Ry1zJgruw8Qmwho1l0zj3iMGwzMXFyJHP2yQZ6uQnxlWD9982t4kxoy40aWP3CKKXpaPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693047; c=relaxed/simple;
	bh=4YbjBJyTk11dnelwq+sWtzQ/ezofz5hFhLKrnBWqb2M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=C3XxS7QyxzivN9D/5L6msjCu7R0fr4mcCzR4LNxevw9UZBsvTmCQ0CKjIqv9HkuziNZUdhyPqRUbuTQ392xBzJsgOTcnn6WU8KY6X9eUIkzfa1mBgZl+UCGDF67ZqFp1m9PhrPHS1YC6Ko/rJeAM4pie9vjqJtmmFuIbqdbDO9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ACfFDmYu; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734693025; x=1735297825; i=markus.elfring@web.de;
	bh=lv0Tg8kFRiWLWCxiMwl0CJlgMQdMwlhTl3AU6IyuETc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ACfFDmYuY1iFjNVPdxSn+d3zuXIwidEgeCHqTgV7gKy/J6M5iA5a+4NHuV8as0Gb
	 5t0ov07U02FKZG0YY3pjc5h6OWEpkxDwRZ0OZh97Yf7IwsCGxcyE6b4b3CRdISokf
	 1vUa4Aa8urWkrLsuGFQA5/gDb2WQEYp9P3UXmwD4xwc1/Qxt0NBHn58+9eLo7k/4S
	 yfx8znAwH0fHfBxHTXbZ9xnpEfb0QpgtACY505fUd7YzFStOEhriX7AbhWLBo3ueK
	 Wv6WE9duQKZguoR4yFKhTaJnl4P7eZEI4pY0PqxsB1Smbf7DmKk8Wo9oPn5LYRdp/
	 yx2rmlHputQ6JjW+mw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1tNUyD0YIW-007c1X; Fri, 20
 Dec 2024 12:10:25 +0100
Message-ID: <41e1f541-ef92-40ad-ab4d-263303479959@web.de>
Date: Fri, 20 Dec 2024 12:10:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peilin He <he.peilin@zte.com.cn>, Kun Jiang <jiang.kun2@zte.com.cn>,
 xu xin <xu.xin16@zte.com.cn>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Fan Yu <fan.yu9@zte.com.cn>,
 tu.qiang35@zte.com.cn, yang.yang29@zte.com.cn,
 Yaxin Wang <wang.yaxin@zte.com.cn>, ye xingchen <ye.xingchen@zte.com.cn>,
 Yunkai Zhang <zhang.yunkai@zte.com.cn>, Yutan Qiu <qiu.yutan@zte.com.cn>
References: <20241220140516563WDQ_X40bt0ZOch3Qte1YO@zte.com.cn>
Subject: Re: [PATCH linux next] net: dsa: fix the dsa_ptr null pointer
 dereference
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241220140516563WDQ_X40bt0ZOch3Qte1YO@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I5esrpbz9f8sSRKxI9iTStDvvUkNyU5mRpq88Gv8+4g11MXu8p4
 Z7Pl6E7tDreSdbXc0BVZddkLZaH96Nz85lxnHT8MUM4L/DwJ6iWYBeFX9gQqJ9gQfpdnwGz
 aMNmkyJMqC1JdowHkQg27uL8T0GQQFQFIvjweeDbKCmgK6AnaeBMBv4q7TqNSYcMZwlinkd
 pNtH51l+0A4/qcRSDDDXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gszh/NFzzDU=;/H3vAU0fMW1nQTZ7C0SxOOmtu6U
 OucSmvHH0MzvBC5mDHLz4P7SfBHphxTXDS4d1HDZjNNKNzTE7bKocUIbdrEkABLudgeKSnMkf
 vIrVmTQ7UDEEzpm5C9qYh4ODvKliG050gW5qmQj1FhdAqLPAOycy1Lf0pTZ5F4lrkuPlaKYk0
 WiBbwhC3rishjEH0L15PDCpjKvIZLEQ9E/zuN1IaNiu69noovyOHWn2B+nA7JxWZWOts9knnm
 ZMO9SMxvvsDstNJ/dBiDPu+cQjIcQ2VGzxJDaDzrXwCjvVKN/VPNqLwSqiInPOVqxft57XogQ
 EOup1NKFKmom7teKgMx3rTwASLK3IMSFctTwh22DTS/Z52WUXYTbCLnUa6lPDALYJrjnh9LlX
 5vg3n6W8EB/zJZ4aWm2R+4TqOpIZhByFPbM7QuucUokHgI5d4wEunU1pkGeideMsH0o44l1gl
 3WpccLvUKfHo+U/wAxkXwhJfmUO25wzjrqn2ik7m6+gYW9JDlu0gNuZliQa6Ym03KpgYmOBpu
 EoVtPjmD/KXnjaXKmuLmFzzttiHvNgE/gGU9vgkNrxvn3JDgQaHPe/vV4MEt8CuGKCHTEhLl1
 mnFN4iNwL7KKvDKFmFa0pWV6dj2yhWQwzZ0k3DsRFjxfsAohNgmqN3xKZD6816IfqiUft/2dz
 wdG0WlNnvVjT96NQNajMZ/4BGEQUH56xw7RjIVHduYuAozkE4WXYpRZvnxG6Gerhogbgn5PcK
 oRVJjQXV8RdG6ovQxIDg4eXBdXbEtT/TyQfC9T0pBjzlI+52O1PTfR+BP2ifwIfhXAE5nuLkl
 bQsH3Ievdo9+ODjRIEjkS4pGKtf8koNyqF8B/bPdoGvJpO9JmozqsTIoFmTo58Po7uvn71b1t
 XM+a4DmDnavFXaOzD4/TYmzIoiLRIIoc+ewlNHQ27jdYYSm+LY/uHNZ0oMPosMLjvWZ8utvJB
 CDMrE92k24XcqCnOQIjwv0+3bdhqKl6YKcnzNpgtzSR9oPeALJV/xgjIF+/f12kP/5CSuSZ36
 coKY9YzaKrHMjjXJKCcRa4NwGK5S5doHRjrKBcyfGzp7r3m0u0KWBziem+knkPQHe9jtqU8L5
 q0lzyGKtk=

=E2=80=A6
> +++ b/net/dsa/dsa.c
> @@ -1561,6 +1561,17 @@ void dsa_unregister_switch(struct dsa_switch *ds)
>  }
>  EXPORT_SYMBOL_GPL(dsa_unregister_switch);
>
> +static void dsa_conduit_ethtool_shutdown(struct net_device *dev)
> +{
> +	struct dsa_port *cpu_dp =3D dev->dsa_ptr;

I suggest to assign this local variable only after the subsequent check.


> +
> +	if (netif_is_lag_master(dev))
> +		return;
> +
> +	dev->ethtool_ops =3D cpu_dp->orig_ethtool_ops;
> +	cpu_dp->orig_ethtool_ops =3D NULL;
> +}
=E2=80=A6


Regards,
Markus

