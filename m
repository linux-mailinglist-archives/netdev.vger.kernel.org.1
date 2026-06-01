Return-Path: <netdev+bounces-293662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH08KMBUHWqnYwkAu9opvQ
	(envelope-from <netdev+bounces-293662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:45:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8561CB2E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D733070F15
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614C391E78;
	Mon,  1 Jun 2026 09:38:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE92391832
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306689; cv=none; b=fQK14dBIjh0JO5bcIVCB3QzDxQ1bDhXhf0lczp+p6L8qcf/kL6vd0NqOfn98oFaI1xVNKS1Em0uU0Nawngn8MLtZuijNlvz3PGDMq6EGDphRN5zc+zGBIVDdOS0KyhC67TsLypm+F6afUBdEr3WBRDMOqPLycOBRLi/Z5xU3SR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306689; c=relaxed/simple;
	bh=W0CN6+Pe5vVd9h9r3m8yogaRHx/WcpMzX0+7prQSwlo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MkbZ5qu8BB139aCCuMo2KRsyDsAlzoae2SMxEFHcmIK3aii6EugHlSut1SKVthypbiFGDGWvtjHyzg7PMtWVHfROb2bw8HzLgktrdpd6mZ+o8+9x1TVX7JJBbLOGTCU6GKn03Qn+/1ONQl2ziFNlFUQ6Y5oOHbWP50RY255815c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1780306621t488t20379
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.156.95.204])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2833811856653556621
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
References: <20260601072221.2952-1-jiawenwu@trustnetic.com> <20260601072221.2952-5-jiawenwu@trustnetic.com> <IA3PR11MB89865C937E3065CD6390FFBCE5152@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89865C937E3065CD6390FFBCE5152@IA3PR11MB8986.namprd11.prod.outlook.com>
Subject: RE: [PATCH net-next v4 4/5] net: wangxun: introduce soft quiesce callbacks for AER recovery
Date: Mon, 1 Jun 2026 17:37:00 +0800
Message-ID: <085601dcf1aa$325b2280$97116780$@trustnetic.com>
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
Thread-Index: AQEmZmPiFxLXVQw6wm5cjAUm9/PfJgGkmD0MAfvgRpe3eYNGsA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mr/o/c6gDciS59L1IPMtMEf9Md+pUJUSD0psYsoB2fPA2VBLaQnT8MlG
	UGOmeUmdZSEMqq6XFR92zErsTWxV8e2A0Y2ru8R2YmTQoFlLezTSRTU+QVHlzpJty/dZrsC
	Sx4klyjHp+6uOs9GTXRFvSUVxt4n8hp/sgdZzd/+KxpmSO04Z9l+gW0nhPFcQ9PfWW1gEP8
	cTkAI4+Qw5s9MZeKhPU2bCJIxYl9FECGz2J85L7aO2fI5oEsTSl0+P5eDjo5S+wCKH9kAwh
	4e0a7CE343nLQBXKCHtU05keZx3GCHXs+dk5lYP/HyiQRGT/ITJZdWUmzOT07WWfwNeWCtt
	c6EBoyPk8D0m+shqLRnvMZ+XHVSj1EM4WQkrwnO8VVS35JZFJO7TgXB+ckz43z8jOrX7QTa
	1DXKoCMYuoC/r5nHTtgOGq7jXpbcB+saOTe+NlDoFyHiDc+aU/+3jsGsIt10RFXMNnN00Md
	g8h3gh7ekU+1pLcpSvowTeehIb6DbdgvfhtLCOTiVCJvhoBsrkktB5trUvVcYZhPqx1hGiH
	C1ptkRhmFqW2XPQ/rzT5AYdHmq6x2nI6Y9onpnQv0NRwt0/lEOx8ELdZMND47Onif/eLWQr
	Fi9WjymNmuboWCDdS+C9kNOmnhWJJdVB1DwrO0wFrAtv8BH1tThDnKZjttox9NQlSIvqxwu
	ZCXSkGHBtABVVYmnH+DZX1nXALr/Hl+pghAKaVmvc8JXMSLu0N1w+achYO8EoxlEf25eVf8
	e+b1luFtpQnw3wLOujfc4RuhAWtmIvuZKq3lx6Gygj+mtj7SRvVx/MZFl3HX03IgiUhiqpJ
	cH0MnOLDX/UGjT1TgZuAR5W5azI8Nwvdu8imrcCFu/OFvz5f2HoA/KyQiyj5JEnGLEepXNs
	dW9KTGwjizdzMY79OCrlWmMwYTVtsgmIiO+eDT3DsK0Rht+weMe96mVfc56Xb/pPzpEUaDf
	+YuDzWBN0tqTRQWO1hEFkhuc+wMwRWhkafCftbWLBNWA78G0NYw8bx8fwHjaZeDnNs8IgWh
	HKJIhTCT2fIIfitRLklo7xiwCdRamxnsCpfE+ADp3JCCeBKwmpsHOF6a6wD7vZMwQ1M4XEd
	A==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trustnetic.com:mid]
X-Rspamd-Queue-Id: CCD8561CB2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index b37c9ed57cf7..816aba4a9099 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > @@ -296,6 +296,27 @@ void txgbe_up(struct wx *wx)
> >  	txgbe_up_complete(wx);
> >  }
> >
> > +static void txgbe_soft_quiesce(struct wx *wx) {
> > +	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
> > +		return;
> > +
> > +	wx_ptp_stop(wx);
> > +	phylink_stop(wx->phylink);
> > +	pci_clear_master(wx->pdev);
> > +	wx_napi_disable_all(wx);
> > +
> > +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> > +	timer_delete_sync(&wx->service_timer);
> > +
> > +	wx_clean_all_tx_rings(wx);
> > +	wx_clean_all_rx_rings(wx);
> > +
> > +	wx_free_irq(wx);
> > +	txgbe_free_misc_irq(wx->priv);
> I think wx_free_isb_resources(wx) is missed here, what Sashiko says?
> I fill like phylink_disconnect_phy() too.
> 
> Can you prove there is no ISB resources leak?

TXGBE is different from NGBE, wx_free_isb_resources() and phylink_disconnect_phy()
are not on the close path for TXGBE.

> 
> > +	wx_free_resources(wx);
> > +}
> > +
> >  /**
> >   *  txgbe_init_type_code - Initialize the shared code
> >   *  @wx: pointer to hardware structure
> > @@ -412,6 +433,7 @@ static int txgbe_sw_init(struct wx *wx)
> >
> >  	wx->setup_tc = txgbe_setup_tc;
> >  	wx->do_reset = txgbe_do_reset;
> > +	wx->soft_quiesce = txgbe_soft_quiesce;
> >  	set_bit(0, &wx->fwd_bitmask);
> >
> >  	switch (wx->mac.type) {
> > --
> > 2.51.0
> 
> 


