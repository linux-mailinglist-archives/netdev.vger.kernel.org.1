Return-Path: <netdev+bounces-292151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGGVD+KiFmqBnwcAu9opvQ
	(envelope-from <netdev+bounces-292151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:53:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B75E0A5D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9F0E3007F78
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766993CCFD9;
	Wed, 27 May 2026 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="wkt4FGYk"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2335276049
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868315; cv=none; b=JGex9jjYVAMGVmfg9aOwOzAN57jvYPXAQijlxBgBLhNevq0VKM+qsrbrpAWKr6D0zUI+PLvx2xw5YvXJWZQJwHfOEVnAG/Jz+GuGNSEUtOBI2DaxW5Q7pVaPhoUshnaXY8ubA7eBes/zZY97iNz+k+9svLuaH4avDDYL5RzO/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868315; c=relaxed/simple;
	bh=NVOHKVXHwnbH81wCzMlzEc+nMaehPnHooU/DuIU4/l0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Vt+9Be9FbHbE+rw3lYulL8TI6FnrhBmkXO5nnlrpeFjCRR9UJbGlZmzy6o9IRO1oBVmvEbKZWfFfhbagv5PWYD7fiVtdpnpKu27nkRmDkClB5FVgTKlx5JPAVGJanBxdY/KFrxzEFwC4RcHfl2l8gKhorQ/Zja+LDkoMMGF/hLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=wkt4FGYk; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779868285;
	bh=133mS37I6tuEBHBlaWgDxx3zzPdztDDKTlpPqXQOUTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wkt4FGYkJn2xg6Z3jREqKIeN13A98dOA/5f2iL7kk4slTtvSKAA7lrK3r+OdF7YMA
	 NXwsM0EhE8FwEY2lqs6nhs64hgfL8LJ8zodzbLWui80jonhwVkRz7UhC0+/pabUF89
	 1fdUK6vbL0RQtTDP3f0YTKBKy6VAwqSGNaYyqzj4=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id CD721E22; Wed, 27 May 2026 15:51:23 +0800
X-QQ-mid: xmsmtpt1779868283tx38d9w72
Message-ID: <tencent_F2C58937ADA208EE4219632E34ED23772F08@qq.com>
X-QQ-XMAILINFO: MMwjR1C73eIs9oQgn7O3W+xV3n1wN3smKCFyuVVTcoMkZJ0GLZ3dXnt4n8QaTf
	 HHb+J4UnO4Wf6oZ2n8jjSnEaYeTjy5Kw9HZqt4gIpVU2RwV7kBhQuOpfoxQUmGZ880RGWSUng4Ko
	 p6cRky14kGG5J6RXXdZyiPmvfPwd9Tn9mK2YUSlG9PMtL86MCVNUgPjKb07sopwvQ3D5m60Qswoe
	 BwTjmTS0WMD/xgTKhFWsoMfkxp9Al+VGBgK4pePMKaoYX4S9f+lQ+zLKNf2IQFAiujlANjk5D/7C
	 a65JtZC9xM4/5UBGDeKBft+CFYGuhCvKM9/NLUWXoQVG9Saitw15bU6pBlrnyArAK9zkhnrWg/34
	 y4HrQnBhulNZcniLjFcjvmlTrB1VT7hB1l803c/AHayHPg3b9AMJn4HZz67lOTlgWGy5FLrFSTIj
	 aN2W78gZv4wSqdxDq0GofiHfzWhc8lotaihT2ZnwwLHX8IPjg2WTvZDSdmDFQz+2mU7u/yaMT1JB
	 liA87/q0TbyFNN0zx9akuEu63sWnOY3KiyHmNiVu4CqjXjLaRH42UueOp4A/hx2CA7OCFehUtAzY
	 DMdy4A47QrjL1zo9TMoNWe1LHwGxBAEZY/i2N3QI8exZ4NDLENCsyyC8NKOmilD3GFTqX9UJucDY
	 TYKqagYzhJFjDFEbeun5gcs3i/y13CZCh0IOw435zRlCLiTMGlUAoNihqmzAzCLwaZlhx5QPRfEm
	 pSoz5p505G+4eltbsxG8rZcYWS3ARXHliEtbvU4iXcuKNAImqKr9gAjKud4587aJVMB1YJhsaOFX
	 9m8iDBUnif2WcWLPhr2lFcBoi94kN48vpeJ39rQgBByqiLGVjS9xjG64qBabiq+rogBANLD/aZBV
	 CGgTLS+HXfUE5U4oX1sfdSzfDuQdZmry7QHXsVRBoQjT/WuQWOg7IzM/7DR0G/QCirf+rBb945J1
	 5L/VAoi1QfxWmZLytrRUjTEPo77Ya8X/EYPBV9UwOcMRm+mVGTRiyvQwTM2xfPbTT6Clbb9A7+mP
	 Uo0TaRWgdKrQKfqwbvXy3ezSq2Jp30+WqM5MLiMw5DSKve8Z63
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Zhao Dongdong <winter91@foxmail.com>
To: kuba@kernel.org
Cc: aleksander.lobakin@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	winter91@foxmail.com,
	zhaodongdong@kylinos.cn
Subject: Re: [PATCH] net: page_pool: check nla_nest_start() return value in
Date: Wed, 27 May 2026 15:51:22 +0800
X-OQ-MSGID: <20260527075122.316127-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260526162736.5e95b928@kernel.org>
References: <20260526162736.5e95b928@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292151-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,google.com,vger.kernel.org,redhat.com,foxmail.com,kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,foxmail.com:email,foxmail.com:dkim,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D0B75E0A5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 16:27:36 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 26 May 2026 18:04:44 +0200 Alexander Lobakin wrote:
> > From: Zhao Dongdong <winter91@foxmail.com>
> > Date: Tue, 26 May 2026 14:51:56 +0800
> > 
> > > From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> > > 
> > > nla_nest_start() can return NULL if the skb runs out of space.
> > > page_pool_nl_stats_fill() does not check the return value before
> > > calling nla_nest_end(), which can lead to a NULL pointer dereference.
> > > Add a NULL check after nla_nest_start() and abort the message if it fails.
> > > 
> > > Fixes: d49010adae73 ("net: page_pool: expose page pool stats via netlink")  
> > 
> > A "Cc: stable@vger.kernel.org" candidate?
>
> Not really, the thinking is that if nla_nest_start() failed then the
> very next nla_put* will also fail (nla_nest_start() is a zero-length
> attr, any attr we put after must be >= in length).
>
> IOW the commit message is lying, there's no way for us to reach
> nla_nest_end(). We will jump to nla_nest_cancel() which handles
> nest=NULL just fine.
>
> Zhao Dongdong please confirm this and respin the patch without a Fixes 
> tag and with an updated commit message. I think we got such a patch
> in the past, so we should merge it to avoid confusing bots. 
> But please make it very clear that this code can't crash..
> -- 
> pw-bot: cr

Thanks for your review.
I carefully reviewed the code. Your thinking should be right --I just happened to notice that most call sites of nla_nest_start() include a non-NULL check. Apologies for the noise.


-- 
Regards,
    Zhao Dongdong


