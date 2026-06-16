Return-Path: <netdev+bounces-299885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id prK6MGRrMWqCiwUAu9opvQ
	(envelope-from <netdev+bounces-299885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:27:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3479D6910B7
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:27:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="s sXnc6Z";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=ZavuDNYx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299885-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299885-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E62C30E78E4
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4927143E4BB;
	Tue, 16 Jun 2026 15:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B043E48C;
	Tue, 16 Jun 2026 15:19:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623169; cv=none; b=VLjRyVqkAbBlF4YOKAZOBcKwO7G+URUvCSz3jmLfuCsPoJX+PZ4VcXiP4Unum1QD6ozzR0VhfTjaAr8b3NQcMPlxpYPDzbTwJMrbtuwz11WCuuh3Urh9SiTlYFPiPsoWwfZCRNgi/wlSHBGNjTwm3o+jnHwqPUFW2f5uSLvSYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623169; c=relaxed/simple;
	bh=8/jM1JR8GA3NIc2HYTpE4xFSrFmVdfngJfzMnbO0d6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dP/jrD+i9tae4ExS0K//O5S4/xae/95WpgzEi4FO9Yd+MgetP/2xeBBtlNmz5zpynZhZZookfi1hWvSe4ul+u8zSItxNOVxqfewy18R5p7M8gsSUtRINa5uQk4y8wr9xR9fFDwC/i9sk5phlWgXTGhtPLbWoEznCKbPiXy7Hcug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ssXnc6Z0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZavuDNYx; arc=none smtp.client-ip=103.168.172.144
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C175EC0174;
	Tue, 16 Jun 2026 11:19:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 11:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781623165; x=
	1781709565; bh=3favjBJSD//yHx0/BDGq5JvLccuw8zroeYHEyULJUw4=; b=s
	sXnc6Z0zv7J/rin9Tq1nf65YQ2jV3d+a3CMGjlotAFsIEBGiXwdgk2Blq37ytDw2
	dColY+Zr6lkR4dFo7+6GuRyfGXi1AhydB+yB4KEWXpNO+v+692xO8dfwNGtol4IO
	DGQ4eeGsFGUo7bcxOSRavCKKpaVgyK41BgUbU15T1GnOngRKUIrDwV252HYvi1vX
	xP3+rr8NM5TZ8V0vlO/bo1uyq6Fi+5Wt2oW9wr4kdTaWHdMzZp8esHv4tmMxDcqG
	uZ+9Be5n4DgkTOJVsxC9deQ1glrkRrkRHGq+izuv1MfJunyfn+9OVc7u2grTvxhl
	/ConGUHH7NBMHI2k+vcfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781623165; x=1781709565; bh=3favjBJSD//yHx0/BDGq5JvLccuw8zroeYH
	EyULJUw4=; b=ZavuDNYxZ//sQyrmPS8NI4EAF/v7xsL5zBpZYjIAAZwNVghOBiK
	f8c3xW0IF/kbKFTf9xtDJ3WmTPLZ05y2gUv3ZMCuEC2FOpNv9Ve8K++aZFrn4sj7
	a9YM/RcZ2X8Q0O0SoWRIYPcbu7Ys0E114nfEunBevhfvtgtPL1LR6bNSWqo9Mm4+
	gvJgumx/NVY60qg3CVdB8sVBb+VHAjArTjAtAnSO10+XEVfv3wDBZaxYFkROa6+l
	x2LS63O+PzFvN9yf9g6GLoTY/nHTxjCJpQPZ8q0TG0IHWIBXa0AI80pKsmjo+Hr8
	iK93mu5vZaKIk01ruYL5Qy4kngsc+HipX+Q==
X-ME-Sender: <xms:fGkxaoVcKyYf31WNUgLvWZWZUEc4uA-YO3CMNhDCMKp2MhN3OP7LmA>
    <xme:fGkxailaNK_cWXTFh79ySd59mD5ObzW5tVUgtRakoy-xdKZXPqiQ1B8ig2xPOgCrl
    JziMcIxFIvks_S9QCFAKKvg6Hn7GPiSlwqHvDzE4SFzcAsgQighibM>
X-ME-Received: <xmr:fGkxanOi1-ETnKkI7hhuWn6WMMzChvLCMC8VBdCagNb45oJr5CMTXvL4lx_7vU2y4CqbPGb_ryFyZk-c_FATwsU>
X-ME-Proxy-Cause: dmFkZTEjCYExASkAqtOAuzqwxQ8gDXC6/PgtHWdzK1yflBTZvBXei8DkzSin9lf3yoBth6
    Yf1M8u2mIJ8DqGZJfk5/2WQNgLXdHewy3MP3rtEX/pVWrxfkMLXdcjNfpDEo8xssjdZ6ce
    TfUNx7AC8gTVc+eojdAjXyVAjh3lwFhNdvh9ht/0d90zyTvllCvHqSkmAH2c7paK3LmecQ
    vUX11J6B4Gsoazz/PRGOSztIGxdVfueH5KLm9cLPHcCIvrajcLagSN7TURcnQhkySZrZfm
    8+fwOKoR3P8/QHomnwYNzmltfnM6JVMxiUnrjngO0xz/EOhOFZDe0yO4VRLNhe/mVak3Q9
    jJfmlrF3mp+C+RfyC3VvmRC5PYrBqRkZFWvoNQfcgxllXYUyAip0nhweT9BNAYznaMxtPN
    25UG8q1XgppVYChl6Q8Xh3dwkrse5ypDF+xllOo6uTmlNlIv3CB5cVYN7cruV/lMT5vu1H
    o70oTiWZX7JT9ezaQ9itUGMco5qwVaZe39ywjA8wKeClTaFJGuKNcS/bK47EFYuyAlZo7X
    6frw4p8FQJ0dclTLz6GB5yAy7jZ+Y0kLFJdajDZWBYHNR6mkwMF7E1+lYmGQxK+SNTLV2A
    y6CjYOfLtZKSh7r4LlY0yUt+QoLq3LUBPSLwlgK8jxAZ7ihP/Is6Qg0Q+8/w
X-ME-Proxy: <xmx:fGkxaqKNOSNyIHlQ3J39ierduS5oeJmVFzUofUODfYFAk5Tn293CEA>
    <xmx:fGkxah2ck0v8Dq6kFgbqgUBh9ZPwSSYcrdSIuqHmGjghSqW4i5buZg>
    <xmx:fGkxamUMUD-shkAn2YhBou-LakZtUxc81rIb-pd7DyCqkBxypR1_cA>
    <xmx:fGkxarNIotq8TqBTFZExXjmcgpuQpbbPoX_YZ1T7DcDxjviFVj7RHA>
    <xmx:fWkxanS3q_MyObUKPboa-NrPl-6krHjY0om7fjVx7ROAqzt-Fof47W35>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 11:19:24 -0400 (EDT)
Date: Tue, 16 Jun 2026 17:19:22 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: syzbot <syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	john.fastabend@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in tls_err_abort
Message-ID: <ajFpejsl1ukTbG96@krikkit>
References: <6a315d48.b0403584.28d0ff.0002.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a315d48.b0403584.28d0ff.0002.GAE@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8697a140486f5628];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299885-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,storage.googleapis.com:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email,queasysnail.net:dkim,queasysnail.net:from_mime,krikkit:mid];
	FORGED_RECIPIENTS(0.00)[m:syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,redhat.com,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cca46a9d1276f38af2ae];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3479D6910B7

