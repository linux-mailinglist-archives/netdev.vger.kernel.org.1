Return-Path: <netdev+bounces-299355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fzRfCpuvL2oXEgUAu9opvQ
	(envelope-from <netdev+bounces-299355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:54:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CE4684577
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:54:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=l9YKQTdG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299355-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299355-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E50A93003713
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C46F31F9BD;
	Mon, 15 Jun 2026 07:53:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD225228D
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:53:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510036; cv=pass; b=Ad9P2GgzxofpOFT91OSjrFzhyd0xhOQEKK58vWcT252GW7BswJyOtwNvqBhnSrVc7OGgWkrICnNGqbJO2sZQ/2cWpFCuRzZPxKxbCtOKXWcrn1KUH1sMNMTHy4GGCfnwQXUdEGyBFyheHSjv8/ONcJK/uph5K+cK1yLbjoORpjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510036; c=relaxed/simple;
	bh=iqFN/tpX3q6tjB+xBeLewyCE5xHFkLdK34oVqtX0Nhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAoP6iUqujXvUYODXlcsUxKtnZKW+kAVwlov/RAkl1/y9VvFbf5XLziVrVmN2RvGhQE0hqzDC/WTewkiQ/Fo+Gpu8R1hz9jUVflDTqeO+coU/2e6Gy34WPhOcMsJOsxIiy28b9F9LOd1ggWXrvIbyk2Olku0sFSFdTcMlSEzuPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9YKQTdG; arc=pass smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5177945a279so35276091cf.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 00:53:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781510034; cv=none;
        d=google.com; s=arc-20240605;
        b=WITQKexDy2gfqLZscXp9CTN2QIEGOsKviktwO8BMl3V1ITPDNZom8bgLArP00/QyAN
         eZ60RBhvO1ldKe79YM4ojja87YZg+oBEyt28cG4BER881Jl0cD5vNONoCfvi+ceKF4Cy
         PpnVyZ/EdQuKFx29EojiMg+WHPgBcVJSv7TNqyUBuoZu5JFeUpnZpQaJvP38OkIUu3Mi
         Ob5wUc+Iu/svM2TgkMGBLbWt4oKcHCnKAJZNPcphFZlQUXFmXMuFa27CHRSYRE0+SJgZ
         vVGTLj3S90DrIdJ2LK1rNbo3T8CkSt/jtolGEGV14utCYZF+q8o4gS/KOjFV7avnk2eP
         TwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iqFN/tpX3q6tjB+xBeLewyCE5xHFkLdK34oVqtX0Nhc=;
        fh=SAqqgTtWgTJrk/fd1I84jJAJLiPqwqIO4/c+Hmz8xpE=;
        b=WkEv/CNiHR0VnQFU7vPanXe1UmeR71t2VeYlJAhlh/Extr2qonkX9etzcDWqsiSNtY
         yiOObvHMx7wqtZ5xuB1p6hs6GegxFkyAi+ojvewFwizMR883ql4Fd7OyVzc6U8HTxwqH
         jd6D15pqnaNEtg8QkvX5cXzVx9YcGoDWEBauO37qphJ6fieDXMg0rCvMLvo/M10xvnFQ
         mOhj0CzMk8s8LC8QnsJEVe3Thq6Vi1k453Akr/P3tUnhymZp7IV0ezW3mDNYs2V+/Btr
         f0xgH0GOcdcOvhtLN4Uec6/gdxS4snHq5Csq0S0BslO7pyqyxGn6PXv3ZzYFwIw0EIsx
         J42w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781510034; x=1782114834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqFN/tpX3q6tjB+xBeLewyCE5xHFkLdK34oVqtX0Nhc=;
        b=l9YKQTdG3x1smj6vp/0l5hkxo3XPeQMAdQVGZLvjynH9W6E/U9d7Sau5FTKakNndZw
         odZxtXovROUwNQf3lpl4Av4+XWOVNoTxpWs1BYpQ0jN6LTcIBqyWulzjRUNUrovuVWoa
         rL0blNbJ3yG1iJkN8SUC5v6pujfbCxK21EGqcfQerBfCn9paZo495fWCHtojZMrBTWDB
         3aY1t36Rnb1H+D84pXGJUKfIYY4gN7x3h+yyni4eEuqqXWOhbsPXQ7Sl/YaEdzhtX8Ix
         zFiEDVphVLc10KFCiRKFbki048K14Uaa6o3dCocknAejF+iqOkwGfQGQ50tNAiQktrd/
         8p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781510034; x=1782114834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iqFN/tpX3q6tjB+xBeLewyCE5xHFkLdK34oVqtX0Nhc=;
        b=a8mU4dHfCfWzAPneuC8Wo2N8ZHl0l+qQx4AvKrnUhy/4asU5kH/cQJRz3OEMFz3hcV
         Z9j8Rtfsw04is5Z+RlfihNtZtQjdqneY8cPojcdhSPM3ybGs9URU9B0yHScDhsN0d1xu
         o1lHiH1D0r8f1Ibau37ZiA34Rjz3q862A6nGXqEux6XRP5ybJ5yrM0ZngGm8zZ3XnN2M
         ohjjRpn78J7NA59XgA6vk1KX+TnZEotx/bcQmshPozBzxCzAJRzKnxY5TKvv/MO9xdT9
         RTFRedN8SnozgkWiHzs4fqFYDVyHgd84pEOSKDFirEpAwANk81dxDRjVgdF3XLNtxETB
         2qpA==
X-Forwarded-Encrypted: i=1; AFNElJ9RDtcFkUzZIzssHaPizxhukSaQzltZg6xW7Z65emT78G1/F9S3N2y50c1amUKa4BNlsrAsabU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3+XyubMqxhj8F5OsZ8mn3fAZ9CmgtQCmTq24dt9/vrQQkH6W
	Dqs/VOdddWw5VlSghK/nJpp4N9wbZ5ohC+ZVfFFR+UdD9rNvEtJRKqed1Os3nBPt1cwQ/fKs/dV
	1sLenJILgCUQh5GBwx4lpten0K1f8Q28oS6I25DN6
X-Gm-Gg: Acq92OFOmIrkTYLW96BRSnk/Pv/lknM/vudRqWw8LPS/6YYPVixCbGfOZXQkteU6bxQ
	IB/w/hoCwPnHMv/n4rQrpl2EBOeNHsott9dDQu/OYNLgBRDWaXqGqLzt5EkgBHJ8b8Ye7WGoj8/
	jTjkKGvZ+brURTGgSU9oB2t+KXCwdeNviP5Z6UR2Gj9MHGeR/hRZsdrbca7HL9NZQ6+/XsQ1A01
	lnqnz9ZxedDxsr+sDiNkULZUU0ISZHfrilNoLJ22zFzW/P19nsvjqwPboXGiIgGte7KUUctzH2M
	+r3UMq88HWwO2iEtcqYgV8g/y2duVFValiAmSol6kaChN1b1XXt/h+HCuNi6GWcRapPCIdM021x
	IZayVYY4fYJqhCtvI++SKeJK0ydTVhA==
X-Received: by 2002:a05:622a:4245:b0:519:75f9:e874 with SMTP id
 d75a77b69052e-51976ed6934mr28436331cf.10.1781510034038; Mon, 15 Jun 2026
 00:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613042619.1108126-1-edumazet@google.com> <20260613101214.1771-1-hdanton@sina.com>
In-Reply-To: <20260613101214.1771-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jun 2026 00:53:42 -0700
X-Gm-Features: AVVi8Cf6uGM8M8DJH4c64JCDlR5PdeR2re5zLcOyooPl5X-inb2su2lIUzphgfc
Message-ID: <CANn89iJq89KWm3eyfKTqjXhdKFy6raRLgfsRX8vXYgBpmBnDiA@mail.gmail.com>
Subject: Re: [PATCH] nbd: Reclassify sockets to avoid lockdep circular dependency
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, nbd@other.debian.org, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299355-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hdanton@sina.com,m:linux-kernel@vger.kernel.org,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:nbd@other.debian.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[sina.com];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev,607cdcf978b3e79da878];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,sina.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20CE4684577

On Sat, Jun 13, 2026 at 3:12=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Sat, 13 Jun 2026 04:26:19 +0000 Eric Dumazet wrote:
> > syzbot reported a possible circular locking dependency in udp_sendmsg()
> > where fs_reclaim can be triggered while holding sk_lock, and fs_reclaim
> > can eventually depend on another sk_lock (e.g., if NBD is used for swap
> > or writeback and NBD uses TLS/TCP which acquires sk_lock).
> >
> > Since the UDP socket and the NBD TCP/TLS socket are different, this is =
a
> > false positive. Fix this by reclassifying NBD sockets to a separate loc=
k
> > class when they are added to the NBD device.
> >
> > This is similar to what nvme-tcp and other network block devices do.
> >
> > Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up =
earlier")
>
> Given the Fixes tag, can you specify anything wrong that commit added?

Nothing 'wrong'.

This (good) commit allowed LOCKDEP to throw a warning and eventually
panic the box.

A Fixes: tag does not imply the patch was wrong.

