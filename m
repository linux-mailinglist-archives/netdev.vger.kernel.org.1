Return-Path: <netdev+bounces-301916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SgC3EOD4PGrpvAgAu9opvQ
	(envelope-from <netdev+bounces-301916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:46:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B76C45DD
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:46:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301916-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301916-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A355B302CABA
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3113955C7;
	Thu, 25 Jun 2026 09:45:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18DD225413
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:45:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380753; cv=none; b=SApPujSO0v9BXNgUSffpTCcsLpvG1ABStd6PxRKvftzdmAwh1C2REP3tB/FfLzB7eIK5LNOxGaEdoVg02JQIiEvmOGLOx5qDdNcRtGToycu89NIEji1hwAPJNd0yXDGccj7J8LjyIOMVmu1Sa4TVDLWCXb7zibag9nLuqq8iEIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380753; c=relaxed/simple;
	bh=zOWrvn3ss+QEOyij0G8oc1ZwjQLhi/VPlCPJGR/+byE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=oclGnZLC3Im+zLRIGmBSPRLwQ+kuIz61CITFJnFV5J4XzqjI5ZPQX+/UVgB53P8tfqmpmKaNbsqVEdzDEgLeZd3FoDvUT+oYJcYm3AzBOh4z4ZsXMWQxbmLV8zEvIjeTGJmy1Ekmwmo0rgBRxO0N5eeR3PqzBGJIYWtT/dK+GaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
X-QQ-mid:tivesync5t1782380674te10425e7
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.204.248.247])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 138484462909513450
To: "'Larysa Zaremba'" <larysa.zaremba@intel.com>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>
References: <60D88ADD3E295420+20260625090851.539640-1-jiawenwu@trustnetic.com> <ajz3QK96wKoLD4n4@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <ajz3QK96wKoLD4n4@soc-5CG4396X81.clients.intel.com>
Subject: RE: [PATCH net] net: libwx: fix VMDQ mask for 1-queue mode
Date: Thu, 25 Jun 2026 17:44:33 +0800
Message-ID: <062401dd0487$3a3152f0$ae93f8d0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKqh+6WpHH9Hogzz1b3o6qRTsUUpQN2I7B0tJhMjbA=
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MlPIYQpV14UTjvyRfkRl7WnZqr1XLaIuFLVC887F0A9TpuhEL68aBRmi
	CrvhBeJzyNOYhrP2XvrjDTrd/H8TfFuskHdgBrN63ejzDpOIbRHUqZL6fDV4K2RqOb/TNXn
	RTqkgHZV7U6K4kAaRkqVYj6/6pIgg0SHpemhQtCsj0TcNlkScek2nCH2artugi+izNujglm
	156CmjKzJJyem9poIKnKF8W2mqahEoiCDOoRiYhDL2A6Yo88RVYsmmyn62ypnSYWLZTQh9P
	Zy/wPg9f1jRvY5ZVMZKrupGtfI+vaD8CZsmg/9MdcJfv0dRRU5M04r5fiHqOfSNIp4n9hlO
	mVGEC94TFAVNclB1ML4TEhh3zecwakhDQZStJVJiG3OofiEVhBgU9izogetZKVmcuFWkbiW
	Tb1NLQ9GQJvSfMiZ2Z5rGKvZIlZ4o4N4CzDuTT7Jx9NbicnWzneWmDqEs/jAptoW2x5czHC
	a4R7WcDkTZ3njRVTrmVQXo7hEIi6O3aDKJh8fC4mz2M9ofMnjSaCeAD5teTZXXxpwZyoJq2
	4xsWGuJ0Yb8eoe/j0tx8h3M9wcfrtsXsQJTrKvpSFTMkDPNGBuZnQp6QCso4KragONE7fGC
	b2gGgscRBOCCpDEb6CuTAJ0FnzKYFnfzAfmZso/hbW/dPOY+CU0culfi+gLiXP4Bs0nGGtS
	+9Cp/1gvpDdfaA74E3TMw6YdZsuLo9nV27/qp0LV6ZH3YpuJspuCxE13gXll6RbX49sJldH
	tis32B88N7MKrzd+8n6VFwgjG5S+ky8RnqKs5tX+Ht+9lvXOoFWlIbpBVAkCoD6hoohqUCp
	VJaVu4P7KdYuEiHHDuoGYgvC7dGMGUoM6sHCd3zNmnq8agv8qHk7n/EWuudELfL0DhKA55F
	vZZHg7wNLbJtUsETctqSBdyulHsjfdvXprM4PGg0r+/Aa++Q7MQd2v8sOr1FMlQne+tuaN8
	YY4g+ZeCFbse9s70svLFC2gkyXxzVVLDW7Rp9BM8z+Re19HNjp34RtEgqZv+oNNCWieI78T
	rKe6ZCa0S6rKN4NccONFAlwjwfml6ogVzASCepf5kKjQ/aPtIT8Hu11+/jMhXOn4Q2yORfP
	KfOxY18epRxIiTb1VAcEyuawmohRCPGI9ORjB1xFOLdagYI4OgfbAM=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301916-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:larysa.zaremba@intel.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,trustnetic.com:email,trustnetic.com:mid,trustnetic.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE2B76C45DD

On Thu, Jun 25, 2026 5:39 PM, Larysa Zaremba wrote:
> On Thu, Jun 25, 2026 at 05:08:51PM +0800, Jiawen Wu wrote:
> > In wx_set_vmdq_queues(), the VMDQ mask was not set for the devices not
> > support WX_FLAG_MULTI_64_FUNC, i.e., NGBE devices. A mask of 0 causes
> > __ALIGN_MASK(1, ~vmdq->mask) to return 0, which incorrectly sets
> > q_per_pool to 0 in wx_write_qde().
> >
> > Fix the VMDQ 1-queue mask to 0x7F then ensures that __ALIGN_MASK(1,
> > 0x7F) correctly evaluates to 1.
> 
> __ALIGN_MASK(1, 0x7F) evaulates to 0x80 (128), not to 1. __ALIGN_MASK(1, 0x7E)
> evaluates to 1. Maybe you need 0x7D for 2 queues and 0x7E for 1 queue?

Sorry, the commit log is so wrong for that '~' is missing...
I want to describe that __ALIGN_MASK(1, ~0x7F) evaluates to 1.

> 
> >
> > Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 1 +
> >  drivers/net/ethernet/wangxun/libwx/wx_type.h | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > index d042567b8128..814d88d2aee4 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > @@ -1802,6 +1802,7 @@ static bool wx_set_vmdq_queues(struct wx *wx)
> >  			rss_i = 4;
> >  		}
> >  	} else {
> > +		vmdq_m = WX_VMDQ_1Q_MASK;
> >  		/* double check we are limited to maximum pools */
> >  		vmdq_i = min_t(u16, 8, vmdq_i);
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > index c7befe4cdfe9..65e3e55db1cf 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > @@ -486,6 +486,7 @@ enum WX_MSCA_CMD_value {
> >
> >  #define WX_VMDQ_4Q_MASK              0x7C
> >  #define WX_VMDQ_2Q_MASK              0x7E
> > +#define WX_VMDQ_1Q_MASK              0x7F
> >
> >  /****************** Manageablility Host Interface defines ********************/
> >  #define WX_HI_MAX_BLOCK_BYTE_LENGTH  256 /* Num of bytes in range */
> > --
> > 2.51.0
> >
> 