2026-06-16, 07:27:20 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f6033078a9e6 ip6_tunnel: annotate data-races around t->err..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=122a98ae580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8697a140486f5628
> dashboard link: https://syzkaller.appspot.com/bug?extid=cca46a9d1276f38af2ae
> compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7af9eb2b9b5a/disk-f6033078.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4b7e03b76e68/vmlinux-f6033078.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/38042dd09caa/bzImage-f6033078.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> err >= 0
> WARNING: net/tls/tls_sw.c:73 at tls_err_abort+0x5d/0x80 net/tls/tls_sw.c:73, CPU#0: kworker/0:11/6099
> Modules linked in:
> CPU: 0 UID: 0 PID: 6099 Comm: kworker/0:11 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> Workqueue: pencrypt_serial padata_serial_worker
> RIP: 0010:tls_err_abort+0x5d/0x80 net/tls/tls_sw.c:73
> Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 1b 89 ab 9c 01 00 00 48 89 df 5b 5d e9 c9 a2 32 ff e8 a4 60 8a f7 90 <0f> 0b 90 eb c3 89 f9 80 e1 07 80 c1 03 38 c1 7c d9 e8 1d 9f f5 f7
> RSP: 0018:ffffc900069379e0 EFLAGS: 00010293
> RAX: ffffffff8a3adf8c RBX: ffff88807d1e0d80 RCX: ffff888058bfdd00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000ffffffff
> RBP: 0000000000000000 R08: ffffe8ffffc513e3 R09: 1ffffd1ffff8a27c
> R10: dffffc0000000000 R11: ffffffff8a3c4d70 R12: ffff888028eaf400
> R13: ffff88804441030c R14: dffffc0000000000 R15: ffff888028eaf460
> FS:  0000000000000000(0000) GS:ffff8881252a0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f521f503ff8 CR3: 0000000086fc2000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  tls_encrypt_done+0x223/0x480 net/tls/tls_sw.c:500


	/* Check if error is previously set on socket */
	if (err || sk->sk_err) {
		rec = NULL;

		/* If err is already set on socket, return the same code */
		if (sk->sk_err) {
			ctx->async_wait.err = -sk->sk_err;
		} else {
			ctx->async_wait.err = err;
			tls_err_abort(sk, err);
		}
	}

I suspect err==0, and sock_error() consumed sk_err in between (the
alternative would be err > 0).

Something like this?

-------- 8< --------
@@ -473,6 +473,7 @@ static void tls_encrypt_done(void *data, int err)
 	struct scatterlist *sge;
 	struct sk_msg *msg_en;
 	struct sock *sk;
+	int sk_err;
 
 	if (err == -EINPROGRESS) /* see the comment in tls_decrypt_done() */
 		return;
@@ -489,12 +490,13 @@ static void tls_encrypt_done(void *data, int err)
 	sge->length += prot->prepend_size;
 
 	/* Check if error is previously set on socket */
-	if (err || sk->sk_err) {
+	sk_err = READ_ONCE(sk->sk_err);
+	if (err || sk_err) {
 		rec = NULL;
 
 		/* If err is already set on socket, return the same code */
-		if (sk->sk_err) {
-			ctx->async_wait.err = -sk->sk_err;
+		if (sk_err) {
+			ctx->async_wait.err = -sk_err;
 		} else {
 			ctx->async_wait.err = err;
 			tls_err_abort(sk, err);

-- 
Sabrina

