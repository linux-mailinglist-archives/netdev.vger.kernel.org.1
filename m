Return-Path: <netdev+bounces-291283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNwFKZMgFGpjKAcAu9opvQ
	(envelope-from <netdev+bounces-291283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:12:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C08D5C91AB
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF4723007524
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870FF344030;
	Mon, 25 May 2026 10:11:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3D9344025
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703901; cv=none; b=pFKxB5I2O9kT5dvKvO23cMDfuglnpoGnxlDj2WOb0gxOS218G0+F/lsoUlZysLy5/1Sdwz9T8/LHaPyvNIkF9irM7ZSBeXE7MRLZXY52HnFsYEl7etGE0NUnZvdc3+93g3EsHMZKhSel0Dd1UMSjbksrVItEwS8p6/qeXzo+B9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703901; c=relaxed/simple;
	bh=hvJPHxp7ZU7kAvyKmjcK4nnfv5fauutVxSmY1ipnhv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qTZVLIPcEfNErx8poTV5YnQ7piYsNl0hVjiIT7DuTXlGovCalKtqqmOaC/qndJmhf+nbVuGmvUoemg9O9n19mKySzC+xSgXgYtCkRaAWoe62EWtKh4MSTZDZOI5q5xcI6HZBB6GMZy4IteXtt0MK4fpbTO3rSW+E5wbxhWgNpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1779703890te534ff55
X-QQ-Originating-IP: eOUvvz+NSP60pu+ER0ozdsvYQdeZ5HSnUfhAH8MIsS4=
Received: from localhost.localdomain ( [122.231.28.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 May 2026 18:11:28 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7971813150419393429
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 0/3] net: libwx: improve VF ethtool support
Date: Mon, 25 May 2026 18:11:12 +0800
Message-Id: <20260525101115.13151-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NdeXJ8Tyb3Z/kWiJkdQ7/my5AVkkSpPiXGrPknqcKczItV2GgjeleLgB
	NfsgZ2+/7gp0WtYDBF1H7GSi0WzHVW1agxnWKTHihLmy3Py2Ls54sXlIPcumKzGFQ5/ioVf
	V4xTGIsnd7QXSoAnruMgRQYNTsNBn2MSWQLhn5gHWmq4PIQUifS7jGGk0favjcH+8x8C23G
	RPEcywe87j6xasOVXpet3rB126ggdun5IWevIYdG1BqFNPHLpiDR2fQGapdk+TW2jfx4EFw
	qwB3NzTuYS/WseFQkyhKXQkYlFPaQR81N6DCtuMtJGHsAmYaPhLupynglZZ4NJKxWUrD8As
	eSl02XqC0PVjzn7RrrdQRAgSWQe+hO5oux5mVw8AWjosf0zKy2sVhqlQ2gYDJWsn0WcB/SB
	q0/HinXfkZQ/X7pcALsMEDlLaASsw/Ewj8KXFKpCUE68Oaj32CnBPsF4LQEoMvGFH5oiXwa
	RbS+RD93vJMCdhUiKGEpe3h0MwcOKA0dVRLOiaSF9QXhZ6nWkUkVvKVISkeWxd0qH76TDrP
	cQ5d2vEdUfeV2Fn+VhQqWDYGroJ+VOoQO089fBEpkdDYSaxZxehT61aL160WEXrHzHvPDUz
	h6eve7b5tRbbo4X3QoE+f22q6OKcP4UyXobUGphCeRHjtq+FYGi7YTHpAInwI7wjECkrxCW
	k1OTzYtnpy28ZtvSnkFb6nXabGtXrwD4LrkqCFpYbmq7z9lVUXxbFR+FjSpp8t441hN1exJ
	QM6FbtPXaaQf5u1IdrIUFety5xwvJj5BzaqibH15k3BG9BSwFDMNnZQpo7SX59egizG5xSa
	s3hpOb894xijsBF9qD7rCeG7/ZJDraYAnh49OyP5upmmu5V+4QYGAw88ibae2QACpp/+4PS
	SuJq1r7QozXVDKTR5i7CePMJjvBZFsZU6Eqgn5KlxjodcpiFkICBZy31/gtvGdaDOf38FZ0
	oIbm9vHSbY7hZrHVd3d3DwwFwN6jNyYS545TZwCTucZauKGauD27L96SiZvQZPRCCc7p3dX
	1LzS6jmjJfagGKb2ZWlOQTtC2060owsdroi99a9l1YduztV3dpHxaYLRj6i6++ycaRMh0Lf
	66RTzGR0IZ5MjXHqnARVYhM4Cx3oudkfJVBf8uwdlovYZ6gHTJct71MZCURVtx94pIcKprx
	U/b2eLy0kJo46nw4+SQFcKNqcw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291283-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0C08D5C91AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series improves ethtool support for Wangxun VF drivers
(ngbevf and txgbevf) in libwx.

This series extends VF support by enabling:
ring parameter configuration via ethtool -G
interrupt coalescing configuration via ethtool -C
hardware statistics reporting via ethtool -S

Patch 1 adds support for set_ringparam in wx_ethtool_ops_vf,
allowing VF users to adjust TX/RX descriptor ring sizes.
Patch 2 enables set_coalesce support for VF devices and updates
EITR programming to use the VF-specific register access helper.
Patch 3 adds VF hardware statistics support so ethtool -S can
report useful runtime counters for VF interfaces.

Changes log:
v2:
- Patch 1:
  Remove some stats which can be replaced by standard stats defined in
  include/net/netdev_queues.h.
- Patch 3:
  Adding a return value to wx_set_ring to make wx_set_ringparam_vf can
  be passed back to userspace.
  Remove freeing and requesting of IRQs. Ring resize only updates descriptor
  resources and does not change MSI-X vector or interrupt configuration,
  so IRQs do not need to be reallocated.
v1: https://lore.kernel.org/all/20260514103405.42175-1-mengyuanlou@net-swift.com

Mengyuan Lou (3):
  net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
  net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
  net: libwx: support vf hardware statistics

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 98 +++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 75 +++++++-------
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 55 ++++++++++-
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  3 +
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  1 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  2 +
 8 files changed, 195 insertions(+), 52 deletions(-)

-- 
2.30.1


