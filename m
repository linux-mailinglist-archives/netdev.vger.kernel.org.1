Return-Path: <netdev+bounces-200692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAECAE68DD
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54DA3B578A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9906B2153C1;
	Tue, 24 Jun 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ+GM+Ww"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4E23741
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775330; cv=none; b=AG9FBncQmf7Ad2bb1D+iXb32JTXWi6IxhFEz23AnEYoFSrTjj/XN//lClFZ2qDTEdRAoYm5/iykBD5EZG3X0l58QMoiVLXSeL3BTvZEm7mQk78qXJkBOOIgseLqJxlXBRj1aNqt9mZdqYr+1haALHOdZq8U3ts0Eb/B7DXj4RgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775330; c=relaxed/simple;
	bh=SzIoD737khL7R5OTC7xjiFnkfL1BC5hgkoTlTjIg28k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZyWZPbq2eBJMPrCphWY59e7+ATGWrwjvDhha1Zfeua4I4VY4Dm4f2lylhPaDYKQdrzMuf2wPQLv4fbFd7rGkMkoHKazEJyBdvfY/eXA3cqXw0sCVFAXaTbfRAKPfNN42SFTP37fmsuC6j25eA8CbVkeENhSOE+uQyBDJVX678s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ+GM+Ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C74DC4CEE3;
	Tue, 24 Jun 2025 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750775329;
	bh=SzIoD737khL7R5OTC7xjiFnkfL1BC5hgkoTlTjIg28k=;
	h=From:To:Cc:Subject:Date:From;
	b=ZQ+GM+WwO3XI7bmJzHw9Y0j7dE/APRaDU0KDy9cR1K5SRUg2reRGENvWyG1FkULAx
	 T30VCNMGz7ikoR0Ek/Jh2X/jZpI/qCyWch5Xc082Fsq721+zPAP/QtU19ywfnbvK8D
	 iu6baf+3EuBUFCQoyvGtCY9XpKrepFBvDVIe+ZJxgDl9OOEyDjPHQGSsua8pwgvquL
	 I6JC5Gj+cT/+9I/q1mTwklf3qFiAAsGhdz+z+AtJZkFwJzLMSFqajDsjU9NwwdbRGy
	 hPB3WtoSgQh3TCENYchflzou3DGu6zWWTIvM8rYNakdwJ1kQHOw5jo3FUIyrfWqubJ
	 FmQaiI1CwTOZg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	mohsin.bashr@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] eth: fbnic: trivial code tweaks
Date: Tue, 24 Jun 2025 07:28:29 -0700
Message-ID: <20250624142834.3275164-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A handful of code cleanups. No functional changes.

Jakub Kicinski (5):
  eth: fbnic: remove duplicate FBNIC_MAX_.XQS macros
  eth: fbnic: fix stampinn typo in a comment
  eth: fbnic: realign whitespace
  eth: fbnic: sort includes
  eth: fbnic: rename fbnic_fw_clear_cmpl to fbnic_mbx_clear_cmpl

 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 22 ++----
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  8 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  5 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  3 -
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   |  4 +-
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 73 +++++++++----------
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 30 ++++----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  2 +-
 8 files changed, 69 insertions(+), 78 deletions(-)

-- 
2.49.0


