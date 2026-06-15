Return-Path: <netdev+bounces-299295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BtXJI6BsL2rnAAUAu9opvQ
	(envelope-from <netdev+bounces-299295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:08:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB86682F7E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:08:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299295-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299295-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7916930062D4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E3247DE1;
	Mon, 15 Jun 2026 03:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD43223DFB
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 03:07:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781492882; cv=none; b=kpW5aMIzz/FjGRayiBzzeqdTdapiRnXlW6gYe0AGFl9+IRiBcdpiWkF/NHk8bphoBFBpzbuChlisj2ChyKeMz1z8/wteX3yNOfpNrlHj0bIUllsjooIJypdatYtpVhgKAG01ae2f4wBTezcsALtXlEaniwVWIDVzDTMQh8dw+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781492882; c=relaxed/simple;
	bh=0C1UYnmCry08Huufzy/KPisYPs31PBRDAhLGOsARSss=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qts3LdxYqbEQKS6eHYrdmhMfmc5GBwpZJpQZ17Wg4kUdqx96WiH0SfKn9HLT3z+31nraKdBNJEqRIMTZXE1E0+I2/zv2EeJcQ3Ez33DXWadGLe7fHEIvALJI39K1QDKvDBcQHTxGYT5ChZl65M5iqaNj9SbW/PdrlZjke86gILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
X-QQ-mid:Yeas8t1781492807t791t52977
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.157.22.210])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12619361186151596884
To: "'Simon Horman'" <horms@kernel.org>
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
	"'Kees Cook'" <kees@kernel.org>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>,
	"'Thomas Gleixner'" <tglx@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
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
	"'Kees Cook'" <kees@kernel.org>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>,
	"'Thomas Gleixner'" <tglx@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
References: <20260610060917.23980-1-jiawenwu@trustnetic.com> <20260610060917.23980-5-jiawenwu@trustnetic.com> <20260612154929.GD671640@horms.kernel.org>
In-Reply-To: <20260612154929.GD671640@horms.kernel.org>
Subject: RE: [PATCH net-next v6 4/5] net: wangxun: implement soft quiesce for PCIe error recovery
Date: Mon, 15 Jun 2026 11:06:46 +0800
Message-ID: <018b01dcfc74$00443c30$00ccb490$@trustnetic.com>
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
Thread-Index: AQH9NqXiSq8t3g99zFNQdAvFN/QoIQJw8LB5AZ4y8Z213f6/MA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nj0bGi/6uW3PSes0yMhWFvyO2EG+v8EjaHTQN1sI2S0QVRmVbMO3h+D/
	cCpbdWupbdpBhGd1KXAERc85vg+Y6WEkBUasvX783VES6PJs9axNh0WgGvnHbmK8jmhk3CC
	/2dFcDlzzXQeeKQSA0c3YEpn1oFK9QSULbaTLl+UWqDV4w4etlAUk3vptL4uGAYd0RCnXM7
	1LAur71mPg6myVJOTN2kxPTQMnjpZc6JkL+h3HMtGus+vnJUdQo74RgGcKu9LOZYYij2Dli
	KVhI7K0tM1Cxm8A0pk+LxQpaSBDmERk2nQ9E2dm0kMVwiBi0Ik8WoToL/BuEaTuTUti8Jd7
	WSr0SiaogDZyy4h8XNa1OAgvVLamrWBkIYQRHYLbAm6kqi7pqrUfAvDrl9t6ky0WrVNk3jp
	yAjdxqZVZo0bJhTYfrcG6C1GcIcP4WV85OwXlbAFbGwDNIDbxQBa7XbxJxRIRiLil6IODFc
	A7WRua+NUUD4kR+Rwze40SbjRkn6Jriw9LKuZo+HT5am16AhYm2G3sGJnhgM/V0uamGoiix
	GZGxGeAnx7FoCvoTzIwGFZbpxdWykKUVyHiIm6yEeOsJpKHrXnrGOso0EnD/25Deg006Cws
	3Nj5KwsNQZ5+gC335mRzdXowq9AutS0n7hayQHGGaS1Yc2Bd7bNgI28B9imXIC+IXHUmVLu
	RYZ6PI7m1QE9kRdwJdJljH4hO4TuZCQ5R86TdGEJMVWIvpA8NkqYg2KqiB+b1bMHmMP3D6a
	CTF6J8Mu5KU5BMYjShDDoNK27T8peuFGAoBO6+VqRLyl1mldFQiqLUKIbF0kBtZyRGJU+dF
	E1gbxhDXtDMQLz/42b+zyGr0A8ND2ehJxSpBV9m2xxMBoAorqgAwL6YFAEjBnrTMTwfQJjL
	9A2V1NBKChEkXp7QMYo9rAgC+ZIa+2GH/YUes6HO47PFFpSoBpqZ7fKO77irHDhq+4hnlrd
	SCkmcbFUik5HQ2rQz0dhEwEe+VlmlehgJ7Ubjol0rap1LrFpF+kc3H1pOYOZ2YuqPMX/KgP
	35e3xNMVeTEAKev0l439bwGhnZp9DnM2cUtkXhdvKMJIL2nnSY7W9fEGmCgIDn5V7ZofnLa
	ivMo1hbuqIw6X+5J8jIwjo=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:joe@dama.to,m:leitao@debian.org,m:aleksandr.loktionov@intel.com,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:tglx@kernel.org,m:gregkh@linuxfoundation.org,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	TAGGED_FROM(0.00)[bounces-299295-lists,netdev=lfdr.de];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,linuxfoundation.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CB86682F7E

