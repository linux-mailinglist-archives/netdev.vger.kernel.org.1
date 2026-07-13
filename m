Return-Path: <netdev+bounces-306997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4R7vEFhSVGqckgMAu9opvQ
	(envelope-from <netdev+bounces-306997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 04:50:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7822D746CC6
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 04:49:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306997-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306997-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A816030477D6
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 02:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699DE312826;
	Mon, 13 Jul 2026 02:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516871B3B19
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 02:45:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910738; cv=none; b=X9rFEGitS/H0amBEOG4VCs0umg58JHOy6qUgTLTLLJuM03rpB6GX97sxqjvp1daHCwUsw1Qi4ZwPg2o9/52EchOPMNy8giD7YdjCQDXdJ/TZ+XfCJh2i07zgfwLRNqvgUJ42/drRdeSxzuFet67p77lv92eXSCgcdGw70t033PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910738; c=relaxed/simple;
	bh=Tuzx6NAdlBeqDaCwQePl6HNEEXKHQ9byvXMc/TaPVzg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QzYXL8VSb3xd1F/5zzbZQXUfTbcTBTyzRaF6HAJMecuExgEZ46dUV3CPTyX0+lg5Na65QPj481cB4v45lNeGeH+aSv+w7pSbGp1DqNWllau3SQmpYAnTDKBHTefJW6uv64XWfhoo7V5D3QPlg1Ul3NQotAp6zAtadzxIgayx33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
X-QQ-mid: zesmtpsz7t1783910673t5a2e1ed2
X-QQ-Originating-IP: JZ0AqYhEx/t0BuaeSGC520JCxTi+jICabUUSZtP/dkw=
Received: from smtpclient.apple ( [115.200.247.46])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 10:44:31 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3857063744777334807
EX-QQ-RecipientCnt: 7
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v7 1/2] net: libwx: add support for set_ringparam
 in wx_ethtool_ops_vf
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <a12bf43b-1cb2-4ca6-b2bb-f4618bc4e8b1@intel.com>
Date: Mon, 13 Jul 2026 10:44:21 +0800
Cc: jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 netdev@vger.kernel.org,
 horms@kernel.org,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <98C4DD1F-7CF0-4B82-88CE-4856FE2D5126@net-swift.com>
References: <20260710015925.34769-1-mengyuanlou@net-swift.com>
 <20260710015925.34769-2-mengyuanlou@net-swift.com>
 <a12bf43b-1cb2-4ca6-b2bb-f4618bc4e8b1@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MP1WLfctJNZW72zPPtDyFMfDfHXH3YW3eVy9F0wt7gdUoyXQenIpB7i7
	zy1tn9IrmyjbnKhpHHPE0iVJUdmzffa9eu5gFUSGStzoGci/ro8MzK5dqzAjaeN5dWHpmrT
	FzKb5U6GiNh5p1pVJ5ln4w8nM5MUC3VBLNKJOGNSgnVwrlKbVnDtN4nwn+SEtuuuvunfVbc
	gjxkLyeR2Dqt52v5gTm588wDdYacSvSvg3SUtLdCx0tbJoDAgaBHXKx3rWGHrxWQAHf659b
	ZQbsWXa6NII8CcOjf/n34CFyVBnDdzvlGbMR6tElIJs1Zz5IxE7fQxRgpQ5Yal0ev2N7hNl
	jk/tia8vb2RC5RPpjrBV6WvxMkoqJxcCKyKTD1SPPtlV8O9YehcGLh25Cl/zzpPWbNqEjqw
	Wf04Cqjp5PUp7Ck+QYcxUUsHpembo5pRYFWAkYbReUF4WeOvFzMyXC818SJLWlkBaArll/p
	iUUlMbGx5HYpfIxDiJVlM+UdGG7K0C6sqyOBpjN3w2n7tmGtQgipKR9i3g5SGLNbLp3YDbF
	73LlG4p8XEGNHFoDe2cNQ/QfH8f9ITh0ZjGE+V6a7NxjBy59x8Vdx44JxUc/7ap518I19Y4
	OaiLyz+cThq2DngHniE1GFDyT1jaj+1HTDgPrX2jRM7ffzB/ymywEtVsGsYRag1VGxCk9oM
	5Fp/dErbZc+CT+GnoHBCZPvhmiAhfNhx6bXW6lya3gIHyydGF5/xhaNvPQWuCEzQmV6sqja
	mkb6lMOVGYmxtgR4olE3smfjgowXhV8vWYgSgJ/P3DVPwKrQgA4cAVSoLHGv000AGqL4tbX
	B6cjAUXqYP0IEfHe3q30luBXSZCSxfvf3AzmYqDYqXwb4AA3+PhnJGShwbWs83/c4VutkZK
	PypArxir4RP+R7Up/gUb6rPiLfYqocqwpMvv3PuaOMxjG3vz990P5Gd7r9zX/nw7Y78c+jH
	dEB5jjLPrD8XCCivFbPj6pJ9IJ9UCdF2oSXukYFsoeVeWvxdOoZnfZprl67dqczo7wVzfLU
	0L7I+NQZreYSFqQ900S6T3ypH0Te+/Qcv1SQGWkVsZymOkf8D95AuRibtXRF6oVA/i4nHKp
	Q==
