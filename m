Return-Path: <netdev+bounces-293967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLj2FxRBHmrviAkAu9opvQ
	(envelope-from <netdev+bounces-293967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:33:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A356D627461
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B1BE30305E9
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E5131F986;
	Tue,  2 Jun 2026 02:29:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF60362120
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367363; cv=none; b=FBa7nWxYH2C9qQCs1H8ORDNEtHu2XvoIgfuol0iCA0kObSd12hhWb0gafqZWzYXufSIb5uPMeVAHfE5vCZ+7QHpSQvYUIAnqNyPFrDOifmPCZelvY2K3zOtC3SZ1egTT93JCuhtHrFe9QQxy34zzQ898jUH1c6fbI1/Gp6xPmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367363; c=relaxed/simple;
	bh=n4O2NE6UtB48+17crp094/J1QXN2t88qmRSnJQVmQvA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qjXFAr/oEe8wS3k7gSgolHPFI9ni/bqDaZ324fv4Uncc8AJkIPbQuAgyroEiuAMTVoK1i2c1cOWlLXETCbVwsRlkbxcbddinZXztBDnOdJpD3Gwu23Bp1a+oyaWvgTlT+GQzrfHrJzDdYUDnLAWLQQtVNENssG5ON05rk3xlMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1780367290t846t11888
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.207.111])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 9419051175110529402
To: "'Loktionov, Aleksandr'" <aleksandr.loktionov@intel.com>,
	<netdev@vger.kernel.org>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Keller, Jacob E'" <jacob.e.keller@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Zaremba, Larysa'" <larysa.zaremba@intel.com>,
	"'Ingo Molnar'" <mingo@kernel.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Johannes Berg'" <johannes@sipsolutions.net>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com> <20260601072221.2952-6-jiawenwu@trustnetic.com> <IA3PR11MB8986104B1CB7F3582CE9D5D8E5152@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986104B1CB7F3582CE9D5D8E5152@IA3PR11MB8986.namprd11.prod.outlook.com>
Subject: RE: [PATCH net-next v4 5/5] net: wangxun: implement pci_error_handlers ops
Date: Tue, 2 Jun 2026 10:28:09 +0800
Message-ID: <088f01dcf237$73f9dc30$5bed9490$@trustnetic.com>
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
Thread-Index: AQEmZmPiFxLXVQw6wm5cjAUm9/PfJgEIHjjLAeFJaVK3gFXTIA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OZiu3a4l9JB5MBVwUbBqAsPP7UeZ/zkXh6UvLYvqXYpFiAY8pAsAmMpt
	Md8SBgKZA5u1bp0XkIk4zAM3QpXa5jAN0FgRgq5FrnwJ3pzaI4kJG0E0/j60599cdIpzN/9
	iMOsr8GV7MZ62G1FkOTT3HBMz57rDmQTCUGr4glSyW5koHukX3gl0xqwiCpo0TR6EgVw/9L
	B8YPTnrzlIGibMdLJnd8nHW8o+/i7/1Ka9iRHRJRrs6zjp578t6IO6lr0AUjhj9ZgibJ9xi
	eRXfebRPJQGc0op+Th3Bhlhv3rTxYfXiDedO2jMhJDJaUG0U/Fz7p9xs9T73/OKMdfXtsAr
	XQ8EkbOoINhrjx0Rw0B6GVsw9Jg9yfM9njQd4C3fjv03aUrSfGcw+xr00l05rl+SSBfcgp7
	5JnnMZWcGpfKv0euiPv9ty1YboS6Mk870LVXNuIzcComf+47rQmJMQ8fgZHqwSDXbg6k6V5
	O4WM1NLSg0NTrcmJUsZX/dGOL7gFR542Nd3Yffzdiu6Kt4GosHaK9pNgb+aQBcM0AZHILrE
	nr7l+FAoGq/zfBGH0kll1eOdzXOKeFVx09csLbkPrx2vufVBR39yLTOBQURnodqUhbNxXZJ
	pZDrEQWOoxGY/3ay49/v5aRg6GdElRVbCfnhim4C+UbqJuJ+fFVUjhy3jhyYImYx21+w7NP
	IQnASu6v2hkyE5y+v5n4A7pahZhM/oc28J4AkE2pBbFwIoJuEGLkfbsPCUiPyZxAQLTjC1I
	UXYMV/D7XhyMbZ/ExTTrkiknf3Uj+ikv5Y5AEuzPDloGjkBJ4v+xHS1EuXqY3FMOoSC9Ggj
	Ywt6c4KBNCSeU0r7BLPqxuUb1aZ/O37gYaIIPaSJwT77XVJ7E+XH8IWNXzyxW5e/UNZQ3wW
	fuurq6kxcgVzMndNxS+SJdkh4WngauSrG94FD7PinD0gdDBT7YIG9n+9s5NT0YoI/+pOpIx
	XgkFJOuTDMNIdZhr7/j56ujSUgeo6OGvqrDbDt7vD2gBhUek0hnvoyCgKyd31W9HtcuWcSr
	h8C+bxLdwvanW1a1BVDqXk9ObQAEj58P5Qw+0wEBQMRtrBPQZDEPwATFPcIZPILWjmc1xrO
	A==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293967-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.974];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A356D627461
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +static void wx_io_resume(struct pci_dev *pdev)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +	int err;
> > +
> > +	netdev = wx->netdev;
> > +	rtnl_lock();
> > +	if (netif_running(netdev)) {
> > +		err = netdev->netdev_ops->ndo_open(netdev);
> > +		if (err) {
> > +			wx_err(wx, "Failed to open netdev after
> > reset\n");
> If you jump over the netif_device_attach(netdev);
> I'm afraid the interface probably will be UP (IFF_UP set, because netif_running() returned true)
> but permanently "detached" - the kernel's watchdog, TX queue wakeups,
> and carrier-change notifications all check netif_device_present() and
> will silently no-op.

If .ndo_open() fails during recovery, the device has not been successfully
reinitialized and therefore should remain detached. 
Calling netif_device_attach() unconditionally would expose an interface whose
queues, interrupts or other resources may not have been restored successfully.

 


