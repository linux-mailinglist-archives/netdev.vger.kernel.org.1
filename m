Return-Path: <netdev+bounces-98653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB838D1F4C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94C81F2124F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F379F6;
	Tue, 28 May 2024 14:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79AC171068;
	Tue, 28 May 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907969; cv=none; b=Q0SPhCaetbtBes7rJTmvkdXpVgb9RdVysPeGgBWdfjyFqmhCxEEtWbpBnREPBLTkZ2U3Caf5Ofrw3ttTMTQkq35fn3bXEBTLxhNPie2/Re1SAc4OGSJnLOhMohek2CUeKzOAcrHj+USnvqHG/WMWK4EMcWd212UA2yuWWgAKqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907969; c=relaxed/simple;
	bh=26cjej1Diaq+7Zs0Tgzi+ST0S9UE7HEhJtsNQRfU5ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bc7bghr6yu78Mor5rgAsQ5Vje41whKP+qQvDS27no7mrCzNi+awpm98NUJXFslle6tHI23/rN6ikha4o8cGlQEgcLFpJtc2JjDgnmynoNi5DlE3Gdcv+uZ8W0WU8qIfBMGtj8m1nBZwIWe6rV7DQ2j6gVRckkmuDzzCRQdThVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c07:2740:1619:be25:bafb:489])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 1F7BE7E01E0;
	Tue, 28 May 2024 22:52:28 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: krzk@kernel.org
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	johannes@sipsolutions.net,
	krzk+dt@kernel.org,
	netdev@vger.kernel.org,
	p.zabel@pengutronix.de,
	robh@kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: net: rfkill-gpio: document reset-gpios
Date: Tue, 28 May 2024 22:52:25 +0800
Message-Id: <20240528145225.1034979-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b1b4c98f-a101-4d3e-8720-736159bc2feb@kernel.org>
References: <b1b4c98f-a101-4d3e-8720-736159bc2feb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkgaVkpPSUgdSxlLQhofQ1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0xBSUxPS0FKTUpCQRkeSU5BGRodGUFPQ0JZV1kWGg8SFR0UWU
	FZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8fbfb0393203a2kunm1f7be7e01e0
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhA6Kzo6IjNOFw0NPUI1PjM*
	CVYKCiFVSlVKTEpNQktMQk9DTUNNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0xBSUxPS0FKTUpCQRkeSU5BGRodGUFPQ0JZV1kIAVlBSk9NSzcG

> Which ones? Can we see the dastasheet or schematics? People claim
> various things (like device reset-gpios being part of controller...).

Unfortunately I didn't find a public datasheet. This is a screenshot of
the GosunCn GM800 datasheet: https://imgur.com/a/4ecCGiy

Thanks,
Chukun

-- 
2.25.1