X-QQ-XMRINFO: OWPUhxQsoeAVAAVcZ5lJdpP/HjjINfMypg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:przemyslaw.kitszel@intel.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[net-swift.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306997-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7822D746CC6

Sorry for the late reply.

> 2026=E5=B9=B47=E6=9C=8810=E6=97=A5 18:19=EF=BC=8CPrzemek Kitszel =
<przemyslaw.kitszel@intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 7/10/26 03:59, Mengyuan Lou wrote:
>> Add support for the set_ringparam in wx_ethtool_ops_vf,
>> which is used to set ring sizes for ngbevf and txgbevf.
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>> ---
>>  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 61 =
+++++++++++++++++++
>>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 +--
>>  drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  4 +-
>>  .../net/ethernet/wangxun/libwx/wx_vf_common.c |  4 +-
>>  .../net/ethernet/wangxun/libwx/wx_vf_common.h |  2 +
>>  5 files changed, 72 insertions(+), 8 deletions(-)
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c =
b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>> index 5df971aca9e3..eae038df6875 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>> @@ -9,6 +9,7 @@
>>  #include "wx_ethtool.h"
>>  #include "wx_hw.h"
>>  #include "wx_lib.h"
>> +#include "wx_vf_common.h"
>>    struct wx_stats {
>>   char stat_string[ETH_GSTRING_LEN];
>> @@ -775,6 +776,65 @@ static int wx_get_link_ksettings_vf(struct =
net_device *netdev,
>>   return 0;
>>  }
>>  +static int wx_set_ringparam_vf(struct net_device *netdev,
>> +       struct ethtool_ringparam *ring,
>> +       struct kernel_ethtool_ringparam *kernel_ring,
>> +       struct netlink_ext_ack *extack)
>> +{
>> + struct wx *wx =3D netdev_priv(netdev);
>> + u32 new_rx_count, new_tx_count;
>> + struct wx_ring *temp_ring;
>> + int i, err =3D 0;
>> +
>> + new_tx_count =3D clamp_t(u32, ring->tx_pending, WX_MIN_TXD, =
WX_MAX_TXD);
>> + new_tx_count =3D ALIGN(new_tx_count, =
WX_REQ_TX_DESCRIPTOR_MULTIPLE);
>> +
>> + new_rx_count =3D clamp_t(u32, ring->rx_pending, WX_MIN_RXD, =
WX_MAX_RXD);
>> + new_rx_count =3D ALIGN(new_rx_count, =
WX_REQ_RX_DESCRIPTOR_MULTIPLE);
>> +
>> + if (new_tx_count =3D=3D wx->tx_ring_count &&
>> +    new_rx_count =3D=3D wx->rx_ring_count)
>> + return 0;
>> +
>> + mutex_lock(&wx->reset_lock);
>> + set_bit(WX_STATE_RESETTING, wx->state);
>> +
>> + if (!netif_running(wx->netdev)) {
>> + for (i =3D 0; i < wx->num_tx_queues; i++)
>> + wx->tx_ring[i]->count =3D new_tx_count;
>> + for (i =3D 0; i < wx->num_rx_queues; i++)
>> + wx->rx_ring[i]->count =3D new_rx_count;
>> + wx->tx_ring_count =3D new_tx_count;
>> + wx->rx_ring_count =3D new_rx_count;
>> +
>> + goto clear_reset;
>> + }
>> +
>> + /* allocate temporary buffer to store rings in */
>> + i =3D max_t(int, wx->num_tx_queues, wx->num_rx_queues);
>> + temp_ring =3D kvmalloc_objs(struct wx_ring, i);
>> + if (!temp_ring) {
>> + err =3D -ENOMEM;
>> + goto clear_reset;
>> + }
>=20
> would be much better to move tempbuf allocation into the helper,
> and just do it at the beginning there
>=20
> in the unlikely event of -ENOMEM, you will just call the "up"
> in the unroll path

This change touches wx_set_ring(), which is shared with PF drivers =
(ngbe/txgbe).=20
To keep this patch focused on VF ringparam support, I will cleanup it a =
follow-up patch.

>=20
>> +
>> + wxvf_down(wx);
>> + /* wx_set_ring() may partially apply changes before
>> + * returning an error. The error indicates that not all
>> + * requested ring parameters could be configured.
>> + */
>> + err =3D wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
>> + if (err)
>> + wx_err(wx, "failed to set ring parameters: %d", err);
>> + wx_configure_vf(wx);
>> + wxvf_up_complete(wx);
>> + kvfree(temp_ring);
>> +clear_reset:
>> + clear_bit(WX_STATE_RESETTING, wx->state);
>> + mutex_unlock(&wx->reset_lock);
>> + return err;
>> +}
>=20
>=20


