Return-Path: <netdev+bounces-299964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MPH1EZXCMWohpwUAu9opvQ
	(envelope-from <netdev+bounces-299964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:39:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E2C69571B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:39:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=u5pTg3lw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299964-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299964-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19935300C3AB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233FF33F583;
	Tue, 16 Jun 2026 21:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28B331EA5
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 21:39:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645968; cv=pass; b=MpUeIMA7DHj19eH5Nv1AVES8Y6O4i/bLbW6M09VBHn4k6WZzzUlWRdqA/Ne1Bpolnxk4MNj4v27rduAo6WFnU/gNhwItf6TlMNVCTFHY9AF13JutCgrg6PKZ46sSdqC5uNuEEFGxDIeSHLMwmeZXS4pY/5jPtu4fKQzKVhL83R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645968; c=relaxed/simple;
	bh=+G5nuspfqQS3ed5PD0TgH+/CQ3RbtR8jKlIRdj+ejWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maHPkqxJLV/rHNFFOITGwnLRHn3fxdr+wVOCZmz3VV6/zoCyakR5u9JKPCZudM6HcNC/FQbbc76YvhhgJBdvCNgmLm/gQ1QHWzFicJD2Kb3EGloGM8vDuK76b9KCzPIRuLWel660GURiFJSfny2wIn8evVvuQW8MmspZWTaigNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5pTg3lw; arc=pass smtp.client-ip=74.125.82.175
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-307263ad0cbso8062396eec.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781645966; cv=none;
        d=google.com; s=arc-20240605;
        b=Ue+Zjw9H66I5Wgnpta9DXLctBdlSSQIxBW6rxK2ZnzfZBs1ubU6xm2o9kAwRIkGV3w
         NIe+XgouJtt5dk0x6813rnv8jMjoV1R0wgrvM5wIRsIe2HymwpwlYJvi/TQNyVE4Gn4d
         6Wu1ZtR/nzDJrWDbYCFIZqZicTeHD/OXbSVx6XHnl3KSdJF209ESoNUpTeuPIoQUEQNj
         TP1sipQRIqYsHfJrYvpVgQS67GVJ+hPWj22khy3keslYd4Wymlhf1vb+fu/Sluc3cEjS
         /wKyIGzSdgrl8KYFBADg1FLBjtKIGLXyF9hVSibgSjl0NQS75++IipFAEcoaj3bFRwpn
         jVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+G5nuspfqQS3ed5PD0TgH+/CQ3RbtR8jKlIRdj+ejWo=;
        fh=BsD03xVt1upId+v1lJe1Sd/dL0JSEcqSJRKrORxH0zo=;
        b=L2Cj4A5Qsj8yr4ufvAGh0ajEZ9AHLAOUcvXKZ6Wpg3LnM1+xCEXiyyHUD8fgk0bJIm
         JN9+cu1I9WbdnuxtWySRUrH14sZh5pNbKcKOzuf1Cu9o0x7ZwtHblipAJaQazzzATpRv
         Y8kBK1kgPX2j+NyzY5CXNdmECW8YOL3zNElGgJ51qCS319nBKIm7NwI0swt5tMPOSx6D
         f1+ZeZJCZyEf+eF9For3O79ysI2s3L+ju1WpG6KrGKanwW0a0Rh+lZwD0MmNTlSLus5O
         q6BFtm/dddofs7Vs8WRpvwalOwn/Bqa+ESBDysfvkCDByHQVTbLjblJzv9Imt6XKUNFp
         gMWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781645966; x=1782250766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G5nuspfqQS3ed5PD0TgH+/CQ3RbtR8jKlIRdj+ejWo=;
        b=u5pTg3lwvKpl0PpsQLTAfu3meqnnd+5c//+V5BnoMAS23o2R/flA3cqe/psT/p1+4/
         gfDGWlo0LyOIFwcu23GTDUkXwGyFSap5y+hbHA3FwQOCUApSudIbFU6ra92gT+/PzJuV
         7Jkw9pdwk5kQXRsUSLbBMd77I/loLV3KTKHFbzXjSATilczzmsCql9rmZgpHjHtGWMgq
         z4t/ZxlSFGxWJNH14tKo8xWxAfLI+HIO9wV0cc98l6o3p7Kjy07kc9da61dEalIV1Yjw
         CfzVx6nUfWXxn/TXDtPtGrWmJ/afUYAGfbmtxzZ0aWh0r+B9uMBXOq/sS4mCeW+mPQTk
         /6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781645966; x=1782250766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+G5nuspfqQS3ed5PD0TgH+/CQ3RbtR8jKlIRdj+ejWo=;
        b=GheAecv+0Q9U4aUKbvBhzKOgOsKLy7eaSWDAXXumCvss9DBr0ThUpC5ZDy5km0MsZm
         sxZM+r74Zb/8mB7V6/b8qbBa9yZ6r/O/yPRCbPFFKCN6A57SY43hZGfPJabs2xOJ46uk
         2m01myEfcCUnPF0HNnYmP3vXxtHohV/Bz+23uzeuyi+rzhwLb6xeFEpwSYI/k8ZJw6DP
         vSAl7NMob2wTYe6hrrJLW5oUNkE15IPYIDSroy11ZwRkQnrjUMGqrOtTRwuw6laOHExL
         fpmKkQDwKtOrkJB/wqJLLC5C5MHkc2zKNO5/dzAsbO4BcLN4eMQxihhj8CNSS50D9FXA
         lhvg==
X-Forwarded-Encrypted: i=1; AFNElJ+8BA83rjExjVNK7eqdGjrDIXki3H341t0z5hJmKD5Iu2YBOEa5YSTRP6GbZZPccSoGAHIGuKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQQS6uTxr/K852RhFjLIL2D7As7z5Amq7o2GmS/zvqV+ho5Ip
	S1PHZOw7OJxL42qBycS/Vn6+vW/8+Ni0ErthdDcRq255/LOQ0UV3ns4z/XH8wZOmnd9Lz0oB6OI
	eUJ4UlU8yHftRx8nb7/uJQdkn4pQvTc3qaLQY7lRw
X-Gm-Gg: Acq92OGecw8uM5UAvxgmK7dS++PAHkUKYPNNHz3OpcV0tx0lpm3v47R+woLiuLZXX3N
	EgLX47SRCU0rPJOiIQdnito8MmF3H9OpA6VN0mILy3QMAdqNwwEiw6twG1BzctO6mjLF3aK3oIS
	Te3LP9Ha2g2lL+R9A71uRuvbxz1XQICUkkLX0LYJu0p3sIwKNIUz3B4HP6Sx7Np+eNu5v39aG0d
	LN8fxjgc21PdKusf6YVHLUtAhY5E7hKaFgWqmDSOUVKe5JSDAvVEtH7m/8bE+BjuJT4SwzHoI/V
	kVNg/WNTbuwerWyI7R8VcRaiyJDInXGVI9ednBhLm2YtWGOJSQjm6xaZA4CD8fHj24Jsxo/2hqa
	1W3IeUTLeByzyFUgSgYZkvsnM6pBotrhb5Xp1XuAws12dgX4B
X-Received: by 2002:a05:7022:ec18:b0:138:6027:ca5e with SMTP id
 a92af1059eb24-1398f66651emr331626c88.1.1781645965050; Tue, 16 Jun 2026
 14:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616141317.407791-1-edumazet@google.com>
In-Reply-To: <20260616141317.407791-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Jun 2026 14:39:13 -0700
X-Gm-Features: AVVi8CfwPcKheWgc5X4qQho_m0Fd2JHAuL-N_Umy6jtW-LZMSmgMeWgaWEYjK_I
Message-ID: <CAAVpQUCbOfsmTxHY-smiM8-ABxXGDXNeL8SVE9ChDj-L+S5HHA@mail.gmail.com>
Subject: Re: [PATCH net] net: serialize netif_running() check in enqueue_to_backlog()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com, 
	Julian Anastasov <ja@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,ssi.bg];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com,m:ja@ssi.bg,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev,965506b59a2de0b6905c];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32E2C69571B

On Tue, Jun 16, 2026 at 7:13=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Syzbot reported a KASAN slab-use-after-free in fib_rules_lookup().
>
> The root cause is a race condition where packets can escape the backlog
> flushing during device unregistration (e.g., during netns exit).
>
> Commit e9e4dd3267d0 ("net: do not process device backlog during unregistr=
ation")
> introduced a lockless netif_running() check in enqueue_to_backlog() to
> prevent queuing packets to an unregistering device.
>
> However, this creates a TOCTOU race window.
>
> A lockless transmitter (like veth_xmit) can pass
> the check before dev_close() clears IFF_UP. If the transmitter is then
> delayed, flush_all_backlogs() can run and finish before the transmitter
> grabs the backlog lock and queues the packet. The packet then escapes
> the flush and triggers UAF later when processed.
>
> Fix this by moving the netif_running() check inside the backlog lock.
> This serializes the check with the flush work (which also grabs the lock)=
.
> We then either queue the packet before the flush runs (so it gets flushed=
),
> or check netif_running() after the flush/close completes (so it gets drop=
ped).
>
> Fixes: e9e4dd3267d0 ("net: do not process device backlog during unregistr=
ation")
> Reported-by: syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a315824.b0403584.28d0ff.0000.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks for catching this !