On Fri, Jun 12, 2026 11:49 PM, Simon Horman wrote:
> On Wed, Jun 10, 2026 at 02:09:16PM +0800, Jiawen Wu wrote:
> > Function wx_soft_quiesce() provide a lightweight shutdown path during
> > PCIe error recovery. It avoids MMIO-dependent operations in PCIe error
> > status.
> >
> > Waiting for the service task to complete may unnecessarily delay PCIe
> > error recovery, especially if the work item is already blocked by the
> > hardware failure that triggered AER. So the service task is not
> > explicitly cancelled in quiesce path. As a measure to block the service
> > task, the checking of WX_STATE_DOWN and WX_STATE_RESETTING is added at
> > the entry of every work item.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> > index 44f3e6505246..dcc8b3ae1445 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> > @@ -842,6 +842,27 @@ void wx_ptp_stop(struct wx *wx)
> >  }
> >  EXPORT_SYMBOL(wx_ptp_stop);
> >
> > +void wx_ptp_quiesce(struct wx *wx)
> > +{
> > +	if (!test_and_clear_bit(WX_STATE_PTP_RUNNING, wx->state))
> > +		return;
> > +
> > +	clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
> > +
> > +	if (wx->ptp_tx_skb) {
> > +		dev_kfree_skb_any(wx->ptp_tx_skb);
> > +		wx->ptp_tx_skb = NULL;
> > +	}
> 
> AI-generated review of this patch on sashiko.dev flags a potential UAF here:
> 
> 	"Could freeing wx->ptp_tx_skb here cause a use-after-free or
> 	double-free?
> 
> 	"Because ptp_clock_unregister() is called after this block, the PTP
> 	 kworker might still be running.
> 
> 	"If wx_ptp_tx_hwtstamp() reads wx->ptp_tx_skb just before this
> 	 free, it will pass the freed skb to skb_tstamp_tx() and call
> 	 dev_kfree_skb_any() on it again.
> 
> I'd appreciate it if you could look into that.

I will move ptp_clock_unregister() to be executed before we free wx->ptp_tx_skb.

> 
> I believe that the other issues raised in that AI-generated review have
> already been discussed in the context of earlier versions of this
> patch-set.
> 
> > +	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> > +
> > +	if (wx->ptp_clock) {
> > +		ptp_clock_unregister(wx->ptp_clock);
> > +		wx->ptp_clock = NULL;
> > +		dev_info(&wx->pdev->dev, "removed PHC on %s\n", wx->netdev->name);
> > +	}
> > +}
> 
> ...
> 


