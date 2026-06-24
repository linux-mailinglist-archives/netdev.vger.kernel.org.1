Return-Path: <netdev+bounces-301598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yR+IGbuoO2rHawgAu9opvQ
	(envelope-from <netdev+bounces-301598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:51:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB55E6BD131
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:51:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=SfnUlIBO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301598-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301598-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A59301368C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31952EEE85;
	Wed, 24 Jun 2026 09:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC22F22B8DF
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:50:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294615; cv=none; b=heL1pu76FeY0OxzGg3LpmSPdYd8RbOWCq6K8tflXQ3qzRS9tzriVuBNFADZfraoSbpUyEa8PDdjWdr1xpztDH/ESsj3atvFH5VSdAuv9aphUIqrduPCZ/3y23XTUIKmskSgW+olDDyzkAtfFImS8GeVxZ+riovKzs4anikp4hJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294615; c=relaxed/simple;
	bh=xiRrASfBClGZls8h00Lwn7h+CVOFM+Kb9IWTI0Ymu0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnvgMIWKo7cfeOmr7WT2ybE8qpHLn3J8uNDwJ+BdgV7VH984uGgxXGxZrdt1Z+Ww3jf81h5Bx2zIGSCmJdB5J0ZggCnR0t5YixLxTKJr79SBP+jsEzgFbZrpNbTmZiq+7Z5Ke+ajQMGwgCUwqG+Bg+bD6MCptuU+kMiSctHJfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SfnUlIBO; arc=none smtp.client-ip=54.204.34.130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782294597;
	bh=N68RMB/q1VgZjQNuQ07ZeKg+CIRWVN7E4ZKgeKRolOA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SfnUlIBOZKB4uD/TlNEnOaiym9mYFVWF1cqEA2uWZxlgxj8Mu/0VsBws97XLtKSUm
	 p+ev9k25jYt6dp9yQjKz4aD64/9UAq5cclJ4NYpi+XDHr7lFB9Mux5CsogYa7PoMuv
	 W9mgjtQUJWxX8XAoEJXj1Lc645HqbbTzg66WBTxk=
X-QQ-mid: esmtpsz11t1782294579t29053857
X-QQ-Originating-IP: hUuIodSh/V0JaPL6xtmfKtYIzxwXGWZ67kVSButBRcA=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 17:49:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2645138778342127022
EX-QQ-RecipientCnt: 12
From: ZhaoJinming <zhaojinming@uniontech.com>
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sean.anderson@linux.dev,
	zhaojinming@uniontech.com
Subject: Re: [PATCH v2 2/2] net: fman: use devm_kzalloc() for fman and rely on devres 
Date: Wed, 24 Jun 2026 17:49:21 +0800
Message-Id: <20260624094922.2971930-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <f0a6fd09-2fab-4bb4-85ae-82f8d383452c@lunn.ch>
References: <f0a6fd09-2fab-4bb4-85ae-82f8d383452c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NoW28xqLdlGMzET7yGQba75g/Qavtvu306GDOB8OdeEOeO3dZQky7yfc
	87mjlZ891wgCPgjWSNjxML2vOS0Ve5id/QJpO7gV3su995k0o25aMoEzyjJXnQ6Hm0LkG4Z
	Y6GhjVcThX9yb/a3VZvlDguPkE0SY6YAANglO+gHv+p8JMErrVC5aQONk+FTBOfcmJblwvQ
	yyYHXWy/TWduSkbyZpkF9Q77D9d4kQi/eCAciq3Eokay52dQ8bz0f2bzcYMKcVt3HZruuI1
	ktif31wA2V2qQmqePklrw6kVeUt2xUoMZRb/Ut8LPGqY5FoX2cb5POjjBZaNpTRsRYCsqbB
	TSikzkekmocLoH1Y+O/vL5jv7qDHAQKJE74j4mSyroHsQmmoKGUrAf6Fvn9gCTJnoEuM7Uo
	8VNRstbetWGxLaUTtL5XKF9c2ApoSUFn4IeZJ58fzux6p7HhA3GKVzaaGPiiyTKOW08BWE7
	G8imh10d1ZVBiDt2GG8D4Ii4GMwhT2g44jzECpA18wKfPqrdh3om3CC46V0BLKq4ehXHGUx
	XDozW/RpVmEuVRdhB17CCu6Ja/jcyKGQWfwbN5sO29B21MBkLhGH7oU4Q3DgLESLEt2+u70
	ylIeJKq8R8hfVt5S3A2Vc2GgDLc3tX/ivjmdcJzO3SdKL2oRPJdya8NINJuSfaiVB9mk4y/
	rWxA/QjHxnG6v+fzNv+lgnTysp/vxDf/wTwqc0zpf1QjUbdXDzUOPsc8edusYnoNhLiCObc
	YhEuapNMEK2L2RaxxrcKtie+EHl4BWfU7YFj243bX5EAfhCn5wlcWXH3Q7RmBf3B8TrseOC
	nRMcUkbL5/3XQ4lAwupKdi+CLTZGTQEvzUP9SnLvFJ+ec6zy70tSzNOgIwqpPgPAnIemva0
	xqDXRr8yVAtgEV9nZz2OX6Kg9gNWzScnj5T5hN437eCH4coCHIA1voE6PjTq3U0m/i8euZ+
	ongJfII3biV3nE+OUAdrhDNPULzvxdTeAVsC8bAAXq+SMIcZPaTbQa5CR5ztuHNQ1V3ruyX
	6R0XtQQ/354WcRCKxX0f1FYDZJgu/U4K7AzY1jqN3t4F1LOBXg1B3M0KgmhoF0Ga/MX4xq2
	Dcvf/a3zTrG
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301598-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sean.anderson@linux.dev,m:zhaojinming@uniontech.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB55E6BD131

Thank you for the feedback. I fully understand the concern about
devm_ conversions. I have reworked the patch to avoid the devm_kzalloc()
approach entirely. The new version explicitly calls devm_free_irq() on
the error paths before kfree(fman), keeping the original kzalloc_obj()
allocation unchanged. The fix targets the same UAF problem but without
introducing any devm_ allocation conversion.

v3:
  - Drop devm_kzalloc() approach
  - Fix by explicitly calling devm_free_irq() before kfree(fman)
    on all post-IRQ-registration error paths
  - Add conditional check for err_irq before devm_free_irq() in
    read_dts_node() to handle the case where err_irq is not registered

Best regards,
ZhaoJinming



