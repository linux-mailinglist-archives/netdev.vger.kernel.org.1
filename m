Return-Path: <netdev+bounces-45320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C47427DC173
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 21:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6076AB20C9E
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C8B1A70F;
	Mon, 30 Oct 2023 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="soedaUdV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED0D51E
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 20:59:08 +0000 (UTC)
X-Greylist: delayed 154154 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 13:59:05 PDT
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF77DE1;
	Mon, 30 Oct 2023 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1698699543; bh=j/93mdadVHbYoQPmGK+yDLiQs0LkTwbTk2gQB3b7nkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=soedaUdVRdYv+jHAqd2owjkSr5eCJQnPV10vomEJEs2FArgL2Mhz65IA/7J2LCO1X
	 1dX+39ymolPR+hXjS7zzxgKSuzuI7QJMPZaI2rvE1wSNqD1XdkJxxMK/QziyuJmHmg
	 gTtS7lGWltKMzOYfawUO3OHXdcnGRgRI9IgtkOrM=
Received: from pek-lxu-l1.wrs.com ([2408:8409:2461:9e8e:549b:dd5b:edb5:dcb3])
	by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
	id EC026E9D; Tue, 31 Oct 2023 04:59:00 +0800
X-QQ-mid: xmsmtpt1698699540tjn8a576r
Message-ID: <tencent_B8EEF56ECDCC8EE7EA46DFD2DC0646C98A06@qq.com>
X-QQ-XMAILINFO: MntsAqBg2ZZ5qpYcOfZJTWIf7kFqPwcp4wLtQkFCbgDIYn+L1GTILYFCbk7Pis
	 UcOtS9O6o6egLLz+SX7PwItYlb3Uq+Bgh+FD3zmcIDWcz3z1YGl3s2LlBWnZeMrFOBNSw+eKRBCu
	 BN5og/axGmo5+SsNQ3Hj+AprCdUXQIQUkF8X0NCBrToaWJ/f1pk5TtUxpGM24Yf424PZz6J0GGQx
	 H1ObCE/Wv8zGSa1k7fMn6I2m5o1EI5not3N1Sq7IXaf1ehDiM8lGYhr81xi/InqpV5OnnC0pHWGl
	 dL/zXx5hsS9emmlPSwGxk0CTcPGM2glQ1BLfeid9IH/qSNBupSWh4H9fG1f5HB3IMGKgnJORpnFb
	 xw5bNWpTagtN3pwH6sY6dV92DcCq3BK/xpmtFVgriRPqPS8h1WtUKFEWRDhocF7ZSpvCVY49w9L4
	 yw+HyWBJaxbJLIyCehWNSNxHDEbVyoDWIKt7Z7wlQfEdTEbbbK8gPBpOEH3x66eKoNdsd4bxGRd3
	 x+8xDcrLdFRX/xBi7Bc8l/bvd73nRr68FyzTUkZoM/GyAB3jSEMo2OXm8NROHwkC1ZG3Bu7kSPdb
	 AK6qq36Xj1WRmgPD+CieMz2PiyGxQpsFXWhrGowim55KBwq34b4hhv/1WheeZS1hIxEBlRQYrh2C
	 GU8NS9wukQUZuL8p1EcsP1Fv6TybinnpueUnvYHRb7ygXZsOHRtjSGdz0eClq/IRfHv21PontruJ
	 flfYbB3+Xlk90ZqewSCLkcNJetYY65J6eCgOJqIG/PY5jkbAyfb29ZJa+Of2r+ybv00btVsMUnWt
	 IRnAJm53uqizbBOGEIPv6kagXvDGNHr5ycuz48CCUEAdh5+9BraVPlRdSAQ8j1zc8/dYELkBc0FL
	 wigy5d8tuiN9tk8pSvT+PCK52WTuczPc3xxYwTmDp9
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: richardcochran@gmail.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH-net-next] ptp: fix corrupted list in ptp_open
Date: Tue, 31 Oct 2023 04:59:00 +0800
X-OQ-MSGID: <20231030205859.2256916-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ZT63LEJCuIY7v_Ou@hoboy.vegasvil.org>
References: <ZT63LEJCuIY7v_Ou@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 29 Oct 2023 12:49:00 -0700 Richard Cochran wrote:
>> There is no lock protection when writing ptp->tsevqs in ptp_open(), ptp_read(),
>> ptp_release(), which can cause data corruption and increase mutual exclusion
>> to avoid this issue.
>
>-ENOPARSE
>
>How can lack of lock protection increase mutual exclusion?
Use mutex lock to avoid this issue.
>
>> Moreover, the queue should not be released in ptp_read() and should be deleted
>> together.
>
>The queue should be deleted togther?  Huh?
No.
ptp_release() should not be used to release the queue in ptp_read(),
and it should be deleted together.
>
>> @@ -543,6 +552,8 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
>>  		cnt = EXTTS_BUFSIZE;
>>  
>>  	cnt = cnt / sizeof(struct ptp_extts_event);
>> +	if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
>> +		return -ERESTARTSYS;
>
>This is not needed because the spin lock (timestamp_event_queue::lock)
>already protects the event queue.
Yes, you are right, I will remove it.

Thanks,
edward


