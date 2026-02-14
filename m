Return-Path: <netdev+bounces-258723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF3+KRi+kGn7cgEAu9opvQ
	(envelope-from <netdev+bounces-258723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 19:25:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F1913CE06
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 19:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42E463004C3B
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 18:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF203033DC;
	Sat, 14 Feb 2026 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ErYQhGxG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vnFtf4G1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ErYQhGxG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vnFtf4G1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67C22A7F0
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093519; cv=none; b=scvgeRMNjWu5GZkHfPWINoVt42r6q0rFROOeemCngRolJeA9Mrj8vLjlNEMUSmtgFHkINI8xPnPLZ4KIspdn0puxdDoexrqnN25dlsBRgPlQ0WKmcDSFbIGPdYyUlfA+lL5sf9VRbFAmTwJa9OZoneK8u4Xe29kUwVLuaR46Nno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093519; c=relaxed/simple;
	bh=eqszYYsuEQFwdlsViPWxpT7lUQRhoNI9dCbw3tbgSgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKFqHxHdgYhLKW5EPbmR/1kdZjIHwJMpGXojfMqO46673kcds1YTWovVV0qWWy2+JsQE1Uju/8e/1BChJyB723hGh1peSNnQKro+UGWNljZhnoL0VbrVn/aPrRm75Ztr0VmiOcHKMkZnu9jkhzr98vatx8QU8+cEntAFI10TyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ErYQhGxG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vnFtf4G1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ErYQhGxG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vnFtf4G1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B31F5BCEF;
	Sat, 14 Feb 2026 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771093516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toMJsawatT3XsMU3R6Ki8vJr4mt/rtjnT1MUnjtT/AA=;
	b=ErYQhGxGgyI+qIzVvIQtFgnlCy+lAMr8DAybYERCxQRyuBqtsPO39bUHetIPov8j70aRDD
	QaoLQlAYBI6v+B3Jijr8GwatELUkrNM+dFVI1LjCfeXuILUQ3sBW3z1+AKeyMgf/qc1l5U
	vfxZyiXaUiYZwj7TQNcko0lJwQe3aYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771093516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toMJsawatT3XsMU3R6Ki8vJr4mt/rtjnT1MUnjtT/AA=;
	b=vnFtf4G1Rhzc2/lKWI7KuWvlu8kSVrwpMaO0Bnw4Vw0ibC8HJpCtlRw9nmw4KyH+libEz1
	JSEllPB8yI8eaQDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771093516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toMJsawatT3XsMU3R6Ki8vJr4mt/rtjnT1MUnjtT/AA=;
	b=ErYQhGxGgyI+qIzVvIQtFgnlCy+lAMr8DAybYERCxQRyuBqtsPO39bUHetIPov8j70aRDD
	QaoLQlAYBI6v+B3Jijr8GwatELUkrNM+dFVI1LjCfeXuILUQ3sBW3z1+AKeyMgf/qc1l5U
	vfxZyiXaUiYZwj7TQNcko0lJwQe3aYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771093516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toMJsawatT3XsMU3R6Ki8vJr4mt/rtjnT1MUnjtT/AA=;
	b=vnFtf4G1Rhzc2/lKWI7KuWvlu8kSVrwpMaO0Bnw4Vw0ibC8HJpCtlRw9nmw4KyH+libEz1
	JSEllPB8yI8eaQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54CE53EA62;
	Sat, 14 Feb 2026 18:25:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /O82EQu+kGlZPwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 14 Feb 2026 18:25:15 +0000
Message-ID: <c57f2565-a6b2-45dd-8307-871a02ae1a7a@suse.de>
Date: Sat, 14 Feb 2026 19:25:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] possible deadlock in inet6_getname
To: Gerd Rausch <gerd.rausch@oracle.com>, Eric Dumazet <edumazet@google.com>,
 syzbot <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
 <CANn89i+mVCLW2g1+tnbK8k9E0AkEuX7AZ+2LbO1_s2L=Gxaaeg@mail.gmail.com>
 <50e88063-14fb-4912-a65d-172a85def1ee@oracle.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <50e88063-14fb-4912-a65d-172a85def1ee@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258723-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 10F1913CE06
X-Rspamd-Action: no action

