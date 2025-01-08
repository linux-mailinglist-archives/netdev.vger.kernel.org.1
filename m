Return-Path: <netdev+bounces-156142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F74A05122
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E491889DD2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD36C187550;
	Wed,  8 Jan 2025 02:52:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88F189913
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304767; cv=none; b=FomA7Mo666ZEeQHuqpYKM7KzPjfZhHU6pieqhCl3nknF4SlLEaqdq+5f7fp2OxzrsaIYJ3K17XajVrqbzm1U3CmPckQTsPsx3X8Yd4bmzngxmbitDX+BhcJ3ZjUQ8lUdZgozM0qZ2ScsEjAvL9lst6zoTxoJbbk93RloaqUjFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304767; c=relaxed/simple;
	bh=W8V53y7Nt4Lv8758am1kQPuT/b2mVbcu2ExZ44f87DI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SkLMFkbTMD6p8gZuH+zQFzl1UtS/lnCUwXpC/MgoryHHs/93m63sC7nIJQeTR2lMPEixTBiCDZq3k+mExGbyQhNtDyZkJZctX5RCJeDFAw6NIjJrEs4dkrlDPu4qDTRtnxzYQHYC4MvqMPTbNqLJrFHGBorKeaGYmq4fmIOO+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1736304744t891t05235
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [218.72.126.41])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3415688581137978565
To: "'Keller, Jacob E'" <jacob.e.keller@intel.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<netdev@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>,
	<mengyuanlou@net-swift.com>,
	"'linglingzhang'" <linglingzhang@net-swift.com>
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com> <20250106084506.2042912-4-jiawenwu@trustnetic.com> <Z3vzwiMzYDvmKisj@hoboy.vegasvil.org> <CO1PR11MB5089788E11ECC1F9F704CEA7D6102@CO1PR11MB5089.namprd11.prod.outlook.com> <035701db60c9$4a2c1ea0$de845be0$@trustnetic.com> <CO1PR11MB5089A5A5ED6C76AA479BE1F4D6122@CO1PR11MB5089.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB5089A5A5ED6C76AA479BE1F4D6122@CO1PR11MB5089.namprd11.prod.outlook.com>
Subject: RE: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of ptp_clock_info
Date: Wed, 8 Jan 2025 10:52:23 +0800
Message-ID: <03ce01db6178$581f2ed0$085d8c70$@trustnetic.com>
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
Thread-Index: AQFgxPKZN8TRQHApGKDHehP8aTZMFAHs3nX/AX2EEwUDF5p6YQGOJ5kVAwF6KEezqNWs0A==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NDtUtlvFer7vILB9QH6Kb/cRfA4AVYCtoicm6W0AOvkgLKU5BblDpYiN
	4QsVL2GK9to6dj2LtoMMj07fOQQhQFJ/ggH8ie1kFC4rdVI5ZeDxVxR41DOgUrxddX/mKqy
	L2nk7fp1YBLE+m1Wq5ZRw6VAZA2xIeCxF+FI0y/vKuOc6Kvo7WjtMpd1/Ku2wUYXtt8am6c
	yvceF2MSoOSWLf+c2O4inL0EYD1FRlr8qx7RARspqGuh003zqejeuElvpuooJQc+71JC7FI
	LEi9VIt37GdDpii89rqaHUxNMJ0xVsVUF7N0kCvQ+KzaPvfhrM120dkzbRGffUosa5U19CD
	4qK7iSB5vyikl5s/r+f7GdA+/Qz4GxKjJsa//LgaQMuN5JVb4zkUaxX0xuQuts7YfEX5tf2
	mw7dJFCjuMqjeC+CaclhGqT6cfK3UF1r6+RQAYtZzAH55uY4lNTgyUNDHLkZW81kPjMg1Jd
	UmG9Iaoq1M7jMDSU7QNzwTP3/mMMeo0la56HWHw4cpqMAtxMFCXR/uNJMtB6ipNW6wJlevE
	IVU3swP8zWixrIxj7PJmnuE5abGt4EpJJvSUCm7Wl1Vyy9yZz7xej14oaoIPkhwscj2ksTd
	NpRpGtV//PbVkoiXRPRM+OYLBVTgxLKDRUiFY1EtWgxI0YZ/TmU8K4WxiBiFiOpx/BoPXC7
	LFg+epwUgy79sMgFOA9XBfwsyAJqeVhxyIEOr+y/RBGnW3EQd8n94YZ+SvdRXeyZQPzXNya
	akD1SanqrXaOuxBM7jTrnQcAh/0cQDc+2FIkO9zgAomrkIRhi1F96tUzEHCj7Q/kpCnY+BQ
	tclR7PZPVi8vilW5gIa8KwFOTVMbx4Zj1+sPDhdwMK59I+Pv2FiVxpI6ikFinHXxdKpR5GS
	C1eIRBK1zOaZU+f/6+XysKo4aRc4H35ptdw7cJEtta0aHCzA5SZOEOwPznKB92muRoWAGW6
	+2yifleWdABcxmBkmx0cyepkfRP5ivLTY66JeajrJRPOsxKxNZA3XEYch
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

> > > > > +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> > > > > +				 struct ptp_clock_request *rq, int on)
> > > > > +{
> > > > > +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> > > > > +
> > > > > +	/**
> > > > > +	 * When PPS is enabled, unmask the interrupt for the ClockOut
> > > > > +	 * feature, so that the interrupt handler can send the PPS
> > > > > +	 * event when the clock SDP triggers. Clear mask when PPS is
> > > > > +	 * disabled
> > > > > +	 */
> > > > > +	if (rq->type != PTP_CLK_REQ_PPS || !wx->ptp_setup_sdp)
> > > > > +		return -EOPNOTSUPP;
> > > >
> > > > NAK.
> > > >
> > > > The logic that you added in patch #4 is a periodic output signal, so
> > > > your driver will support PTP_CLK_REQ_PEROUT and not PTP_CLK_REQ_PPS.
> > > >
> > > > Please change the driver to use that instead.
> > > >
> > > > Thanks,
> > > > Richard
> > >
> > > This is a common misconception because the industry lingo uses PPS to mean
> > > periodic output. I wonder if there's a place we can put an obvious warning
> > > about checking if you meant PEROUT... I've had this issue pop up with
> > > colleagues many times.
> >
> > Does a periodic output signal mean that a signal is output every second,
> > whenever the start time is? But I want to implement that a signal is
> > output when an integer number of seconds for the clock time.
> >
> 
> The periodic output can be configured in a bunch of ways, including periods that
> are not a full second, when the signal should start, as well as in "one shot" mode
> where it will only trigger once. You should check the possible flags in
> <uapi/linux/ptp_clock.h> for the various options.

Looks like I need to configure perout.phase {0, 0} to output signal at the closest next
second. And configure perout.period {0, 120 * 1000000} to keep the signal 120ms.

But where should I put these configuration? It used to be:

echo 1 > /sys/class/ptp/ptp0/pps_enable


