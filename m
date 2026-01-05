Return-Path: <netdev+bounces-246945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A947FCF29F1
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 10:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 956883024F66
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F0C32E72A;
	Mon,  5 Jan 2026 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2F55jyd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71C32C33E;
	Mon,  5 Jan 2026 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603801; cv=none; b=BI/mQz3sPUXg2mYUpctMXgutT1VoD1V4/aGp+eStu4Xmva0p3vw5klOUAgSla2qILiV145ceENjcLCb4VZycIrcgxYl+imiXvyQa4bHydoVzIVXBi/CXNFUqDZSEO+iGiGxNjf+khA3XphFJcXWpESCc1DR9KpFt2TfsWUvXDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603801; c=relaxed/simple;
	bh=V+xA5EARlczpo3HEUeQMynrALtQ9E+tYDnkD4JHTyW8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sgddHpiIV6DXWRYD1LYBYaBvu3OIOA2yBJs+csjoyL5v8CYDOMft1GAvff4Nkud0v5F+up7pT+3O3zegHXoefl7E2PGmfhEVhzdJwsD3xSQlIZUasDcACwb1WK4j7eqS6YO1Az589quCtielth15MNZlREaDPBd/jYCNGO3Illw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2F55jyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2577BC2BD00;
	Mon,  5 Jan 2026 09:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767603800;
	bh=V+xA5EARlczpo3HEUeQMynrALtQ9E+tYDnkD4JHTyW8=;
	h=From:Subject:Date:To:Cc:From;
	b=U2F55jydFouj8ssrsi8tLLJro+12tJ8qOcq/0ZKUig63/+zmYLqe3HSu7vjOugnSl
	 n5TV5uVtZnLCIU3hp7EfNuuSLPosdJMF2atLJIM6S8WA/BRnnM/Ww+O9T/o4UBLvVX
	 a9tRXEPYGybck9uuTG7O2wECn8TJJHudLx9Q7vyEByoW3kBD9hfGN0/CMqDBZuexwf
	 JrB634HrDGdi6nibIuTzCmBxpwg2Vn7coozx9CRylYCf2Fa0Eu+DTFMmNZuAXGKTbM
	 xmQ3Eq1bxKhHjBdiNNp6AcvbMvSy0rQkLaH3ewU5vtda+ULEAIdCG6yq4hZC/hyFy0
	 3JRYFdvKgevRA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] net: airoha: Init Block Ack memory region for
 MT7996 NPU offloading
Date: Mon, 05 Jan 2026 10:02:55 +0100
Message-Id: <20260105-airoha-ba-memory-region-v1-0-5b07a737c7a7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MPQqAMAxA4atIZgNt/Pcq4lA1agatpCCKeHeL4
 xu+90BgFQ7QJg8onxLE7zFsmsC4un1hlCk2kKHSWEPoRP3qcHC48eb1RuUlGizqqaE8q2xWE0R
 9KM9y/eeuf98PtGcaIWkAAAA=
X-Change-ID: 20260102-airoha-ba-memory-region-58d924371382
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

This is a preliminary series in order to enable NPU offloading for
MT7996 (Eagle) chipset.

---
Lorenzo Bianconi (2):
      dt-bindings: net: airoha: npu: Add BA memory region
      net: airoha: npu: Init BA memory region if provided via DTS

 Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 11 +++++++++--
 drivers/net/ethernet/airoha/airoha_npu.c                     |  8 ++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)
---
base-commit: dbf8fe85a16a33d6b6bd01f2bc606fc017771465
change-id: 20260102-airoha-ba-memory-region-58d924371382

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


