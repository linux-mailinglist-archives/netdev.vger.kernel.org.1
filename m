Return-Path: <netdev+bounces-197889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69157ADA29A
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 18:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1874416BBAB
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDCD1E3762;
	Sun, 15 Jun 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="JSf5ARVj"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E3113B5B3;
	Sun, 15 Jun 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750005740; cv=none; b=XjV2NFaWJpdcG2WY43pyffyMnovFdSzBK7ZG1z6VR8zCxmvradudAJM7aqwtdOI4Hj97py8zP2wMOUCU+m91ov1+DPQoKGCJwbijWuY2/AD8FIRe4Q2hmDEQME2p6kiB/zo/bnBsClnOs1BNHn7T13b/idUsY00g49myVrnhG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750005740; c=relaxed/simple;
	bh=QKcZxZXwwFGx6k0XrSFLjyB45TJX1o/2X8RQBqjF5Nc=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=TV7WIC8EhlvZ+SsoBwZWILRe9J3L8GmXdIxNOFOin1GJw7ngEP0sXIEO5EfNwmTvwGOJTEW549Qc8EMwod+eQXgZ//FKhq/uOIZHWiBFvLNhoBdUOKv9PVUkuu7FES2jjiIJwvOgSGIzLryTfe/MkiBQkiSIojzfgqWmRHyyU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=JSf5ARVj; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1750005735; x=1750610535; i=frank-w@public-files.de;
	bh=QKcZxZXwwFGx6k0XrSFLjyB45TJX1o/2X8RQBqjF5Nc=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JSf5ARVjN2H1oqrX4p34XAxsluXp3Lm3SsqU3/lhMnJmdfHjIE+8YeUrieR19GP9
	 tcmfgrKzGMzMw9/02lvJcABgJBtLLOOP4+W8oxL160yXHT4lIqxVNqRlrj69GmkYt
	 CyOMKngbiC62hZRBCXGSQN6/W6BclDDls1TEh6nHKt30GYg1Y7Ng+Q9badilN+JJr
	 KGL0uSLn74MjiU39zhoPqSBqhldKpmgje5EQDb15tPp8V1oGLT+/2/umehLpk91hE
	 9QmDbkkGaTjANkAjkRWtDm/MqPmVVZyDt+ikCbJ10ppzRb6ghDmp83DB1t+UGWLqm
	 peNg1Ty0WjwPOub1GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.71.3.253] ([100.71.3.253]) by
 trinity-msg-rest-gmx-gmx-live-847b5f5c86-84n87 (via HTTP); Sun, 15 Jun 2025
 16:42:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-eafa403a-1d9f-4842-a65c-84badd4fa6ee-1750005734980@trinity-msg-rest-gmx-gmx-live-847b5f5c86-84n87>
From: Frank Wunderlich <frank-w@public-files.de>
To: linux@fw-web.de, nbd@nbd.name, sean.wang@mediatek.com,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 horms@kernel.org, daniel@makrotopia.org
Subject: Aw: [net-next v3 0/3] rework IRQ handling in mtk_eth_soc
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Jun 2025 16:42:15 +0000
In-Reply-To: <20250615150333.166202-1-linux@fw-web.de>
References: <20250615150333.166202-1-linux@fw-web.de>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:gfzxyuXSRRAJZTS3O6R2MPK4ZqeDCQnmkhoEmwuunLO3iPNh65Ny1QVJsiAyB7EOpPrXt
 fmmdFXLL4sHsZVzMO3zK0qjMiYeWlcV8CyAn0KzerScECnEOn7GGWtzkIls3N+Hf1JMMnylZya4K
 GuH7SrsB5b8q4gwM+gXO4FcV7p29qRSTcmPDL2odUCPo+Ekb5BO6enXTUwyxUzgOsIGBFlWK/ck/
 qAwIyB21HxT6T596Bdbz4SwUOpDW4VedeugLlWSJ+iv67YCmXpOIS+lplBywVrMHpirIi+vvqNuE
 7RM8IbHuKlCtiWkaxDNP40Y7RcbJ8aqTHjRbU62rs27fM4QlK3vCFanVb9v9hkv140=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z46WAXs0WfU=;0KChdF0K4ur9LAkuyndxm1pe2yZ
 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
 zl9I91XGrtZFECMjJRAMdJd1bxow==

> Gesendet: Sonntag, 15. Juni 2025 um 17:03
> Von: "Frank Wunderlich" <linux@fw-web.de>

sorry, missed the changelog:

v3:
added patches
- #2 (add constants for irq index)
- #3 (skip first IRQ on ! MTK_SHARED_INT)
to the v2 non-series patch

https://patchwork.kernel.org/project/netdevbpf/patch/20250615084521.32329-1-linux@fw-web.de/

Tested on BPI-R4/mt7988 with IRQ names and BPI-R2/mt7623 and BPI-R3/mt7986 with upstreamed
dts via index-mode.
I do not have any MTK_SHARED_INT (mt7621/mt7628) boards to testing.

