Return-Path: <netdev+bounces-288254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG1MK3nnBmoHowIAu9opvQ
	(envelope-from <netdev+bounces-288254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:29:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A954C6C3
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BEE630A8074
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF91143637A;
	Fri, 15 May 2026 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B53tXIrQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F021436367
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836251; cv=pass; b=dUUD0nCbxNszli0LwCQ0BlSudo5P8MdjMibo7SxJNpG1L3qG3fgErZvxS7Naf2h+nWgyALNIbghxUHTzEW4zEZFLO0nQaaTGnJU76HOh7aIy9hUudQp+Ei2ECDWzUITwSKPllqcOs33dX9fb/laER7DFpjLd5oCxlms1ajCVv3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836251; c=relaxed/simple;
	bh=XgWC+GwweQWt038ptA/xyDWlyEQYKRJAnSWl2cpdbtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1jFzNr5GGINcA9NPHfnV4vHZ5pJW2Vejca8WL8ySM4JkHgBMB9ZCVkJ1txNMOjbYoz0aYdFjvig/QLo+CivYX2WyYFpXyLw3lyuxKAlRXRmrd68ti7zhP8aNZWb0NsxuTKZEMI4g1HbdU8kecUfrNJxzfW2aJxbd8dVlAjfO/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B53tXIrQ; arc=pass smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-393a49d2e5eso77436721fa.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778836247; cv=none;
        d=google.com; s=arc-20240605;
        b=kCgKuYn/Rr/RNbsePWCvjUVt7ZL+Jb0X3nqCGI4X6QCRsiBiFLG14/ZP0fL9cKjqsC
         9MTRyKjB6/PUuvjkxqyTL61B6aMNTSuIORcDZhhGbORHbaQnBHQcDbs4o21pKdQNDYwe
         Bb2RXlNcOoi8O7RhogyV7Rou9crzIuUpGeIompTOhT/u7SiOR7D+TqjnpX+/hdMSRIwa
         W3bdngZvZkINHR+EdG1nAZ29Bo6BY3GgcJiWuWIh3J+HJxL7cRoF4+H5D0ZtTN4LxSFk
         Y8mtObw+agRtVgLEU7LDV7YOn9G98Y+xxvVXOT95i1RsoJnvtUgPIX9+tqaY9zDR+OIM
         NRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eGpXS0DEPBrEJ67yIQ4gTPv2lm5TnhViA0o5Zx+53Ds=;
        fh=FwICqXA9jmCrFFCnBlMNpKU0pG6mXTxYs5DwwKt0wos=;
        b=fMODqNY0UVyaWuaUslGSlgzzimArvQ43y1WmWXys0g6K0aIestB9CYSM4UzrI8FtGD
         wrL9aLZSVNzGbPy4K7lLZuyMlkPipMBInVtEe7jsCatuVLre6Xrp2Y/g8yx34HEKs/lr
         qwzG76OJAX/yDmssbzMcwNRRM7usHDp6Gl+LD52wZ5kiD0U2ZUDpKil0PiTs5jZyV+qm
         TBd9TGdOBg0OENlgPyuqpi3CCUrFPyGyr5VmZ+TyAO8kEck2UuC16UrGGvfdArlrQFQs
         dKa7Dml3ATHpllZN5J00JbDKYmzH9l4YqLo6MmXFo7r1JwnqR7bEJFZk9+IAEl3BlqEM
         1fCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778836247; x=1779441047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGpXS0DEPBrEJ67yIQ4gTPv2lm5TnhViA0o5Zx+53Ds=;
        b=B53tXIrQ/EvL7aoVq8aOVjupz1enuoisq2FrWMHWVaz5b58Idd5e6mQ3s0JLUvUnc5
         eE6Ta1JDs0WurBTaCkAOcl/hNnBlNYKxDNX6PTvSYS1UAL8vv12w3Q1UZoPeu//iUHjz
         tF5B0ssZ8VJI2msuhN2cArN2lGfvAjEMAL2auWuTb8hhDp4r4ezAs0ZF88gq9GMApCJD
         Joc5PTBp/501mXWGZ17stXSYauZil1twQaJpbeqB1IiONXHYwYob4RsDrMTf0uGXshLc
         u3g1pzvzFiByL5tyL34DzGT9PCscD1qxk0VzPL44ZXGb4UGx7WixQlRARoFPDXuqSJzg
         CS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778836247; x=1779441047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGpXS0DEPBrEJ67yIQ4gTPv2lm5TnhViA0o5Zx+53Ds=;
        b=agrr4fa9jSvz1caMghJlrvvRXPmfUBhewqcXXp8mq3uR/7lou5La2Sbljb+RrH6c0U
         +w/T/74z2Y8e0YiSBON6wUVCWY7lN76PQfGbvtHAlMoYmcCocpQnKTIlGkZX1xjDq2Gr
         +BbTMXCpbR1mNz12DAMMNdZEIylzFnFppecQzAIJsNVxVDj+pinoyONF3cZQu1U/VRe9
         veG2l2JQBgfuwCQ+lflt6HWSUQU2dejVeaIceblA15+AAg38C6tCdevT8m5/rR5sySi5
         aPMI+PcCHo1m/X7cCPi50CM5QE+p6PtCpAAmWdrsFJf9vw2g3SUH1diRIQYF2hlQmzem
         hfVA==
X-Forwarded-Encrypted: i=1; AFNElJ/6PF216YPWy4UjA4DNjPojejkb0nHj9aYR2Fc+7aa6ddAXOH3Cw1SwaB5c0/xBerLD1zT1O4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YydvBQSoh5/O9Oqr+5iNkmVcqVPwe+Tquyrlz6b+RPO0xB7sT9f
	uqs9i4v8hKL1xyIFlPVWIrkrnvuqw0thcLWzRiT40SrsoXKzTAb7C8R8xJHkSrP6FG/A+WC7LS6
	sKetCaO7YLLqmTrLR/j8HHxnw3+ZY67s=
X-Gm-Gg: Acq92OE9RzVhIf9IfNj9E418F8d61J4qT31cwQUgf25WPGudzDBrPDQQQHjVjsaREPc
	TycIVYxELsXDThIlNERqtKmU4mPGsTXeeWhmdlaQqU6m/AV2KsRWrIEZeYntdOGOONHt7MTByWl
	oLHRmkQxfdGWKw7KydkFAeVkRF97neQnJU5O9Hsjweix7A+R9gAWV3W2yuFNN+36vtzDrBwJ/9L
	K2ET1XepS2N9t/wIFgMIhnU8h9yzg48Dh3s5t4oAbZ0SMHaA8KxK186C/v1u75oWx4Ner7DXghi
	gr4zutGB7x+PvXqED6E=
X-Received: by 2002:a2e:9f07:0:b0:395:2467:9e74 with SMTP id
 38308e7fff4ca-39561f200b5mr6525051fa.14.1778836247092; Fri, 15 May 2026
 02:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515050437.104716-1-rollkingzzc@gmail.com>
 <e0a24b78-9800-4927-b611-ccbad1e906fe@linux.dev> <CAB7XQsEJDoZHUznSYE3v1DadVXGWP7J21rS4Q=BuMr_jV9tX_w@mail.gmail.com>
 <c5fadf42-583c-4e8c-8484-46781a0581b2@linux.dev> <4a96c17d-0024-4ddb-99b1-c8475b7b95e1@linux.dev>
In-Reply-To: <4a96c17d-0024-4ddb-99b1-c8475b7b95e1@linux.dev>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Fri, 15 May 2026 17:10:34 +0800
X-Gm-Features: AVHnY4Kqf-RaKHaEmq-c6zaAUxtM41v21dedcRhT71xkg4LL308eRg_RDAb4Fvw
Message-ID: <CAB7XQsH1Fxm0CCacsy8Qb44tWavpMrCRDXNibxYo97GKQn8ZRA@mail.gmail.com>
Subject: Re: [PATCH] net: skmsg: pin the delayed-work psock in sk_psock_backlog
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AE5A954C6C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288254-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Jiayuan,

Thanks, understood. I will treat any follow-up submission as bpf, not
net, and I will not send a new patch revision just for this reproducer
information. I will also carry this Fixes tag in the next formal patch:

  Fixes: 8259eb0e06d8 ("bpf, sockmap: Avoid using sk_socket after free
when sending")

On the ordering question: moving the TX_ENABLED clear before clearing
sk_user_data would close the window for workers which enter
sk_psock_backlog() after teardown has started, but I do not think it is
sufficient for the interleaving reproduced below.

The backlog worker tests TX_ENABLED before it calls sk_psock_get():

  if (!sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
          return;

  if (!sk_psock_get(psock->sk))
          return;

That test is not serialized with sk_psock_stop()'s ingress_lock. A worker
can pass the TX_ENABLED test and then be preempted before
sk_psock_get(psock->sk). If teardown clears TX_ENABLED after that point,
then clears sk_user_data, and a new attach publishes a replacement psock,
the old worker still calls sk_psock_get(psock->sk) and can pin the
replacement while continuing to process the old delayed-work psock. The
instrumentation below parks the worker exactly in that window: after the
TX_ENABLED test and before sk_psock_get(psock->sk). So a pure ordering
change in sk_psock_drop() would not affect the worker once it has already
passed the initial TX_ENABLED test.

Below are the two local patches I used for the reproducer, against
917719c41. The first patch only adds the debugfs gate/counters and
logging around the existing skmsg paths. It does not publish a replacement
psock, does not clear sk_user_data, and does not add an extra put. The
second patch adds a one-shot sockmap_redir selftest path which creates
AF_UNIX SOCK_STREAM socket pairs, redirects one byte to the destination
sockmap entry, waits until the old backlog worker is parked, deletes that
sockmap entry, reattaches the same destination fd with BPF_NOEXIST, and
then releases the parked worker. The PMB prefix in the diff is only the
local probe namespace.

I ran it as:

  make -C tools/testing/selftests/bpf LLVM=1 \
          OUTPUT=/tmp/bpf-out test_progs_sockmap_redir test_sockmap

  PMB_SOCKMAP_ONE_SHOT=1 \
  PMB_SOCKMAP_REDIR=sk_skb-to-ingress \
  PMB_SOCKMAP_FAMILY=u_str \
  PMB_SOCKMAP_MAP=sockmap \
  PMB_PSOCK_PHASE=pointer \
          /tmp/bpf-out/test_progs-sockmap_redir -vv

The warning came from the existing final put path in the old worker:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xbf/0xf0
  Workqueue: events sk_psock_backlog
  RIP: 0010:refcount_warn_saturate+0xbf/0xf0
  Call Trace:
    sk_psock_backlog+0xc8c/0x1ad0
    process_one_work+0x8b7/0x1af0
    worker_thread+0x574/0xf10
    kthread+0x2fc/0x3f0
    ret_from_fork+0x58b/0x830
    ret_from_fork_asm+0x1a/0x30

Thanks,
Zhang

--- 8< --- kernel instrumentation patch --- 8< ---
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6187a83bd..79d8769bb 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -4,12 +4,101 @@
 #include <linux/skmsg.h>
 #include <linux/skbuff.h>
 #include <linux/scatterlist.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/sock_diag.h>

 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
 #include <trace/events/sock.h>

+/* PMB_PSOCK_BACKLOG_GATE */
+static u32 pmb_psock_gate_enable;
+static u32 pmb_psock_gate_release;
+static u32 pmb_psock_gate_parked;
+static u32 pmb_psock_mismatch_seen;
+static u32 pmb_psock_get_seen;
+static u32 pmb_psock_last_old_ref;
+static u32 pmb_psock_last_old_ref_before_put;
+static u32 pmb_psock_last_old_tx;
+static u64 pmb_psock_last_cookie;
+static u64 pmb_psock_last_sk;
+static u64 pmb_psock_last_container;
+static u64 pmb_psock_last_current;
+static u64 pmb_psock_last_get;
+
+static void pmb_psock_probe_snapshot(struct sk_psock *container,
+      struct sk_psock *current_psock,
+      struct sk_psock *held)
+{
+ WRITE_ONCE(pmb_psock_last_cookie, sock_gen_cookie(container->sk));
+ WRITE_ONCE(pmb_psock_last_sk, (u64)(unsigned long)container->sk);
+ WRITE_ONCE(pmb_psock_last_container, (u64)(unsigned long)container);
+ WRITE_ONCE(pmb_psock_last_current, (u64)(unsigned long)current_psock);
+ WRITE_ONCE(pmb_psock_last_get, (u64)(unsigned long)held);
+ if (current_psock && current_psock != container)
+ WRITE_ONCE(pmb_psock_mismatch_seen, 1);
+ if (held && held != container)
+ WRITE_ONCE(pmb_psock_mismatch_seen, 1);
+}
+
+static void pmb_psock_maybe_gate(struct sk_psock *psock)
+{
+ unsigned long timeout = jiffies + msecs_to_jiffies(10000);
+
+ if (!READ_ONCE(pmb_psock_gate_enable) || psock->sk->sk_family != AF_UNIX)
+ return;
+
+ WRITE_ONCE(pmb_psock_gate_enable, 0);
+ WRITE_ONCE(pmb_psock_gate_parked, 1);
+ WRITE_ONCE(pmb_psock_last_cookie, sock_gen_cookie(psock->sk));
+ WRITE_ONCE(pmb_psock_last_sk, (u64)(unsigned long)psock->sk);
+ WRITE_ONCE(pmb_psock_last_container, (u64)(unsigned long)psock);
+ WRITE_ONCE(pmb_psock_last_old_ref, refcount_read(&psock->refcnt));
+ WRITE_ONCE(pmb_psock_last_old_tx,
+    sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED));
+ pr_info("PMB_PSOCK_BACKLOG_GATE park cookie=%llu sk=%px
container=%px old_tx=%u old_ref=%u\n",
+ (unsigned long long)READ_ONCE(pmb_psock_last_cookie),
+ psock->sk, psock, READ_ONCE(pmb_psock_last_old_tx),
+ READ_ONCE(pmb_psock_last_old_ref));
+
+ while (!READ_ONCE(pmb_psock_gate_release) && time_before(jiffies, timeout))
+ msleep(1);
+ pr_info("PMB_PSOCK_BACKLOG_GATE resume cookie=%llu sk=%px
container=%px released=%u timeout=%ld\n",
+ (unsigned long long)READ_ONCE(pmb_psock_last_cookie),
+ psock->sk, psock, READ_ONCE(pmb_psock_gate_release),
+ time_before(jiffies, timeout) ? 0L : 1L);
+}
+
+static int __init pmb_psock_probe_debugfs_init(void)
+{
+ struct dentry *dir;
+
+ dir = debugfs_create_dir("pmb_psock", NULL);
+ if (IS_ERR_OR_NULL(dir))
+ return 0;
+
+ debugfs_create_u32("gate_enable", 0600, dir, &pmb_psock_gate_enable);
+ debugfs_create_u32("gate_release", 0600, dir, &pmb_psock_gate_release);
+ debugfs_create_u32("gate_parked", 0600, dir, &pmb_psock_gate_parked);
+ debugfs_create_u32("mismatch_seen", 0600, dir, &pmb_psock_mismatch_seen);
+ debugfs_create_u32("get_seen", 0600, dir, &pmb_psock_get_seen);
+ debugfs_create_u32("last_old_ref", 0600, dir, &pmb_psock_last_old_ref);
+ debugfs_create_u32("last_old_ref_before_put", 0600, dir,
+    &pmb_psock_last_old_ref_before_put);
+ debugfs_create_u32("last_old_tx", 0600, dir, &pmb_psock_last_old_tx);
+ debugfs_create_x64("last_cookie", 0600, dir, &pmb_psock_last_cookie);
+ debugfs_create_x64("last_sk", 0600, dir, &pmb_psock_last_sk);
+ debugfs_create_x64("last_container", 0600, dir, &pmb_psock_last_container);
+ debugfs_create_x64("last_current", 0600, dir, &pmb_psock_last_current);
+ debugfs_create_x64("last_get", 0600, dir, &pmb_psock_last_get);
+ return 0;
+}
+late_initcall(pmb_psock_probe_debugfs_init);
+
 static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 {
  if (msg->sg.end > msg->sg.start &&
@@ -671,6 +760,8 @@ static void sk_psock_backlog(struct work_struct *work)
 {
  struct delayed_work *dwork = to_delayed_work(work);
  struct sk_psock *psock = container_of(dwork, struct sk_psock, work);
+ struct sk_psock *current_psock;
+ struct sk_psock *held_psock;
  struct sk_psock_work_state *state = &psock->work_state;
  struct sk_buff *skb = NULL;
  u32 len = 0, off = 0;
@@ -684,13 +775,35 @@ static void sk_psock_backlog(struct work_struct *work)
  if (!sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
  return;

+ pmb_psock_maybe_gate(psock);
+ rcu_read_lock();
+ current_psock = sk_psock(psock->sk);
+ rcu_read_unlock();
+ WRITE_ONCE(pmb_psock_last_old_ref, refcount_read(&psock->refcnt));
+ WRITE_ONCE(pmb_psock_last_old_tx,
+    sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED));
+ pmb_psock_probe_snapshot(psock, current_psock, NULL);
+ pr_info("PMB_PSOCK_BACKLOG_RESUME cookie=%llu sk=%px container=%px
current=%px old_tx=%u old_ref=%u mismatch=%u\n",
+ (unsigned long long)READ_ONCE(pmb_psock_last_cookie),
+ psock->sk, psock, current_psock,
+ READ_ONCE(pmb_psock_last_old_tx),
+ READ_ONCE(pmb_psock_last_old_ref),
+ READ_ONCE(pmb_psock_mismatch_seen));
+
  /* Increment the psock refcnt to synchronize with close(fd) path in
  * sock_map_close(), ensuring we wait for backlog thread completion
  * before sk_socket freed. If refcnt increment fails, it indicates
  * sock_map_close() completed with sk_socket potentially already freed.
  */
- if (!sk_psock_get(psock->sk))
+ held_psock = sk_psock_get(psock->sk);
+ if (!held_psock)
  return;
+ WRITE_ONCE(pmb_psock_get_seen, 1);
+ pmb_psock_probe_snapshot(psock, current_psock, held_psock);
+ pr_info("PMB_PSOCK_BACKLOG_GET cookie=%llu sk=%px container=%px
held=%px mismatch=%u\n",
+ (unsigned long long)READ_ONCE(pmb_psock_last_cookie),
+ psock->sk, psock, held_psock, READ_ONCE(pmb_psock_mismatch_seen));
+
  mutex_lock(&psock->work_mutex);
  while ((skb = skb_peek(&psock->ingress_skb))) {
  len = skb->len;
@@ -743,6 +856,11 @@ static void sk_psock_backlog(struct work_struct *work)
  }
 end:
  mutex_unlock(&psock->work_mutex);
+ WRITE_ONCE(pmb_psock_last_old_ref_before_put, refcount_read(&psock->refcnt));
+ pr_info("PMB_PSOCK_BACKLOG_PUT cookie=%llu sk=%px container=%px
held=%px ref_before_put=%u\n",
+ (unsigned long long)READ_ONCE(pmb_psock_last_cookie),
+ psock->sk, psock, held_psock,
+ READ_ONCE(pmb_psock_last_old_ref_before_put));
  sk_psock_put(psock->sk, psock);
 }

@@ -789,10 +907,15 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)

  sk_psock_set_state(psock, SK_PSOCK_TX_ENABLED);
  refcount_set(&psock->refcnt, 1);
+ pr_info("PMB_PSOCK_INIT_TRACE alloc cookie=%llu sk=%px psock=%px ref=%d\n",
+ (unsigned long long)sock_gen_cookie(sk), sk, psock,
+ refcount_read(&psock->refcnt));

  __rcu_assign_sk_user_data_with_flags(sk, psock,
       SK_USER_DATA_NOCOPY |
       SK_USER_DATA_PSOCK);
+ pr_info("PMB_PSOCK_INIT_TRACE publish cookie=%llu sk=%px psock=%px\n",
+ (unsigned long long)sock_gen_cookie(sk), sk, psock);
  sock_hold(sk);

 out:
@@ -890,12 +1013,20 @@ void sk_psock_drop(struct sock *sk, struct
sk_psock *psock)
  write_lock_bh(&sk->sk_callback_lock);
  sk_psock_restore_proto(sk, psock);
  rcu_assign_sk_user_data(sk, NULL);
+ pr_info("PMB_PSOCK_DROP_TRACE clear cookie=%llu sk=%px psock=%px
ref=%d tx=%d\n",
+ (unsigned long long)sock_gen_cookie(sk), sk, psock,
+ refcount_read(&psock->refcnt),
+ sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED));
  if (psock->progs.stream_parser)
  sk_psock_stop_strp(sk, psock);
  else if (psock->progs.stream_verdict || psock->progs.skb_verdict)
  sk_psock_stop_verdict(sk, psock);
  write_unlock_bh(&sk->sk_callback_lock);

+ pr_info("PMB_PSOCK_DROP_TRACE stop cookie=%llu sk=%px psock=%px
ref=%d tx=%d\n",
+ (unsigned long long)sock_gen_cookie(sk), sk, psock,
+ refcount_read(&psock->refcnt),
+ sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED));
  sk_psock_stop(psock);

  INIT_RCU_WORK(&psock->rwork, sk_psock_destroy);

--- 8< --- userspace selftest patch --- 8< ---
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
index 9c461d931..ebaf5cf21 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
@@ -22,14 +22,17 @@

 #include <errno.h>
 #include <error.h>
+#include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <unistd.h>

 #include <netinet/in.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/un.h>
+#include <sys/wait.h>
 #include <linux/string.h>
 #include <linux/vm_sockets.h>

@@ -108,6 +111,9 @@ struct socket_spec {
  int out[2];
 };

+#define PMB_PSOCK_DEBUGFS "/sys/kernel/debug/pmb_psock"
+#define PMB_PSOCK_POLL_TIMEOUT_MS 5000
+
 static int socket_spec_pairs(struct socket_spec *s)
 {
  return create_socket_pairs(s->family, s->sotype,
@@ -123,6 +129,373 @@ static void socket_spec_close(struct socket_spec *s)
  xclose(s->out[1]);
 }

+static bool pmb_sockmap_one_shot_enabled(void)
+{
+ const char *value = getenv("PMB_SOCKMAP_ONE_SHOT");
+
+ return value && strcmp(value, "0");
+}
+
+static int pmb_probe_path(char *path, size_t path_len, const char *name)
+{
+ int len;
+
+ len = snprintf(path, path_len, PMB_PSOCK_DEBUGFS "/%s", name);
+ if (len < 0 || len >= path_len)
+ return -ENAMETOOLONG;
+ return 0;
+}
+
+static int pmb_write_text(const char *name, const char *value)
+{
+ char path[256];
+ ssize_t len = strlen(value);
+ int fd, err;
+
+ err = pmb_probe_path(path, sizeof(path), name);
+ if (err)
+ return err;
+
+ fd = open(path, O_WRONLY | O_CLOEXEC);
+ if (fd < 0)
+ return -errno;
+
+ err = 0;
+ if (write(fd, value, len) != len)
+ err = errno ? -errno : -EIO;
+ close(fd);
+ return err;
+}
+
+static int pmb_write_u64(const char *name, unsigned long long value)
+{
+ char buf[32];
+
+ snprintf(buf, sizeof(buf), "%llu\n", value);
+ return pmb_write_text(name, buf);
+}
+
+static int pmb_read_u64(const char *name, unsigned long long *value)
+{
+ char path[256], buf[64], *end;
+ int fd, err;
+ ssize_t n;
+
+ err = pmb_probe_path(path, sizeof(path), name);
+ if (err)
+ return err;
+
+ fd = open(path, O_RDONLY | O_CLOEXEC);
+ if (fd < 0)
+ return -errno;
+
+ n = read(fd, buf, sizeof(buf) - 1);
+ err = n < 0 ? -errno : 0;
+ close(fd);
+ if (err)
+ return err;
+ if (n <= 0)
+ return -EIO;
+
+ buf[n] = '\0';
+ errno = 0;
+ *value = strtoull(buf, &end, 0);
+ if (errno)
+ return -errno;
+ return 0;
+}
+
+static int pmb_wait_u64(const char *name, unsigned long long expected,
+ unsigned int timeout_ms)
+{
+ unsigned int waited;
+ unsigned long long value;
+ int err;
+
+ for (waited = 0; waited < timeout_ms; waited++) {
+ err = pmb_read_u64(name, &value);
+ if (err)
+ return err;
+ if (value == expected)
+ return 0;
+ usleep(1000);
+ }
+
+ return -ETIMEDOUT;
+}
+
+static int pmb_wait_u64_nonzero(const char *name, unsigned int timeout_ms)
+{
+ unsigned int waited;
+ unsigned long long value;
+ int err;
+
+ for (waited = 0; waited < timeout_ms; waited++) {
+ err = pmb_read_u64(name, &value);
+ if (err)
+ return err;
+ if (value)
+ return 0;
+ usleep(1000);
+ }
+
+ return -ETIMEDOUT;
+}
+
+static int pmb_reset_probe_state(void)
+{
+ int err;
+
+ err = pmb_write_u64("gate_enable", 0);
+ if (err)
+ return err;
+ err = pmb_write_u64("gate_release", 0);
+ if (err)
+ return err;
+ err = pmb_write_u64("gate_parked", 0);
+ if (err)
+ return err;
+ err = pmb_write_u64("mismatch_seen", 0);
+ if (err)
+ return err;
+ err = pmb_write_u64("get_seen", 0);
+ if (err)
+ return err;
+ err = pmb_write_u64("last_old_ref", 0);
+ if (err)
+ return err;
+ err = pmb_write_u64("last_old_ref_before_put", 0);
+ if (err)
+ return err;
+ err = pmb_write_u64("last_old_tx", 0);
+ if (err)
+ return err;
+ err = pmb_write_u64("last_cookie", 0);
+ if (err)
+ return err;
+ err = pmb_write_u64("last_sk", 0);
+ if (err)
+ return err;
+ err = pmb_write_u64("last_container", 0);
+ if (err)
+ return err;
+ err = pmb_write_u64("last_current", 0);
+ if (err)
+ return err;
+ return pmb_write_u64("last_get", 0);
+}
+
+static int pmb_retry_reattach(int map_fd, __u32 key, int sock_fd)
+{
+ unsigned int attempt;
+ __u64 value = sock_fd;
+
+ for (attempt = 0; attempt < 200000; attempt++) {
+ if (!bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST))
+ return 0;
+ if (errno != EEXIST && errno != EBUSY)
+ return -errno;
+ sched_yield();
+ }
+
+ return -ETIMEDOUT;
+}
+
+static int pmb_wait_child_ok(pid_t pid)
+{
+ int status;
+
+ if (waitpid(pid, &status, 0) < 0)
+ return -errno;
+ if (!WIFEXITED(status) || WEXITSTATUS(status))
+ return -EINVAL;
+ return 0;
+}
+
+/* PMB_SOCKMAP_ONE_SHOT */
+static void pmb_test_sockmap_one_shot(void)
+{
+ struct redir_spec redir = {
+ .name = "sk_skb-to-ingress",
+ .idx_send = SEND_OUTER,
+ .idx_recv = RECV_INNER,
+ .prog_type = SK_SKB_INGRESS,
+ };
+ struct socket_spec s = {
+ .family = AF_UNIX,
+ .sotype = SOCK_STREAM,
+ };
+ struct test_sockmap_redir *skel = NULL;
+ enum bpf_attach_type attach_type;
+ const char *phase = getenv("PMB_PSOCK_PHASE");
+ const char *map_name = getenv("PMB_SOCKMAP_MAP");
+ const char *family = getenv("PMB_SOCKMAP_FAMILY");
+ const char *redir_name = getenv("PMB_SOCKMAP_REDIR");
+ struct maps maps = {};
+ unsigned long long mismatch = 0, container = 0, current = 0, held = 0;
+ unsigned long long ref_before_put = 0;
+ bool sockets_ready = false, attached = false;
+ pid_t delete_pid = -1;
+ __u32 key = 0;
+ __u64 value;
+ char send_buf = 'A';
+ int fd_in, fd_out, fd_send;
+ int prog_fd, err;
+ ssize_t n;
+
+ if (!test__start_subtest("pmb_sockmap_one_shot"))
+ return;
+
+ if (access(PMB_PSOCK_DEBUGFS "/gate_enable", F_OK)) {
+ FAIL_ERRNO("missing %s", PMB_PSOCK_DEBUGFS);
+ return;
+ }
+
+ if (!map_name || strcmp(map_name, "sockmap") ||
+     !family || strcmp(family, "u_str") ||
+     !redir_name || strcmp(redir_name, "sk_skb-to-ingress")) {
+ FAIL("unexpected PMB one-shot contract");
+ return;
+ }
+
+ skel = test_sockmap_redir__open_and_load();
+ if (!ASSERT_OK_PTR(skel, "open_and_load"))
+ goto done;
+
+ maps.in = bpf_map__fd(skel->maps.nop_map);
+ maps.out = bpf_map__fd(skel->maps.sock_map);
+ maps.verd = bpf_map__fd(skel->maps.verdict_map);
+ skel->bss->redirect_type = BPF_MAP_TYPE_SOCKMAP;
+
+ get_redir_params(&redir, skel, &prog_fd, &attach_type,
+ &skel->bss->redirect_flags);
+ err = xbpf_prog_attach(prog_fd, maps.in, attach_type, 0);
+ if (!ASSERT_OK(err, "bpf_prog_attach"))
+ goto done;
+ attached = true;
+
+ err = socket_spec_pairs(&s);
+ if (!ASSERT_OK(err, "create_socket_pairs()"))
+ goto detach;
+ sockets_ready = true;
+
+ fd_in = s.in[0];
+ fd_send = s.in[1];
+ fd_out = s.out[0];
+
+ err = pmb_reset_probe_state();
+ if (!ASSERT_OK(err, "pmb_reset_probe_state"))
+ goto cleanup_sockets;
+ err = pmb_write_u64("gate_enable", 1);
+ if (!ASSERT_OK(err, "gate_enable"))
+ goto cleanup_sockets;
+
+ value = fd_in;
+ err = bpf_map_update_elem(maps.in, &key, &value, BPF_NOEXIST);
+ if (!ASSERT_OK(err, "bpf_map_update_elem(in)"))
+ goto cleanup_gate;
+
+ value = fd_out;
+ err = bpf_map_update_elem(maps.out, &key, &value, BPF_NOEXIST);
+ if (!ASSERT_OK(err, "bpf_map_update_elem(out)"))
+ goto cleanup_maps;
+
+ n = send(fd_send, &send_buf, 1, 0);
+ if (n != 1) {
+ FAIL_ERRNO("send");
+ goto cleanup_maps;
+ }
+
+ err = pmb_wait_u64("gate_parked", 1, PMB_PSOCK_POLL_TIMEOUT_MS);
+ if (!ASSERT_OK(err, "wait_gate_parked"))
+ goto cleanup_maps;
+
+ delete_pid = fork();
+ if (!ASSERT_GE(delete_pid, 0, "fork_delete"))
+ goto cleanup_maps;
+ if (!delete_pid) {
+ err = bpf_map_delete_elem(maps.out, &key);
+ _exit(err ? 1 : 0);
+ }
+
+ err = pmb_retry_reattach(maps.out, key, fd_out);
+ if (!ASSERT_OK(err, "reattach_out"))
+ goto wait_child;
+
+ err = pmb_wait_child_ok(delete_pid);
+ delete_pid = -1;
+ if (!ASSERT_OK(err, "delete_out"))
+ goto cleanup_maps;
+
+ err = pmb_write_u64("gate_release", 1);
+ if (!ASSERT_OK(err, "gate_release"))
+ goto cleanup_maps;
+
+ err = pmb_wait_u64_nonzero("last_get", PMB_PSOCK_POLL_TIMEOUT_MS);
+ if (!ASSERT_OK(err, "wait_last_get"))
+ goto cleanup_maps;
+
+ err = pmb_read_u64("mismatch_seen", &mismatch);
+ if (!ASSERT_OK(err, "read_mismatch_seen"))
+ goto cleanup_maps;
+ err = pmb_read_u64("last_container", &container);
+ if (!ASSERT_OK(err, "read_last_container"))
+ goto cleanup_maps;
+ err = pmb_read_u64("last_current", &current);
+ if (!ASSERT_OK(err, "read_last_current"))
+ goto cleanup_maps;
+ err = pmb_read_u64("last_get", &held);
+ if (!ASSERT_OK(err, "read_last_get"))
+ goto cleanup_maps;
+ err = pmb_read_u64("last_old_ref_before_put", &ref_before_put);
+ if (!ASSERT_OK(err, "read_last_old_ref_before_put"))
+ goto cleanup_maps;
+
+ fprintf(stderr,
+ "PMB_SOCKMAP_ONE_SHOT phase=%s container=0x%llx current=0x%llx
held=0x%llx ref_before_put=%llu\n",
+ phase ? phase : "pointer", container, current, held,
+ ref_before_put);
+
+ if (!ASSERT_EQ(mismatch, 1, "mismatch_seen"))
+ goto cleanup_maps;
+ if (!ASSERT_NEQ(container, 0, "container_nonzero"))
+ goto cleanup_maps;
+ if (!ASSERT_NEQ(current, 0, "current_nonzero"))
+ goto cleanup_maps;
+ if (!ASSERT_NEQ(held, 0, "held_nonzero"))
+ goto cleanup_maps;
+ if (!ASSERT_NEQ(container, current, "container_vs_current"))
+ goto cleanup_maps;
+ if (!ASSERT_NEQ(container, held, "container_vs_held"))
+ goto cleanup_maps;
+ if (phase && !strcmp(phase, "refcount") &&
+     !ASSERT_EQ(ref_before_put, 0, "old_ref_before_put"))
+ goto cleanup_maps;
+
+wait_child:
+ if (delete_pid > 0) {
+ err = pmb_wait_child_ok(delete_pid);
+ delete_pid = -1;
+ ASSERT_OK(err, "delete_out_wait");
+ }
+
+cleanup_maps:
+ bpf_map_delete_elem(maps.out, &key);
+ bpf_map_delete_elem(maps.in, &key);
+cleanup_gate:
+ pmb_write_u64("gate_enable", 0);
+ pmb_write_u64("gate_release", 1);
+cleanup_sockets:
+ if (sockets_ready)
+ socket_spec_close(&s);
+detach:
+ if (attached)
+ xbpf_prog_detach2(prog_fd, maps.in, attach_type);
+done:
+ if (skel)
+ test_sockmap_redir__destroy(skel);
+}
+
 static void get_redir_params(struct redir_spec *redir,
       struct test_sockmap_redir *skel, int *prog_fd,
       enum bpf_attach_type *attach_type,
@@ -460,6 +833,11 @@ static void test_map(enum bpf_map_type type)

 void serial_test_sockmap_redir(void)
 {
+ if (pmb_sockmap_one_shot_enabled()) {
+ pmb_test_sockmap_one_shot();
+ return;
+ }
+
  test_map(BPF_MAP_TYPE_SOCKMAP);
  test_map(BPF_MAP_TYPE_SOCKHASH);
 }

