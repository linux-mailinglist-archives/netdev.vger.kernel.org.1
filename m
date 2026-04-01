Return-Path: <netdev+bounces-273883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFJUEv+czGkaUgYAu9opvQ
	(envelope-from <netdev+bounces-273883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:20:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BAE3749DA
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56DD4302EE9C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 04:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB6636E484;
	Wed,  1 Apr 2026 04:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="FiRIGAFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2772DBF76
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 04:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017213; cv=pass; b=RLg03O86WNSzSMSSs+cj+OMpjVoGnWXnt+bs5abLPhZwFJrwtj90qLR0GJPPOlTfV7iPW6vlo46Z2eZSmY4Bce4ITpWtGqHtU1WZUVsZ1t0gCGrtbWBQLaRF9HFUZmw1qemzDWwIJwlLl1GMCAF1oWvJser6326wLOc+w6z6OSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017213; c=relaxed/simple;
	bh=hSIlCijvb+O9fAJX4JT7gS/ZykG42ddR4OkZF238iZA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FqtqryeHQqGF2GQJ7aMXmHOaOCxmSxVYN1GQK6pOn55ZfAQUw3YmSem48COTHmvJEROPBYBjR8kFzbn2ryvJZ+UCzaERFR7Gl0//8X7wHFpwqXItQBHKgMuUQgZFgb3IYrq3Qe59OZgE+vWUd8iXGvh8sWVmiGT1UHaemAzodEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=FiRIGAFb; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56cc6fe8815so2637839e0c.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775017211; cv=none;
        d=google.com; s=arc-20240605;
        b=APW2gmNDjjoNRV1PajCzOvKFLkZPqLf6sXqIKjfx0dV8AfKNGR8yoURRinNRww0Bzb
         2wAC0UjFgF7y6VFmOJv/H5h8yW+iXf3OTzIj6NgvfCrAwMdugJUWw48P5MBwNO4p4Png
         S/NVu6wIqqlMRFdGxAhrmon300T+9zPQWkLR7EoAaVnL9iTE81+gRroJbvZjxaVJfJjz
         QB2TDOws9iAt6b5Ol7dJqLplklJSHtAdlW6+opuvgEDPkjBMey3MvLuFbTWAfgn6zlUN
         q8jQtk3/lo7GSal96UN1GBYghUnFOVy2pPS0n/A0fjrlC1+87ABNu+DgGlCCnFTENRv3
         opgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lggviiDhO1ulOczVkg1BAAuiMur/dnkCZ+TpfZ9eNBo=;
        fh=7CWqjkp/EgjLIOP5idJa3i9xhiN9s2dmmbshbq5GNpQ=;
        b=STj3G08mY50ivd+Q0OGBsEJH9jUNE1scTLuCiL56zCI9A40oNRXeCslKYJ4qCkzdxW
         UCmdtUOhkG63CQsQ8lffylpOMBfm40kPZxZqW3CbWVv58U/1ZsvvQpSHNfjap4XMnKBR
         z0+JveQIZn2Wsws0fqAkxS5mb1XUXvJLCSHlCmqUz9s2fWD8TTI7qxi0UbLTDjdKWSVr
         lEiHYDtKx3OO0LHqzw/DSntNPSPOT9IdF/Zparw/xkkkSv6BG3IgDM5WYC5uNznnP1SI
         Sw2kEGYqUtKSRm18akFjE7bIx+8D47W/hd+z3+R7T7EOwAaSBBubSIjwLju2kH0ZGnAP
         fb1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1775017211; x=1775622011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lggviiDhO1ulOczVkg1BAAuiMur/dnkCZ+TpfZ9eNBo=;
        b=FiRIGAFbgPdsAtjKvVsDaDv8XjUr3O2yO2vg1mrG8wDL29usRCUtvMAELDwdn/yMeP
         ATk1Q9DS7ENGteC49ZvnRlAOeVtVhgAjTGJFbejV3NGeg4B+v57N2AWdU41z+mSX1kdC
         fUnb7kN079mYEqHAcjf1k81u4oc6djcjV3XTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017211; x=1775622011;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lggviiDhO1ulOczVkg1BAAuiMur/dnkCZ+TpfZ9eNBo=;
        b=rw8GYsb0PWKaan9Zv+0itmKzhLMXJzbPWpOAYEPrl0/6sdw+rMkN5oZ6fSzcjjIOFR
         /HrNyCfwpkoEwwFIwOvXKdvmL6t5CHktpYEsyJKdiTCpDoS9BNwrh44CbM31QzIRBHys
         RUl8+2E3/+bg505gIfUFj34qpT2xtlAmcns+w0cef0Ug/QIwuAZfDHabVntAvWBcFTVJ
         R40v2l3eRpdNdfru3gf8Xfgh2G3n8r2pGu8GDNItuU+6raTCNp7ozpZ/59bZGznVviiw
         nxaO0Gkxz30p9XQrc+aS1wEayeb14w8xDWJWAjv4qZcCAh9UuM31uWH4/R48YrzaG3kF
         1npg==
X-Gm-Message-State: AOJu0Yx9/qlh/b2dgtfSNx7TosNuvuyzLI4CUahH3xkc9Ua3qMluIlB9
	1oyJlpZ7Tsa32CL/XY2tcP7K6+/R8DWg/mO4/xuX6b5MhJSEBZRpXR9dscaMSFSnG0Fc1kE1XxA
	VN1M73BFIW8I6iCTH1rDZh1YRqo4yRUmD5306LChTrCQUkTFkjTPfupA=
X-Gm-Gg: ATEYQzzYUx9qAhNENHjjHTvbvPJnbmWWw0mTh/5fvIKXu4ohX3m6sGzn15gImd5nF53
	G/zjqCjSc4BGbHVrMrIZr8Fq67dJrzgzFsnfnZkv7bnqD+s+fACplfMiB1PzvPT9TGTKJjBRNZj
	0EGrubr2zZhAMJLms0vrcUlC95iA2mL+JFzkfMtL9q9bB+oPyVYREm3MDFuQcahZdimGuzOBF3T
	mtnFWS0DBVZpDhwiy9L28DrLjPVzKzqRUqYFmglNXh46LK2iGwe4t+sqq3EUG6H5d/d0wigO1fK
	L+BiULne
X-Received: by 2002:a05:6122:3982:b0:56b:960a:a4b7 with SMTP id
 71dfb90a1353d-56d8a831824mr928799e0c.5.1775017210759; Tue, 31 Mar 2026
 21:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Wed, 1 Apr 2026 01:19:59 -0300
X-Gm-Features: AQROBzAoYMFr5WQUPEwtX5FedLN7yAQB3veEuX2tn6McmyHFKyrAriM5i67pGXs
Message-ID: <CAPhRvkyFrKO3O=D9YZoWWVwykCZ1-fXkzA9NyaJ8aaX9b-pcXw@mail.gmail.com>
Subject: [BUG] rxrpc: Client connection leak and BUG() call during kernel IO
 thread exit
To: netdev@vger.kernel.org
Cc: Anderson Nascimento <anderson@allelesecurity.com>, dhowells@redhat.com, 
	Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Jeffrey Altman <jaltman@auristor.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273883-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8BAE3749DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

I have identified a reliable way to trigger a BUG() in the RxRPC
protocol at rxrpc_destroy_client_conn_ids(). This occurs because the
kernel IO thread can exit while there are still active connection
objects registered in the local IDR (local->conn_ids).

I did a quick analysis and the result is the following. When the IO
thread exits, it calls rxrpc_destroy_local(), which in turn calls
rxrpc_clean_up_local_conns(). However, that function only iterates
over the local->idle_client_conns list. If a connection was recently
created by rxrpc_connect_client_calls() (via
rxrpc_alloc_client_connection()) but has not yet been deactivated or
moved to the idle list, it is completely missed during this cleanup
phase.

Because the connection remains in the IDR, the subsequent call to
rxrpc_destroy_client_conn_ids() finds the entry, logs an "AF_RXRPC:
Leaked client conn" error, and hits a BUG().

I can reliably reproduce this using a client and server where the
server calls close() immediately after sendmsg().

My suggestion for a fix is to update rxrpc_clean_up_local_conns() to
check the local IDR instead of just the idle list, ensuring all
allocated connections are reaped during teardown. I don't have the
time to properly test a patch or verify if the teardown for a
brand-new conn differs significantly from an idle one, so I wanted to
report my quick analysis to the maintainers. I tested on Fedora 43 on
kernel 6.18.

420 void rxrpc_destroy_local(struct rxrpc_local *local)
421 {
...
433         rxrpc_clean_up_local_conns(local);
...
451         rxrpc_purge_client_connections(local);
...
453 }

813 void rxrpc_clean_up_local_conns(struct rxrpc_local *local)
814 {
815         struct rxrpc_connection *conn;
...
823         while ((conn = list_first_entry_or_null(&local->idle_client_conns,
824                                                 struct
rxrpc_connection, cache_link))) {
825                 list_del_init(&conn->cache_link);
826                 atomic_dec(&conn->active);
827                 trace_rxrpc_client(conn, -1, rxrpc_client_discard);
828                 rxrpc_unbundle_conn(conn);
829                 rxrpc_put_connection(conn, rxrpc_conn_put_local_dead);
830         }
...
833 }

54 static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
55 {
56         struct rxrpc_connection *conn;
57         int id;
58
59         if (!idr_is_empty(&local->conn_ids)) {
60                 idr_for_each_entry(&local->conn_ids, conn, id) {
61                         pr_err("AF_RXRPC: Leaked client conn %p {%d}\n",
62                                conn, refcount_read(&conn->ref));
63                 }
64                 BUG();
65         }
66
67         idr_destroy(&local->conn_ids);
68 }

[88656.300130] rxrpc: AF_RXRPC: Leaked client conn 00000000cf1d5a14 {1}
[88656.300702] ------------[ cut here ]------------
[88656.301099] kernel BUG at net/rxrpc/conn_client.c:64!
[88656.301442] Oops: invalid opcode: 0000 [#17] SMP NOPTI
[88656.301765] CPU: 0 UID: 0 PID: 3989526 Comm: krxrpcio/7001 Tainted:
G      D W           6.18.13-200.fc43.x86_64 #1 PREEMPT(lazy)
[88656.302039] Tainted: [D]=DIE, [W]=WARN
[88656.302323] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[88656.302599] RIP: 0010:rxrpc_purge_client_connections+0x58/0xa0 [rxrpc]

Regards,

-- 
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

