Return-Path: <netdev+bounces-37909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B9D7B7BBF
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 11:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2EFDC1C203D6
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD1610976;
	Wed,  4 Oct 2023 09:19:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E57E10960
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 09:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C2FC433C7;
	Wed,  4 Oct 2023 09:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696411149;
	bh=tEO8vCCvisCz4+5j7sExpN12U3KtcRG5oAUcYxTNdFA=;
	h=From:To:Cc:Subject:Date:From;
	b=KTc7tBd/7KO2ix1Zsu9gDCfepi+VUMdElp5bnraAjnXlFgHpoz6E413trG7WQ+Q9K
	 m/6Hsxbn3UmEPM34y9mDd5htG/RMtQwq8hkJ9R29GgkQaQCBUzO8M5lr9CdtzC76mM
	 CFQff7CFBGOSHUsBDIMqOaUbpXo8RIQkJ1h9+awNSMW9Oorkl79x5xG8ITFTNIs3wb
	 zvdMwDdGZK/uf+KwR1VCQg58aZMRkgXx8H4G6qLdKEi4wWrTMzvFM8u2nX+cuAanDt
	 RXVmI836zOeEbju0v6c8hHKNpAxGP57DEXgkNq05KY1spjk6XWSxO77eCT8dim5Grt
	 sl5Ql75xymbIA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net v2 0/2] net: dsa: qca8k: fix qca8k driver for Turris 1.x
Date: Wed,  4 Oct 2023 11:19:02 +0200
Message-ID: <20231004091904.16586-1-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

this is v2 of
  https://lore.kernel.org/netdev/20231002104612.21898-1-kabel@kernel.org/

Changes since v1:
- fixed a typo in commit message noticed by Simon Horman

Marek Behún (2):
  net: dsa: qca8k: fix regmap bulk read/write methods on big endian
    systems
  net: dsa: qca8k: fix potential MDIO bus conflict when accessing
    internal PHYs via management frames

 drivers/net/dsa/qca/qca8k-8xxx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.41.0


