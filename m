Return-Path: <netdev+bounces-294532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nfyWCe6WH2oRngAAu9opvQ
	(envelope-from <netdev+bounces-294532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:52:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D0633B89
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:52:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294532-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294532-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 473853003BF9
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45E3D8115;
	Wed,  3 Jun 2026 02:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25F191F98
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 02:52:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455144; cv=none; b=Y7kFJCo/VCEFu9bTYmcqyX5FPabrusjBnugLVFH56Dxb6bs4t8F50BQK9pF7kVh6N/OpCsXqce8RQRL2LFOd4wCbob0Nn17IaswuFCWw3KgaTPa26mzHRKoh664hg4k+oqDfZ+6rnVJPxJPcxuzdQf80x8WrXd0zuwHuMbw6YdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455144; c=relaxed/simple;
	bh=Q6eR0SAT/uKHN/6h7YuGqZBEURlSyy2gNsq2bj3TXiY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=kh5s9wC7t9BNOoMkUBFdidrGG3yFC92JBrskoM7oj6AWyDSJf/I+7nvKPh7GYdYutYKCFtOn5kIHBGm4jGanodHZCl8y4LWHAkrzm0FSyWasOZJZeqK/8/7/IXUwm1vCDCzyENGzOaqWBvlJgEn7KxhjPxftnCV3TA2IVXvzjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
X-QQ-mid:Yeas8t1780455089t594t31214
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.207.111])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 486067191020761161
To: "'Larysa Zaremba'" <larysa.zaremba@intel.com>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Ingo Molnar'" <mingo@kernel.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Johannes Berg'" <johannes@sipsolutions.net>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>,
	<netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Ingo Molnar'" <mingo@kernel.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Johannes Berg'" <johannes@sipsolutions.net>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com> <20260601072221.2952-6-jiawenwu@trustnetic.com> <ah6-x9CJHwxh_3Qt@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <ah6-x9CJHwxh_3Qt@soc-5CG4396X81.clients.intel.com>
Subject: RE: [PATCH net-next v4 5/5] net: wangxun: implement pci_error_handlers ops
Date: Wed, 3 Jun 2026 10:51:28 +0800
Message-ID: <095a01dcf303$e03d08a0$a0b719e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQEmZmPiFxLXVQw6wm5cjAUm9/PfJgEIHjjLAbXhlRG3g0pdsA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MKut7GF+UZm9gj21eL6U7wzx7XMwbtj1SL/jq616fwfP5IKufGn3D5l3
	pse0sxhBzsDeHA+Rg8HJHa7VOKg7K7lVhfq9ipnMwnetTIb5F/G/wypWuPtpuTUv+LW1yFz
	s62FfErEB4iDbAMWpTWrFFSYBASdJJ3MFJf5kLyL8xvURAGzjaJ5hhLF9grTJk2Z/4GOHci
	ZlNnEmhQSgTz1G/Ih0DBRUxPH2rRYH6USI/BmpygmjZhCtC+eZUtYF3k/k+QCKm3qqH14Pa
	Nv5DZmPhpu71MpBPW/XLjH3kC5HakPCPbc6KY29LBqBiDNxINaPLLvrybZI0XilV/4g1onT
	EyX3y/ZsIbUbHlEJOvBJTFIW0ewAVSpKRBpXWZo4nsUMfPzzfAqp7bGKqOqo4jzGBThWvm4
	/6mEBLLMC4bABU7o5ug0M7JnxkvYcb/IFScfhAsJXuMHWlEPm0a/Rn3xO9NC7NoAbEVx8zM
	Pk3WDpAKET20weOu4YQiU8qmtefBPAq7Mim5cYljqXq9QkvznYhrzn7EPGhA+ST87IQ/hYx
	/jaC7Mp29duKkpvtYcT7jMK001WloKOsZqF+/H/UG52e4R7tHFIyyA4judGbcLphxoGet7w
	fHIgPSh4AT1wRtCSAaQCMUFbzMB19h0qu1W2ZizYlzeqURaN4w3kjOPywENbdrcLmdM3wgq
	RF2s4xcmXFYHbVAG+DxIqV3RhJ99aKSo9ycTvXEIbthoPpZNCSHtLjgpGkDkZHqWJNLhB66
	CNWte4XCPtkGI6RReQLV7COeBzO4a8XbOQGlnsTIwJ/htE5RO5a8W2bk35Cb9ZbZGHzeCPA
	UC8CmY75sz+mrR3hkTjXwWIgrYuBRxPSMddChFbWCdsNe8OcLpMq84PtLMoYs3SSoga5E9W
	8nctKyl+t/V/Nk7Df1tXDmiyTDyLHs0yH9xczTuSoyXA146Mm6ySlZzh3uTni2NZTedv5Er
	Kl17aQmR3hOq/LC+e3FkAsYHs0PoWQnQOmjNTW/Vru71AmCBn8Ja359e+YmzGFAuHOxsgbR
	DAbn9BRp5zyBRPkb08imnEcN+om/jH+24kw7Is1SYExf1fVTDGQkTWxB9xzMDGFTrjqyrYv
	MlbcpR0MEqS03znEUvjjueFHlZboMNtDXLuKlxvIEZFpHWJX4NC6/Tv4blE1QC0sA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:larysa.zaremba@intel.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:mingo@kernel.org,m:joe@dama.to,m:leitao@debian.org,m:aleksandr.loktionov@intel.com,m:u.kleine-koenig@baylibre.com,m:johannes@sipsolutions.net,m:fabio.baltieri@gmail.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	TAGGED_FROM(0.00)[bounces-294532-lists,netdev=lfdr.de];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:from_mime,trustnetic.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 224D0633B89

On Tue, Jun 2, 2026 7:30 PM, Larysa Zaremba wrote:
> On Mon, Jun 01, 2026 at 03:22:21PM +0800, Jiawen Wu wrote:
> > Support AER driver to handle the PCIe errors.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_err.c   | 111 ++++++++++++++++++
> >  drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
> >  drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   9 +-
> >  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   8 +-
> >  5 files changed, 127 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > index e249cea874be..ae5d14071f3d 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > @@ -4,11 +4,122 @@
> >
> >  #include <linux/netdevice.h>
> >  #include <linux/pci.h>
> > +#include <linux/aer.h>
> >
> >  #include "wx_type.h"
> >  #include "wx_lib.h"
> >  #include "wx_err.h"
> >
> > +/**
> > + * wx_io_error_detected - called when PCI error is detected
> > + * @pdev: Pointer to PCI device
> > + * @state: The current pci connection state
> > + *
> > + * Return: pci_ers_result_t.
> > + *
> > + * This function is called after a PCI bus error affecting
> > + * this device has been detected.
> > + */
> > +static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
> > +					     pci_channel_state_t state)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +
> > +	if (!wx)
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	netdev = wx->netdev;
> > +	if (!netif_device_present(netdev))
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	if (state == pci_channel_io_perm_failure)
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	rtnl_lock();
> > +	netif_device_detach(netdev);
> 
> Sashiko says:
> 
>  "Calling netif_device_detach() stops new packets from entering the TX queue but
>   doesn't wait for currently executing ndo_start_xmit operations to complete,
>   which netif_tx_disable() would do."
> 
> Device detaching does not grab __netif_tx_lock(), so it does seem like
> netif_device_detach() leaves some race possibilities.

netif_tx_disable() is missed in soft_quiesce(). I'll add it.
 