On 2/13/26 7:51 PM, Gerd Rausch wrote:
> Hi,
> 
> On 2026-02-13 09:26, Eric Dumazet wrote:
>> On Fri, Feb 13, 2026 at 1:15 PM syzbot
>> <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com> wrote:
>>>
>>>
> [...]
>>> ============================================
>>> WARNING: possible recursive locking detected
>>> syzkaller #0 Not tainted
>>> --------------------------------------------
>>> kworker/u8:6/2985 is trying to acquire lock:
>>> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock 
>>> include/net/sock.h:1709 [inline]
>>> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: 
>>> inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
>>>
>>> but task is already holding lock:
>>> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock 
>>> include/net/sock.h:1709 [inline]
>>> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: 
>>> tcp_sock_set_cork+0x2c/0x2e0 net/ipv4/tcp.c:3694
>>>
> [...]
>>>   lock_sock_nested+0x48/0x100 net/core/sock.c:3780
>>>   lock_sock include/net/sock.h:1709 [inline]
>>>   inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
>>>   rds_tcp_get_peer_sport net/rds/tcp_listen.c:70 [inline]
>>>   rds_tcp_conn_slots_available+0x288/0x470 net/rds/tcp_listen.c:149
>>>   rds_recv_hs_exthdrs+0x60f/0x7c0 net/rds/recv.c:265
>>>   rds_recv_incoming+0x9f6/0x12d0 net/rds/recv.c:389
>>>   rds_tcp_data_recv+0x7f1/0xa40 net/rds/tcp_recv.c:243
>>>   __tcp_read_sock+0x196/0x970 net/ipv4/tcp.c:1702
>>>   rds_tcp_read_sock net/rds/tcp_recv.c:277 [inline]
>>>   rds_tcp_data_ready+0x369/0x950 net/rds/tcp_recv.c:331
>>>   tcp_rcv_established+0x19e9/0x2670 net/ipv4/tcp_input.c:6675
>>>   tcp_v6_do_rcv+0x8eb/0x1ba0 net/ipv6/tcp_ipv6.c:1609
>>>   sk_backlog_rcv include/net/sock.h:1185 [inline]
>>>   __release_sock+0x1b8/0x3a0 net/core/sock.c:3213
>>
> [...]
>> Gerd, please take a look, thanks.
>>
>> commit 9d27a0fb122f19b6d01d02f4b4f429ca28811ace
>> Author: Gerd Rausch <gerd.rausch@oracle.com>
>> Date:   Mon Feb 2 22:57:23 2026 -0700
>>
>>      net/rds: Trigger rds_send_ping() more than once
> 
> Syzbot is right:
> 
> inet_getname() acquires a lock_sock() that was already held
> as () is about to give it up, but before
> doing so, handles the backlog receives & callbacks.
> 
> Just need to figure out a way to obtain the peer's port number,
> without ending up in such a recursive lock scenario.
> 

Hi,

Shouldn't this be enough?

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 6fb5c928b8fd..a36e5dfd6c66 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -59,30 +59,12 @@ void rds_tcp_keepalive(struct socket *sock)
  static int
  rds_tcp_get_peer_sport(struct socket *sock)
  {
-	union {
-		struct sockaddr_storage storage;
-		struct sockaddr addr;
-		struct sockaddr_in sin;
-		struct sockaddr_in6 sin6;
-	} saddr;
-	int sport;
-
-	if (kernel_getpeername(sock, &saddr.addr) >= 0) {
-		switch (saddr.addr.sa_family) {
-		case AF_INET:
-			sport = ntohs(saddr.sin.sin_port);
-			break;
-		case AF_INET6:
-			sport = ntohs(saddr.sin6.sin6_port);
-			break;
-		default:
-			sport = -1;
-		}
-	} else {
-		sport = -1;
-	}
+	struct sock *sk = sock->sk;
+
+	if (!sk)
+		return -1;

-	return sport;
+	return ntohs(inet_sk(sk)->inet_dport);
  }

It would be safe from rds_tcp_accept_one() path as the new_sock has a 
reference count of 1 and no other component should be to release it.

In rds_tcp_conn_slots_available() path, fan-out can be only performed 
from receive path, AFAIU if data is being processed from the socket we 
should always be holding a lock.

If these premises are not correct, we can always make this conditional. 
But getting rid of the kernel_getpeername() call is performance-wise too.

I am testing this against the syzbot report/reproducer.

Thanks,
Fernando.

> Thanks for forwarding this,
> 
>    Gerd
> 
> 


