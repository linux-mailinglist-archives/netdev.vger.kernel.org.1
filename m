Return-Path: <netdev+bounces-305753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YBAyKnEmTmqiEAIAu9opvQ
	(envelope-from <netdev+bounces-305753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:29:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B41F72453E
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:29:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305753-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305753-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EB42303C5FB
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F403393DF1;
	Wed,  8 Jul 2026 10:24:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA53AB262
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:24:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506283; cv=none; b=uCkyAjVSwJrQUtzjU9LIywK/2vYe+ddWqXpINgMMeM2hvFZOIJCJN5o8xpl43KmOF3ZyW4eCCKsbSOWcXXmGWrxzTJXyBc5B9BIXntg6lt4MsL0xV47nxCwzvRm2ezvY1xIPwddxRUVxhI9VMAZuIU/GlElNgeLSa/QNlFmuE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506283; c=relaxed/simple;
	bh=H2shEOmNejMQSYdatJnwXRcHlaK5PfqWoplcteZBtvk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UPxVJ3qpR1NCi991u+suGxgPT8Zmay1Ze1tKIiBk8PcF3GuNPENe+ykxoB5A/D3CcT2zyJHyEtmKsSWq6KuAtP7qZgc4PHNRICQk5t2KE81uJy1FggStdPlQMwtOQPS2jZbUrgDgfH0H9B9EUWUt5Mn6c3l7XDdh7ZKpBoC6/n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
X-QQ-mid: esmtpgz12t1783506234te4e7f166
X-QQ-Originating-IP: 0O58FwahYTO6u4S7lcAVRSo8k9RjSzH5DW7xKk2VDQY=
Received: from smtpclient.apple ( [60.188.196.189])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 18:23:52 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 81809779861008349
EX-QQ-RecipientCnt: 6
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v6 3/3] net: libwx: support vf per-queue
 statistics via ethtool -S
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260707095046.104606-1-pabeni@redhat.com>
Date: Wed, 8 Jul 2026 18:23:42 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 horms@kernel.org,
 kuba@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C73D2F94-B574-47ED-9744-7B3C3DA9BB39@net-swift.com>
References: <20260701100145.23738-4-mengyuanlou@net-swift.com>
 <20260707095046.104606-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: N4l297NxaS4d/0DAGa1I6fOMJypBS6l1As2m29UbKrUEk4ZcPpBCvwdl
	oEds33LVv+AUJ0gZ4qJU226TiImx+OhvqcNlKIDioP5OKG4RKt7prUlIhsoKK1AITAwY+v2
	uji0X7q+X9uxod0WppG/EoodXH7Ip5Wis7gNetj0jWvIWVyPrMoAkH6TjolTMdDuHN5rxMC
	Y4Cv3oICljhnZ4zZ5hZGJFr7kAf3DcOPjRKkrOMUxz1q6eu/AyHrrzPeGLgq/hGvtJKT/aU
	dlZkKqWEY9+s/sM4+0RO1XAX43sUEbwpXyJMLDhpP03K3D3GRtWSpREGJdv+5Tz7bUpYf+2
	NjCnITndqi4kTCG0uS6ksytutIf1HQXEIF6nv8M1TRtU+jc0aCWuSjEChAr6Lny/GH2gMEj
	rxmLmqYNQ+HXb9S/FTSXl7two4fdTvl+4lPBWyVAnpf4xPG8QTLvLFwhx4FEBfmpUoRY1oO
	kWcP7Cd7hDMon4Fnd9rszA7F1PI3el+uSWIhkjL+wTIVv42OYN4uWXjAlK5dEljfA5RbYZp
	oodF5M+SSzjMfiNKe7wKk+383xPA2cp13ihOEs+GlxvcIZ6znzrULsmPfjhazp8Fwzu/fFX
	LzTeYJIRUnoyjgNyvhCJQpBEOaVUf8/BIMRBtTlDqCtqpkjLtBGT8f1dJW5Z6POAUynNiUf
	mcq31qTUMQXvwBXarwmlD2vxYzSeWbQTq85bi5l522uIsJfJ1rOwastpsCnCRs1Tb2IUkLE
	Xp6faMT1bp/+fLEP4u3dQoV5+z1/rdDjgdgtL3L+yED/+upOXVsBVyUK/ZKvQ+U+Op9bt1A
	IaZVypuKvmQU+Oug5tewq+liyepsvlsUiDIx+apz/+wVjmBb6YYQAVwZjJJ7NEibqsL0NhC
	UJnYS9U0Yb3oSbcBuc142qLCMkvFlBHHNeV1DCfkN3IXMnwhBtFehO9vYNA96nrH301cdAX
	/MhPazPvTmIfRMpPxmlif4VbiLLxIv+ebm+3Sc0vtFrMfizn3DUC5XLZCrkfTzBP3d9Vh0T
	+MBlQQoknwbmYa6pzfpqK13myb5dEDFi/6MRKKeZcDdhhnfRkops2ipfqovgXaCyZtliOEe
	dla3/DbWJu4cf4N0rwXZLHfYBoAtpizwA==
