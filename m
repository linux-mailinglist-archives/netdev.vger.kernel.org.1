Return-Path: <netdev+bounces-73029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1717585AA72
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82D828099A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5522A45BF8;
	Mon, 19 Feb 2024 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxZ82dta"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171B3BB38
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365341; cv=none; b=k8OQNf49wPLfMN1X0gyIL9IWMnG7WO17IeJLwyfqhdHcnWq9CLan2pJwmMI50n8w1hrLXnOWmOe9gEa+TpoiF4Hd7mMsvWgkOx3n5iebeFD1Qa3SLwL+gQYMjPSqeQ+fCLcuJdx5JKg09WEDq4pkoRascHHJriITnMFCKGKrmvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365341; c=relaxed/simple;
	bh=4Cm7CK6itqMSFhXpBwpUuavxC80RrXnUw/thq+zPlfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yvpt6WujDG3aWTX0FB6GHuYWbSe5OKrL7g/CpYtGBsJb2YsvrtU7gLhZjXPjwxXc+8Y8GRBmwLvXROIo63EwHHUybl3nrR+cPtgVhuTNITCghziWKL91FuKXHuQnZghZHFLarn2MdIZOs33LlipYajX6QvNAxD3L8CybmEIE46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxZ82dta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BF4C433C7;
	Mon, 19 Feb 2024 17:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708365340;
	bh=4Cm7CK6itqMSFhXpBwpUuavxC80RrXnUw/thq+zPlfE=;
	h=From:Date:Subject:To:Cc:From;
	b=jxZ82dtag0JE299fwPOaocnIsny9rtzrEzu+fSe03r/qQikYA3dvIDBABLOBM5WY3
	 FxQA0BNEo0555qwo0dK8FdFqWnZZV52jZHchQ7dKu7WiXqBYD2z+Kfm9fxIpPbWxUj
	 9PWO2HEcf8eA7LGM0nEg7OtDeXP/D9uMosCpll+RvUMt9aTdkbckc8C9yJlOb48STR
	 K820KK3r+asbzE+6Xzn/+72EtTid6G8v7/LNxW0dFzzzK5YRPdWyAa4v6pspmjRKbO
	 YKMZQR44Ww30aICOiGrPHPuhomZcp1iixBcy3PUWPl70iFsJZdwptmvtT4eEYumfTD
	 wDDcvt6F16Ptw==
From: Simon Horman <horms@kernel.org>
Date: Mon, 19 Feb 2024 17:55:31 +0000
Subject: [PATCH net] MAINTAINERS: Add framer headers to NETWORKING
 [GENERAL]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-framer-maintainer-v1-1-b95e92985c4d@kernel.org>
X-B4-Tracking: v=1; b=H4sIABKW02UC/x2MQQqEMBAEvyJz3oAJCsaviIeoPToH4zKRRRD/v
 oOHgq5D100FKijUVzcpflLkyCb+U9G8pbzCyWJOoQ5NHXx0rGmHuj1JPg2bYIQp+sQtd2S/r4L
 lepsDZZw0Ps8f8qNOmmgAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Herve Codina <herve.codina@bootlin.com>, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

The cited commit [1] added framer support under drivers/net/wan,
which is covered by NETWORKING [GENERAL]. And it is implied
that framer-provider.h and framer.h, which were also added
buy the same patch, are also maintained as part of NETWORKING [GENERAL].

Make this explicit by adding these files to the corresponding
section in MAINTAINERS.

[1] 82c944d05b1a ("net: wan: Add framer framework support")

Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0697e2fb8e8..466a0fc46f76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15237,6 +15237,8 @@ F:	Documentation/networking/
 F:	Documentation/networking/net_cachelines/
 F:	Documentation/process/maintainer-netdev.rst
 F:	Documentation/userspace-api/netlink/
+F:	include/linux/framer/framer-provider.h
+F:	include/linux/framer/framer.h
 F:	include/linux/in.h
 F:	include/linux/indirect_call_wrapper.h
 F:	include/linux/net.h


