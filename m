Return-Path: <netdev+bounces-189352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A9AB1D6C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 21:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D221C410D9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A189A23C8C5;
	Fri,  9 May 2025 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihZVhp6M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916A22E3E9;
	Fri,  9 May 2025 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746819986; cv=none; b=NEaZm/NhCLeALNFYzdvtJLpF6Q3pmLK0GJkeiUgv67Ds8lFQNlBX7XbPENTW4d5Yk84ZkW+LHoFg0GfXF7V6CvCsjtI7xN6/jaKOhyPEFvaUVQMzjsOf3TlDsQPmgZmRV09aVY8PIMO+2X0UcV0Bu3ZSF73DMn37BgJYNyrufvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746819986; c=relaxed/simple;
	bh=xMrb+rDPrSCIyK2OkucvlROXsFEcbJSgaNN+mqQk+QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q88eLSx8SNFFT42eGM5ndGLhivmbjo4SloVdz0CSsY+4ZwhevhMu9u3wAqF5mwNQDCI/wtx9o8KGt4QvT5OOA0c5cHr1kVANxKbG0O/GBJFiHKnbon70Veu5SoVCSSBH1fSZQ5V1kIXayfGjo2c32tbE0PUtoNAFX3A/LmL6XXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihZVhp6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD83AC4CEE4;
	Fri,  9 May 2025 19:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746819985;
	bh=xMrb+rDPrSCIyK2OkucvlROXsFEcbJSgaNN+mqQk+QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihZVhp6MdL77p7iiThFGHHufeeiTopYAZUKPxTMGInJTVI7xr9SBmFL8S87Yc7+SS
	 TPn8tS4qiwlGAQu37oxIAPR5sIE/nSdKGlRvRjGThNkJQMKpqRdJZ+Voo1iGTUI9hC
	 6gUfWDt41RosJC2OO8eKOJf8JxYAnMxXu7mK8zaqtWb2oBLlPMYhsTgEIK6J1uC0HK
	 hZYaBco5+Ox6oCQs+YYD94K9Ka9VYOOnZLRNZ4iY8J6Bi78s25cEUVpVgH7p1CUPRg
	 FjMeaCEmNrOT4gDHAFUtJeVzpL9PnfkPlC83A0O6Fi2keISBX4DVGCEYwip4hNpSd0
	 aTzLmKrFPASAA==
Date: Fri, 9 May 2025 12:46:22 -0700
From: Kees Cook <kees@kernel.org>
To: syzbot <syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] UBSAN: array-index-out-of-bounds in
 llc_conn_state_process (2)
Message-ID: <202505091223.3C51585567@keescook>
References: <0000000000009767ec0619fe6a1d@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009767ec0619fe6a1d@google.com>

On Mon, Jun 03, 2024 at 08:59:20AM -0700, syzbot wrote:
> HEAD commit:    6d7ddd805123 Merge tag 'soc-fixes-6.9-3' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12596604980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
> dashboard link: https://syzkaller.appspot.com/bug?extid=628f93722c08dc5aabe0
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4d60cb47fbb1/disk-6d7ddd80.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f3ff90de7db5/vmlinux-6d7ddd80.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d452970444cd/bzImage-6d7ddd80.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in net/llc/llc_conn.c:694:24
> index -1 is out of range for type 'int [12][5]'
> CPU: 0 PID: 15346 Comm: syz-executor.4 Not tainted 6.9.0-rc7-syzkaller-00023-g6d7ddd805123 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_out_of_bounds+0x110/0x150 lib/ubsan.c:429
>  llc_find_offset net/llc/llc_conn.c:694 [inline]

static int llc_find_offset(int state, int ev_type)
...
                rc = llc_offset_table[state][3]; break;

But this seems to be racing against:

>  llc_qualify_conn_ev net/llc/llc_conn.c:401 [inline]

static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
                                                              struct sk_buff *skb)
...
        struct llc_conn_state *curr_state =
                                        &llc_conn_state_table[llc->state - 1]; // <<<<<<
...
        for (next_trans = curr_state->transitions +
                llc_find_offset(llc->state - 1, ev->type);

Otherwise the first one would have crashed too (a -1 array index). Is
something racing:

void llc_sk_free(struct sock *sk)
...
        llc->state = LLC_CONN_OUT_OF_SVC;	// = 0
        /* Stop all (possibly) running timers */
        llc_sk_stop_all_timers(sk, true);


>  llc_conn_service net/llc/llc_conn.c:366 [inline]
>  llc_conn_state_process+0x1381/0x14e0 net/llc/llc_conn.c:72
>  llc_process_tmr_ev net/llc/llc_c_ac.c:1445 [inline]
>  llc_conn_tmr_common_cb+0x450/0x8e0 net/llc/llc_c_ac.c:1331
>  call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1793
>  expire_timers kernel/time/timer.c:1844 [inline]

Given this is in a timer, it seems likely, especially given the above
"llc_sk_stop_all_timer()" call. And llc_conn_tmr_common_cb() is reachable
from several timers:

void llc_conn_pf_cycle_tmr_cb(struct timer_list *t)
{
        struct llc_sock *llc = from_timer(llc, t, pf_cycle_timer.timer);

        llc_conn_tmr_common_cb(&llc->sk, LLC_CONN_EV_TYPE_P_TMR);
}

void llc_conn_busy_tmr_cb(struct timer_list *t)
{
        struct llc_sock *llc = from_timer(llc, t, busy_state_timer.timer);

        llc_conn_tmr_common_cb(&llc->sk, LLC_CONN_EV_TYPE_BUSY_TMR);
}

void llc_conn_ack_tmr_cb(struct timer_list *t)
{
        struct llc_sock *llc = from_timer(llc, t, ack_timer.timer);

        llc_conn_tmr_common_cb(&llc->sk, LLC_CONN_EV_TYPE_ACK_TMR);
}

void llc_conn_rej_tmr_cb(struct timer_list *t)
{
        struct llc_sock *llc = from_timer(llc, t, rej_sent_timer.timer);

        llc_conn_tmr_common_cb(&llc->sk, LLC_CONN_EV_TYPE_REJ_TMR);
}

llc_ui_release() does:

        sock_put(sk);
        sock_orphan(sk);
        sock->sk = NULL;
        llc_sk_free(sk);

And I see llc_sk_free() also does:

	sock_put(sk);

What holds locking on llc? The timer callback is locking itself, but I
don't see any locks in llc_sk_free(), but in theory there should be no
locks left?

What's supposed to be happening here? Moving the state assignment later
doesn't look right, given the explicit check here:

static void llc_process_tmr_ev(struct sock *sk, struct sk_buff *skb)
{
        if (llc_sk(sk)->state == LLC_CONN_OUT_OF_SVC) {
                printk(KERN_WARNING "%s: timer called on closed connection\n",
                       __func__);
                kfree_skb(skb);

Is it just that a lock is missing in llc_sk_free?

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 5c0ac243b248..99c4f06477eb 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -974,7 +974,9 @@ void llc_sk_free(struct sock *sk)
 {
 	struct llc_sock *llc = llc_sk(sk);
 
+	bh_lock_sock(sk);
 	llc->state = LLC_CONN_OUT_OF_SVC;
+	bh_unlock_sock(sk);
 	/* Stop all (possibly) running timers */
 	llc_sk_stop_all_timers(sk, true);
 #ifdef DEBUG_LLC_CONN_ALLOC

-- 
Kees Cook