X-QQ-XMRINFO: MPJ6Tf5t3I/yesON6mHkT11hJVx/QaGLwA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[net-swift.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305753-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url,net-swift.com:from_mime,net-swift.com:email,net-swift.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B41F72453E



> 2026=E5=B9=B47=E6=9C=887=E6=97=A5 17:50=EF=BC=8CPaolo Abeni =
<pabeni@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: AI Reviewer <ai@example.com>
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> Now I have enough information to produce the report.
>=20
> commit e59c58bb080afb34cac34c91b8c320a1f05134e6
> Author: Mengyuan Lou <mengyuanlou@net-swift.com>
>=20
> net: libwx: support vf per-queue statistics via ethtool -S
>=20
> The patch wires wx_get_sset_count, wx_get_strings, and =
wx_get_ethtool_stats
> into wx_ethtool_ops_vf, adds a small vf-only global stats table, and =
starts
> calling wx_update_stats() from wxvf_service_task. It also adds NULL =
checks
> for wx->rx_ring[i] / wx->tx_ring[i] inside wx_update_stats.
>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c =
b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>> index 22037f015ded..f72908630ea4 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>=20
> [ ... ]
>=20
>> @@ -114,7 +133,7 @@ void wx_get_strings(struct net_device *netdev, =
u32 stringset, u8 *data)
>> ethtool_sprintf(&p, "tx_queue_%u_packets", i);
>> ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
>> }
>> - for (i =3D 0; i < WX_NUM_RX_QUEUES; i++) {
>> + for (i =3D 0; i < WX_NUM_RX_QUEUES(netdev); i++) {
>> ethtool_sprintf(&p, "rx_queue_%u_packets", i);
>> ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
>> }
>=20
> [ ... ]
>=20
>> @@ -852,6 +878,9 @@ static const struct ethtool_ops wx_ethtool_ops_vf =
=3D {
>> .set_coalesce =3D wx_set_coalesce,
>> .get_ts_info =3D ethtool_op_get_ts_info,
>> .get_link_ksettings =3D wx_get_link_ksettings_vf,
>> + .get_sset_count =3D wx_get_sset_count,
>> + .get_strings =3D wx_get_strings,
>> + .get_ethtool_stats =3D wx_get_ethtool_stats,
>> };
>=20
> [Medium]
> Before this change wx_ethtool_ops_vf had no get_sset_count / =
get_strings /
> get_ethtool_stats callbacks, so the VF exposed no ethtool -S output at =
all.
> Wiring these in also picks up the shared per-queue string loop that =
emits
> tx_queue_%u_packets / tx_queue_%u_bytes and rx_queue_%u_packets /
> rx_queue_%u_bytes.
>=20
> Per-queue TX/RX packet and byte counters are a category that already =
has a
> standard uAPI (netdev_stat_ops with queue_stats_rx / queue_stats_tx,
> surfaced by netlink and ynl). Documentation/networking/statistics.rst =
and
> the ethtool -S guidance state that new counters covering values that =
have a
> standard uAPI should not be added to ethtool -S even when the driver =
does
> not yet implement the standard interface.
>=20
> The wangxun tree does not implement netdev_stat_ops (no
> get_base_stats / get_queue_stats_rx / get_queue_stats_tx callbacks are
> present under drivers/net/ethernet/wangxun/).

Ok=EF=BC=8CI will remove patch3=EF=BC=88support vf per-queue statistics =
via ethtool -S).
>=20
> Would it be preferable to expose the per-queue counters on the VF via
> netdev_stat_ops instead of adding them to ethtool -S here?

