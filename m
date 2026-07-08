Return-Path: <netdev+bounces-305783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vDE3LwE6TmpoJQIAu9opvQ
	(envelope-from <netdev+bounces-305783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:52:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D307260A0
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:52:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b="BNj//PAA";
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305783-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305783-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8561F3003813
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93171434E50;
	Wed,  8 Jul 2026 11:52:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748036C59E;
	Wed,  8 Jul 2026 11:52:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511549; cv=none; b=ER1pbcbAXj9+ujdofyndkwrxjlsLOH7Dhr5zro2MxVJRZFBJlIZUu5wRrn4rnk6oEpKXfvluNKDXFZJ81VjmLrwxrasZLI1r6Jla+9QX+CTYO8FbSV2qabi71n7vl47hnrTsKq3IeVo3RIsL+kYDEQ6xroNbjERUBuBnSULYXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511549; c=relaxed/simple;
	bh=oZmGZS3pzi/VQFsLhOrS9pyabhJ1VP/0yQFCPqWKZZ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KVf03sKiLRE6XOcjfq9YfUkt19rHH5/ScHRM2Dy9eKG7VU9KC3RDxUiGho4DlBBroyYTOE5oLOTZjTdXjRpjNP4h0+ktE92alCz2INOw1OtgoGNoDWl1xax5G8amZMCLNJmGNcllfQXr+0ftDvQwUH9HRr23BhDhQSQZToP5k9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BNj//PAA; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=LZ9Pn8dtV4Hh/0XuHWnaRHJNDJz+nFdXBLV514+izjs=; b=BNj//PAALBTxlGm/ZghjT3DAc5
	NB8IY+mEw3vkXUpsDVZXBRMS2o8lyHjTnKSYtPE4goheVdLKaVu9YehqL6H2dcLbYJazTR8mCtCx7
	xd8nETHo4BkkGnJeh60ymg+PINNkNlE5UIBQ6ZfUkd1i5p8+pcw8LrJTAQBOfYOsJfvA92AkOr+8r
	fMu71OyRhjGJG3xozNFOK7LOPrKioDSvPwy7GM8ztTl7EW4WwqHMK9PCDhuyijx2jkDUdZK12OT69
	tO1dM2IWuskSt9j8Nc3eZlEP1xy2hpJdTSJlbzYm+T6aqyuG81meQijMuyqgVZYJCv4+ewx6srrOm
	d1JDO8Ag==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whQp7-002ve7-00;
	Wed, 08 Jul 2026 11:52:17 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] nfc: llcp: Move to .getsockopt_iter
Date: Wed, 08 Jul 2026 04:51:57 -0700
Message-Id: <20260708-getsockopt_phase3-v1-0-d8394f2fc554@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN05TmoC/x3MUQqDMBAFwKuE920gNa1CrlJKMfapSyEJ2SCCe
 PdC5wBzQlmFimBOVO6ikhOCuXUG8zallVY+CAa96wc3usGubJrnby7tXbZJ6a2/L2N8MHq6iM6
 gVC5y/M8nEptNPBpe1/UDlC6aBG0AAAA=
X-Change-ID: 20260706-getsockopt_phase3-34f7b5eb3e0b
To: David Heidelberg <david@ixit.cz>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sdf.kernel@gmail.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3361; i=leitao@debian.org;
 h=from:subject:message-id; bh=oZmGZS3pzi/VQFsLhOrS9pyabhJ1VP/0yQFCPqWKZZ0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqTjnt0iqMpFju1LH927R+GsUds9Q76Lc2beDsS
 HURDTiIXOmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCak457QAKCRA1o5Of/Hh3
 bT2ED/9XcJR/fndkocmXmxo9HoMcXvhV46vRonam/VpP9slEWUfstL16XrYXdCX+v52HMN/AjpF
 EdltvZZSBKK6nrW5E1udFo0f7zwdwJH3icPRtHLf7g2CHWyI5gZ6XUavBQ2uZc1Gdyr9VuLp6FW
 bkClnUuer2v6L7WDAp0oCby9n2f/lEEyFJICL9UHonQ213E9yI0eln5ZJ81RuESYBZqThbIt/Qz
 CB/ACJritclalt0jdBQYd7Yq5o/4rwOW3KM+lb+g5qRD7VdPoe1y8t9gvc/TefIAD0OdPYQ5Mha
 E10IQLp+a+5RE9heupf5w5XKJSFRiJ5L/I/TlGyFzeEvSKvyZqt2UzSnz+Rzd6UIIXeYjVXke/+
 p6UvJ/WFPF0EPgAHSkmHz9nl1aOjUfdTAeCf3HF25GuoIzp2BYxINToHEcp0481eIQW31RqaeVQ
 QZ70Wf4B4amd5wYwFs86BSxFUx3zzqiOrotUCAGtnakDP5SVFR0/UP2OWuE5gPotpvFjS2PJbqF
 gynykAq5bEYR574ODEwUO8yjtuMmirEDDneqBcT318o7DmZn/mQ8p2MFsujuxy3boXjBqnxrZTA
 KA//MJ1pC6M0K5/EUXJx2xvP5AuUDh5ICgUM3p3IExfzOYLnyXKAD7ZnaPc4lyoCUWqPINpq1lR
 R6CW03jD0Huu/rQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305783-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,debian.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sdf.kernel@gmail.com,m:leitao@debian.org,m:kernel-team@meta.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52D307260A0

