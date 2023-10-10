Return-Path: <netdev+bounces-39568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E27BFD43
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BB72819C2
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4228208C5;
	Tue, 10 Oct 2023 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="E7BDpSyv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF888BFA
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 13:22:52 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A6AC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CgV//G1uYpZ5/atwrJv//Vk46ibNjcYmUJiUebJQ2ZU=; b=E7BDpSyvGvx2hyzaiwyJaiJdDD
	YkeGYaa1yYc2RbrAfWZoKjHsti8hzK3YPiSNSEmg0Afr5diR01tCfJzLoLy56TEGCPDXEmhAf9EqZ
	VGPElWQRTo2UGDZXdDgRdTsuM+i5rHyasbnQFYOX7h5QNK1MQh3KXt15vBPk6AjpbpDjXXPg9b3Ez
	/Rqmp/fS4ySuBkkT2rQE7hl55LucM3f3VKpcMHi85LQgf15Fua4qPN1lNOZE6TMj+SdjL6Vogxs7A
	W0p8lW0I1992RYflW3KHrLRt0FVu7eN+0yJ6lHD81pdd0lr3AhQgC8oZJckfkZ9K4XhjHLZ3iwJ5A
	D4pbQyBQ==;
Received: from [192.168.1.4] (port=20309 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1qqCdW-0001iY-1y;
	Tue, 10 Oct 2023 15:18:58 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 10 Oct 2023 15:18:58 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <marex@denx.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next 0/2] net: dsa: microchip: enable setting rmii reference
Date: Tue, 10 Oct 2023 15:18:52 +0200
Message-ID: <cover.1693482665.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

KSZ88X3 devices can select between internal and external RMII reference clock.
This patch series introduces new device tree property for setting reference
clock to internal.

Ante Knezic (2):
  net:dsa:microchip add property to select internal RMII reference clock
  dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal

 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 6 ++++++
 drivers/net/dsa/microchip/ksz8795.c                          | 4 ++++
 drivers/net/dsa/microchip/ksz8795_reg.h                      | 3 +++
 drivers/net/dsa/microchip/ksz_common.c                       | 3 +++
 drivers/net/dsa/microchip/ksz_common.h                       | 1 +
 5 files changed, 17 insertions(+)

-- 
2.11.0