netdev_stat_ops support is deferred to a follow-up patch; this one only =
extends ethtool ops.
>=20
>> void wx_set_ethtool_ops_vf(struct net_device *netdev)
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c =
b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
>> index 260e14d5d541..349afbe60132 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
>> @@ -2886,6 +2886,8 @@ void wx_update_stats(struct wx *wx)
>> for (i =3D 0; i < wx->num_rx_queues; i++) {
>> struct wx_ring *rx_ring =3D wx->rx_ring[i];
>>=20
>> + if (!rx_ring)
>> + continue;
>> non_eop_descs +=3D rx_ring->rx_stats.non_eop_descs;
>=20
> [ ... ]
>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c =
b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>> index 26de78e9a69e..1d84fe35d7d9 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>> @@ -409,6 +410,7 @@ static void wxvf_service_task(struct work_struct =
*work)
>>=20
>> wxvf_link_config_subtask(wx);
>> wxvf_reset_subtask(wx);
>> + wx_update_stats(wx);
>> wx_service_event_complete(wx);
>> }
>=20
> [High]
> Can this call race with VF PCI suspend and shutdown to produce a
> use-after-free on wx->rx_ring[i] / wx->tx_ring[i]?
>=20
> Both ngbevf and txgbevf use wxvf_suspend as their PM suspend callback =
and
> wxvf_shutdown (which calls wxvf_suspend) as their pci_driver =
->shutdown
> callback:
>=20
>    static DEFINE_SIMPLE_DEV_PM_OPS(ngbevf_pm_ops, wxvf_suspend, =
wxvf_resume);
>    ...
>    .shutdown =3D wxvf_shutdown,
>=20
> wxvf_suspend() in wx_vf_common.c does:
>=20
>    int wxvf_suspend(struct device *dev_d)
>    {
>        struct pci_dev *pdev =3D to_pci_dev(dev_d);
>        struct wx *wx =3D pci_get_drvdata(pdev);
>=20
>        netif_device_detach(wx->netdev);
>        wx_clear_interrupt_scheme(wx);
>        pci_disable_device(pdev);
>=20
>        return 0;
>    }
>=20
> wx_clear_interrupt_scheme() ends up freeing the q_vectors (via
> kfree_rcu), and the ring allocations are embedded in the q_vector, so
> wx->rx_ring[i] / wx->tx_ring[i] end up pointing at memory that will be
> freed after an RCU grace period.
>=20
> wxvf_suspend / wxvf_shutdown do not call timer_shutdown_sync on
> wx->service_timer or cancel_work_sync on wx->service_task, and they do
> not set WX_STATE_DOWN.
>=20
> With this hunk in place, the service_task now walks wx->rx_ring[] and
> wx->tx_ring[]:
>=20
>    void wx_update_stats(struct wx *wx)
>    {
>        ...
>        for (i =3D 0; i < wx->num_rx_queues; i++) {
>            struct wx_ring *rx_ring =3D wx->rx_ring[i];
>=20
>            if (!rx_ring)
>                continue;
>            non_eop_descs +=3D rx_ring->rx_stats.non_eop_descs;
>            ...
>        }
>        ...
>        for (i =3D 0; i < wx->num_tx_queues; i++) {
>            struct wx_ring *tx_ring =3D wx->tx_ring[i];
>=20
>            if (!tx_ring)
>                continue;
>            restart_queue +=3D tx_ring->tx_stats.restart_queue;
>            ...
>        }
>=20
> If the service_task latches a non-NULL rx_ring / tx_ring pointer just
> before wx_clear_interrupt_scheme runs, the added NULL check does not
> help, and the subsequent ->rx_stats / ->tx_stats reads touch memory
> that has been kfree_rcu'd. wxvf_remove() covers this by calling
> timer_shutdown_sync + cancel_work_sync before =
wx_clear_interrupt_scheme,
> but wxvf_suspend / wxvf_shutdown do not.
>=20
> Should wxvf_suspend (and hence wxvf_shutdown) quiesce the =
service_timer
> and service_task, or set WX_STATE_DOWN, before =
wx_clear_interrupt_scheme
> now that wx_update_stats is on the service_task's call path?
> --=20
> This is an AI-generated review.
>=20
>=20


