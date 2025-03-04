Return-Path: <netdev+bounces-171657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF89A4E0BE
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F53B189F1AB
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA935204F6C;
	Tue,  4 Mar 2025 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fuaar3L4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971721FF1C1
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098090; cv=none; b=aVQwBmx4ogE5ijuI+LNqcyAFOIgGCaOAFqx4vzUFm64i86XTDMxZQHjuQDUiNpXUrLU4mn7HJVFmJA71sb2vq+Bi2JCc+i59xFIDqHjQc0ApQeWdE7qVVbK69CDo1VpE1bFHnqJM3BGRfpMNCu1yHGegbMH6AdYsQy8F72GR/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098090; c=relaxed/simple;
	bh=MhGN41K3h5wvzfaPu/fAdR/Ut2sL0VepW3PUQjaeqC8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g+69+oZHTavuMnBRm0vNRl4L8RrAi+XbNb/ruKkVnf2N5yz6lc8t5JDMlIfWo755Tl6scC86O4fGJ/dnaNSSUpoasMrBLK0er1pc4NtQ+4VBp1+JYfHactFEbQlWmS02quzBb66mmF+m/FYrfXbjzEDjGmRqZK4AeN3BBu83CSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fuaar3L4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17932C4CEE5;
	Tue,  4 Mar 2025 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098090;
	bh=MhGN41K3h5wvzfaPu/fAdR/Ut2sL0VepW3PUQjaeqC8=;
	h=From:Subject:Date:To:Cc:From;
	b=Fuaar3L4twKYOWqPzk8o8YCPuss4eTN5NxRMYbiH2yE3BkYQB/A1xkzssUaA7lNyG
	 yokhs+OqsBOISumhPRBLSPE67YoRVkEuywbTRoBVPkgwWv8WvKdzMh5pQ/BRcl4SCk
	 AdjjhrTAdlBzSUTFnRSWaARDT0PHKhxmAofx2X8dhALmNce2UdDHzYYBs6oxRY9jik
	 uQd5Ryq+Bblb5bAePQNEu3S9KoT9t+s1ThI32aluB0R7WFEMaUhsm13jqY8RMDC4vi
	 TSw72vUC7xF1F8nyxAQn3q6RZuvX3tPxgLiMd2Sg6xQaYsphXDIuVKCY8tJLPn2jUQ
	 5NAQic95D0reQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/4] Increase maximum MTU to 9k for Airoha EN7581
 SoC
Date: Tue, 04 Mar 2025 15:21:07 +0100
Message-Id: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMMx2cC/x3MTQqAIBBA4avIrBvQ7Ae6SrQwm3I2GWOEIN09a
 fkt3iuQSJgSTKqA0MOJ41lhGgU+uPMg5K0aWt322uoOHUsMDukOKBnTgc6bwW69XkdroGaX0M7
 5X87L+37KcF9tYgAAAA==
X-Change-ID: 20250304-airoha-eth-rx-sg-ac163d50b731
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

EN7581 SoC supports 9k maximum MTU.
Enable the reception of Scatter-Gather (SG) frames for Airoha EN7581.
Introduce airoha_dev_change_mtu callback.

---
Lorenzo Bianconi (4):
      net: airoha: Move min/max packet len configuration in airoha_dev_open()
      net: airoha: Enable Rx Scatter-Gather
      net: airoha: Introduce airoha_dev_change_mtu callback
      net: airoha: Increase max mtu to 9k

 drivers/net/ethernet/airoha/airoha_eth.c  | 97 ++++++++++++++++++++-----------
 drivers/net/ethernet/airoha/airoha_eth.h  |  3 +-
 drivers/net/ethernet/airoha/airoha_regs.h |  5 ++
 3 files changed, 71 insertions(+), 34 deletions(-)
---
base-commit: 188fa9b9e20a2579ed8f4088969158fb55059fa0
change-id: 20250304-airoha-eth-rx-sg-ac163d50b731

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


