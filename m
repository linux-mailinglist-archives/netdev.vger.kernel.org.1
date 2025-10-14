Return-Path: <netdev+bounces-229243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D717BD9BA8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01C1188435E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCD62FC025;
	Tue, 14 Oct 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="lZJgHsSY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h27YKG2a"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2A304BC5;
	Tue, 14 Oct 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448422; cv=none; b=bT7EGw6SVaAmZyBmXy8gH8l0HeL5+G+Rddpl0qdqNdpxw7nwth4bH/Q5LcSce0usMhaYGc/2ioVMXKGAT8Y8UJDABl1hMgzvEaB4cltmNHp44oVD3AZEjCmCj3jl8ezHNzYYhFjidk22mtWBeA4ao/8kCFF0gYiz/qcXjXScp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448422; c=relaxed/simple;
	bh=hXCKJ+hMZ0N9v4f87T51ieYkJGSHaAvjzaKvcg0maRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asHK7UGlAZ+sXFD3+Veine4DQUv9rgOIP7JP+WkaihmRUWaKvitefJ44P6YoNHMgMOMmdgZ9tat92nlxl425Vdw60ukg/ravO0gCoIDXKt8zJMVkLA9pnwcZGpwd8+CjD3amNzW3SvErJmbmu6kwyqKbpjaJUL3HVMq70Qv40zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=lZJgHsSY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h27YKG2a; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E2472EC008A;
	Tue, 14 Oct 2025 09:26:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 09:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760448417; x=
	1760534817; bh=m5oecF8M1+NO9SuhOhdXOIQPyb6XjVKIe3cMgm6wXPw=; b=l
	ZJgHsSYNUUOdD3gCn5G0mgPutCQlL4Jw0iuggyAiSLrJVmjMN5KcMNVx5Zm/UaME
	OigTo8o+hS3KbumVNjjlqqe8r0qXc6jDF8TrRL50p4ictGPK5KCwbHOD0m+SNQeZ
	mcw4Nf4OsHcZX7NTHoZUsf1wJEUWe5p3qwP6nAbekrYNCwsD4G1iy/9THFpMxJx5
	AiR5Ug4EVsb1hwxUGzRDMOriKrb03HGW7BrqhiH5XyYdXs1ALqzUa44VtuHja0/v
	JrLTTD2tSMLrq81wYis9d+VWHzivUPcUEx74nv8WInJvIqK3JN/NKoBf7v0ro723
	Yt9ztXwYSXKc4e+W0f9tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760448417; x=1760534817; bh=m5oecF8M1+NO9SuhOhdXOIQPyb6XjVKIe3c
	Mgm6wXPw=; b=h27YKG2a5yS3RiC/aJP5yMleC3YbsQtJvOx/b/2tAcj/uiGzQ6u
	41Gur5mEvoSTZX1r4PsJAPXoW/P5KFdwtl7b4h6AjzUV/7lhE7GrXgqZKXLgWpA/
	YhwLXC+WLzW2/asf4uYfk6oOGPRP9jk/6uyewPywvVbQbo7GB2MTUWrY2p4RIuQi
	7z4IbgfYDtJc1YYbQ1UKU8gGp/tADrntsfE+QKS86c4l7zi9INioxyI/Qa7fdtl4
	+patKMYMgxr11e7vidYYWDJB0ZC9OTKUzWKdxSbNWZmLPcAuoY1Es7ArQsbxlKog
	Oablzb+64i7xAC5V61OH/r9qpdTuwNxBcYg==
X-ME-Sender: <xms:n0_uaL24_Qct1SvUuU0N0bs0wDSXhKUVohPGTFBpH0v1uWfJVtef1Q>
    <xme:n0_uaLqz68FxBUeJiOq80-5XDL835Bd92jxi5VgA0CJmLZ7FLqRRLw-ZsgI8XTzJX
    YeV4ArXJ7EmWMJTm7RbHvSrU3bPaGeZLP-sF9Eiaclo3jjiF9R8ZyU>
