Return-Path: <netdev+bounces-79682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A187A8E5
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 14:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49E31F24BBF
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F21F43AC3;
	Wed, 13 Mar 2024 13:59:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193B47784
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338375; cv=none; b=VYjpaOL37IVK2YNI1/O2lnop2+2Y8DZZelsVmTPJKST472+dikgYqAPNjpbYNi33265rRjRRsZ/RUACCpqLv3y2HkWbBWqMt5jj8oD06vQZxYqvj5TmbGWZUS2zUw2XCWAd7q99mZ4gDxIvnLr3gMqCnbaedxUReK4HhnLDQWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338375; c=relaxed/simple;
	bh=iPjtTXtGBNqqHtpmj/RD96a/h3FsCnTbifhUxkUft74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIZRXvVMZ9Xrx03AcjwGSp+LJxd+CbBojgmU8CvfMChafbAV9jx1TgSJkwY8A50pix7JCT+S7FAJCeulq5zQjiw/ZF6+mEDnCOWxx1bqXqldQITuzl/xmnsQVbLhL0jVl8Wp7VS8fgw5hJ8MTb0cxuU7WvBo39LvT1utCCApIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rkP8Q-0000WY-Vx; Wed, 13 Mar 2024 14:59:11 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rkP8K-0067ui-OF; Wed, 13 Mar 2024 14:59:04 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rkP8K-00FZqY-26;
	Wed, 13 Mar 2024 14:59:04 +0100
Date: Wed, 13 Mar 2024 14:59:04 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: syzbot <syzbot+3bd970a1887812621b4c@syzkaller.appspotmail.com>
Cc: astrajoan@yahoo.com, davem@davemloft.net, edumazet@google.com,
	hdanton@sina.com, kernel@pengutronix.de, kuba@kernel.org,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
	pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_queue_drop_all
Message-ID: <ZfGxKE126E_INT_w@pengutronix.de>
References: <00000000000095640f05cb78af37@google.com>
 <0000000000002755ce061389d67b@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000002755ce061389d67b@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

#syz fix: can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

