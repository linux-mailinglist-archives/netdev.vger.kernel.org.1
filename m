Return-Path: <netdev+bounces-300232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mwdWJUnyMmrs7wUAu9opvQ
	(envelope-from <netdev+bounces-300232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:15:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E269C1EB
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:15:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=JeZ2uI+Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300232-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300232-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAAB6315DD25
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 19:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF0B345750;
	Wed, 17 Jun 2026 19:15:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C0379ECD;
	Wed, 17 Jun 2026 19:15:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723703; cv=none; b=kdCd2vfA9vsrkkM98gDGfd2n36gCh0JwEhRZraDE4XC3r13q7HN76tfIAfzkKjGP4hWIYQyxXu0W7V9P67uj3Lj2ShslSLGhmcrMggaQ9VWQQAJEfxkx7XDaDhGWWrJghZ0grvAEyTHgjH15BaLlGl3TzKanz3rfYtxMWa+2KHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723703; c=relaxed/simple;
	bh=U/JjWDaNTGpaVDDjDb7/UO/EuFA3dV5VcowRISEDLcY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N4EGGBsGzcP+j9cocVaZ9SdKOyKSOj5kc8L4CdjXUb0CIqSEBIi7u9g2xJlZJgWHAj4zasesmnHYQOMzOisviIcDJT+Sn+hGx22jpiYRS8+8oXZRJFsH1Cx0aY9kCt6/3De4N3q0G1q6IEI6bTbyJhVTyNP+v56bD5WEyzOrGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeZ2uI+Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2655A1F000E9;
	Wed, 17 Jun 2026 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781723702;
	bh=FASyi1AWkm+i6K2loGoBP4D8Pk6x5oWdo88DHdM7e3M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=JeZ2uI+YYS81CYkYXl5rr2DX06e0pb02WFbd4Q04fu1pKRXGLh3pO3L4+aa4/PnzA
	 4IuAU/mVOpzj81LyZML8/JASJTgYhPYDnt5EIqtenZjzcbts/PKm7jpDWHMuQsBRbe
	 yNDdcZSM+FjrFVahUrWVuSB+Nsb6u/Q9UU1dgQSiCOUwy4JY0ZFzY/6M5kzk5UPRFQ
	 uSbpUhe0KceTihL1nm2a2u35+SlHk7z/EFy8XkkbavXnHJNUCarmCUNHux4krTx4rd
	 SMGDkLWdxMkRfM57lgxgr8+E1mfQR94ZuAVgDbUKK9VtAApntrP93yMu/CXgltvfpb
	 YS+96iLSJ6fqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569AF3931008;
	Wed, 17 Jun 2026 19:14:57 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260617065516-mutt-send-email-mst@kernel.org>
References: <20260617065516-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260617065516-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 8cb2c9285e4ce9154f45fb15633ebd45dfd8d9cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d44ade05aa21468bd30652bc4492891b854a400a
Message-Id: <178172369584.1775335.8856194024948624969.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 19:14:55 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	a0yami@mailbox.org, ammarfaizi2@openresty.com, arnd@arndb.de,
	chenhuacai@kernel.org, chenhuacai@loongson.cn,
	christfontanez@gmail.com, Damir.Shaikhutdinov@opensynergy.com,
	david@kernel.org, den@openvz.org, enelsonmoore@gmail.com,
	eperezma@redhat.com, ethan@ethancedwards.com, evg28bur@yandex.ru,
	filip.hejsek@gmail.com, francesco@valla.it, graf@amazon.com,
	harald.mommer@oss.qualcomm.com, jasowang@redhat.com, jiri@nvidia.com,
	johan@kernel.org, johannes.thumshirn@wdc.com,
	lingshan.zhu@kernel.org, luis.hernandez093@gmail.com,
	lulu@redhat.com, mhi@mailbox.org, michael.bommarito@gmail.com,
	mikhail.golubev-ciuchea@oss.qualcomm.com, mkl@pengutronix.de,
	mst@redhat.com, mvaralar@redhat.com, nathan@kernel.org,
	oleg@redhat.com, pawel.moll@arm.com, physicalmtea@gmail.com,
	polina.vishneva@virtuozzo.com, q.h.hack.winter@gmail.com,
	r@web.codeaurora.org, osenp@gmail.com, schalla@marvell.com,
	shuangyu@yunyoo.cc, stefanha@redhat.com, vattunuru@marvell.com,
	yanlonglong@kylinos.cn, yichun@openresty.com, yui.washidu@gmail.com,
	yuka@umeyashiki.org, zhangtianci.1997@bytedance.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300232-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:torvalds@linux-foundation.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:a0yami@mailbox.org,m:ammarfaizi2@openresty.com,m:arnd@arndb.de,m:chenhuacai@kernel.org,m:chenhuacai@loongson.cn,m:christfontanez@gmail.com,m:Damir.Shaikhutdinov@opensynergy.com,m:david@kernel.org,m:den@openvz.org,m:enelsonmoore@gmail.com,m:eperezma@redhat.com,m:ethan@ethancedwards.com,m:evg28bur@yandex.ru,m:filip.hejsek@gmail.com,m:francesco@valla.it,m:graf@amazon.com,m:harald.mommer@oss.qualcomm.com,m:jasowang@redhat.com,m:jiri@nvidia.com,m:johan@kernel.org,m:johannes.thumshirn@wdc.com,m:lingshan.zhu@kernel.org,m:luis.hernandez093@gmail.com,m:lulu@redhat.com,m:mhi@mailbox.org,m:michael.bommarito@gmail.com,m:mikhail.golubev-ciuchea@oss.qualcomm.com,m:mkl@pengutronix.de,m:mvaralar@redhat.com,m:nathan@kernel.org,m:oleg@redhat.com,m:pawel.moll@arm.com,m:physicalmtea@gmail.com,m:polina.vishnev
 a@virtuozzo.com,m:q.h.hack.winter@gmail.com,m:r@web.codeaurora.org,m:osenp@gmail.com,m:schalla@marvell.com,m:shuangyu@yunyoo.cc,m:stefanha@redhat.com,m:vattunuru@marvell.com,m:yanlonglong@kylinos.cn,m:yichun@openresty.com,m:yui.washidu@gmail.com,m:yuka@umeyashiki.org,m:zhangtianci.1997@bytedance.com,m:filiphejsek@gmail.com,m:luishernandez093@gmail.com,m:michaelbommarito@gmail.com,m:qhhackwinter@gmail.com,s:lists@lfdr.de];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,lists.linux-foundation.org,mailbox.org,openresty.com,arndb.de,kernel.org,loongson.cn,gmail.com,opensynergy.com,openvz.org,redhat.com,ethancedwards.com,yandex.ru,valla.it,amazon.com,oss.qualcomm.com,nvidia.com,wdc.com,pengutronix.de,arm.com,virtuozzo.com,web.codeaurora.org,marvell.com,yunyoo.cc,kylinos.cn,umeyashiki.org,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E53E269C1EB

The pull request you sent on Wed, 17 Jun 2026 06:55:16 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d44ade05aa21468bd30652bc4492891b854a400a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

