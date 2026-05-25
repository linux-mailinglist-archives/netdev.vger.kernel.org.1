Return-Path: <netdev+bounces-291228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCw9CaCsE2r7EgcAu9opvQ
	(envelope-from <netdev+bounces-291228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 03:57:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A2A5C54E9
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 03:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9816A3002B48
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 01:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088426B764;
	Mon, 25 May 2026 01:56:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EDD2673B0
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674205; cv=none; b=OGrFQEdd9Np/GWrw+3Po4S9TMUxeBl74C5ikYPvdXr61oA9+Yq0zn9lLk9QE61xJ/C/ieb69XEtNvrGlyGDJ8g9WM/uzUHtHgS6fdH+GpkJ5lQqhm5Pt17Vrl6cyf6nUuJVwo63YXOt1hgmplWMzb4N5uQmrod+70RoVVCdHVho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674205; c=relaxed/simple;
	bh=oM0HF2ZF5ty3edtSMi6OEPzmHLIwyyC1eXQKZTrkMAI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=CJMGgMxdrMIihAGV2S1rLubjbo6u5NF75snwMqHTlEyLH4ws7fjkeV8db2g39ZodRuoaFhelIMwh89i6uJsgnedOOqP3Wb1G2RXs3acnKeyWHgP4dSX5q2t32fMtmOCPcVjoNfcyvU+Cf3XjPM/rxRwz6D5pMaMayl/FkfpnoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1779674139t372t02676
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.246.224])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8077940220465381992
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<kees@kernel.org>,
	<larysa.zaremba@intel.com>,
	<jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<kees@kernel.org>,
	<larysa.zaremba@intel.com>,
	<jacob.e.keller@intel.com>
