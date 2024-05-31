Return-Path: <netdev+bounces-99702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA82C8D5F86
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 12:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BBCB23305
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887CD1509AF;
	Fri, 31 May 2024 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in0C/vLC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20236134;
	Fri, 31 May 2024 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150952; cv=none; b=ikpdGZAPC86Ff1SB61UcYjxcgSGwmNZs0vZ1LieNFAPzkFgbJU7fpOAabt+YY5tuaxxTAT348JkXmgsI1DpmCko/ehixg8nvWjs/o/o+fkPtIDZlaLOgM52dltYoRnZf1/xynEQZ2/kC3HDsjBKxk67RzxJoKjXa+E0RDOUEksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150952; c=relaxed/simple;
	bh=WQ5KjE3FayifgtccZSf+eqppJtRC/22af7rfJ/uCD4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntiSwvIBfNP9qTvD69j/nEhZoLjItzlnc9r509m14M9JlTKZMQg6GwvcOiGZo4Mx5zFXD4Hr0o2hl6jZdoIrhFE6vFgODG0N44ns/jv7RMQNmvCePwiAQIHQ9yhNEoioXxMt/bWW1fEL8R+Mrq/W1iAlF3n7P6P1WXguvo5SIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in0C/vLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B76C32781;
	Fri, 31 May 2024 10:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717150951;
	bh=WQ5KjE3FayifgtccZSf+eqppJtRC/22af7rfJ/uCD4A=;
	h=From:To:Cc:Subject:Date:From;
	b=in0C/vLCelfGMYs+gCxjXApD6iU++oQRpc2NB5SZM+cpsy3Eq1xJsbi9Ti0jhxkYU
	 1P/t8ELNbx6DbcIPsUsiN9vNPLxx0HztNIil/5WJmhXngQFMnKwV8OsOmt6e63NA+/
	 tTECZYH8lenBlvPLEuwK+EvjHsB+JdQeVA+r3OB+RyXQ7ZBeD+0aC/RxMqYqILZlfV
	 DdvuGbUQXrJGouGN5wxILviUTr0B2OyXMWi5pIHFI7AfLrppIx2+yAyasPHE6NcpRa
	 FAt0Z+X3tGdDJgWodLLSWfXFn/SSZXWOxWrYGKLYdxpfOM8rN4s1EpBasXuOj+XFD0
	 NEZLdZKoZePYw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu
Subject: [PATCH net-next 0/3] Introduce EN7581 ethernet support
Date: Fri, 31 May 2024 12:22:17 +0200
Message-ID: <cover.1717150593.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add airoha_eth driver in order to introduce ethernet support for
Airoha EN7581 SoC available on EN7581 development board.
EN7581 mac controller is mainly composed by Frame Engine (FE) and
QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
functionalities are supported now) while QDMA is used for DMA operation
and QOS functionalities between mac layer and the dsa switch (hw QoS is
not available yet and it will be added in the future).
Currently only hw lan features are available, hw wan will be added with
subsequent patches.

Lorenzo Bianconi (3):
  dt-bindings: net: airoha: Add EN7581 ethernet controller
  arm64: dts: airoha: Add EN7581 ethernet node
  net: airoha: Introduce ethernet support for EN7581 SoC

 .../bindings/net/airoha,en7581.yaml           |  106 ++
 MAINTAINERS                                   |   10 +
 arch/arm64/boot/dts/airoha/en7581-evb.dts     |    4 +
 arch/arm64/boot/dts/airoha/en7581.dtsi        |   31 +
 drivers/net/ethernet/mediatek/Kconfig         |   11 +-
 drivers/net/ethernet/mediatek/Makefile        |    1 +
 drivers/net/ethernet/mediatek/airoha_eth.c    | 1552 +++++++++++++++++
 drivers/net/ethernet/mediatek/airoha_eth.h    |  719 ++++++++
 8 files changed, 2433 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581.yaml
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.c
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.h

-- 
2.45.1


