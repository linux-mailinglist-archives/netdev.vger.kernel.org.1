Return-Path: <netdev+bounces-259997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPXABrYtnGkKAgQAu9opvQ
	(envelope-from <netdev+bounces-259997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:36:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F020174FA2
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC88B309527F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8035C1BF;
	Mon, 23 Feb 2026 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAJCWw0C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894A35C18D
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842485; cv=none; b=EUybKTgy90sXAxlJjEaArobcuWKhzmeQko7mzddtz7XMYbDQv1CVlr/N6kwMLnmbhZVp+1+zqqJhG9Ob0NdMux3wUFfhZYRoRHhBM4nF3WHfLdP80F2aXatoz7dtGT/8aYXAakDQmbRXIYW1eRzFeMSliY6JTq+5Gmc2rURQHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842485; c=relaxed/simple;
	bh=N2bM5Up2XL0atqGOG2enGUu9vC/fkdKMG9llDdkFOoo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nDwXtAQ6T3RUjH2wyWMNV8GEHJrv1GpMVJxctsQEcnd653svdWEPXnzHOb+ea61xhAT2YO3PsYthlAW4rBokJdNUPrz8Y/YC2A0WtjeTBpCsO0InyTZvBrtv4E4AW/L60eG3BWZvOHSwHGT3p2T9jedzQ+upi1DjSRkqIqEY3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAJCWw0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C9ECC116C6;
	Mon, 23 Feb 2026 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771842485;
	bh=N2bM5Up2XL0atqGOG2enGUu9vC/fkdKMG9llDdkFOoo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eAJCWw0CRgq9z7X06mCXtcvpYReS0J1EuKKocuZuG+Y9+l+AmqRSAWH5vT2KyKD19
	 unuPV8Jh2DVeBbjMDoM3AetOy6g2Knb9Tn7At1bS5vVGiSQQ8PcCPFPw1nhGLH9bjZ
	 dESDhIloqlgJ+W1j/EaqnZow9h24GuHAF7XCNFKduR9vFaInhTzv1x5Xq068LsVVoy
	 x6cKWjilHodmwqPNGhMw6bLwo4V2lGeKhzMme+4SgbT6ynS5DenGCqu47CLDQ3so39
	 eXHcXFGGswN3iClMcT6R6guew+oLS7x3E9w4ofEGLIQCiBh7Oh672vTXnRgTVlO17R
	 HPs2sG9cZ9U1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B844E98E12;
	Mon, 23 Feb 2026 10:28:05 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Subject: [PATCH v2 0/2] net:ethernet:enic: add VIC ids and link modes
Date: Mon, 23 Feb 2026 02:27:19 -0800
Message-Id: <20260223-enic-cscwi36355-v2-0-63488194a974@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIcrnGkC/2WNQQ7CIBBFr9LMWsxABaMr72G6qMNgZyEYMFXTc
 HexiSuX7yX//QUKZ+ECx26BzLMUSbGB2XRA0xivrMQ3BoPGoTGoOAopKvSU3vXWqn3wiBd7CKw
 R2uqeOchrLZ6HxpOUR8rv9WDWX/tr6b/WrBUqO6IeHe6ct3wiKZS2lG4w1Fo/nOGj164AAAA=
To: netdev@vger.kernel.org
Cc: Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771842484; l=917;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=N2bM5Up2XL0atqGOG2enGUu9vC/fkdKMG9llDdkFOoo=;
 b=ePtJYNXa95b+fVzS5ILEB9gq+wC/V8iZ3E6DkIITTTW8Y+O5+8iFmUb5ABMrKO4bk6/M/NKvI
 eonYPGwVkUfCQ+giMuvYaKAwxku8hyVWLwabh5BYZcPeRdgjlKuEVaA
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259997-lists,netdev=lfdr.de,satishkh.cisco.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:mid,cisco.com:email,cisco.com:replyto]
X-Rspamd-Queue-Id: 6F020174FA2
X-Rspamd-Action: no action

Add VIC subsystem ids and their supported/advertised media types so ethtool
reflects the hardware capabilities for the VIC variants.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Changes in v2:
Addressed comments from Andrew Lunn
- Removed the advertising of the link speed as we don't support autoneg.
- Link to v1: https://lore.kernel.org/r/20260221-enic-cscwi36355-v1-0-5a01a6046d5e@cisco.com

---
Satish Kharat (2):
      net:ethernet:enic: add VIC subsystem ids
      net:ethernet:enic: map ethtool link modes by VIC type

 drivers/net/ethernet/cisco/enic/enic.h         |  39 +++++++
 drivers/net/ethernet/cisco/enic/enic_ethtool.c | 155 +++++++++++++++++++++++--
 2 files changed, 187 insertions(+), 7 deletions(-)
---
base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
change-id: 20260220-enic-cscwi36355-7fd00b59fe10

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>



