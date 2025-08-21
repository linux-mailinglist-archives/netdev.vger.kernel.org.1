Return-Path: <netdev+bounces-215442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9C6B2EAF5
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C7F724183
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E9B1F4CA1;
	Thu, 21 Aug 2025 01:46:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3C5FEE6
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740811; cv=none; b=PMi7dJ7PedwQawpcE4XQ6qLZT9HoHhL2o7gOFEQxUi+JToBT41Ru98aGrxl9H6lusGcHGnP7FDQJ9FXQGkpHakzCbvSKVk4tIo7wBS0BCtdrhWaKW3k0GEiQbmxS8guiyUdHmINH0xZXqUJZlaPNbkGt1UI/U98L7zIKuruR/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740811; c=relaxed/simple;
	bh=ySONGNdsPmg86SSrrcztNvt0AGXVE7A53Onq5Bg+ekI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GkTObfhRwhrcGKQK9LmcJ4RN7RLUctGFEGBw2OyNy39TVlrWvYJZN11gzTv3jCtNuuMI6PJosrdaqnp9PoPn1t3jGtTiuPlaPtX9IeArAowoxnTBUedeovZZD7MGLJH+QBVEs2vo5ePoKTLnqIQf6HDAdD0XN+guVI87djCViqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1755740706t582t41196
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.233.175.250])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 10310331411603570299
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250812015023.12876-1-jiawenwu@trustnetic.com>	<20250812015023.12876-5-jiawenwu@trustnetic.com>	<20250815111854.170fea68@kernel.org>	<0bea01dc1175$d1394730$73abd590$@trustnetic.com> <20250820084513.587f560b@kernel.org>
In-Reply-To: <20250820084513.587f560b@kernel.org>
Subject: RE: [PATCH net-next v4 4/4] net: wangxun: support to use adaptive RX/TX coalescing
Date: Thu, 21 Aug 2025 09:45:05 +0800
Message-ID: <0c2101dc123d$38242470$a86c6d50$@trustnetic.com>
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
Thread-Index: AQJSp6GMsSi4kqJepxUFy3vdl3vtHAGdM6CxAmQrRkwBFLaOdgFi17CDs0tjf7A=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N/EN6P+BmEafMucSaU+EidtO8KWDCUV+kDrBDtGciYrQ/rnYHpN2Nmpy
	lpnO3modbI81oMmekgKMJQfYItFbPbDaQeog3NbavYRq6QKtqKmsGCljsRQ9Khcx+5ennce
	tCtYPR2wCAr2eLbRCr2d+e7d7cX1/vCwIWG7ArWC9nLAFc7GsElNOq76ogAq5kMpClGqNOk
	5F6gKbxgw/E+NWjFFN7a1x9qXb9DkhzkCl+I5GCIcJO/ZUPG9EcUMj0hvIPAS1nNc4qQn8g
	G6h/nbCOs3LACILPg76Vq8R6IGHb7SR7EiggDy3NkrlPVJIxNTwhnTgmkN37+BfA6d5sVaI
	cFqvh2VSxCIjYGpwhEaZbh8EKE9r8PsCWyJJIpa8b4jblQ2/ItUkVqYI3qBMPfy2dR4W39i
	ylUF7wDn5S9tSAHh/tuPgqRWuceedj/tkhmLwHFG5HeRGaGfqty3IEShUdRaYnr0pPOTcB1
	jhk3UICxSifkQKKC1xiVGRZm6ef8AEl8phHtSG1krjK5XHwanBrPhdPpL3R5waHswKVvONJ
	YE6esr+XBYcvutoiXNL0nkuVMrxcVyoe7NQ7iDWzIx/a1RjJWlrKp27UT+cTxfK7FWfmNdl
	52SFnavkntSwwRG24Ktd7aKziiGigGHyAkx9DotMgaNGjyQwbjTxXB89x4/WckUQpBS8aMu
	khk0I5cp+qlfXcmg0z4PLbU5ClzzkOR1K7B2rMOMTrPxgpAxff/mRPMJekJExK7sc8n3wh/
	sS0mXw18eRVeM8eeuUadNvsYikSuJfwQEV0qwY0xhXRDO5XxAVvWyo3pHpO8myS78zW1Sla
	egApXnZb4cgkHgCDR0gArKrBlKK0FxFa74PYxYa2Lp6c9Z7AmpBy3mJyykiy2y/39PTECCn
	hgm5W+UDxj+LcvnNZ1T7Xeba9/fCGmSsM4Z2hyEGEKsMgyYdsalIuft0t/13NUTEKRfLC26
	ylfjrIrcwH7AO4wfZ4gZFOifYxTE0TDL89Opq+diPOZPfygPf4/Apmjrl2WffQxj0T6a7Fu
	gTF533P9cvdrqPRqy1P0lNrdh8G2W1HGuEEc/FUaRCWvWEcWQt
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 11:45 PM, Jakub Kicinski wrote:
> On Wed, 20 Aug 2025 09:57:43 +0800 Jiawen Wu wrote:
> > On Sat, Aug 16, 2025 2:19 AM, Jakub Kicinski wrote:
> > > On Tue, 12 Aug 2025 09:50:23 +0800 Jiawen Wu wrote:
> > > > @@ -878,6 +909,8 @@ static int wx_poll(struct napi_struct *napi, int budget)
> > > >
> > > >  	/* all work done, exit the polling mode */
> > > >  	if (likely(napi_complete_done(napi, work_done))) {
> > > > +		if (wx->adaptive_itr)
> > > > +			wx_update_dim_sample(q_vector);
> > >
> > > this is racy, napi is considered released after napi_complete_done()
> > > returns. So napi_disable() can succeed right after that point...
> > >
> > > > @@ -1611,6 +1708,8 @@ void wx_napi_disable_all(struct wx *wx)
> > > >  	for (q_idx = 0; q_idx < wx->num_q_vectors; q_idx++) {
> > > >  		q_vector = wx->q_vector[q_idx];
> > > >  		napi_disable(&q_vector->napi);
> > > > +		cancel_work_sync(&q_vector->rx.dim.work);
> > > > +		cancel_work_sync(&q_vector->tx.dim.work);
> > >
> > > so you may end up with the DIM work scheduled after the device is
> > > stopped.
> >
> > But the DIM work doesn't seem to be concerned about the status of napi.
> > And even if the device is stopped, setting itr would not cause any errors.
> >
> > I can't fully grasp this point...
> > Should I move cancel_work_sync() in front of napi_disable()?
> 
> My point is that this is possible today:
> 
>      CPU 0                     CPU 1
> 
>   napi_complete_done()
>                             napi_disable()
>                             cancel_work()
>   wx_update_dim_sample()
>     schedule_work()
> 
> You can probably use disable_work_sync() and enable_work..
> to fix it.

Get it. Thanks!