Continue to convert the protocols to getsockopt_iter callback.

Proto llcp is one of the last to be converted, and it was waiting for
the following fixes to land first, avoiding merge conflicts.

 * commit 000fb5bc757a ("nfc: llcp: read llcp_sock->local under the
   socket lock in getsockopt")
 * commit 81e676dec04f4 ("nfc: llcp: avoid userspace overflow on invalid
   optlen")

Now that they have landed, let's move llcp to .getsockopt_iter callback

Regarding the whole project migration, this is where we are:

Missing proto_ops migration (as of net-next)

net/can/isotp.c:1707                          isotp_ops                  (.getsockopt = isotp_getsockopt)  [1]
net/can/j1939/socket.c:1375                   j1939_ops                  (.getsockopt = j1939_sk_getsockopt) [1]
net/ieee802154/socket.c:410                   ieee802154_raw_ops         (.getsockopt = sock_common_getsockopt)
net/ieee802154/socket.c:972                   ieee802154_dgram_ops       (.getsockopt = sock_common_getsockopt)
net/ipv4/af_inet.c:1060                       inet_stream_ops            (.getsockopt = sock_common_getsockopt)
net/ipv4/af_inet.c:1096                       inet_dgram_ops             (.getsockopt = sock_common_getsockopt)
net/ipv4/af_inet.c:1128                       inet_sockraw_ops           (.getsockopt = sock_common_getsockopt)
net/ipv6/af_inet6.c:660                       inet6_stream_ops           (.getsockopt = sock_common_getsockopt)
net/ipv6/af_inet6.c:696                       inet6_dgram_ops            (.getsockopt = sock_common_getsockopt)
net/ipv6/raw.c:1276                           inet6_sockraw_ops          (.getsockopt = sock_common_getsockopt)
net/l2tp/l2tp_ip.c:628                        l2tp_ip_ops                (.getsockopt = sock_common_getsockopt)
net/l2tp/l2tp_ip6.c:757                       l2tp_ip6_ops               (.getsockopt = sock_common_getsockopt)
net/mptcp/protocol.c:4567                     mptcp_stream_ops           (.getsockopt = sock_common_getsockopt)
net/mptcp/protocol.c:4676                     mptcp_v6_stream_ops        (.getsockopt = sock_common_getsockopt)
net/phonet/socket.c:451                       phonet_stream_ops          (.getsockopt = sock_common_getsockopt)
net/sctp/ipv6.c:1043                          inet6_seqpacket_ops        (.getsockopt = sock_common_getsockopt)
net/sctp/protocol.c:1106                      inet_seqpacket_ops         (.getsockopt = sock_common_getsockopt)
net/smc/af_smc.c:3330                         smc_sock_ops               (.getsockopt = smc_getsockopt)
net/smc/smc_inet.c:33                         smc_inet_stream_ops        (.getsockopt = smc_getsockopt)
net/smc/smc_inet.c:80                         smc_inet6_stream_ops       (.getsockopt = smc_getsockopt)

Link: https://lore.kernel.org/all/20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      nfc: llcp: widen getsockopt value locals to u32
      nfc: llcp: convert to getsockopt_iter

 net/nfc/llcp_sock.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)
---
base-commit: 5c73cd9f0819c1c44e373e3dabb68318b1de1a12
change-id: 20260706-getsockopt_phase3-34f7b5eb3e0b

Best regards,
--  
Breno Leitao <leitao@debian.org>


