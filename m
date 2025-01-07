Return-Path: <netdev+bounces-155716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9E8A0378B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6476B1885442
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 05:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FCC19ABCE;
	Tue,  7 Jan 2025 05:59:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11B193435
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736229572; cv=none; b=iJl/x3ZQK0/0+P+ybtPeqi/5KSSHCBVug2KPso9hQugrHGE1yWvT04uO9saTOP1tXYLz1wupOzPByR0+2liwK2mVMh4BYTiuBYrw11ODU6qQt5+Xjcex+SnsFBOk76xI8Q37HSe4WmPI/tKHoeqYGl4OhjfcWPlPzVDrbk3HmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736229572; c=relaxed/simple;
	bh=p/s6JEDMJC/YR1OukXOT/04PsSR86UtDZExPIAX5+qU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=JdWWFrXp44/mSY23CgD/5e9Mx90HkeEUvkerJ3lqCnIabm3KAYwIEMWZyVMC0xT5dH7s9qNbYRzU6fm8aXnMI/ubv7OsATVR5Uz3gPeOwuzoVcvquTGs81EMXeyKn4U3woygNWvo50oTROtiWe/Q1D8n+eS1kIxVMfAd7M8akNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1736229559t585t33273
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [218.72.126.41])
X-QQ-SSF:0001000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3338068587643237043
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
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com> <20250106084506.2042912-4-jiawenwu@trustnetic.com> <Z3vzwiMzYDvmKisj@hoboy.vegasvil.org> <CO1PR11MB5089788E11ECC1F9F704CEA7D6102@CO1PR11MB5089.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB5089788E11ECC1F9F704CEA7D6102@CO1PR11MB5089.namprd11.prod.outlook.com>
Subject: RE: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of ptp_clock_info
Date: Tue, 7 Jan 2025 13:59:18 +0800
Message-ID: <035701db60c9$4a2c1ea0$de845be0$@trustnetic.com>
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
Thread-Index: AQFgxPKZN8TRQHApGKDHehP8aTZMFAHs3nX/AX2EEwUDF5p6YbPLzKyg
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M5znx2hx04lbfo+HBZCNlj6Tru1uBNBiwKvxevOlbts/o0i8Z6rtRU4A
	n0CcUHV1G/+BteW0ckpOmuQdNW29i4oj6hbvjBO14EVtpuFJ8s/6kQPeI8C17Jun09AcgV0
	i3T+pn+48APR+VR+V0T3C36XIAK8oZpb4z5p1jD2Omy8G6pb1q/n1NNEZZtH3DobU8H0eYM
	JpuyGpzKJaOU7QbnVxk8UYzNtcl0Gys2P4QvKMO0mxWU4eSJuiI3+EMpd0A6NQYOUX0vdQc
	dU9ptKudovPdyuY1MSEaOSIvzHApdQqxJSWvhlyDvZe6T8zNAH9dEEzWzwZXFLr8QG+R5qw
	nZGeg1W888L5/CqAbVpqQFw6ijkwm8KtqGvDWDZEvNyqsDNXr3R2eVqx/NL7hJjhdWup9MO
	rhwKvYEnawMvcrQy2SJIsVJ4Py7a7buuGGOhwD0dyR935vBqj2g+czyLtX3Qq9jJu7sIoNP
	Sdx2Kf97OP4dZNauZO1MIHTORk8zjHjVuJ+QVm7eY/h0m8gvjFLFGVio2P80bRjGVezOJk9
	CJGxveVSt3KesxkXE4bRFu6KhkRsRWXmj7Gd1MqBnTVuPkNYnEp/8PbgJgz0P7QTmy0FaM6
	AI5ZRT9HqINJfWXVEK4/K2sYbZVUiiikPR/3jNZzotnrKSyiOJM2XCv3vLO2Cjrn1w13dwB
	Niant+PswiuufCTv5IOkep40Nd9ra4U6llZKlBZPvMIKcEzaG7n+U1/n4zreghi+RwjGbmU
	hon7G8D+dIZ7JWThbc8eN8ME4G5nGQRrazRlbeyD4Ci+IJojDgykwpEbzHqw/M+JkEUBe4i
	oloKBGu52gwCHaCsgbOm7SQlGRKHnMAgC4IUBo5nMpkYhXGKSDTKr27Yr4tCTIFMmDVX75i
	h16azCHkCqifLttHzeKRs23sVgLc1lfCYe5IwSx44J04PSaw9LBhAM7j53nb3diSao117NH
	ccLKg3CsNl9gKp+42AoFojfzusONddzTCbZTVj178AMsvxrybeu1KQB2fjJeCUvewGt8HwN
	hZkG/koA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

> > > +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> > > +				 struct ptp_clock_request *rq, int on)
> > > +{
> > > +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> > > +
> > > +	/**
> > > +	 * When PPS is enabled, unmask the interrupt for the ClockOut
> > > +	 * feature, so that the interrupt handler can send the PPS
> > > +	 * event when the clock SDP triggers. Clear mask when PPS is
> > > +	 * disabled
> > > +	 */
> > > +	if (rq->type != PTP_CLK_REQ_PPS || !wx->ptp_setup_sdp)
> > > +		return -EOPNOTSUPP;
> >
> > NAK.
> >
> > The logic that you added in patch #4 is a periodic output signal, so
> > your driver will support PTP_CLK_REQ_PEROUT and not PTP_CLK_REQ_PPS.
> >
> > Please change the driver to use that instead.
> >
> > Thanks,
> > Richard
> 
> This is a common misconception because the industry lingo uses PPS to mean
> periodic output. I wonder if there's a place we can put an obvious warning
> about checking if you meant PEROUT... I've had this issue pop up with
> colleagues many times.

Does a periodic output signal mean that a signal is output every second,
whenever the start time is? But I want to implement that a signal is
output when an integer number of seconds for the clock time.



