Return-Path: <netdev+bounces-156163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C1DA0532F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55E01633F9
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8411A7264;
	Wed,  8 Jan 2025 06:28:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908941A4F1B
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736317721; cv=none; b=He19ts1y3DoLQhp8ZlWFN9R4H1BHztwjIVLnRd9YLY44iifU4d9ZJThIg6QlvbvZE/C/+HJ6Otxv8PwsyXrnXirzc60ph9y9RH01EZ1MqyP3xAJ1oCud6svONTE9vGnETojPdFZ6PLvSlFTt5YQqUPkk9yrF/A35sAlbWmow87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736317721; c=relaxed/simple;
	bh=J8CGx16ivWdsu0vHi1nOdqzusa/I7w5xMqZ8UCad9c0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MCXMJxJyuZv0q/O1wJWbgiszlMi8pQrFfWJQSrSjn5F9ym0JNTi/W2m72Rq0sKYt27QTzTS+bMe2VD9nUSlZSoHqg/CfZK8/9Q8xtH4WnewP1feDum+IkRFMr9k4WbtwQdwhnAIbfXAuxB+l57LS/fFqDg8lto0rInF+BAW7Huo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1736317701t217t21531
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [218.72.126.41])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8841218007050947155
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
	<mengyuanlou@net-swift.com>
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com> <20250106084506.2042912-4-jiawenwu@trustnetic.com> <Z3vzwiMzYDvmKisj@hoboy.vegasvil.org> <CO1PR11MB5089788E11ECC1F9F704CEA7D6102@CO1PR11MB5089.namprd11.prod.outlook.com> <035701db60c9$4a2c1ea0$de845be0$@trustnetic.com> <CO1PR11MB5089A5A5ED6C76AA479BE1F4D6122@CO1PR11MB5089.namprd11.prod.outlook.com> <03ce01db6178$581f2ed0$085d8c70$@trustnetic.com>
In-Reply-To: <03ce01db6178$581f2ed0$085d8c70$@trustnetic.com>
Subject: RE: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of ptp_clock_info
Date: Wed, 8 Jan 2025 14:28:20 +0800
Message-ID: <03e001db6196$82ad8480$88088d80$@trustnetic.com>
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
Thread-Index: AQFgxPKZN8TRQHApGKDHehP8aTZMFAHs3nX/AX2EEwUDF5p6YQGOJ5kVAwF6KEcCsYTFCLOTiXHQ
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MAMW4dxoxFytMlZ5pTWcdysxswP0sXuOqXA/zmRO7bPoaE6nL36ynaT7
	eAeCn+0CTtphsNWFb65rq4w43CNJwzfYg6r+vTIMNbLXnUdSad5ZNvo2d0jXFPXLDZ7DgHl
	fFC3qH7JjnukUU6lpD4xpss38pQufBuFQ/Dibi7Wl2xE0QM+6kfet86dHV0i5dcoEeM8om9
	xT/gYNbpaJ9Io21ei9n1IYdoaLIYirYMvLbWBgkuzfceqjVww2gAX+G85RK6FGsNqtN5uOC
	NE0ZfP40FJoideQS8M4bB5zMLgzKMLi8S13hu93IphwQsOmpUXH/+mEDEhgKJg6GQuMfc5f
	BBbE5ymYuKasAYzoMHUGL7CpCjCp4zb/nflGESLParj4NMGy9IpoULQsns+vq/vUhQb7V5d
	rOkZzF0Mb7EUpJvD+5oIGGWKfSOrTa0JqKetqSovrI4P9d8+G96tTyRM5U9XPjd+zaGui3N
	6KrJ7wCnkzqiexdiisfyRoo+zIFwr+BK2Rd80ymMhLlbN2pO8YBdCIiPhg+1slBpmXA8wgb
	pj/N67BaIwonnoPYuRgghNpqxmYvtxkm0DrMSVC5BVl9EQxkm9tyaX/q7xIPMUY2kONnM/j
	3j8mYb9/+UktDKZJAVdTQ3I1UcIjmtBVjwbK5lm+pGJhlkmw8LPEvyI9ShMbzg7dh6D+DjX
	r/zTecrhv9mU2iuc2z1epH93i8WPsZc5kNAMEjCiwCFyEo1pV2hJL6J63MQ7Uybes2eBY1E
	cZVKwSGsfNh2ondqiWDjrVd6ySsTUwcvbhAKzoVnO1f9WWpxgymWRXfp6E/cvN+bjijkEKk
	zyD+oy9N3SyND80uUFHDTJ1uHaeHDUs1uEs4Tv1h8O6T/W3PpahhHMbW49mYAvtV9PyF30S
	ZN4mTFiyAjozuYYFCCaumuR2YQqqWn5COwuLoxxrzJ+ugPYEs0Ar1CJik7Sc9PYMyUx+f7T
	EeTcpObRg4EuyylYYI37BCdA1Q0LLa9xz642HiNxtB89beGArRjl7Z5A2
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

> > > > > > +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> > > > > > +				 struct ptp_clock_request *rq, int on)
> > > > > > +{
> > > > > > +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> > > > > > +
> > > > > > +	/**
> > > > > > +	 * When PPS is enabled, unmask the interrupt for the ClockOut
> > > > > > +	 * feature, so that the interrupt handler can send the PPS
> > > > > > +	 * event when the clock SDP triggers. Clear mask when PPS is
> > > > > > +	 * disabled
> > > > > > +	 */
> > > > > > +	if (rq->type != PTP_CLK_REQ_PPS || !wx->ptp_setup_sdp)
> > > > > > +		return -EOPNOTSUPP;
> > > > >
> > > > > NAK.
> > > > >
> > > > > The logic that you added in patch #4 is a periodic output signal, so
> > > > > your driver will support PTP_CLK_REQ_PEROUT and not PTP_CLK_REQ_PPS.
> > > > >
> > > > > Please change the driver to use that instead.
> > > > >
> > > > > Thanks,
> > > > > Richard
> > > >
> > > > This is a common misconception because the industry lingo uses PPS to mean
> > > > periodic output. I wonder if there's a place we can put an obvious warning
> > > > about checking if you meant PEROUT... I've had this issue pop up with
> > > > colleagues many times.
> > >
> > > Does a periodic output signal mean that a signal is output every second,
> > > whenever the start time is? But I want to implement that a signal is
> > > output when an integer number of seconds for the clock time.
> > >
> >
> > The periodic output can be configured in a bunch of ways, including periods that
> > are not a full second, when the signal should start, as well as in "one shot" mode
> > where it will only trigger once. You should check the possible flags in
> > <uapi/linux/ptp_clock.h> for the various options.
> 
> Looks like I need to configure perout.phase {0, 0} to output signal at the closest next
> second. And configure perout.period {0, 120 * 1000000} to keep the signal 120ms.
> 
> But where should I put these configuration? It used to be:
> 
> echo 1 > /sys/class/ptp/ptp0/pps_enable

I see. Thanks for your suggestion.