References: <20260519080048.7448-4-jiawenwu@trustnetic.com> <20260522073456.2032440-1-horms@kernel.org>
In-Reply-To: <20260522073456.2032440-1-horms@kernel.org>
Subject: RE: [PATCH net-next v1 3/3] net: txgbe: rework service event handling
Date: Mon, 25 May 2026 09:55:38 +0800
Message-ID: <03b301dcebe9$959576a0$c0c063e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJYwl1ZHtkV/zAT79Kiom6TpXSotgGVbYmjtRmfy/A=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NQpUKHQ/Y/CETVvvE6nrweO9Ei1wcOizQ/9BAax1hi5LKB3SY6sCyHbf
	02f3ltJHNayr3EvsmaYnUirU9K17A+NztjBSpjTVvcPYNTfiP5sF8IciuoNuxjnU/DZZfGm
	gLlfpJfap+P1DG7EO3Sp3nrK8Hdc1HEUls7b1Zt0kvT9M+qGugTkLzWP6VeNXcjYMoQqebw
	EmRZdFyOSTIzXgimUpNUH2enIfQKvPDRZ9orLqab1DM11aq5iVXQunM34g4kHj8Kl5SZ231
	b60io6w/PrU3B4Ydj+hrrPgM82EizX28XWhYzQ7gZUYXT0v2dG5CVgKo1w6wWSdVKBJliBY
	9T8pfb4CpgdP10SJFrYv0nmGnMqLZWorlDb5mPOpWORxJWeNeQJsLFinhvlPSAjRUu917b7
	tEuGb5BjAbgg+tbtf97zAU4PYsF4Ydft/0uzcvnzECvDuMlF8H33MeKQHAsHMGGj5E3y+oF
	zVL1xDnaEQHZ40TN4f7QB66915FK9n6SqSm07JxdBOtJ+tgKIWUDdikeglVBHBzNqWrC99l
	tzfJ5wjx/YkPz7vr6zmm3PUggR5bXgZ/w6aOyj0r1TaYe9FYGBtmHFs7WZiSnduZoH79ivV
	upn2oSkBvhdhxbviIkK2GQAp8M4PcrqYI2F4oea4oeF5+T0q4ax8Ahs0QRBLOpeMTmlKahV
	nTZp868hnhs0bKJWajSKZQLBUfqJYhCFQnK8CEjiQ+NEJjgHE4JJn6xZ+gjgAeNzsni27DB
	KhMd0Jvfgl8XO7spx7YdhmK6FeZB4yWG7Ay2tZ/OP5zmDE8gBb8+GajO1llHAhJdlmdveoP
	53cDNG8w1CAyGLIEZdWZSasPWr6+f6z9PmGPk1oHH8jwGm7GvDvr5OR/tRD6pfSXGvLrnWz
	nu7RQr1Xj7WVCUahfkaV1g0XBOznfM2mBgVIpXWUUsHaTnPicnSIMFW6DzpZfissMm9Ob0m
	rM68ytmRh3FmqR1avrR2VkzBc4lDD3AvlogHO2Q4EQBv+NiBFyzridXqmaMJuGrS2SYUpgS
	RJG4hqUyTwoYwUaTIshCjpzncP/EAvzQ5THSmAHbb0jIdR2BMv1q0YRjTquZbADzOkxCqiN
	/hOC3v+tO9stj+TItVKLMamoNyasSJ5rmdmIKJpyo/w
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291228-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.970];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 48A2A5C54E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 3:35 PM, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: txgbe: rework service event handling
> 
> This commit converts the link event subtasks to use test_and_clear_bit()
> and changes how module detection retries are handled. It also explicitly
> cancels the service task during device teardown.
> 
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index 6755464b46371..ce82e13aa8ae0 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > @@ -93,31 +93,23 @@ static void txgbe_module_detection_subtask(struct wx *wx)
> >  {
> >  	int err;
> >
> > -	if (!test_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
> > +	if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
> >  		return;
> >
> >  	/* wait for SFF module ready */
> >  	msleep(200);
> >
> >  	err = txgbe_identify_module(wx);
> > -	if (err)
> > -		return;
> > -
> > -	clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
> > +	if (err == -ENODEV)
> > +		set_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
> >  }
> 
> Does this change prevent the driver from retrying transient firmware errors?
> 
> Since txgbe_identify_module() communicates with firmware via
> txgbe_identify_module_hostif(), it can fail with transient errors like
> -EIO or -ETIMEDOUT.

Once the firmware interaction returns an error, it should not continue trying.
We believe this will keep printing errors. So just clear it.

> 
> Before this patch, the WX_FLAG_NEED_MODULE_RESET flag was only cleared upon
> successful completion, ensuring the periodic timer would retry on any error.
> 
> Because the flag is now cleared immediately and only re-armed on -ENODEV,
> could a single transient timeout cause the driver to permanently abandon
> module setup?
> 
> >  static void txgbe_link_config_subtask(struct wx *wx)
> >  {
> > -	int err;
> > -
> > -	if (!test_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags))
> > +	if (!test_and_clear_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags))
> >  		return;
> >
> > -	err = txgbe_set_phy_link(wx);
> > -	if (err)
> > -		return;
> > -
> > -	clear_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags);
> > +	txgbe_set_phy_link(wx);
> >  }
> 
> Similarly, does this silently drop link configuration on failure?
> 
> Without a way to re-arm WX_FLAG_NEED_LINK_CONFIG, any transient failure
> in txgbe_set_phy_link() will result in the driver no longer retrying link
> configuration.
> 
> [ ... ]
> 
> > @@ -233,6 +225,7 @@ static void txgbe_disable_device(struct wx *wx)
> >  	wx_napi_disable_all(wx);
> >
> >  	timer_delete_sync(&wx->service_timer);
> > +	cancel_work_sync(&wx->service_task);
> >
> >  	if (wx->bus.func < 2)
> >  		wr32m(wx, TXGBE_MIS_PRB_CTL, TXGBE_MIS_PRB_CTL_LAN_UP(wx->bus.func), 0);
> 
> Will canceling the service_task here leave the WX_STATE_SERVICE_SCHED bit
> permanently set if the work is pending?

When will the work be pending? Could it be overthinking?

> 
> The wx_service_event_schedule() function sets WX_STATE_SERVICE_SCHED before
> queuing the task, and this bit is normally cleared exclusively at the end
> of the work function.
> 
> If cancel_work_sync() dequeues the work without running it, the bit is never
> cleared. When the device is later brought back up, attempts to schedule the
> service task will fail, which seems like it would permanently break module
> detection, link configuration, and stats collection until the driver is
> reloaded.
> 


