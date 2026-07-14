Return-Path: <netdev+bounces-307556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8NaIBQd9Vmoj7QAAu9opvQ
	(envelope-from <netdev+bounces-307556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:16:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0F9757C78
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:16:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sleFoFWb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307556-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307556-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E16A300460D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3093D7D65;
	Tue, 14 Jul 2026 18:16:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6513D75A9
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 18:16:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052992; cv=none; b=gZ3QvviFMad7MNIuIThAPKlDpGBOYqWxmn7IBWPqe1Y67Dy+E+Y8zGNU/jjbTbZEnEOa3wB+b6zcPImBw26B4cJKC8X3ZOan2TuIPib4W6UBgIr2MAaQWQh1ktGaGiDNUdOW8KMlzfjmxcRVfIZulK7fNF+iH2KxkGdE6+6r4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052992; c=relaxed/simple;
	bh=hIljgCSsXh/p3svvug1v/D+MXs0XzrFD1w8GnaxDtyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDARLJ6Sje/BSrK3gx2LMhr0KCtSpFaVLSf8pml0/Tiunp/6U3fO0krbemLKKwhESQMPE4PPBt2znhoSPDkUh0630tsNqcVOorqBg4vrhn2fUMPdEyHXyaPnQ7TsSFJXQUPY0N5NEd3HtzDmcLIwls/j4X0JpIz+h38F8gzjCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sleFoFWb; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848643382fcso5200388b3a.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784052991; x=1784657791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M4ANFsp313QLwA+WwxkhGeYupYp6HRdxaXxq16sMgtc=;
        b=sleFoFWb7ETHm38xuc7giMYC8Lo2aCa11qJD4pyY4nmVtjoJcit9FnckPHTr0AgEOV
         Ly44UDuIxX5B7eYt2WF2eHOdJBgEi4hlE2TID7vh/ra73s4BXNtNizlEFULiFaTuJ7u9
         kcn9VbtPOZAWNi3behDCcQ/eGttTHmqtnD/9+NC4EB2a8XyY/XgK2foamfEBPAxjwUbG
         hBkPKoqqoFSa+Q4xvyggWca/ZExAeSni/ieqQWuuGBzHM5tzX9ia1NsmVcx5Sd8UuMGl
         hDdSw5Ry6mH+9OkQR5QQYwe0LKRtB20wUQotrn5fF7EfvKhPaADKku4QGWV1PPQgyitj
         yW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052991; x=1784657791;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4ANFsp313QLwA+WwxkhGeYupYp6HRdxaXxq16sMgtc=;
        b=fUqiAISogNkzcyf0RhfYqEpf1O0/95+XQ0273fEj32oj9qHzxJOaZWojG7gQFADcxr
         kvZo4quqm4ZyYrPrUlnJx9xrWItPKp94UK/bjXJk92H1aXYKBF60s7ynwV1+gSQl21ja
         gMXN+WKQPhhvWfhgUJMlTOfBlsaLklSLxFKLKZ561iOqh8wV1PfPTkqrjX5U2AXSw/IA
         WM2In02coix5z/f52gF+NTYUGV2Jx9I7GEHOGgJ8VuhGrJ82x5DK2GltCBaWb9qRBIuo
         X1+LrJpl6ycY6V5VKo5HUOnWAhFr+wfNkfe3g/M8u2I65idXeVlr/Z4vGrnEvx1K9xcK
         hySA==
X-Forwarded-Encrypted: i=1; AHgh+Roz3JkCGAJP8xU3cE6hdJJAnO0ylWw3w/qeIM8q3N1s31a6lHDsAhv0/VuiWUVp+CrtgyhrZSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhw0qkrHaDHfnU2MTE1tTesLt16CB1v/VyvFvjMChOQsB+snrk
	jLhhMby3gaUsg8/2StU8lg4uPLBEMVCKhWYj/4da66XmzpVRgxWfpu9k
X-Gm-Gg: AfdE7cm14qjy8+mAV7IAKQ9Ym0KGKbltzl684+GIjzniyV77K955HuxPgPMNypvumsI
	H/7lkc7AfZ4krDJ5hTy46aT3WePeIVQ38VO5OnC9BWCIMUT4xr3M6Igxk5X3vZCEhwjCYQdzldY
	DA/JiqkH5VRUAGYdyrqeens2MZ0Dhmx4cWyHz/uk8mbVmRsDCT9YojQFZa8oikXaqiJKNQ/Jz0Y
	gZuW8F5BqWW4WZrVUYQ0JQTYh5aVLyBY3eWvxESRicFgEkCj7ovHN7N+dbGsZLIi/Ndkl/KZ6nN
	utYrcNDQp0raR1DGvJgfNqFsEN2pO64BsBaszPG3ZxqVqJWArY/+jNM7dQOznKC5Z/SCGR4np0t
	qgAjdlVq9PXC8ktdOIaU0+Oq2CkyBH/7AIuy+Vuolzauos6bb5HcYoVPH+wPFKrgctMfYunqZMc
	smc3hAkXhSTshUrNFxdn/D
X-Received: by 2002:a05:6a00:4fc6:b0:848:7cbc:7a0e with SMTP id d2e1a72fcca58-84a5140f2e9mr4300084b3a.11.1784052990589;
        Tue, 14 Jul 2026 11:16:30 -0700 (PDT)
Received: from john-p8 ([98.97.42.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bfbc3sm1855945b3a.33.2026.07.14.11.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:16:29 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:16:27 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Nnamdi Onyeyiri <nnamdio@gmail.com>
Cc: nnamdi.onyeyiri@squarepoint-capital.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, edumazet@google.com, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [BUG] bpf, sockmap: spurious wakeup by tcp_msg_wait_data()
 causing unexpected EAGAIN in recvfrom()
Message-ID: <alZ8nmJlkhguOG5v@john-p8>
References: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nnamdio@gmail.com,m:nnamdi.onyeyiri@squarepoint-capital.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-307556-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,john-p8:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA0F9757C78

On Thu, Jul 09, 2026 at 07:43:56PM +0100, Nnamdi Onyeyiri wrote:
>Hi,
>
>We've encounted what appears to be a bug with bpf when invoking recvfrom() on
>an ipv4 tcp socket that has been added to a sockmap.  It results in unexpected
>EAGAIN errors, that we've diagnosed as the result of spurious wakeups from
>tcp_msg_wait_data().
>
>This has been confirmed to still be present on the mainline kernel, and I have
>written a reproducer at: https://github.com/Nnamdi/recvfrom_sockmap_eagain/
>
>Attched is a patch that we found resolved this using kpatch locally.  It just
>causes spurious wakups to go round the loop again.  I'd like to get a sense of
>whether this is expected behaviour, or really is a bug, in which case, is this
>the correct fix?

If its breaking/changing applications I think its a bug. Can you submit
the patch below? We had something similar with ioctl FIONREAD behavior
as well that was recently fixed.

Thanks,
John

>
>Thanks,
>Nnamdi.
>
>----8<----
>From 0e0c342363b2e435297ab1feda402cde6ad54525 Mon Sep 17 00:00:00 2001
>From: Nnamdi Onyeyiri <nnamdio@gmail.com>
>Date: Thu, 9 Jul 2026 13:06:33 +0100
>Subject: [PATCH] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
>
>recvfrom()/recv() are documented as only returning EAGAIN for blocking sockets
>when they have a receive timeout configured.  however, adding a blocking
>ipv4 tcp socket without a receive timeout to a sockmap will cause EAGAIN errors
>sporadically.
>
>this happens when tcp_msg_wait_data() wakes spuriously (returning 0) in which
>case, if no receive timeout is configured, we loop again instead of returning
>-EAGAIN.
>
>Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
>---
> net/ipv4/tcp_bpf.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>index cc0bd73f3..38fd391ff 100644
>--- a/net/ipv4/tcp_bpf.c
>+++ b/net/ipv4/tcp_bpf.c
>@@ -317,6 +317,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> 		}
> 		if (data && !sk_psock_queue_empty(psock))
> 			goto msg_bytes_ready;
>+		if (!data && timeo == MAX_SCHEDULE_TIMEOUT)
>+			goto msg_bytes_ready;
> 		copied = -EAGAIN;
> 	}
> out:
>@@ -390,6 +392,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 			sk_psock_put(sk, psock);
> 			return tcp_recvmsg(sk, msg, len, flags);
> 		}
>+		if (!data && timeo == MAX_SCHEDULE_TIMEOUT)
>+			goto msg_bytes_ready;
> 		copied = -EAGAIN;
> 	}
> 	ret = copied;
>-- 
>2.52.0
>

