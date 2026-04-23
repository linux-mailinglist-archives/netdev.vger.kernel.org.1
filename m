Return-Path: <netdev+bounces-280565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bIBcIh5s6WndZAIAu9opvQ
	(envelope-from <netdev+bounces-280565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:47:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4188444BF25
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9830300532F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 00:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8819A1A680E;
	Thu, 23 Apr 2026 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WZDNCw/+"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28FF35966
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776905239; cv=none; b=VtqNAa39S4IAnwzK5qErj7Pa2VUYRVrZdy1+HWBnOnKGXBbn9L7Mh4VKjSqXgkDuaNFL8zLvsp+fAEUn1eKoKc6s/Gj0hffb7cLx3+GeLn0ID2Oao6QpfqBfrDSI5gZR6of9TLg9aXAL23JPOMbLUTJ6jWDWm6ttIPl4J+BXEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776905239; c=relaxed/simple;
	bh=mjqTjStdH4Ci331vrPkqQG1XjQmLcqba80Y/zzNziYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNMi2fPu3x/NN3oyf9vLMs/Q84OnRWg/ULbBQE7KsZvWwU2RFJx9pQ1jBR/kjNoWCUmqUP7Jvm6Dl0Gp9eZHpVcglWRI0Ct1A3Rs1Qo/bQ+MqFBc5q8SDoKLlJyNAaLisNT5PNV3YPCHOCCjdFWPf+9OSJYa9G8AfWkinCmweHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WZDNCw/+; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776905231;
	bh=zFSBpvs47LhGZs+3T3U/fMg222IcLvrRI8ewKb6Aoek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WZDNCw/+DhaqoFoqn11yYOeLmCZcPFdSGK5GQ4L4Sdf5H0snfeCHDhKAO+WaFnqDJ
	 niThDSyskgadoaSeoHH2ajvRWEo31XxWXPvnlx+SZJwj0GXaVfBprMrisY16jsBG+K
	 sTdxg0t1y7asABm7Vj0jD8FsVm0S3S7a4w0gBAdY=
X-QQ-mid: zesmtpgz1t1776905225t576ebbd5
X-QQ-Originating-IP: LwCWARsPpnwh1kZxVyKpfJ6hAe824mOPQoMaIRvdVUk=
Received: from uos-PC ( [117.152.201.246])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Apr 2026 08:47:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18018664094774004843
EX-QQ-RecipientCnt: 13
From: Morduan Zang <zhangdandan@uniontech.com>
To: remi@remlab.net
Cc: courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	zhangdandan@uniontech.com,
	zhanjun@uniontech.com
Subject: Re: [PATCH] net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind
Date: Thu, 23 Apr 2026 08:47:02 +0800
Message-ID: <380EA6DD33CD573D+20260423004702.136366-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2466095.vKB9LnXJlr@basile.remlab.net>
References: <2466095.vKB9LnXJlr@basile.remlab.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MidxaXJBY8ZS6+LwbXiLvKKFoozKhnrOqzX8qOPSvtoeGdPuZIRGh1kd
	ELxlAjbfh84kQB7108LtYuBS2Xhz2q8J2PW7jO8krE7hZGe41FaiGndSM41c+I5gT3o/YPU
	oW3Zebzin9zhjlLTacvP5iBfB3MdfzcgtnvXO4wtaruwC+BQPmQH3s8asPn+Okh57r9/HPO
	5jykY5yfsk0X0uxc5Rb9RDMvSZh0zhCNAjBslkFhjcUmlYf4Z44UvEcBo3NENAVeUgvcoFG
	yN0+A+8AjZl5kaEO2vqcrfB8zKW8m7bSZfCljJVEmcvYmQWiEa1WHH1euP9clPr9ZkBsJrq
	WPBNzDfWF/9Kg1nqz8JweCOhaZ1IJbx2RicrJhgqWlY1Bqbi7Jmrnca6lQSajYmHAxsRZWp
	FdUKvsgl/vjbC9rA9pjA0Eu1NiK1nzeqa2PKWQa8JFYQUfJDhUNsSvK1t/16jjo4ccAwClL
	vncrlJWjrYdfALkODYKipMXfIlLxxn2E1hzLNtMmn5jiXyLpSzLQUNYBeKJITvMERVFg2XH
	MRM50MXgmonqpyccaFTmiGvFC1N6sNMM5/SNDIYZSLR3FR/IiEKncb3pvpxIhoNd5rusSLj
	2yVyi0Ds9motmAaz856q2Ca5U3Z28ybJEJR5Scu3cK1jm4+DVLW/kEdn09NTg2sUF/A757Y
	5yQqxOEL5lfIk9lz45uR3FwR+eR/eNZtkIRaNpQDCSjFFW++1ddX72sZnB1xUDbbb9CzyJ3
	wu2Niu1CPQQam6EsLPRiri3KQym/WG7PcZQVkPMYmJY5P9oqKV5kMx1vCb5O2T97tkB951R
	0cbVif9EgNbGEb9kbh3d4ps8VezjfGrZ0Ng+1EP0LAardRanPTvEwhTpqtQs+m5jiKWWfrY
	s+xYBKGxc3wnSrr3+cBKAUNDJJYUtjXlNolkuP6n4MnMWgupXhuNLNmokupfdosfeJIaGb1
	NdApShmwoWhbJpg4n2JLYEg66BXUlHgsEUJ3gCeNdUB1iecD2qGIP+fAU7xdzIoKExHRfbN
	SEf4RwSF4tah2jJqlVTfcZIq9Rl8VGOGrljZ6+VQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,uniontech.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280565-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,706f5eb79044e686c794];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uniontech.com:dkim,uniontech.com:mid]
X-Rspamd-Queue-Id: 4188444BF25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Remi,

On Wed, Apr 22, 2026 at 06:18:48PM +0300, Remi Denis-Courmont wrote:
> This could be written as just
> 	if (err != -EINVAL || unlikely(...)) return err;

Thanks, that reads much better.  Folded into v2 and resending now.

Morduan

