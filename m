Return-Path: <netdev+bounces-276350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJJBLYoP1mmxAwgAu9opvQ
	(envelope-from <netdev+bounces-276350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:19:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B67D63B8E5F
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B37843001F86
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C7439EF0E;
	Wed,  8 Apr 2026 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IDN8nLvc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6939939C00F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636357; cv=none; b=GJy+yswHNhLmmY/cZT7JwgJCwfihpfHD8YsQ3PW0EnyQglgWFtn7EebQ2zIjxT/cbmfvZOPYiqH4eooCBtb7hYqXAPkxZ6Me4X6Yp1XazlIZdvY/OdHPqsTV1YksDl8961o82TnQmcxyoFMPM72zVNDK6DcIxB0X8Xqqhm84C6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636357; c=relaxed/simple;
	bh=Ap85XTAbnvigCwiU4GMC+VmIAjFDpqkTrV4E8h+d4ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4dDLonqABK/36nGeVAUBhH7B5/UODYoU2e+XTveCLf/dnyee1cRsMtOBZnr9DpeyHgQ4l8PkBwVhYy+sqgtW8ImkFzvkHJy2j+m5699iNl6yyTxcsOLmY/rlaSogjXaBDQ8MrFMCTcBSZibjLrx4+LHjGZPb9n7UlHUcNMHXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IDN8nLvc; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775636347;
	bh=TXy8b4hc5WuVMNGkdYLoKmL6iPX+8CVFMd9n5KSSOqg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IDN8nLvcbIKVWfPy27UWd+rY4va3OWy95+hlYghpoEUqUxEiFrxc+Da4ugm1pSWby
	 nhqLcGKrdkE9qIzXwUz9AYgSMcpQhrnRWxjzxQYYkkqjR33lhI6wJDi5BUNrlyGYsH
	 oKVxkqgxX/S4DxzCrhwNxAk9s9RxOUM5e9CWkdSQ=
X-QQ-mid: zesmtpip3t1775636334t7b87affe
X-QQ-Originating-IP: Hp4eiQ4ycRFMfB+gGBu2PJpZNA9LajrBXTInIfiiwoU=
Received: from uos-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Apr 2026 16:18:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13218983909469976630
EX-QQ-RecipientCnt: 12
From: Morduan Zang <zhangdandan@uniontech.com>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petkan@nucleusys.com,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,
	zhangdandan@uniontech.com
Subject: Re: [PATCH] usb: rtl8150: avoid using uninitialized CSCR value
Date: Wed,  8 Apr 2026 16:18:51 +0800
Message-ID: <4A9247C80F1D1581+20260408081851.159023-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403154538.GA187715@horms.kernel.org>
References: <20260403154538.GA187715@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MfQnJH+7WKv6ti+pp3v5hf4t/KKAwfKYQ6sdfriP8g9Wbcw7Cp8DpnTt
	0zSqbKAwwk2JfOEswBFCcjs2BR1aC+GlMRdJOG9TIeQKaQswEIxUNMHg2LEM9gvx6I2qUHj
	UgeGEf8SDo3SMaanF6YVnnFaHoB9LrSxi6q6MQl8pdbeeYSqwWQ6YM+yJvRabF1U3Tw1bb3
	yfR09gWIfYC/skka7qTwV3S1HTB8TYJXZ8IRjT8aMzkfWtEjXg809E4DGnPfmsAri3zKmOC
	mQyq0REe/JxjvXnnzVEdQDcIpa9xp3H+MyiZz3MDenii+K8J7qvblrFF+l6RkG2MtKNb1ln
	vjBcjnoZT3u0sY9THDyh9qI58Kc9NPpFaiH1JGKe55KlY6lVEzYfsd2do37LaASaR3LhOaC
	aeeLqe2rkzoFp87RNIExXyVYfhp4WlDYqbWhM3D9UTt9NQ80V3cAT1dzQyGxNYjHMfAtZ8X
	eUKbw4SwygaPuFq9SvWuZpKPsKrToCevsmRU2WSko9eZbn3EONF7COBUWfgKSFak7QkYzBo
	FhTsfkXd9FbL0cWqzC2fDF7Z15/LBDjKoAT5uzzPiEDPaSQokOmG7mzCPTVWi8YXycF/3IX
	6LY2q92tlL0+DrD4LYlhyqAuC9ZjHiH8tCfSs23SIqvV8SNty/jr7ONVUhJuJcorQERaTK9
	wbAYsoWigoWQhNwacr8bmCHxFVVecmkepUUGylZt7SPGLfu/eW2XDRjy81dmMtRJN6ateEW
	EYyj0Jk3IWZhEUgsaz8IoQel/OkBcrC7n/mOJfZOT24nb9YOIGAhCpHbgX6d44Xf3ynXQfm
	dF3h217BzF5y9ZSqgbX5OBY4KktcK7awp48NunDPviOFOV2mPHNFXODAjh8ncRbo5v4dnrB
	jKMQHlODLmnWWiN+BM63nktVfXmyCIWaWgn5na8dlC1IgzXHtHq4Qll2p0a95a5/LabMOyf
	2gAAo4WMV+TLRCUH7pLUdICGGhyTmr/5+dRoJ8LpafTQRvTieTXe2VyOY6UaM/OPUx9tN8r
	XJbFnQgw==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276350-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B67D63B8E5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I wonder if we can handle this a bit more succinctly,
> while still making it clear that the error is handled.
> Something like this:
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index 4cda0643afb6..816759ced56c 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -722,7 +722,8 @@ static void set_carrier(struct net_device *netdev)
>   rtl8150_t *dev = netdev_priv(netdev);
>   short tmp;
>  
> - get_registers(dev, CSCR, 2, &tmp);
> + if (get_registers(dev, CSCR, 2, &tmp) < 0)
> + tmp = 0;
>   if (tmp & CSCR_LINK_STATUS)
>   netif_carrier_on(netdev);
>   else
Thanks for your suggestion.
I agree that errors should be handled explicitly, but I prefer not to force the carrier off
when CSCR read fails. The control transfer error here may be transient, and treating it
as a link break would cause the carrier state to toggle frequently.
Therefore, if the get_registers() call fails, should we keep the previous carrier state and
return directly? (Perhaps with a rate-limited warning as an option), while still avoiding
the use of uninitialized stack values.

If agreed, I will send a v2 incorporating the suggestions. 
 

