Return-Path: <netdev+bounces-273494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIzBFQp2y2k3HwYAu9opvQ
	(envelope-from <netdev+bounces-273494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:21:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF55365080
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DBE0303D8A6
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C28396B68;
	Tue, 31 Mar 2026 07:20:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4EF394793
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941610; cv=none; b=uMphhQhgIM2kkMU86/TWHtRW8ChtBkmbBl+Q7hpJs4Kf3PSoPA42KoMpYBmkb9xFDpMFa/8+fa6rGAUF3ee6J33g8FDe+KO+grspxcOapniwHgO7dVgwOCnzMuxqb1XxJCCC5yY25FFgt+2BSPhUkftZWIduDxDwTRRFxYBgZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941610; c=relaxed/simple;
	bh=elCprgIfyZmynNxyFih948fHQDY6a/gAsEUW4KZbOJk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=a85nPlSakCVI9fhTd1WXRdbs8VLZfMmdvRPadiACGcBtt2DrgWErp/xMchmRnWUutb/4Tg/YV/iJXRKmB3bT0JwP60C7T5smGzz+VCOEhR32fStlWt17hMVM0gdAAUyCeG79Vzx1xWMKwbFesg20a1Oi/w8fPUK87ekycyIWjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1774941546t748t35093
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.227.224.139])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 5401902762098304351
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<michal.swiatkowski@linux.intel.com>,
	<jacob.e.keller@intel.com>,
	<kees@kernel.org>,
	<joe@dama.to>,
	<larysa.zaremba@intel.com>,
	<abdun.nihaal@gmail.com>,
	<leitao@debian.org>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<michal.swiatkowski@linux.intel.com>,
	<jacob.e.keller@intel.com>,
	<kees@kernel.org>,
	<joe@dama.to>,
	<larysa.zaremba@intel.com>,
	<abdun.nihaal@gmail.com>,
	<leitao@debian.org>
References: <20260326021406.30444-5-jiawenwu@trustnetic.com> <20260331005527.3459556-1-kuba@kernel.org>
In-Reply-To: <20260331005527.3459556-1-kuba@kernel.org>
Subject: RE: [PATCH net-next v6 04/11] net: ngbe: implement libwx reset ops
Date: Tue, 31 Mar 2026 15:19:05 +0800
Message-ID: <073601dcc0de$a87b2e30$f9718a90$@trustnetic.com>
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
Thread-Index: AQGnYjFgiICnEG1OS+zPz18hM02VsQLH5aBfthy4xNA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MKP3LwvGEIjI/a51TJEFxsbxjgtZZqq2Ffjo4uins8uvgvefpVoW9NlH
	KyaRp8G0j7N/EAvJl0TtLiaOFPO0wei4g0+vP4Zc+lZp0vnDaW6C8wxZnx3ZD9LuMN36OAD
	qctz2UrV07ikUhv2PzboRVvE+k6JUkW+E8AE31LaDN0h+0CZGRZCowltMTVslIs2jKEy9aD
	VU5d/CIr8L1nwBkG9n/NFvWiBwSIy4obVDDKyvBCQJNHYBJqYZxppRJq0leqLoQyuJVo5g1
	wP+8GWqr0ZA9XsNJBS1XINhY+o1PeooU1PrIOjw1VGp6bdDC42h+bu4P3ildulnfa24gIc3
	z6EdAoaoN6pi90O8dSOYhTiv5tQg7vQV9mVHK+ZrJUP3Jx7QGnMLwnJe3gqgqALKvQ1dl7g
	CZHwU7vDKvgn9rrpEzzkliZlbEKsXOswKiquWvOyQ3ED+HlPUDxragcJhNOgLUGM/McWQhq
	o8nPIYFiHqPLrhxXmCUOngJAxmXu74E5VnJVkPnATZH9OyHSSZYB3htnsFttw6+PLfMHZ8N
	//Cgrzm1wQjSirLAiP/EYW9cyDWRtgV3/tUbCMfn308kunhc+U/Zc2tnR4yDZcp2/WLLEim
	NGzOmGzB3eM36Bw5leioTnhE2SON8c6Q9U1u9x0A6s1tduK4ZbX/t7nzN6oh+fXittJRqEz
	iUdbuorIYl9clLMq9KfC0x0yMzEG3Qbrrhgh+eXq6PCoTSIgYW4VYiHzHIQ5P9LUbYtfGOB
	8aXsDSTWckivCerps1EmWpobwM4jgE98zPwlDYwc3HiYnWKJk6kYCyND0c0le5/TTZaL4zm
	WOYRAU3tqs3bG0TLIPTy2dtTWKUMnKf4fFQ2eLCUO3rRxKJPRnwm00iYC/LTDZf04YcaSRH
	CCKC/U70Yt1dyqluBCJG3B/LJ5/G5DQUvuOrgGk6OENQY8qX2sc8q7wtnCIA9qJ5q7NhxLA
	cCQj94br0HNEdEoaINZ3wJqHGXv4ZvrrxhneK/SSdmeISrZluas+TmdMAiCRddYsJCdDCA+
	Kt/ZKPo0Z0xusQI5iBX1DbNbEJmHuitS5O03T+Gp5NEYkCHi8HYRhgABxH1JknN2U1UlsBV
	tkw3BIHbuwYIZX7Cl9zYBtdEs7i/tkE6Ij1OFx5ncwIfsur1WwSyVrQAWNlpak534iE1zOu
	rNVD
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273494-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,linux.intel.com,intel.com,dama.to,debian.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.833];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCF55365080
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +static void ngbe_reinit_locked(struct wx *wx)
> > +{
> > +	int err = 0;
> > +
> > +	netif_trans_update(wx->netdev);
> > +
> > +	err = wx_set_state_reset(wx);
> > +	if (err) {
> > +		wx_err(wx, "wait device reset timeout\n");
> > +		return;
> > +	}
> > +
> > +	ngbe_down(wx);
> > +	ngbe_up(wx);
> > +
> > +	clear_bit(WX_STATE_RESETTING, wx->state);
> > +}
> 
> Is it possible to use a standard kernel mutex here instead of a bit flag for
> synchronization?
> 
> Looking at the underlying implementation of wx_set_state_reset(), it relies
> on an open-coded polling loop:
> 
> static inline int wx_set_state_reset(struct wx *wx)
> {
>         u8 timeout = 50;
> 
>         while (test_and_set_bit(WX_STATE_RESETTING, wx->state)) {
>                 timeout--;
>                 if (!timeout)
>                         return -EBUSY;
> 
>                 usleep_range(1000, 2000);
>         }
> 
>         return 0;
> }
> 
> Using a bit flag and a sleep-polling loop to guard a teardown and bringup
> section acts as an ad-hoc lock. This approach bypasses standard kernel
> synchronization guarantees and prevents lockdep from analyzing the lock
> ordering.
> 
> Since this context is allowed to sleep, could this section be protected by
> a standard mutex instead?

I think using a state flag here would be better. Because other code paths
(like watchdog) need to check if a reset is in process without taking a lock.



