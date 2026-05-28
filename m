Return-Path: <netdev+bounces-292564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dbmWGvzbF2oUTggAu9opvQ
	(envelope-from <netdev+bounces-292564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:09:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C9A5ED224
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6182930057A6
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 06:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48DE314D07;
	Thu, 28 May 2026 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BAPeXR+9"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D132AABD
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948245; cv=none; b=OsxktKqIQm13s2xMnAooaDULK6r55hSNP8uGvSnjdp+laSiHrxBhYQQyJOLmVv+bsEQzZ34WRC/J6W4Je/aZi8qQNVarT0243x0oWUXUq6b2JfhCVvURTLi6POeBePt+bb7j1Wk0ngLedwHfOGhsphm/Wn0l/ai1P7wkQgibw+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948245; c=relaxed/simple;
	bh=leftlKj9ju/t5xFZB3umlFpYoXFpXag7tXij8X1ff/c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Lio18gCkimCYElg7J30iPV7tGHTyL1sPs+gi79DzLy1QFZOcElmRAssBzAAS5l1nGDAmFjegda6zw0j0rwdiZgZbCMT9a2bgSvh09pd+40BWuXZ3+cj6xc0e4GHeMijqnUzCnknCSvXp6jsbAlmhRV3zrkKyzJdOH2zjc7AJKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BAPeXR+9; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779948238;
	bh=wKyFW0Id5ab5cSNKpqoj68nL8LTCd3dUNjmh9UB3aWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BAPeXR+9qJ1YmUfAYBs0LYg7aPt+kawdKuFJV/CqSt4LVGcnWfzLTz+XX68sa+Clg
	 3Jtq59lcLZvQXOiDJ1+7/vjWJIhEeoVsJvc5vlLoBoxUmpuZ9+K8ORO+RW3ANkQaP/
	 xV3sTTHv1ZTI9AZSM9tZYLyDPA3iEaBPN0Gg32ek=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id F8944F1; Thu, 28 May 2026 14:03:56 +0800
X-QQ-mid: xmsmtpt1779948236tkkwe82l2
Message-ID: <tencent_58EED319742E3CEDB877C1C5803708A24508@qq.com>
X-QQ-XMAILINFO: MnnqVTktpo2O3uz7rJLI3UDDBns2wNboMMQ2XlRh17xwMkt4IBHVX4yH4Xc7pf
	 GvdE4iWiBdnrlltisfVWaHVIllyqAZlitYETlhm76AuuMCIDfRXuQAdPl06JvOXpbTeKt4mNejuD
	 cJYVEy6lXFxENy+bblgzwu6KSCZfJfRlVjO9GrWp/FfdVswfC2Bl55OP2T2lS/tdNLufOCtEQPzV
	 kzJDbmyMUvDxoX+gDRr7anE1bV7Mb2uwUna/wOB/tZHoDzL/6V8EZLSX2Tp9NOrvk6q+Zb2x9S6z
	 O9xxAOaOJRDC7WIpvestuGv2qudHfLIgJUXQdAXttt8UEzQw3OkvwQZ1jQr2GVXqZnsl7cxps3Sb
	 O+YP2ihDrXAE9+i6zSW/d1Ul5ksTfdc93VUXmC15Tk941VCI7iu+H/sNKScAY1b+Y4KDNL0HL/bw
	 Wc53T0chPb4akvqdji8oqyQ7/Mpx57dG/mmZWnc8u7p5ftoKNETGizNmhXpxh2SH5gwvtccigc9W
	 DyHxGyrGULjHymnLq2bJOMnKvAAHI6yaHSpFoR5Rmb2GWcMYSh24cNdeoaabbgTG5GD6fQ80UbND
	 9JxSUZyXD98YunXS19uKZVZrLBctqe6yC4AoUhU5m3HEQF/b9SGY6XHBDUeihTGIWSTOwOdI4NeY
	 Jnl6LGxtqs6zFbkVIHkBmG23sz7JipFHgHwxnIkWg1J299Vx7NnkR3kfcxiamyuHuLvvwvFuZDep
	 s7e2eWXr3up3x1NaL8Ppc3fq1gy0dicr8isReKV3zuYA75Iejnpkx6FMfHrRFZCHsU+NTsLwiHd3
	 FUYIoq+lCZyjCau17S6Z5TCTSreoS0VwkgLQNCXrrtBHNFd+1Fn8ynwfmzWc1yrRYLEge+1FWRQm
	 IAmgHzktQ1/V+awV2eqvjLLJswB1SpfqcCS9gPKAsHJwhiU4bXIhaUhO8onEJ39f3dD0y9v67U9q
	 CwTUkMGVdLKSoNPY74+J93p0wtcfuZA/U6YrX8W7IHym3FoqQ0IRAqN6oO1fCggDdJ67x7iEXIDT
	 NWvzAPrkeD2fvGt1z2N7L++EHzT93KhDEMph30Il1RDhWc/B9w
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
Date: Thu, 28 May 2026 14:01:35 +0800
X-OQ-MSGID: <20260528060135.255045-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527174121.2289833e@kernel.org>
References: <20260527174121.2289833e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,google.com,vger.kernel.org,redhat.com,foxmail.com,kylinos.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292564-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 74C9A5ED224
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 17:41:21 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 27 May 2026 15:51:22 +0800 Zhao Dongdong wrote:
> > On Tue, 26 May 2026 16:27:36 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > On Tue, 26 May 2026 18:04:44 +0200 Alexander Lobakin wrote:  
> > > > From: Zhao Dongdong <winter91@foxmail.com>
> > > > Date: Tue, 26 May 2026 14:51:56 +0800
> > > >   
> >  [...]  
> > > > 
> > > > A "Cc: stable@vger.kernel.org" candidate?  
> > >
> > > Not really, the thinking is that if nla_nest_start() failed then the
> > > very next nla_put* will also fail (nla_nest_start() is a zero-length
> > > attr, any attr we put after must be >= in length).
> > >
> > > IOW the commit message is lying, there's no way for us to reach
> > > nla_nest_end(). We will jump to nla_nest_cancel() which handles
> > > nest=NULL just fine.
> > >
> > > Zhao Dongdong please confirm this and respin the patch without a Fixes 
> > > tag and with an updated commit message. I think we got such a patch
> > > in the past, so we should merge it to avoid confusing bots. 
> > > But please make it very clear that this code can't crash..
> > > -- 
> > > pw-bot: cr  
> > 
> > Thanks for your review.
> > I carefully reviewed the code. Your thinking should be right --I just happened to notice that most call sites of nla_nest_start() include a non-NULL check. Apologies for the noise.
>
> I don't see a v2 so I'm just going to rewrite the commit msg myself and
> commit this.

Thanks!
I was under the impression that this patch was no longer necessary.


-- 
Regards,
    Zhao Dongdong


