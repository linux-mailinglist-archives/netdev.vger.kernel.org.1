Return-Path: <netdev+bounces-298012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8OipCvx1KmrbpgMAu9opvQ
	(envelope-from <netdev+bounces-298012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:46:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D43FD66FFD2
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:46:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298012-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298012-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D260B3002B74
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A03BA229;
	Thu, 11 Jun 2026 08:46:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69EE3BAD8B
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:46:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167606; cv=none; b=nNxbbdIG53rJyyJXqVCO8eee5xXKkvfROvwdp2MdEXGRsBPlnLeBAvsEq07HPquO5oN8vA/DeLgexwvwpYsx6k0XvnADijV+EulWXKAadYjgeW41eIbc/YpuAVW0RrJg2KroCDFsfYYbkl3UCecxlbLe9lWbY5P0JUsxU2JjHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167606; c=relaxed/simple;
	bh=TachjiD8XfT6CvojmwT9V1UTaS5HizT8YT98nj5Se1M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L5ISjMEnS0AYt2yH/xllc5eg7aqoOpl9zTLNPi4NDHadJZD9Z/LfTJOWWwrU6Dt/0JV8lsqnbY+gRD6Tg3T+Msxgi/r8EvcPeh0SUeSsKDfn874gWCkqt6RJC0/j6ZnAxaXTljHlVNLrVNy4qBWq0bNLsgFnIZMcCpYpFOm9X3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
X-QQ-mid: esmtpgz15t1781167580t7a2ed0b0
X-QQ-Originating-IP: JINsNGitbrn02e7vizQvyj8wqEphQ/wBc1ktKNrk5Zw=
Received: from smtpclient.apple ( [125.118.31.65])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Jun 2026 16:46:18 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17257102433803783823
EX-QQ-RecipientCnt: 5
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v4 3/3] net: libwx: support vf per-queue
 statistics via ethtool -S
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260611064859.GP3920875@horms.kernel.org>
Date: Thu, 11 Jun 2026 16:46:08 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 kuba@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F78E77E5-D224-41D2-886B-04989C054219@net-swift.com>
References: <20260608103946.25786-1-mengyuanlou@net-swift.com>
 <20260608103946.25786-4-mengyuanlou@net-swift.com>
 <20260611064859.GP3920875@horms.kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NX6pP3YJT7gr2Yq1PPxbRvu2fLm3GaCvY11T7tLGWII/ex5BUK4e+hSt
	AUGEQTwQaAyDv0CagQ5s9SN3oPv+7gE6OiWgerm3whSVbCEMdnPcSKbClEcE3fA1IInSJn8
	n70T4QJUB++yJUgfHbDr3i0RFZJpUH4fQtF8ZgO08K1dDfMrZrNTBNFiukoTyvf1tD23zo+
	DJW3eIHn2UckdGpUAJ+nOIMVY/HuCgrQVGM5/7DrB/gqN4qs5euYc7uM8D53xLdXMHReY7y
	RtabCRvAp3iBYI3fG/b2mlflGEM6aXCgfmwpQCDRnM2cy2IE3GCKRiAayv9ZNx2JXaUWlUF
	p9XDfqDqQbV0FpLXLQs+NW8w5qFli9WlI+gWLNJzDmVCmf8c2ZEgRfHwilLIyuoevBM7BbR
	d1DT7nQz+zFiOF8xT4Ne/vK3coP2m3qAodVs+W6eVZNtETFVujOlJgHRUE4ySoUiqnHWor+
	rxk9u9bKNP2Ts/PQ87CAnRjP7QE8EmyrJqj6gO91k28MYli9MNVEIZECRgTEgtAWnxZuhQc
	P61BqBwEq4rNLweaoPQnSOuLclJbt4ZEZ3/wujlwyPztu2yma8aXQI05gSxqzLUD5IlXbbk
	TK+hMVG0hPzRnK/HxePw8sztADgTGL+fqq0lIkSO2DrK+KWCii7iYaZ/dTb51+OlZMuHSv3
	NB446mvRVAOvBMQYUHn3duXjRV8PkmTXWjTwStx/hyRB4jNMgJhJ7G5X7hWIlAyZCKkBzZn
	Trxj+gudseGngsH9JS8Evk6H7Xm87W2yQCCQcuSPjBFJrGqXniRxlBgSAlyI2vW8my71Fcl
	/sLbaMO9DTrgLfPYTffyDva3Zt3C2das5C1h2b5t8NDpBGdkpOeDbVcAJRF0/OjOmy5Gwbr
	/3j/XWwc+ToG2KBR8DwZkeBSUYzWZG18b7sxqInnxjk61nkFH81e7WTQ3Dni/5eKdfq+b6J
	cnbW1RQXRI0AX+WHvrb2agdz18990yjEuO5DUpjhpS6akk4U28kigcflYDhc35OwkV68PaC
	91JGYY13f4vkJT1FK1YxJvI0KEUMX9iWJUjal3CMmLl3v1J6yB+MtlbxQ2cqTkQQAAquBVq
	mucONEwD3Gbat7XNeetJUYuadHEKcLjRB1bC7gJD36VRUbM/OrmfbI=
