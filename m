Return-Path: <netdev+bounces-111653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4952931F2F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 05:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE8D1F21C1A
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 03:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C1D53B;
	Tue, 16 Jul 2024 03:14:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286115ACA;
	Tue, 16 Jul 2024 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721099644; cv=none; b=Y3uxNe+cpp8RhKkYlI8Q2QN2/NTPmv67/Zxl//8HQGOqypN9PDRWBc1queHmw5jcmYoBdyMQoQvxbfBIbJSe7oLlIogYyJZi5B8lZIRxqRtLIXOMZ5qIUif7dVDK1aZ+CJLcgi3cu783NZYrf8JyfUd0sAZzVRzcvBCPp2FBBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721099644; c=relaxed/simple;
	bh=/TGUaXpu0w2Zo01DYM6wone38TrTwOdm5ugkWYKDdYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BeB2d7NUGihNraauG4BhX16RB8KEhjZVV1kJOF9kCFXNUBHXzQNTfs3DdJ67fNuzL5ouHnXBFxl5/aJ9TkahpXjEasKoi8uL8cxW4VIM+FA7qnrChG3vieffz6hrShH7fESZhL+uY/5k7dvw2wCjKyS/x6DGpfE9/3YJx5XWiOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from droid02-cd.amlogic.com (10.98.11.201) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.39; Tue, 16 Jul 2024
 11:14:00 +0800
From: Yang Li <yang.li@amlogic.com>
To: Kelvin Zhang <kelvin.zhang@amlogic.com>, <xianwei.zhao@amlogic.com>,
	<ye.he@amlogic.com>
CC: Yang Li <yang.li@amlogic.com>, <linux-bluetooth@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/4] Add support for Amlogic HCI UART
Date: Tue, 16 Jul 2024 11:13:55 +0800
Message-ID: <20240716031358.1256964-1-yang.li@amlogic.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for Amlogic HCI UART, including dt-binding, Amlogic Bluetooth driver
and enable HCIUART_AML in defconfig.

To: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Yang Li <yang.li@amlogic.com>

---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20240705-btaml-v1-0-7f1538f98cef@amlogic.com



--- b4-submit-tracking ---
# This section is used internally by b4 prep for tracking purposes.
{
  "series": {
    "revision": 2,
    "change-id": "20240418-btaml-f9d7b19724ab",
    "prefixes": [],
    "history": {
      "v1": [
        "20240705-btaml-v1-0-7f1538f98cef@amlogic.com"
      ]
    }
  }
}
-- 
2.42.0


