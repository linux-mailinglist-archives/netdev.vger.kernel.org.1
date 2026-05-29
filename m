Return-Path: <netdev+bounces-293038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC6fF7xGGWrHuAgAu9opvQ
	(envelope-from <netdev+bounces-293038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:56:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2CB5FEE12
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7D18300210A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6EC3AA9F4;
	Fri, 29 May 2026 07:52:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305D19CCF7
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041124; cv=none; b=bFlzjJfqCy+yWEbDjZyT3ON3KvS10AdnqWhQNaLJl9j3La1Y3fcgSxAJEFausr6nTi2l+dQ/RMA+nTUgiBKgY67/G4OJ65pj99IyTzgmqefC4FxReLtLL/m5a+RvPlQlX7EXSJtdFgrqz8rdfxszLBUg3J1l3ASJeYP/Z9r+7xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041124; c=relaxed/simple;
	bh=cS+qJDGb4BZSsTGha4Gw+txQ2QHJCshBMBVScG17kSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pf27bhD8GvOfzGYf9r23Cpt4uX+zNrcy4OWcqUymE9A8BaN+PmsQBnTX3UNWDF4SmprOKRFl0XmS8hYeR4+z1XhcgwVkNCaENzblpMLcDjYBb/l+ZNB63hzBNqAaALlQlWCPJ8PNkTLWRDkmZnxLvBQp3zV3XoBZemg/t75Djk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz8t1780041115tc7b1a8e1
X-QQ-Originating-IP: gbmraeUwhsZ54weEFniLS8ipb1tlhBwKg3YqunsRn9E=
Received: from localhost.localdomain ( [183.156.95.204])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 15:51:53 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13068928620097599656
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 0/3] net: libwx: improve VF ethtool support
Date: Fri, 29 May 2026 15:51:44 +0800
Message-Id: <20260529075147.88398-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OE3tIrIEWSq4UycHo1aNlzZMufyyLXjDp4erKBQoXLf+zP3zi/biXXfe
	f1TDf9rJB6RTzGvjIVQ3evqU/QqE7nb5dh4iIDkFb8i+Y+B0LDBjYfRD/jzlqK1RQOyZqLy
	SeyA/iLnmH/INyu+M3qgZwLMGKF+VveKdsgeGXvS9WlrPxVFeAUKtFDSBlNjkM6oFvBnVkT
	7fWch7YYRsxgn5sJFc1qG5Z/6/UGOnwHxWGhf48+YwFLvugF1MxQnG1UwO+XBWPT2C1V19F
	I/oPONuwQE+s6kCv17TtZZsSqrjkbxsU8GeLiZaX3rVxAxKTF/FW301gpcth5BQxmPbZAYJ
	lcKi1tKGMcjj0kkGeBSixZJrFsKbVLudUR+9PmCz6fIYZty1KKA0vAgUlPYrD7/ghmNmDkW
	H0Sqcwy+AbcIdPmbt10pMdEcGC8lsQcimeEVeBEq2RRTCAzMm/kWuIXJX6pP0GPoSjnHCg8
	XWS1XyCW/cjlmveDa+/naoWIRpwddeUveMns7gKlimvmmCH2x6DtvQHeXigVLUYJtiVMVkS
	PNm9DDId4tQ36RoL9R85G2wgxWxJ2/7St2kHujCbrMkDb5jZVS0M6XAiaW0obsoBaJCQycM
	DkQJkxpZjkr+lLb+6GRQbbuAqObcOaZ2Ki142R93DMqS05/nw/0n1wr6jJFqZr2sK4WnNZs
	nQOs8pMUg0ddJQLgsc2e8G1oUB5v8duNaoLmBxfQrSr4D3Uz/wmrAtK0Zw9wQEjVqGnUczi
	2oYxVAvr30tqlUiMEtPlKh1kt1Stvr3kkFKmQAvjTNZ0riWTPEx1bdFOxP1jxeu4M1ISq/i
	/XY3CxcjmaytaIS1DZ5c9Oj7a+uasaDn7xdIqv20P8DVir3pr7oq11O7bopJK6PrKKdSFgF
	lnhoB59r0JlSdgI84Kt81FjEnW/Ne+XTkfkaq/6N7JSLGYsvmCQ4mOOZfqJ3qfAPM3sZxsR
	4WyPd2T69Cyki1lAwjL7l+4NAa9ZdRozXF7d9PLmWac+0Hmta0bowkPt2GJJw4RcF7HXBxs
	xqOpB3Vnyg7FdGqDfNWxnZa2g2a7jqVxbZxau9xnJOHWctjvGoRabHr71HhkEbe4ZNbPSmj
	x+y3iF+oT2DlUirHhdSqkDy3Vu8vdVZAfCIhaoVbVX86KZz+N5ULG8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[net-swift.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293038-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: AF2CB5FEE12
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
v3:
- Patch 3:
  Drop netdev_stat_ops support from this patch.
v2: https://lore.kernel.org/all/20260525101115.13151-1-mengyuanlou@net-swift.com
- Patch 3:
  Remove some stats which can be replaced by standard stats defined in
  include/net/netdev_queues.h.
- Patch 1:
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
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  7 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  2 +
 6 files changed, 109 insertions(+), 15 deletions(-)

-- 
2.30.1


