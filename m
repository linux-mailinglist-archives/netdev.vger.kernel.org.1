Return-Path: <netdev+bounces-287100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAzDIlsLA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:13:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BBC51F25E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D04F430167D6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFB138E8D0;
	Tue, 12 May 2026 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="h2TG5ZJ7"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F321345BD67;
	Tue, 12 May 2026 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584362; cv=none; b=JMYNsYDG+pO4DXzg5oPABFfut8V3AbgGH6fI/cAlZGir1PH4I9Yi4qLbKeT6QPAjmJfsQAx5HTq2PEZevpzU9akwx+Yo/NtrZg3fIcLRwQumXJYleo1L67sd5dmQid3vbgAIf9l6BnbcTsUW3KLb1PjdrYJU0LKvbpzLqtR09gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584362; c=relaxed/simple;
	bh=h6zSdtN9jQgMR/YPfbG1OygHwk4VDPpboHdb0JfjOWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IW3dRu1NTAaMwUO9CGAjGZKPi7xepe5DUUS+bDAkTDwt0FHsdNhoYCqwOhXfzfOPNkqeWZ9VXg3zIUbbJg+JW3lUywpNAZZiN2yUxHaQtFCcNPD+LNoKwYorHxq7Ga1H9GcJgUra0CkAZZsh01WJDa89BlYlnxOwleqCSEwt0/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=h2TG5ZJ7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=1XedRuOdFDTkq6Iy8V1E9JuuU/kZM1EoPconoc3Ujuk=; b=h2TG5ZJ7jWZaAC6oJJ9p1q3p0J
	Fz1LABqaoB5+ZtxtUwJ1fy1+YIzFGhH1kJMviJYgO3mZHc/x/S24KooI8aF62Bplv6ybjKoeJ+MDV
	GngGawnXoj4wWG2Vz1brHNB6OD7QlqNvffPZWSnQLdXSr4mWjAAJ7k3mvwnRnnzJLnl+D92bfuyoo
	YrFDdzqFTOrTw55/wne07hiPTJi1jrrLVnKB0VgeAKaLcuVoLQbM03mStAM3kaUHfDJUOxd4JuGtu
	OEE16KpJhRXUm7cgofuYwzdC8FT5+NKDzKY/ts8k6JG2EdBak2yOHLnqCk2f8FIkQZcqNsK9KAAe6
	lw7zgkUQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMl2S-002Kqj-2b;
	Tue, 12 May 2026 11:12:37 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 04:12:16 -0700
Subject: [PATCH net-next v2 1/6] Bluetooth: hci_sock: write the full optval
 for getsockopt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-getsock_three-v2-1-30b7b22ef14c@debian.org>
References: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
In-Reply-To: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=leitao@debian.org;
 h=from:subject:message-id; bh=h6zSdtN9jQgMR/YPfbG1OygHwk4VDPpboHdb0JfjOWE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwsamdWMyGriAw22QbzyOxsIWKmyJi2oEk9cd
 0dl2DuZa/SJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMLGgAKCRA1o5Of/Hh3
 bWuXD/9wV6UvdSKsEwpuvK5jLVsagbcx0Cd4a6oskdxdwaLpf7CYDNxTwJKgkj7uXkkK3GeHkAT
 NfTvKbvsXOSBH45RGy2JX1zjcXYRIlN2eHbKRGLVBpty280S/0hTZR/PIqdLBU68gSLo3AJmtZj
 3tiagIpvk1AKaBroefmqd5qW8cfXmC5UDMgFoIOAfYdvJLjWvogdI6A+yiA+jDB0Hpb+tE/OLiq
 Ca/qUBa2Vpmv4tBPn140Pgv01wyrKGS+yR1CmBccWN0TBMEclHKybfyy9VEACjN57dOh3aQdXKs
 FZotNjTgu1zbJ6ml7dVaYH4GyzELL2/ry6QqG/cOuM340hzT6Kh0MZ+JKWac3Mhagom5sucI1ZO
 Y1R+8hvphu0p6UzLj1U+HL8Y9wR+QfMNzaQo0Wtc0m9JwaH9T8zTejonUSViNO5D6bXLPh11YfJ
 TmlK20xyU6aQ1kPe+fw3U1UQNRynm8PEr7lcDhljCPLEqXc7r09nWoj8jpuEIg8f47koxRwTBQX
 sdbROfjktpIV6IehkDOoL+KolGeLdbV0dHLI9c1pe6I9JrSnNcoeJcR0sd37CwKDh39uobC85d3
 iGruwxaJY/5nFpUdvrnQ4lfBzzgMggLuCmKs2Cmx788LcORikaKKS6EfyUwJkpD73MeUXWBwJ5k
 wIioujjpEuy2FCA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 88BBC51F25E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287100-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In hci_sock_getsockopt_old(), HCI_DATA_DIR and HCI_TIME_STAMP both store
their value into a local int and then call put_user(opt, optval). Because
optval is the function parameter typed char __user *, put_user sizes the
write from sizeof(*optval), so only the low byte of the int is copied to
userspace.

The matching setsockopt path reads sizeof(int) via copy_safe_from_sockptr,
so userspace passes a 4-byte buffer in both directions but previously got
back only one initialized byte on the read side.

Not sending this through 'net' tree given this bug is mostly invisble,
given opt is 0/1, and the last byte is being properly copied.

With this change, the upcoming translation to .getsockopt_iter becomes
mechanical.

FWIW: This behavior appeared in commit 1da177e4c3f4 ("Linux-2.6.12-rc2").

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bluetooth/hci_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 0290dea081f62..1823c06ba8940 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2088,7 +2088,7 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 		else
 			opt = 0;
 
-		if (put_user(opt, optval))
+		if (put_user(opt, (int __user *)optval))
 			err = -EFAULT;
 		break;
 
@@ -2098,7 +2098,7 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 		else
 			opt = 0;
 
-		if (put_user(opt, optval))
+		if (put_user(opt, (int __user *)optval))
 			err = -EFAULT;
 		break;
 

-- 
2.53.0-Meta


