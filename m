Return-Path: <netdev+bounces-306346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eGnJB8XtT2oIqgIAu9opvQ
	(envelope-from <netdev+bounces-306346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:51:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E44734880
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:51:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="k/AxyOAX";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306346-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306346-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 623B43079B9D
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9207743B4B1;
	Thu,  9 Jul 2026 18:44:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC03437470
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 18:44:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622641; cv=none; b=rC8joxh8x5KQaq59O0GHozDFJHXuDVEnJ7ZSmcaS10QI88mMk8UCmQpz5uUy6iAPOEkF5fvp8DLMdCiuKo7268UWd3CD+LQRQ1E5b4a7H1/oac2c1fBvvg7QnAITMPeGUoBDaMXMRnWNlcmBjKMsXvxiuhqiGIbX8rjIxLRbj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622641; c=relaxed/simple;
	bh=AzEDPy4n/tg2P9pNqq6HFSvn16Pn7gioI4RLhq1dSCY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PAmIq5EgT+E1DZVcwHW6mRo8rfL/zTsJtHF7pOYx5wnYjxCb7tjiheZOkvbmiJTJyvZB2xLt8aBkas3Flu1eH8bwAFXnq4xxsfTsjtAaQFjUrYPhAnaXeXJ8ALif2he13nf+sW3oNBUJXkKC9af1NboJ0ms/IqPkiOzIHilSToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/AxyOAX; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493ed9d8c5cso900125e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622638; x=1784227438; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sBGn3ij6+2HsbaUjO7lwDiZD87M45vBU8uaHQgq/mEw=;
        b=k/AxyOAX7qJMRw0x6qVpp4p7muM/ahM1miwmZcUqwaDoqMu8uUhIH5J5RyNg7ndtml
         y1cn5oiPvNovwNHTvjtSaIzpx9ngA3NattfCNmSpe87vxXGDL23COese01rEcF7YZauh
         I+ALiHQ0JeHFz+SG2qUDfTRgHQpRv1Wo0kYSx+YtTPj/EawGxURUnCNxSH3HN32IfyfQ
         gqwCrTH8Ip47hdnuDPyt6gAHGxVkwgbr90GVcNo07VhXyZtL5POrdyqji4RlwloH3CeA
         c97SfYt6Bh1cvXG1X2VzckG8MTO1O0um1c5egDSl0kxccs3UaWXCFYGfRFkVMsk2oVj5
         Wz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622638; x=1784227438;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sBGn3ij6+2HsbaUjO7lwDiZD87M45vBU8uaHQgq/mEw=;
        b=CUNTD/+k3WhOmQkm01p8X1K/EttAj6rH2MD7DOfvdjfAg1xs/60O1hzVAqlvgAkSOh
         /Eiw06vdbiTpW1/IqZKenuLWwmjG0Eez679H0JKpZJt/wOtsxULx/KD2B2jDTUEhNUY2
         mH6HBhrZkMGBS4N0VzFbVfixzxeTra+U78QFCyfuWVTNjhmgdikmLRC7xxbmwIAyNEVA
         myZPHWxRqss+hokWPP95KwVZCWpvalyL5PeePI5Byi3o2T0ssEok9GKFws6KL40mzo7Z
         9TdSr+vXzS2H5c+NuS9YIUfm3vMPhVUuv3l5AB8/i4aNfvUPsBAkzAMO2TOeUviFcx+X
         AEEQ==
X-Gm-Message-State: AOJu0YwGu5cJXUdhbDdooOAm6TugBkzcj7OM4GVKIE9RvKc9NafItztU
	hG1m2Q43Ii3gPIuLH58XRhxNMThW5oedIPGsfIPRx+03cRfwgaPE3HLk
X-Gm-Gg: AfdE7clhMHBs/r5/hcDJT0R+fHDSJ2m8ueIghDJKC3b1xkIhvLWDx9ThbaUVfJICqen
	YVuxt025wE+t0wt8M6WcNpHAIjHCayY/4falqFrjcIT/JzOghDm2IDCZZcwjBPTfA6qXELBbyVJ
	r8txWHiwOK57F44ObY0oIexZKJSwX2YyKRPtVGi9hz7NU53wD99DN83kwJUA10xC0Moyecuypa9
	DSenxCzCQppVarAUPdIbg2UVhGzAIZa1haczE4QDON7FGzJZpqkesNvA4za7Ie5xm28B4pcHioJ
	36s8Dcc3K/drdZ0t6ioXp1nu0jyI86sOHm+LpWtS0BJDHRUTpemU/y7/n/6pGzLafFjMW8s9AmX
	TYj7xfswoqHU4K81TaSEAB2rkCOacfT7w7QgJm8D1KfJb0yP08V9F/KrIYRVmSVvvitsvSkubYT
	cXRgjOaKvy5yU0/zbZDooxUXECbxDRrIHjJaqx6OtoXAWSggHPlho1ejX+/UFQE+8QMXrybuu2q
	ImD
X-Received: by 2002:a05:600c:4f90:b0:493:e404:3727 with SMTP id 5b1f17b1804b1-493e68c6da4mr94463245e9.23.1783622638328;
        Thu, 09 Jul 2026 11:43:58 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2a2e499sm8261895e9.0.2026.07.09.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:43:57 -0700 (PDT)
Date: Thu, 9 Jul 2026 19:43:56 +0100
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: nnamdio@gmail.com, nnamdi.onyeyiri@squarepoint-capital.com, 
	john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, 
	edumazet@google.com, ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [BUG] bpf, sockmap: spurious wakeup by tcp_msg_wait_data() causing
 unexpected EAGAIN in recvfrom()
Message-ID: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306346-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nnamdio@gmail.com,m:nnamdi.onyeyiri@squarepoint-capital.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nnamdio@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com,squarepoint-capital.com,cloudflare.com,linux.dev,google.com,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nnamdio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9E44734880

Hi,

We've encounted what appears to be a bug with bpf when invoking recvfrom() on
an ipv4 tcp socket that has been added to a sockmap.  It results in unexpected
EAGAIN errors, that we've diagnosed as the result of spurious wakeups from
tcp_msg_wait_data().

This has been confirmed to still be present on the mainline kernel, and I have
written a reproducer at: https://github.com/Nnamdi/recvfrom_sockmap_eagain/

Attched is a patch that we found resolved this using kpatch locally.  It just
causes spurious wakups to go round the loop again.  I'd like to get a sense of
whether this is expected behaviour, or really is a bug, in which case, is this
the correct fix?

Thanks,
Nnamdi.

----8<----
From 0e0c342363b2e435297ab1feda402cde6ad54525 Mon Sep 17 00:00:00 2001
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
Date: Thu, 9 Jul 2026 13:06:33 +0100
Subject: [PATCH] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

recvfrom()/recv() are documented as only returning EAGAIN for blocking sockets
when they have a receive timeout configured.  however, adding a blocking
ipv4 tcp socket without a receive timeout to a sockmap will cause EAGAIN errors
sporadically.

this happens when tcp_msg_wait_data() wakes spuriously (returning 0) in which
case, if no receive timeout is configured, we loop again instead of returning
-EAGAIN.

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
 net/ipv4/tcp_bpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f3..38fd391ff 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -317,6 +317,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		}
 		if (data && !sk_psock_queue_empty(psock))
 			goto msg_bytes_ready;
+		if (!data && timeo == MAX_SCHEDULE_TIMEOUT)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 out:
@@ -390,6 +392,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			sk_psock_put(sk, psock);
 			return tcp_recvmsg(sk, msg, len, flags);
 		}
+		if (!data && timeo == MAX_SCHEDULE_TIMEOUT)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 	ret = copied;
-- 
2.52.0


