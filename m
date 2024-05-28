Return-Path: <netdev+bounces-98520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90ED8D1A87
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269321C228E9
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3216C848;
	Tue, 28 May 2024 12:01:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AB71753;
	Tue, 28 May 2024 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897706; cv=none; b=VO7egTa9/CqFldG8p6pdbRO2V6OdHsrSud+v/nc6zBQggOrPZqejHwm9T9g2afyp6mWHYf/mV+va1IteNwk0N5Lv3kJwraBOIeWN92xav6EfUimGKBpikFNavCduSGgL/24tga6zZZ35Rnp1y9CjoPmgRfQjQPQJSGtvtZAIYCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897706; c=relaxed/simple;
	bh=zfx0MSh1KhRgg8DWNyYAPlhEMV4YZB4dHZzaBYVC0so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSbtybrkQz8Qlip8KOT7LtmGi6VCM/SrH7vFh/HQ2wKGthCL4+5zUJL3KR35dvCtXIGW42WSBkkAHN3KUeiago4pf4GfphC/i5eDKhgl82VWaOYtJtpXLBqhqsBPGHHvioWbgHOMxanYYOVDEg0P6RT2JkNj8mR7iQY3mJRhbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.60])
	by smtp.qiye.163.com (Hmail) with ESMTPA id E4C547E0162;
	Tue, 28 May 2024 20:01:12 +0800 (CST)
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
Subject: Re: [PATCH 1/1] dt-bindings: net: rfkill-gpio: document reset-gpios
Date: Tue, 28 May 2024 20:00:40 +0800
Message-Id: <20240528120040.1021052-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <35400cd9-176b-4a87-94d5-f3400628f19b@kernel.org>
References: <35400cd9-176b-4a87-94d5-f3400628f19b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHhlJVhhKHxpKHU4ZSB9PQ1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKTVVJTlVCT1VNS1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8fbf136fb203a2kunme4c547e0162
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjI6Qxw4TTNPOQ06DDwvNhQp
	PygwChhVSlVKTEpNQ0JMTUxITktKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VNS1lXWQgBWUFKTUtNNwY+

> Please focus instead on why.
>
> https://lore.kernel.org/all/d096d9ea-39db-4a15-9c4d-ae228db970cb@linaro.org/

Thanks for the link, I missed it.
But for the 4/5G modules, it usually has multiple gpio connections
and cannot be controlled through just one gpio. For example, when
rfkill unblock, if the module is not reset again, it will not work.
In this case, can rfkill-gpio be allowed to use reset-gpios property?

Thanks,
Chukun

-- 
2.25.1


