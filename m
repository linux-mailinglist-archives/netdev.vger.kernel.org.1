Return-Path: <netdev+bounces-80084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1030187CF03
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BC01C21935
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2A91B7F8;
	Fri, 15 Mar 2024 14:34:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E33CF75
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513288; cv=none; b=Jhd8D1TKxBCVJYwdIGEFRyn5OwJeD7niLuLH0izy8QvEBNGZ+9jFIfl3uf4898cXAVg1YI2Ruou8B2b8z32GoIT8HkRCYtcXfQ/WQWCbzbSjgwpcCoP1LJjtPlk0cphRFsuYVZMYjTFSV4OG9wptDMyJTilRo40h1vl9qFw5e/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513288; c=relaxed/simple;
	bh=iPjtTXtGBNqqHtpmj/RD96a/h3FsCnTbifhUxkUft74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCeN17o1M4hkp9npWstv+S/BfdSd2JT8P4+FKuPkzyIUTOtex1DxNh9P3nFt5/73fwzQQiTCTVACwMffyM01CDmChBVvB6K157tmyEnqWezlYvrMQ/Twx5ITY+Ljlh5Mlx3bysMbw+ydSF7T3dosA2nq9V87wPdi2lzzqE5oofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rl8dV-0000qo-Tx; Fri, 15 Mar 2024 15:34:17 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rl8dR-006WRK-BX; Fri, 15 Mar 2024 15:34:13 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rl8dR-0013Tz-0o;
	Fri, 15 Mar 2024 15:34:13 +0100
Date: Fri, 15 Mar 2024 15:34:13 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: syzbot <syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com>
Cc: astrajoan@yahoo.com, davem@davemloft.net, edumazet@google.com,
	hdanton@sina.com, kernel@pengutronix.de, kuba@kernel.org,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
	pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net,
	syzkaller-bugs@googlegroups.com, wg@grandegger.com
Subject: Re: [syzbot] [can?] possible deadlock in j1939_session_activate
Message-ID: <ZfRcZVCJZxnt1Jq-@pengutronix.de>
References: <000000000000e8364c05ceefa4cf@google.com>
 <0000000000002d73880613abfe48@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000002d73880613abfe48@google.com>
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