X-QQ-XMRINFO: NyFYKkN4Ny6FwGAChrpIkuCO/bJLFL868g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:kuba@kernel.org,m:horms@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[net-swift.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298012-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D43FD66FFD2



> 2026=E5=B9=B46=E6=9C=8811=E6=97=A5 14:48=EF=BC=8CSimon Horman =
<horms@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Jun 08, 2026 at 06:39:46PM +0800, Mengyuan Lou wrote:
>> Add per-queue TX/RX packet and byte counters to the VF ethtool stats
>> table.
>> The stats length is now dynamically determined based on whether the
>> device is a VF or PF via wx_stats_len().
>>=20
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>> ---
>> .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 48 =
+++++++++++++++----
>> drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  4 ++
>> .../net/ethernet/wangxun/libwx/wx_vf_common.c |  2 +
>> 3 files changed, 44 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c =
b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>> index 30c6ef6103ac..86f6ac63acf7 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>> @@ -48,6 +48,10 @@ static const struct wx_stats wx_gstrings_stats[] =3D=
 {
>> WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
>> };
>>=20
>> +static const struct wx_stats wx_gstrings_stats_vf[] =3D {
>> + WX_STAT("non_eop_descs", non_eop_descs),
>> +};
>> +
>=20
> The AI-generated review available at =
https://netdev-ai.bots.linux.dev/sashiko/
> flags that this is user-exposed and probably could benefit from a bit
> more explanation in the patch description.
>=20
>> static const struct wx_stats wx_gstrings_fdir_stats[] =3D {
>> WX_STAT("fdir_match", stats.fdirmatch),
>> WX_STAT("fdir_miss", stats.fdirmiss),
>> @@ -69,15 +73,26 @@ static const struct wx_stats =
wx_gstrings_rsc_stats[] =3D {
>> #define WX_QUEUE_STATS_LEN ( \
>> (WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
>> (sizeof(struct wx_queue_stats) / sizeof(u64)))
>> -#define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
>> #define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
>> #define WX_RSC_STATS_LEN  ARRAY_SIZE(wx_gstrings_rsc_stats)
>> -#define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
>> +
>> +static inline unsigned int wx_global_stats_len(const struct wx *wx)
>> +{
>> + return wx->pdev->is_virtfn ?
>> +        ARRAY_SIZE(wx_gstrings_stats_vf) : =
ARRAY_SIZE(wx_gstrings_stats);
>> +}
>=20
> Please don't use the inline keyword in .c files unless there is a
> demonstrable - usually performance - reason to do so. Rather, please
> let the compiler inline code (or not).
>=20
> It is of course fine to use the inline keyword in .h files.

Ok=EF=BC=8CI will drop it.
>=20
>> +
>> +static inline unsigned int wx_stats_len(const struct wx *wx)
>> +{
>> + struct net_device *netdev =3D wx->netdev;
>=20
> netdev seems unused.
>=20
> Flagged by AI-generated review on sashiko.dev=20


#define WX_NUM_RX_QUEUES netdev->num_tx_queues
#define WX_NUM_TX_QUEUES netdev->num_tx_queues

#define WX_QUEUE_STATS_LEN ( \
(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
(sizeof(struct wx_queue_stats) / sizeof(u64)))

netdev is used.

>=20
>> +
>> + return wx_global_stats_len(wx) + WX_QUEUE_STATS_LEN;
>> +}
>>=20
>> int wx_get_sset_count(struct net_device *netdev, int sset)
>> {
>> struct wx *wx =3D netdev_priv(netdev);
>> - int len =3D WX_STATS_LEN;
>> + int len =3D wx_stats_len(wx);
>>=20
>> switch (sset) {
>> case ETH_SS_STATS:
>> @@ -100,8 +115,11 @@ void wx_get_strings(struct net_device *netdev, =
u32 stringset, u8 *data)
>>=20
>> switch (stringset) {
>> case ETH_SS_STATS:
>> - for (i =3D 0; i < WX_GLOBAL_STATS_LEN; i++)
>> - ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
>> + for (i =3D 0; i < wx_global_stats_len(wx); i++)
>> + if (wx->pdev->is_virtfn)
>> + ethtool_puts(&p, wx_gstrings_stats_vf[i].stat_string);
>> + else
>> + ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
>=20
> The AI-generated review at https://netdev-ai.bots.linux.dev/sashiko/ =
also
> flags that these seem to cover statistics that can be exposed via
> netdev_stat_ops, which is preferred.
>=20
> If consistency with the PF stats is desired for VF stats, then perhaps
> netdev_stat_ops can also be implemented for PF queues.

Netdev_stat_ops will add in another. changlogs v3 just remove it.
>=20
>> if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
>> for (i =3D 0; i < WX_FDIR_STATS_LEN; i++)
>> ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);
>=20
> ...



