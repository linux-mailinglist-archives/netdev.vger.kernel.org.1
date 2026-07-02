Return-Path: <netdev+bounces-303914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gbqYNcPORWpOFgsAu9opvQ
	(envelope-from <netdev+bounces-303914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:36:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFEA6F30F7
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:36:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303914-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303914-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF2FF3021746
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 02:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0930C17E;
	Thu,  2 Jul 2026 02:36:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67830DEB0
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 02:36:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959808; cv=none; b=q3ViCoE8V48kJ2ZeUeWjV4v4vma9okqB5b/ABBG0PVBKKqHoXTJ9E8dA2LMbf/ciuoaNHwuZ7JwE8ul87VtsOVdu2GPVOox4eWdEOW8Mt6OpHRzQUL/YCyaceeKusFW3FGHKBlXV8wownSuGc+5lDfQgLE/r91/Y6P79nhR5MsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959808; c=relaxed/simple;
	bh=qJleJ2P7T7ysS4stbIbgH3VI+OYnpG69DBzp1sy/OyA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=DhsnKkT8ZKNdpfQU50Vlt1bhr1EgR9OrG3Mj4MvbXJvZEi7mAX1zyWv2nUrCFVRNaOVwj2Kh+c0dim/Fy82HNkNMNT0Dywp8oaZeLZWKDG3AUO8gaXFd7JC3Q6VSOa2zQzSnusX2sEQudG+YVf+jTNcK7E5TVh6YIoASmci54Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
X-QQ-mid:tivesync5t1782959723tde873c50
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.190.76])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3599502236476360653
To: "'Breno Leitao'" <leitao@debian.org>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	"'Thomas Gleixner'" <tglx@kernel.org>,
	"'Rongguang Wei'" <weirongguang@kylinos.cn>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>
References: <20260701072357.33984-1-jiawenwu@trustnetic.com> <20260701072357.33984-6-jiawenwu@trustnetic.com> <akTvTF7n9P1lrqCN@gmail.com>
In-Reply-To: <akTvTF7n9P1lrqCN@gmail.com>
Subject: RE: [PATCH net-next v9 5/5] net: wangxun: add pcie error handler
Date: Thu, 2 Jul 2026 10:35:22 +0800
Message-ID: <083401dd09cb$6e203b00$4a60b100$@trustnetic.com>
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
Thread-Index: AQGJwPPsd35Dci4QEAVDgcZ4JwF3iQH0CFSiASRn/dm251Eu8A==
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M8EzRWOz+OLaP6DtEjq4vBVVeRH2s1rpA5Ge8qqujkYnfPqwhYbUK2RE
	iufqEPPEVUQ87hwRpW42T3iqDDxSCj+zvOR+o2ztyyLa9eG84K+9gK2dTvQH1Kv61XHdtDg
	VrOSRZpjXAGqi/GPmz6UjVe31rlSGigeMwt7eq+59HNH95G9Mi35NSEU4d2pvCsQc9GfACC
	ZTgxn4SrbAhYPCDsHwVbEg0agRP4u3IRPTT+iDFU6YAAFMP9NwxA+2594cnMfRur47T+V1h
	Jn+fvyPw/Hi/a19pmLUiXWZxH9bOAPCs8jDu14BP2gOeXgn3HV7xWfwQD2Ylf9y88qpos86
	R4llgRjKPnaUlzVi3zBh4ErwXwrjY116XLXoA7XE0asmyuzKlBLnc/iki6o+h5ZQUXD2q9e
	0PQO8LS6yCy38KwgM67d7Rh8yz3HXp0IKvIiw+3dRqFNJNZEADHXNP/yZvzv1heLrx6lfLY
	7B+BEfVNEOKrn+AVoTaIAewmh4L1iPptgc/s0ULF/YRcQTcAz89XKzs3pjL/eOdfW2xK8dw
	rpTBZVR92AN8VbVxo37AUmFkHTaV5ZElu1SDP9KDCEAK4WK9d4W9qHuSqSgW+hG0e/qmXsY
	NjWSWvH/NIcVb2i63r66hKwRcT/c0CUitO5BuYkVfsPwEPUbbVX1HBW24k8EQ8lLlDil/Z7
	yccGXT1HFywnLSBZ1/KTAJ29ChWEI/ak5/sC5Fsrj3RI48GTVZSv94fmiXs+Ca7/5NNh9MX
	+0KfYocLZafVASXspVAbIJ4xPunrTV3s/tTl3cqSdFn1sGuHz1smjqpePZ6/3zSKg1gyWp5
	3ViC5Idx7ywdmvhA6By/QVqxW8UbqDr1oY3HDATrIKtucgWHEgK9CQ6B2kfn7ZMnZwUWjo2
	0QiffhlBM7Qpu8fuunbtxKlUmbWsunXPNosIaiBUqBoKyZsFbqEFCaHDX6mknV+vI9QNOC5
	EDOHBnn2MGf3PXqVowrBa33FCf/Tra3pigS8K01ioSOuHnYy1JGBVc3+BDCS2RYIXTr2TYJ
	xa2h87dF14+mug8h7BqCEFRLyDgXfhPMF3Ck0xps7JgfAHim7mEO97MZzvI7y07GrAG78MW
	9nMw6/rH+F53xRynoQp3OaceEaaUS2Bo82/z+M3mnak
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:gregkh@linuxfoundation.org,m:tglx@kernel.org,m:weirongguang@kylinos.cn,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-303914-lists,netdev=lfdr.de];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,linuxfoundation.org,kylinos.cn,baylibre.com];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AFEA6F30F7

On Wed, Jul 1, 2026 6:45 PM, Breno Leitao wrote:
> On Wed, Jul 01, 2026 at 03:23:57PM +0800, Jiawen Wu wrote:
> > +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	pci_ers_result_t result;
> > +
> > +	if (pci_enable_device_mem(pdev)) {
> > +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> > +		result = PCI_ERS_RESULT_DISCONNECT;
> > +	} else {
> > +		/* make all memory operations done before clearing the flag */
> > +		smp_mb__before_atomic();
> > +		clear_bit(WX_STATE_DISABLED, wx->state);
> > +		clear_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> > +		pci_set_master(pdev);
> > +		pci_restore_state(pdev);
> > +		pci_wake_from_d3(pdev, false);
> > +
> > +		rtnl_lock();
> > +		if (netif_running(wx->netdev) && wx->down_suspend)
> > +			wx->down_suspend(wx);
> > +		if (wx->do_reset)
> > +			wx->do_reset(wx->netdev, false);
> > +		rtnl_unlock();
> > +		result = PCI_ERS_RESULT_RECOVERED;
> > +	}
> > +
> > +	pci_aer_clear_nonfatal_status(pdev);
> 
> After bfcb79fca19d ("PCI/ERR: Run error recovery callbacks for all
> affected devices"), AER errors are always cleared by the PCI core and
> drivers don't need to do it themselves.

Thanks. I'll remove it.


