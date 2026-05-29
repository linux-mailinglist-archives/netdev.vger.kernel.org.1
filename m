Return-Path: <netdev+bounces-292995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ECzAjkpGWp/rQgAu9opvQ
	(envelope-from <netdev+bounces-292995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:50:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B35FDA00
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E638130EDAF1
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C83A1684;
	Fri, 29 May 2026 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="h3M40yN2"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B03A2540;
	Fri, 29 May 2026 05:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033472; cv=none; b=EET8We71Mz/K+KfqX3zZ+3G9ommtQdzj4xPCawcGrKc2CQpOiQROYZT4/JADZVB9iVeHcnlBM2vsPJevQI1Y1IEG3vQvT4z0ZTfGMsa1q/6lMETZ+/6nx+9caENDe4Zr95HVYBIKnsZabySzd15NdANt2YmgCakHVWaMATrUECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033472; c=relaxed/simple;
	bh=lTVats1/3JAffJhdGb5lrzqUkzkUDggDPMsXbwHLjcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I/7drIqmszNF/MZAmeXlaGcfIEvbrDnGkfvW7fKo1NzEA+Ri14Y8sVF8QpLh51yX/iSBwdNWivq5LLXMQZCx6YkoYCHeYhjmB1df8cHSguiaqnaEyE8knkb4S0UB1vCYAXYW5naSHZMhaRVeXUcvYefQBPvF68JSYSWhPt2B5uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=h3M40yN2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64T5hqRjB3908671, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780033433;
	bh=rtjWEsp/o05lMGpREuo0QXlKafK0Yf4N90ixQE5WZQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=h3M40yN2GjfbrORmd320Er8RXa0VLUxRT/GBFh8pb871376vJdyXgvPfbwsp3/tEv
	 VTjnpdtFyRWm/x8RMrVtQfCujeuTmhk3/Qf1is0hzEwYWH3Ze5USAVc2QwfaS1Olpn
	 QsVdAZXYUoudsgAfwfpeQV7KWhDR/CGTKbtNLzr+ajfSzGx6nvkDaoeQG4SqYEFcJY
	 N66bOq6R7w0NQBWgalHNQVbTkiMYw8P135mZhHG4gYNfL5siJk3bCYU8kJFpsVvhhn
	 UvzrwQfFc5lP4XO2cc8B+NheQDPyg1QkzVmPEt/DwfeILwl8dQM9ejJhaAAG09aXV8
	 9gh00MpcHx7ng==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64T5hqRjB3908671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 May 2026 13:43:53 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 May 2026 13:43:52 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Fri,
 29 May 2026 13:43:52 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Jakub Kicinski <kuba@kernel.org>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Patch net-next v6 1/7] r8169: add support for multi irqs
Thread-Topic: [Patch net-next v6 1/7] r8169: add support for multi irqs
Thread-Index: AQHc7Oc8L+opUxqbfEm3mE61Tomyi7YjrQwAgACrvJA=
Date: Fri, 29 May 2026 05:43:52 +0000
Message-ID: <6f55096511784f66ae46a217014def79@realsil.com.cn>
References: <20260526081117.173-1-javen_xu@realsil.com.cn>
	<20260526081117.173-2-javen_xu@realsil.com.cn>
 <20260528180004.58991104@kernel.org>
In-Reply-To: <20260528180004.58991104@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292995-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,realsil.com.cn:mid,realsil.com.cn:dkim]
X-Rspamd-Queue-Id: 458B35FDA00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>On Tue, 26 May 2026 16:11:11 +0800 javen wrote:
>> @@ -4820,7 +4838,7 @@ static int rtl_rx(struct net_device *dev, struct
>rtl8169_private *tp, int budget
>>                       goto release_descriptor;
>>               }
>>
>> -             skb =3D napi_alloc_skb(&tp->napi, pkt_size);
>> +             skb =3D napi_alloc_skb(&tp->rtl8169_napi[0], pkt_size);
>
>the caller is the NAPI poll function, you should pass that NAPI as arg to =
rtl_rx()
>already instead of hardcoding [0] in this patch.
>
>>               if (unlikely(!skb)) {
>>                       dev->stats.rx_dropped++;
>>                       goto release_descriptor; @@ -4844,7 +4862,7 @@
>> static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, in=
t budget
>>               if (skb->pkt_type =3D=3D PACKET_MULTICAST)
>>                       dev->stats.multicast++;
>>
>> -             napi_gro_receive(&tp->napi, skb);
>> +             napi_gro_receive(&tp->rtl8169_napi[0], skb);
>>
>>               dev_sw_netstats_rx_add(dev, pkt_size);
>>  release_descriptor:
>
>> +static int rtl8169_set_real_num_queues(struct rtl8169_private *tp) {
>> +     int ret;
>> +
>> +     ret =3D netif_set_real_num_tx_queues(tp->dev, 1);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return netif_set_real_num_rx_queues(tp->dev, tp->num_rx_rings);
>
>netif_set_real_num_queues() exists, just call it directly instead of addin=
g your
>own helper.
>
>> +}
>> +
>>  static int rtl_jumbo_max(struct rtl8169_private *tp)  {
>>       /* Non-GBit versions don't support jumbo frames */ @@ -5599,6
>> +5669,22 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>>       return false;
>>  }
>>
>> +static void r8169_del_napi_action(void *data) {
>> +     struct rtl8169_private *tp =3D data;
>> +     int i;
>> +
>> +     for (i =3D 0; i < tp->irq_nvecs; i++)
>> +             netif_napi_del(&tp->rtl8169_napi[i]);
>> +}
>> +
>> +static void r8169_init_napi(struct rtl8169_private *tp) {
>> +     for (int i =3D 0; i < tp->irq_nvecs; i++)
>> +             netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll=
);
>> +     devm_add_action_or_reset(&tp->pci_dev->dev,
>> +r8169_del_napi_action, tp);
>
>devm_add_action_or_reset() can fail (as the AI bots point out) but this wh=
ole
>devm_ dance is entirely unnecessary networking stack will automatically
>delete NAPI instances when device is unregistered.

Thanks for your review.

In patch v3, link: https://lore.kernel.org/netdev/20260513115543.1730-2-jav=
en_xu@realsil.com.cn/
I tried to alloc struct rtl8169_napi dynamically for saving memory accordin=
g to Heiner's suggestion. I agree with his suggestion because only 8127 rss=
 are enabled.
And in this ai review, link: https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20260520031603.700-1-javen_xu%40realsil.com.cn
AI suggested that the lifetime of this devm_kcalloc'd napi array may be com=
patible with the netdev's napi list. So I add devm_add_action_or_reset in p=
atch v6.
I checked the code and agree that the stack auto-deletes NAPI instances in =
free_netdev() -> netdev_napi_exit(). However, because devres releases resou=
rces in LIFO order:
1. kfree for the NAPI array (allocated via devm_kcalloc) will be called fir=
st.
2. free_netdev() (registered via devm_alloc_etherdev) will be called second
When free_netdev() calls netdev_napi_exit() to iterate over dev->napi_list,=
 the NAPI memory has already been freed by devm, which will cause a Use-Aft=
er-Free. That's why I added the devm action to explicitly remove it before =
the memory is freed.

So I wanna know what should I do? Whether keep the action in this patch(dyn=
amically allocate napi array) or patch v2(fix the array size), or any other=
 suggestion will be apperaciated.

BRs,
Javen


