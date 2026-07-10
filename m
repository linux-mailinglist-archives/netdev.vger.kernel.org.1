Return-Path: <netdev+bounces-306643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XElEJGY0UWr3AgMAu9opvQ
	(envelope-from <netdev+bounces-306643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:05:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B0673D309
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:05:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="ibq6Xw/E";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306643-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306643-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D5B83010913
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38183749E5;
	Fri, 10 Jul 2026 18:05:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88356261B71;
	Fri, 10 Jul 2026 18:05:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706721; cv=none; b=eKi2b57RPjLdkqtjqRl6R1vcv6dJd/l54VeXXeCnAZfW3yuezzYv7cxSAKWa8cdgjY1TXEJWozjryT8fGoXTylJqmqhY6XN/t/edyQDhyQSqoirzUVrrVugG9z27mpoVGaUSHB5HcBHGts3jmItlyFHBSYr0fYXZVxnE4KeJ3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706721; c=relaxed/simple;
	bh=OmyrVmI5ppkf19L9LjK0zGXXm1LNkcgfajrs6KhlWAQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q6LySfyII1GH0sdvK+ggELaJxbzyhix7f0pw+WmOs5j3DdVhilVLOEkFipaU6CcdMbQQBjjvwCg/Hs89PqXDq0YDoKrXG/S3issfuissK9mFB1jhCVlnPZGl71nY+O0uFtO25xUQ+DzCg0AULjh5UjQKAkEW1ZyfB5AqcdJkf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibq6Xw/E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FD31F000E9;
	Fri, 10 Jul 2026 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783706720;
	bh=s6aZ8xbRU9qyPDYgSEMyFwcZC4kk2rnu9pMRfgO94gs=;
	h=From:Subject:Date:To:Cc;
	b=ibq6Xw/EQjiL1mON4FHgPBhAl+DB7SKBgmxu3Bb21jHwXPaSLj07l5bih6js8XTsS
	 nTgKyQl4RfQhZjwWpVkK+7xiswmfvHNwR/ks85znM5CN7lDj/9XdGnBtrT/d76fEBJ
	 GhE2D3ZCJQ5wtP2JYuhVWhy8K8KT+z+KLlpdl20ierUweYtGfZt/mJDnMd7fQNlXtz
	 W9rYtSzRz5OnEV6H/KVXHpKHfBYZZsJYYn1cOi2ksu8H4oYkO4DkdVUWZxZfqs3/nw
	 krM5lwJB0jqIKEV7cQ6U/4sPvHhJXtfuXd3gli0V++t8DJ6Iqz/EOiGzQbcEDwcXEo
	 xccIOyG6wcbBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/7] selftests: net: add missing kconfig and settings
Date: Fri, 10 Jul 2026 20:04:40 +0200
Message-Id: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCQAxFr1KyNpAO0qJXERft+EfjIpXJKELp3
 Y26fJ//3kqOqnA6ditVvNR1sYB+11G+TXYF6yWYkqRBRjmwobGXxkXfnBdrkxqqc5r3aehFxoJ
 MIT8q4vELnygcOv9Hf8535PZN0rZ9AHEqRah/AAAA
X-Change-ID: 20260709-net-sft-fix-containers-2b4261007fec
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, Antonio Quartulli <antonio@openvpn.net>, 
 Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>, David Wei <dw@davidwei.uk>, 
 Wei Wang <weibunny@fb.com>, bpf@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2324; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OmyrVmI5ppkf19L9LjK0zGXXm1LNkcgfajrs6KhlWAQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLICTYKP/i+cZcuZa9AWdy7kSu1y68XLfn97+Lp1Lr/Zg
 XklnkEeHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPZPJHhn1L5mWvM7Uttpp/3
 Zf8+8XK31aEaxYbdmksun/O3FmN//5yRYU31Hc3SC4sk6nivd/rVT1jtM81gOWuNCvfG/oWXvxQ
 d4gAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306643-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,m:kuniyu@google.com,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:dev@openvswitch.org,m:antonio@openvpn.net,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:mohsin.bashr@gmail.com,m:dw@davidwei.uk,m:weibunny@fb.com,m:bpf@vger.kernel.org,m:leitao@debian.org,m:asantostc@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,redhat.com,ovn.org,openvswitch.org,openvpn.net,queasysnail.net,lunn.ch,iogearbox.net,gmail.com,fomichev.me,davidwei.uk,fb.com,debian.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28B0673D309

When trying to execute the same selftests targets as the ones executed
on NIPA, but using containers with minimal tools, I got some issues
with a few tests.

Most of these issues are due to missing kernel config, but also too
short timeout:

- For the kconfig, these issues were not visible on NIPA, because some
  targets are executed in the same runner, using the same kernel: the
  config files of the different targets are merged. On my side, I
  followed the recommended way, and only used the config file on top of
  a 'make defconfig', revealing some missing kconfig's.

- For the timeout, that was not visible on NIPA either because the
  Netdev machines are very powerful and the timeout is doubled when
  using a debug kernel config (ovpn case), or because there are some
  custom values on the test branches only (drv-net).

While at it, add an extra patch to display an error message in case of
failure with some netconsole scripts.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (7):
      selftests: af_unix: add USER_NS config
      selftests: openvswitch: add config file
      selftests: ovpn: add IPV6 and VETH configs
      selftests: ovpn: increase timeout
      selftests: drv-net: increase timeout
      selftests: drv-net: add missing kconfig for psp.py
      selftests: netconsole: ignore busywait errors

 tools/testing/selftests/drivers/net/config               |  3 +++
 .../selftests/drivers/net/netconsole/netcons_cmdline.sh  |  2 +-
 .../drivers/net/netconsole/netcons_fragmented_msg.sh     |  4 ++--
 .../selftests/drivers/net/netconsole/netcons_resume.sh   |  2 +-
 .../selftests/drivers/net/netconsole/netcons_sysdata.sh  |  2 +-
 tools/testing/selftests/drivers/net/settings             |  1 +
 tools/testing/selftests/net/af_unix/config               |  1 +
 tools/testing/selftests/net/openvswitch/config           | 16 ++++++++++++++++
 tools/testing/selftests/net/ovpn/config                  |  2 ++
 tools/testing/selftests/net/ovpn/settings                |  1 +
 10 files changed, 29 insertions(+), 5 deletions(-)
---
base-commit: 1cd23ca80784223fa2204e16203f754da4e821f8
change-id: 20260709-net-sft-fix-containers-2b4261007fec

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


