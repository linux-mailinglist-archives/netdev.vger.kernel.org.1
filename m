Return-Path: <netdev+bounces-288219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBfTLizWBmomoQIAu9opvQ
	(envelope-from <netdev+bounces-288219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:15:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A75554B254
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8E023082116
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4F43FADE8;
	Fri, 15 May 2026 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1usW8D6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EE53FA5CF
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832793; cv=pass; b=MRtdS2WsQHQII/ZjNvsW1juLXLMb7BIOlvEqDcOzc4xqDenkLhcIPZNvXN+saKbFoyQooTmnjR0XUVM5wxo7XKUIuT5X6NYXjM12lUDuVgQBn/Lu8j7Z0UwbpqThBmT4erYXakP6gfKv/xLNNt9x+OanXjy7nh9mK2ANCeE3zLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832793; c=relaxed/simple;
	bh=WZojfUbXd3wS4TVRo6hSiQiW7Yxrt5hOcaPdrieI9Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1Wwjf4qkh9+xKPAODJZvnCvYUaUp40rUauPGEODyU9hCzbe7oCPne6uWnqd0PLSUKMy3FZYHctrk4trJW/EpB35NfVW/xFT7jlK8olXfgLxnbjYgWlaUG3T3+Hu2f2cH4i4sJ3TOLzOP4VWW6nsloAmOSUPXte2pMIjultfv+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1usW8D6; arc=pass smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-38be5e86918so109581511fa.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778832790; cv=none;
        d=google.com; s=arc-20240605;
        b=d3JXJ+kjk56r2x1oyUWjOChoJLNRtlegYqcooQsTlfpdPTldddvQuQxiw8EAgW9XRb
         lKbU92g8P/yeXpHSX7dQ7obUsT+ivhZ2zbtUvEhhyParnZtZw1Ih4fN3wl7YYy5bveuo
         RF+wSuz6/2pVFRSOeZdJXehmldsKv1Ta9y/qia7BOz++P6neTkluqsFNmeyzmG9IvHm7
         J3X/ddS1qiZJtQnafFPk+8DJg1vat3zaWBduFFZdIqo8GWFJx2+eq3NJ0Uv8bvu4NPop
         dmgV6ErVy5LIcMFXdHZJpGTQm5l5FsAsvZ/K8jWZ+vzv2+X8qYOAWoN7vepPF1q5f/cJ
         DVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a4JAmq7jALYWdvpg4Mui88YmjXY6uXYwFxPs/+Z4xyc=;
        fh=PJrzzZNg2cbjN2488YkO4hVvySGOpHTRYNsuy/zt4MY=;
        b=NgtdDBCVob2KCvIY6f5tZacHouQ/qFTzNuWH5jJIwPcHYWskPuw291Q3Enh7JbtY4/
         bV4X7Tsj3ZQ8Ai92RkpgkLbL2HmyXzzhMvH/vrU9e/GZ007eBfrYMYMDNbDwcG1kY5pG
         F6frRbyL46mb9j1PHOSGsgdBzHYHvhkM3i7wT5AHmM+nHGcaFUTOCYiN8ur90BfolfUg
         rwyxTye00VzeaB+g6YdbYsazovoiyvkRmSb37sTw+RK4z4DWdAgxkC++fjl2aCev8kM2
         TXksMEPHzkNsOMHWooAPj9JGfA79x5YXlPKXxgfbQh/JZZRQ6+Lknf+kyeS7xUVK6bQI
         Henw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778832790; x=1779437590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4JAmq7jALYWdvpg4Mui88YmjXY6uXYwFxPs/+Z4xyc=;
        b=P1usW8D6DVVsjF+Bzq/VQjg3qsR4oAR6lAinDy08ATFV3PSqJAM0QZYy5ivG7mg0vD
         l7br1jZNzxnSdU2h7sFQS2n2OMODzKHOdq0yLIoEIYmrA57RDWOs5B61V7yeiY1x26HI
         b7oP5ufuomQ1RP2D8xjAZazZqtNt/xIU44Uhlxl2cBgM5WqsnKuCwptG60Sv8DWfeEVJ
         b9wb/qEF3gjG+R+wiLEEycDSj0GPn7gqdMfrHF8g0qUXcrCiJ+MzuEmH2cQ4pAygngqe
         5qWKUmst9wtA7L1DANLA7yrLOrLCBNiZrH089U4QAN1wcaJyBd1H/Pv7OShB3iunszAs
         48zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778832790; x=1779437590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a4JAmq7jALYWdvpg4Mui88YmjXY6uXYwFxPs/+Z4xyc=;
        b=qD7jHuHpZGpg8bV+4d11z7ItOEFjECcgJDoOWu5QgJrj6W8kaEIFlS+mUwkdZOZ+fc
         VPQPE21JE2eDolaJDnGCHJneBJzSJ5XPYpU3clDlDRFD53uChHccOzw8r6pTf9o1dFSQ
         ul0tJt8egJCCJrHqnt7S7ooNbliGUc9r7nBAxjDne9vJ5LWa3Xj6xdOLMkvir2IbbFwb
         /EZpMr/VTXyyiX9xxdX1QRz3UwRbp7zwWUFg/ax0exGu+eESp54HoOuwrDf2l6OIgsN7
         9DqEbI7O5XZ1ljfL8H2yK+L0ObBAvr4dkKQGoKmyodwDTPkX2yCUmRN+GGrN5B/eE1RQ
         5SIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+99pVR2V57/TAkGgEKPPRO1DRAYYCHJda0SZDN8g49uWKl9Njs5LSY6ym5jzX1T3Q/wXRQ/wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRU9UEQxXpatYrbE/WQW5N4/zCOPmHH0lgJ0Db6UwA1AjV/DZe
	v2zGwczwTcet759WHlk5naHzN1aeHxNvt+4xuK1qGWWd4mUGz1ChKxlGpFjiHuuVmPWMMwkt1lh
	3vuw2fDi0erJ17FW1q+0WeDvpUPQKytg=
X-Gm-Gg: Acq92OHIOOj20d/XwEv6qQbGz6JJGh1L5LeHDx9RcNCdJt/ZUrYxzVMdIJIfjCvWXLt
	HGWwByjtp5vYV08BOugDtk8CNoyC4OucGNhu0QmO/ron0P6DIQmo2e6qdaq6mThp6gVkQ36Zqul
	gHcj3GdQrFLEF9LwVd85ow6+JupI+VscA8vgUVvfezXIBxGfeH+761qo/ehusmMvrH+pFvhbw9j
	M6ZDQtG1LRTc5QhGIvdwtqLEzEjtwnQaSa7zTkH7OpfSZBF5wwpcfmtiWAt51/Pvry9kfcxBHfL
	gp0DcW7yzcusip097VtR301iNI++Wg==
X-Received: by 2002:ac2:4845:0:b0:5aa:123d:b755 with SMTP id
 2adb3069b0e04-5aa123db7f4mr324589e87.28.1778832789745; Fri, 15 May 2026
 01:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515050437.104716-1-rollkingzzc@gmail.com> <e0a24b78-9800-4927-b611-ccbad1e906fe@linux.dev>
In-Reply-To: <e0a24b78-9800-4927-b611-ccbad1e906fe@linux.dev>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Fri, 15 May 2026 16:12:56 +0800
X-Gm-Features: AVHnY4LR9n2-Ae_qI7oLykis3AKXqA3FEb14WmP1plDNUNwyVA_AWuBsLTL_fJE
Message-ID: <CAB7XQsEJDoZHUznSYE3v1DadVXGWP7J21rS4Q=BuMr_jV9tX_w@mail.gmail.com>
Subject: Re: [PATCH] net: skmsg: pin the delayed-work psock in sk_psock_backlog
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3A75554B254
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288219-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Action: no action

Dear Jiayuan Chen

Jiayuan Chen <jiayuan.chen@linux.dev> =E4=BA=8E2026=E5=B9=B45=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=94 14:10=E5=86=99=E9=81=93=EF=BC=9A
> Where is the 'last_old_ref_before_put' symbol from? I can't find it
> anywhere in the tree.
>
> If you are using LLMs to dig into races like this, please also have them
> produce a reproducer, e.g. patch mdelay() into
>
> the relevant windows to widen them, then trigger it from userspace.
>
>

Hi Jiayuan,

Thanks for checking this. You are right: last_old_ref_before_put is
not an in-tree kernel symbol. It was a temporary validation probe
label which recorded the old psock refcount immediately before the
backlog worker's final put, and it should not have appeared in the
commit message as if it were kernel output.

The in-tree path I was trying to describe is:

  sk_psock_backlog() starts at net/core/skmsg.c:670.
  get path: sk_psock_get(psock->sk), net/core/skmsg.c:692.
  put path: sk_psock_put(psock->sk, psock), net/core/skmsg.c:746.
  detach clears sk_user_data at net/core/skmsg.c:892.
  reattach publishes a replacement psock at net/core/skmsg.c:793.
  warning path: REFCOUNT_SUB_UAF at lib/refcount.c:28.

The trigger was based on the in-tree sockmap_redir BPF selftest
under tools/testing/selftests/bpf/prog_tests/.
The one-shot test used AF_UNIX SOCK_STREAM socket pairs, attached
the sk_skb verdict program to the input map, inserted one socket
into the input map and one destination socket into the sockmap at
key 0, then sent one byte through the input peer so the destination
psock backlog worker was queued.
For validation I used a temporary local instrumentation patch in
net/core/skmsg.c. It added a debugfs-controlled gate in
sk_psock_backlog() after the TX-enabled check and before the
existing sk_psock_get(psock->sk) call, plus counters and pr_info()
snapshots in sk_psock_backlog(), sk_psock_init() and
sk_psock_drop(). It also stored the pointer returned by
sk_psock_get(psock->sk) for logging. The worker still used the
existing get path and the existing sk_psock_put(psock->sk, psock)
exit path.
With the worker parked before sk_psock_get(psock->sk), the test
forked: the child deleted the destination sockmap entry, and the
parent retried BPF_NOEXIST update of the same key with the same
destination socket fd until reattach succeeded.
After the delete completed, the test released the old worker. At
that point sk->sk_user_data referred to the replacement psock, while
the delayed work still belonged to the old psock. The recorded state
before the warning had the sk_user_data psock and the psock returned
by sk_psock_get(psock->sk) equal to each other, but different from
the delayed-work container. The instrumentation was only used to make
that interleaving deterministic and observable. The warning below is
the kernel's normal refcount warning path.

The native kernel report from that run was:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xbf/0xf0
  Workqueue: events sk_psock_backlog
  RIP: 0010:refcount_warn_saturate+0xbf/0xf0
  Call trace:
    sk_psock_backlog() (net/core/skmsg.c:670)
    process_one_work() (kernel/workqueue.c:3200)

So the reproducer is instrumentation-assisted, not an
unmodified upstream selftest. The instrumentation can widen the
race window and record the participating psock pointers, but it
does not publish a replacement psock, clear sk->sk_user_data, or
add an extra put on the old psock. The final warning is reached
through the existing sk_psock_put(psock->sk, psock) path after
the test has forced delete-plus-reattach to happen before the
parked worker resumes.

I will send v2 as a new thread after the netdev 24-hour
interval, with the lab probe label removed from the commit text.
If useful, I can also share the small instrumentation/selftest
diff separately to show the exact widened window.

Thanks,
Zhang Cen

