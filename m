Return-Path: <netdev+bounces-292166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAh2ERCoFmrEoAcAu9opvQ
	(envelope-from <netdev+bounces-292166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:15:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA025E0EEF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E4C7300AD85
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE0E3D34A1;
	Wed, 27 May 2026 08:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E632EA47C
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869707; cv=none; b=ePcBbKkJ/sD0XZ41PmTriD2gkY4t4tia1CGQhaPcBenw36wXIU/0y0Cl3gsM6tymEN7AAnhKMJJXwVWIDvXlt5v+i6cz+tWFZAmOTuO2emIXEW0wP9n46GSuuapIddK0G2vJnPop695cqQfFWFZsj76CYHmVG6z/zrnmv7bxOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869707; c=relaxed/simple;
	bh=ZUUQr8OcnyIbzpzl3ZM5evKQPUoby6CUTcoRi2vIbOw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fyAXc1wqrK6C5nxCFrdJCd/zIFoQDQhnh2jJtPJ4Mpg3ZmJysCeYCqTHirzY9ufbmxxgOTifz84HXnubjDu9FZLn1KfL9hk7b+Ev8ppxCx7J9XEep0UNdE7OmtsGVGHeQCdsQQ9OmFrXMvPzMgVkXurypWpmlJdzT4cLgwkXjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz2t1779869676tc2215c8b
X-QQ-Originating-IP: cAtRHS+YN50IwYpCWVVc+5xJ9n/fz2wMSLjYZwEhrro=
Received: from smtpclient.apple ( [122.231.28.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 May 2026 16:14:34 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13802026031804003876
EX-QQ-RecipientCnt: 4
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v2 3/3] net: libwx: support vf hardware
 statistics
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260526184903.17bff72b@kernel.org>
Date: Wed, 27 May 2026 16:14:24 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7EA1D24-29B9-443B-833E-5ECE14321ADF@net-swift.com>
References: <20260525101115.13151-1-mengyuanlou@net-swift.com>
 <20260525101115.13151-4-mengyuanlou@net-swift.com>
 <20260526184903.17bff72b@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NrJHW3hvBPkCfDZxO7vhmdqvQ4r5r3JHx0A1hES3FHp9KsTiOcywRTt7
	Vao5mBngQajb7lnOnr23aLm5PP/WPXl0f4RokhVcy/sxdcmHEDzIICuv+g5AGlHTvzbJbp8
	VCmvyf4yZfjYlCfLwoVezB0IUD0md3AQNnfchtvf1ti0G1cFtfHjPiYeiMYibgB+CD+pUhd
	nk8fuNvoaUQMYe2GJrpSiRurvUdk4FYZtSZMDCZl0W0KLcdv2McFo834lQYZcTzfx2+taxt
	1ZZkN06EIJBFtTkXGzLuOlWARU3RDjo8H3XPM4lFikDDEqoYd8mwTyTDnpd5xCjiMcrv1uC
	vYj0k2xxCco2oCg3PjKyilI8s+Sj7C9XcLmXifvfcaYFaoFD1cRPrWNH+CMIxpPudMi7QUX
	A+Us9bPIzJeAfsv3DXz8umNMwZe/iLLEZfmGdrXRkzBa80F9k3WMsuK1uqvGki4Iw818fyw
	d7g+mn29GBDoUpnc6W0f6Nr1KAcn4TvHj4MrCeXXGBUOietXK2NuchZmj5dSvUzLHsqI8HT
	qMhlqGoGtMAimUwGQ9ENNBMndQLEpTkUVzy0smFoprh2veqynWCmSB5kZO5WCoB3rmycVoh
	ZNEtCDW0mWlm0ZO724Upwjfqie4mlij3KYn8ezwg/b9R/pmo0ibvREnAxErbA5C/8I2CM9V
	eTrXalf0BlNRnH1ifyQLOrTuGFDx4z/ID7eGjZSqrSuZ8eJEUeeb0Pt0fH2TQsBYEaQinE8
	stf27V9FpSxV57JI5fj8CHuMkZ6IwxyGrYnjTMtt/YEDwDlFxihYFMBEM9ypFFyZxFWmxva
	2q45NhZXY3aOlhJkqUPLm4vTZeQgMoKxldcJuZ1RAH6HpSjklqpJvDiqEg0sz3gKnEpTp1Q
	crFx2w0vHpKcAXeMPDJ9P9Pmdma4q2KtDhgkdRk2lBcPLZP56uuTGrx91nk8CHngJcfMH/V
	RKp0bmuy1yxXEIbMF4eImOMLuz/mHFmBvn1S3Pnr/CNfJJj3KJGrgvTseELyp96aKCNEkOM
	4Sh5c22EmoTCzg/33X21cqIDSKPSQEV9IcVcD8uAhAN3Hna34W3S8KzKpqYzg=
X-QQ-XMRINFO: MPJ6Tf5t3I/yxzgI1+Bf9Xa7ZyLAxEoBgw==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[net-swift.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292166-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.482];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1EA025E0EEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> 2026=E5=B9=B45=E6=9C=8827=E6=97=A5 09:49=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, 25 May 2026 18:11:15 +0800 Mengyuan Lou wrote:
>> Add support to show hardware statistics for ethtool -S ethx.
>=20
> Sadly this does not build. When you repost I think it would be good
> to split this patch into two - one for ethtool -S and one for=20
> the queue stats via the netdev API.
>=20

OK, I will send another patch about queue statistics via the netdev API =
together with the get_stats patch.

> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: warning: =
declaration of 'struct netdev_queue_stats_rx' will not be visible =
outside of this function [-Wvisibility]
>  423 |                                     struct =
netdev_queue_stats_rx *stats)
>      |                                            ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:428:7: error: =
incomplete definition of type 'struct netdev_queue_stats_rx'
>  428 |         stats->packets =3D ring->stats.packets;
>      |         ~~~~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: note: =
forward declaration of 'struct netdev_queue_stats_rx'
>  423 |                                     struct =
netdev_queue_stats_rx *stats)
>      |                                            ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:429:7: error: =
incomplete definition of type 'struct netdev_queue_stats_rx'
>  429 |         stats->bytes =3D ring->stats.bytes;
>      |         ~~~~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: note: =
forward declaration of 'struct netdev_queue_stats_rx'
>  423 |                                     struct =
netdev_queue_stats_rx *stats)
>      |                                            ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:430:7: error: =
incomplete definition of type 'struct netdev_queue_stats_rx'
>  430 |         stats->alloc_fail =3D wx->alloc_rx_buff_failed;
>      |         ~~~~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: note: =
forward declaration of 'struct netdev_queue_stats_rx'
>  423 |                                     struct =
netdev_queue_stats_rx *stats)
>      |                                            ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:431:7: error: =
incomplete definition of type 'struct netdev_queue_stats_rx'
>  431 |         stats->csum_complete =3D wx->hw_csum_rx_good;
>      |         ~~~~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: note: =
forward declaration of 'struct netdev_queue_stats_rx'
>  423 |                                     struct =
netdev_queue_stats_rx *stats)
>      |                                            ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:432:7: error: =
incomplete definition of type 'struct netdev_queue_stats_rx'
>  432 |         stats->csum_bad =3D wx->hw_csum_rx_error;
>      |         ~~~~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: note: =
forward declaration of 'struct netdev_queue_stats_rx'
>  423 |                                     struct =
netdev_queue_stats_rx *stats)
>      |                                            ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:436:16: warning: =
declaration of 'struct netdev_queue_stats_tx' will not be visible =
outside of this function [-Wvisibility]
>  436 |                                     struct =
netdev_queue_stats_tx *stats)
>      |                                            ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:441:7: error: =
incomplete definition of type 'struct netdev_queue_stats_tx'
>  441 |         stats->packets =3D ring->stats.packets;
>      |         ~~~~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:436:16: note: =
forward declaration of 'struct netdev_queue_stats_tx'
>  436 |                                     struct =
netdev_queue_stats_tx *stats)
>      |                                            ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:442:7: error: =
incomplete definition of type 'struct netdev_queue_stats_tx'
>  442 |         stats->bytes =3D ring->stats.bytes;
>      |         ~~~~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:436:16: note: =
forward declaration of 'struct netdev_queue_stats_tx'
>  436 |                                     struct =
netdev_queue_stats_tx *stats)
>      |                                            ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: warning: =
declaration of 'struct netdev_queue_stats_rx' will not be visible =
outside of this function [-Wvisibility]
>  446 |                                 struct netdev_queue_stats_rx =
*rx,
>      |                                        ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:447:12: warning: =
declaration of 'struct netdev_queue_stats_tx' will not be visible =
outside of this function [-Wvisibility]
>  447 |                                 struct netdev_queue_stats_tx =
*tx)
>      |                                        ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:449:4: error: =
incomplete definition of type 'struct netdev_queue_stats_rx'
>  449 |         rx->bytes =3D 0;
>      |         ~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: note: =
forward declaration of 'struct netdev_queue_stats_rx'
>  446 |                                 struct netdev_queue_stats_rx =
*rx,
>      |                                        ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:450:4: error: =
incomplete definition of type 'struct netdev_queue_stats_rx'
>  450 |         rx->packets =3D 0;
>      |         ~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: note: =
forward declaration of 'struct netdev_queue_stats_rx'
>  446 |                                 struct netdev_queue_stats_rx =
*rx,
>      |                                        ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:451:4: error: =
incomplete definition of type 'struct netdev_queue_stats_rx'
>  451 |         rx->alloc_fail =3D 0;
>      |         ~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: note: =
forward declaration of 'struct netdev_queue_stats_rx'
>  446 |                                 struct netdev_queue_stats_rx =
*rx,
>      |                                        ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:452:4: error: =
incomplete definition of type 'struct netdev_queue_stats_rx'
>  452 |         rx->csum_complete =3D 0;
>      |         ~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: note: =
forward declaration of 'struct netdev_queue_stats_rx'
>  446 |                                 struct netdev_queue_stats_rx =
*rx,
>      |                                        ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:453:4: error: =
incomplete definition of type 'struct netdev_queue_stats_rx'
>  453 |         rx->csum_bad =3D 0;
>      |         ~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: note: =
forward declaration of 'struct netdev_queue_stats_rx'
>  446 |                                 struct netdev_queue_stats_rx =
*rx,
>      |                                        ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:454:4: error: =
incomplete definition of type 'struct netdev_queue_stats_tx'
>  454 |         tx->bytes =3D 0;
>      |         ~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:447:12: note: =
forward declaration of 'struct netdev_queue_stats_tx'
>  447 |                                 struct netdev_queue_stats_tx =
*tx)
>      |                                        ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:455:4: error: =
incomplete definition of type 'struct netdev_queue_stats_tx'
>  455 |         tx->packets =3D 0;
>      |         ~~^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:447:12: note: =
forward declaration of 'struct netdev_queue_stats_tx'
>  447 |                                 struct netdev_queue_stats_tx =
*tx)
>      |                                        ^
> ../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:458:37: error: =
variable has incomplete type 'const struct netdev_stat_ops'
>  458 | static const struct netdev_stat_ops wxvf_stat_ops =3D {
>      |                                     ^
> ../include/linux/netdevice.h:2452:15: note: forward declaration of =
'struct netdev_stat_ops'
> 2452 |         const struct netdev_stat_ops *stat_ops;
>      |                      ^
> --=20
> pw-bot: cr
>=20