X-ME-Received: <xmr:n0_uaLI415aMZi1a135jk2RrBgJDDhZZVqwyrv1CPGLuykYI8JnC3zHHIiTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepveekhffgtddvveejvedvgffffeeftedtfefhtdfgueetgeevuefftdff
    hfduhedvnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpd
    hgohhoghhlvggrphhishdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtg
    hpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvfhhfvghn
    rdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopehshiiisghoth
    dohegtugeivdellegvuggvgegugehfjedtleekjegssehshiiikhgrlhhlvghrrdgrphhp
    shhpohhtmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfth
    drnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtph
    htthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:oE_uaHThqWF7BiSWWGf_NPyrCmap1kHXMuI5nXVzobcD0X75jNRBzQ>
    <xmx:oE_uaDNEbG5QYVMJJeBwTaTle6yykwd-pGtFmVG7zyX8PEIKtRJKHQ>
    <xmx:oE_uaEVazbSNgRUt0VaOtIo0jc2RI6HwP8c6IHLNhpE5mzwSzrTzWg>
    <xmx:oE_uaOiOFQWrb2XgHBahkaB4JpZjGl5yhUcxqSPpRZfAVambMAZXbQ>
    <xmx:oU_uaGCDPEkTsUiuupAWXzyWpQC0kGa0mthzZMrN53JJNrwxWc1TiYrf>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 09:26:55 -0400 (EDT)
Date: Tue, 14 Oct 2025 15:26:53 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: steffen.klassert@secunet.com,
	syzbot <syzbot+5cd6299ede4d4f70987b@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_migrate (2)
Message-ID: <aO5PnU4dhUuzM34e@krikkit>
References: <68e2ad62.a00a0220.2ba410.0018.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68e2ad62.a00a0220.2ba410.0018.GAE@google.com>

2025-10-05, 10:39:46 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4b946f6bb7d6 selftests/bpf: Fix realloc size in bpf_get_ad..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=13be46e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
> dashboard link: https://syzkaller.appspot.com/bug?extid=5cd6299ede4d4f70987b
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f0ef71bdead6/disk-4b946f6b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0c8251d5df12/vmlinux-4b946f6b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/29bad3cdad16/bzImage-4b946f6b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5cd6299ede4d4f70987b@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 __xfrm_state_destroy net/xfrm/xfrm_state.c:800 [inline]
> WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 xfrm_state_put include/net/xfrm.h:928 [inline]
> WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 xfrm_state_migrate+0x13bc/0x1b10 net/xfrm/xfrm_state.c:2165

Steffen, this looks like we simply forgot to set XFRM_STATE_DEAD
before the final put() in the error path of xfrm_state_migrate (and
xfrm_state_clone_and_setup):


diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9ea1d45b79e3..7ae10fac7b31 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2074,6 +2074,7 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	return x;
 
  error:
+	x->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(x);
 out:
 	return NULL;
@@ -2163,6 +2164,7 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 
 	return xc;
 error:
+	xc->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(xc);
 	return NULL;
 }


Does that look reasonable? The state was never add()/insert()'ed, so
it goes through put()/destroy() without delete() first that would set
XFRM_STATE_DEAD.


It also looks like we're missing a xfrm_dev_state_delete if
xfrm_state_migrate -> xfrm_state_add fails, since
xfrm_dev_state_delete gets called during __xfrm_state_delete, and this
new state will only see xfrm_state_put/__xfrm_state_destroy:

@@ -2159,10 +2159,13 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 		xfrm_state_insert(xc);
 	} else {
 		if (xfrm_state_add(xc) < 0)
-			goto error;
+			goto error_add;
 	}
 
 	return xc;
+error_add:
+	if (xuo)
+		xfrm_dev_state_delete(xc);
 error:
 	xc->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(xc);


-- 
Sabrina

