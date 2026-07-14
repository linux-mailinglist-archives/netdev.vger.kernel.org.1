Return-Path: <netdev+bounces-307415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ppMdHBcGVmqtyAAAu9opvQ
	(envelope-from <netdev+bounces-307415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:49:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A037530F1
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:49:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307415-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307415-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA45D3032CF4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CBB441637;
	Tue, 14 Jul 2026 09:45:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628444102B
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:45:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022316; cv=none; b=o2GPB5Ya6wy12P0NtUEbEFDEiz6FWtziCYfG66JQ0TcmuqgsyCwCiN7vlN3fo4b+1oYKVLYgs4Ie2YoDQiBRQvDSRPR7XeAr9rxBCxuh1uz1skZc/Vsw6CbBo1KN31NtpJVABxGjWWKgXmwFeSOV8dt9UQov8hatA9m3penlKzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022316; c=relaxed/simple;
	bh=e80hz75fHiACsNYtOBtU0RPSLiyNWmDj3nFkWksyFUk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ie+PrAbTlb3uNKhi12ywM9Ufr6DlC88xK2tzFfuU/Z/jK6SnaQzskXodz4rohtC4xb701fQKINSJU5GjbtZL9hJL/WeWZu2tvRL5Hh6/VIpECIYUt2JBAd6CDbqzt1xlTMUyqIZx00dZrbvlRhD8RDXjhU3WpB3p6jVvKROaheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
X-QQ-mid:ivesync10t1784022230tfee9f710
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.200.247.46])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 109505156687055239
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<aleksandr.loktionov@intel.com>,
	<jacob.e.keller@intel.com>,
	<michal.swiatkowski@linux.intel.com>,
	<kees@kernel.org>,
	<joe@dama.to>,
	<leitao@debian.org>,
	<shaojijie@huawei.com>,
	<u.kleine-koenig@baylibre.com>,
	<weirongguang@kylinos.cn>,
	<larysa.zaremba@intel.com>,
	<fabio.baltieri@gmail.com>
References: <20260707061455.39564-5-jiawenwu@trustnetic.com> <20260714091113.1815787-1-horms@kernel.org>
In-Reply-To: <20260714091113.1815787-1-horms@kernel.org>
Subject: RE: [PATCH net-next v10 4/5] net: wangxun: implement soft quiesce for PCIe error recovery
Date: Tue, 14 Jul 2026 17:43:49 +0800
Message-ID: <0e1d01dd1375$461c15d0$d2544170$@trustnetic.com>
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
Thread-Index: AQK7Hm39yqKCzwep1DFT/xBLMuQ50QIvZhNXtJ8tdhA=
X-QQ-SENDSIZE: 520
Feedback-ID: ivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M7BGKxRTCLhkgKw7+3++8nvCYl9mWV3FwsCpyMQnms2NGb+NTIW2Om2n
	DDJkWtFdZ8/yx5A0s6zBk6h4RAkdPAVT7olmXt3L05VHfa6fVFPT34rMmT8sBP8RZ9B6l8L
	g8SJskiB62ywcIdRCgHnEgjc5UKZcAhKjZ3zyfbhlrWNlGlyLiIbPY5d2nmS1zJ5PzCe+3c
	gw5ts4+JauwCy99guZCb3EVYtM+0xx/x/v0JZ4lD1egLLT2u36kNBhd73/L35Iz6DnI2jFW
	Kx74NV2aT/NZK/fu3H+EW1LAyNkV2znpYad3mn4Uom8HqOqnBxhjDw9MmfbQo0rdYlkSADz
	yuaiuhTG8GI/VZgJU2NaKDaywj7MvjcQ7ctnoEtlWqG41U43SQ18SbdS87Kz8m/mDRQnECR
	VqVhkJ8HiPb34OE+p1508aZyi2/14W17aEMAxYL7KeNjqVo4ESRSO6712KAypowiixhx+jY
	DHCCsUDFSXJ8WSD2vsGqMv1qC6dsC85oBVGQEfWHGBMun4Qo1uHkUx8XwOK9zeANX12tATm
	vHxPWm/eU2PYCf9W3sn4T6Jdn0WHZ9xaGHjLMkBgeYq4Si0t6iWBQs5O/LK3hjq99Y0ftFB
	cTXxQUwrCGpy+10MxsKo/GaqGRLg0qeDBsJh4q1yVEH+vwFKZAvF5akZysPNuLYMyegcdDy
	i76MaOv1fHCGnzyTMVT61Oblu0VqE1bFeJk8s5yseKSJf8tA58nl1sd2J31DQrkQG+Y831S
	DvfEcQGatgMrTfu7t8Wtspu/Vx7xLaAkNUijNnJ+0BXAPCFS3k/bePO/P8lBjyK485dxWuu
	Z+cV7ri24WHqEUhKctz7gGSCeUZ7BTS86IqoEvs8VBox+2t0hgBSHYxa+iws+FiLM4Sxpvl
	EetxsdR9gr150jqoF0aI9nOu+pq03DtdavaYHTGrHVA1yU2pp5zBZlWolpJmtY0M+VZlHgw
	YgptU/pUg8ds/JXroz7XP49cBjkk28YL1kUCMD2CNOmTiL0rV4zZ6G9ccIaXKVgncY7tmYA
	sFcsuFcupvP1ffZGMof6XzW/x3CKW05YWyHWbkRwC6jN0gPyg9r4jTBv9k1RE=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:kees@kernel.org,m:joe@dama.to,m:leitao@debian.org,m:shaojijie@huawei.com,m:u.kleine-koenig@baylibre.com,m:weirongguang@kylinos.cn,m:larysa.zaremba@intel.com,m:fabio.baltieri@gmail.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-307415-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,huawei.com,baylibre.com,kylinos.cn];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:from_mime,trustnetic.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99A037530F1

> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > index c8a4822d38194..a65312c8078fa 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> [ ... ]
> > @@ -3383,5 +3383,23 @@ void wx_service_timer(struct timer_list *t)
> >  }
> >  EXPORT_SYMBOL(wx_service_timer);
> >
> > +void wx_soft_quiesce(struct wx *wx)
> > +{
> > +	if (!netif_running(wx->netdev) ||
> > +	    test_and_set_bit(WX_STATE_DOWN, wx->state))
> > +		return;
> > +
> > +	pci_clear_master(wx->pdev);
> > +	netif_tx_stop_all_queues(wx->netdev);
> > +	netif_carrier_off(wx->netdev);
> > +	netif_tx_disable(wx->netdev);
> > +	wx_napi_disable_all(wx);
> > +	wx_ptp_quiesce(wx);
> > +
> > +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> > +	timer_delete_sync(&wx->service_timer);
> 
> [Severity: High]
> The commit message notes the service task is deliberately not cancelled here
> to avoid delaying PCIe error recovery. However, does omitting
> cancel_work_sync(&wx->service_task) open a race window with the subtasks
> that rely on the WX_STATE_DOWN flag?
> 
> > +}
> > +EXPORT_SYMBOL(wx_soft_quiesce);
> 
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index a8773712cff82..a7bde03a98feb 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> [ ... ]
> > @@ -94,6 +94,10 @@ static void txgbe_module_detection_subtask(struct wx *wx)
> >  {
> >  	int err;
> >
> > +	if (test_bit(WX_STATE_DOWN, wx->state) ||
> > +	    test_bit(WX_STATE_RESETTING, wx->state))
> > +		return;
> > +
> 
> [Severity: High]
> Does this state check adequately protect against concurrent MMIO access
> during a PCIe reset?
> 
> If the task passes this check, it subsequently sleeps for 200ms:
> 
> txgbe_main.c:txgbe_module_detection_subtask() {
>     ...
>     if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
>         return;
> 
>     /* wait for SFF module ready */
>     msleep(200);
> 
>     err = txgbe_identify_module(wx);
>     ...
> }
> 
> If wx_soft_quiesce() runs on another CPU during this msleep(), it will set
> WX_STATE_DOWN and begin a hardware reset.
> 
> When the task wakes up from the sleep, will it call txgbe_identify_module()
> and perform MMIO reads (such as rd32(wx, WX_GPIO_EXT)) while the device is
> in reset?
> 
> Could this time-of-check to time-of-use race lead to Master Aborts or
> fatal PCIe errors during AER recovery?
> 
> >  	if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
> >  		return;
> 

This task is typically triggered during interface bring-up or optical module
insertion. It has a very low coincidence rate with the timing of pcie errors.
Nevertheless, as a defensive measure, I will add a re-check of WX_STATE_DOWN
immediately after the sleep returns.



