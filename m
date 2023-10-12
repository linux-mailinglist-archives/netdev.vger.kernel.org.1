Return-Path: <netdev+bounces-40324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F57C6B9D
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42D0282845
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070391D68D;
	Thu, 12 Oct 2023 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="TA8K93Uv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E485A12E47
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 10:56:13 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBBDB8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 03:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FtpKSP0hfJHCZWhMxfal7y4RuMSvS97qM5FFvV8QAOw=; b=TA8K93UvfrOuoV4BXvy2ijoeKs
	TFOL88N+OOGc9g+fVjjf2AnAnc79x9P9OA53M/rA2Rd4zS1H0ss8Eynjl4THzOb+fF6QHZHufw5rz
	IqiLH6pYtBOcj9csQBwlQNXjNRRTSB/gMX8Ca46wNCj1VkNCp5dlsTOLS2bax3isPA4NdKJgB4Q7A
	32YwO7UsaDRHLbqb9K7jVlff+IU127QeX73BoneVmLvrgEgRqZ3mCp/DSczSSH/zch7pClAal409N
	s/1DBtp02ewZ21BS/dPfrOHxXVumkICXPnZW5sO77lB56TUMhzpM2iutI0pu+4Ow66XulGnppodw1
	Ht/51hAQ==;
Received: from [192.168.1.4] (port=44470 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1qqtMM-0005Tj-1W;
	Thu, 12 Oct 2023 12:56:06 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 12 Oct 2023 12:56:05 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <marex@denx.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ante Knezic
	<ante.knezic@helmholz.de>
Subject: [PATCH net-next v2 0/2] net: dsa: microchip: enable setting rmii 
Date: Thu, 12 Oct 2023 12:55:54 +0200
Message-ID: <cover.1697107915.git.ante.knezic@helmholz.de>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

KSZ88X3 devices can select between internal and external RMII reference clock.
This patch series introduces new device tree property for setting reference
clock to internal.

Ante Knezic (2):
  net:dsa:microchip: add property to select internal RMII reference
    clock
  dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml    | 19 +++++++++++++++++++
 drivers/net/dsa/microchip/ksz8795.c                   |  5 +++++
 drivers/net/dsa/microchip/ksz8795_reg.h               |  3 +++
 drivers/net/dsa/microchip/ksz_common.c                |  3 +++
 drivers/net/dsa/microchip/ksz_common.h                |  1 +
 5 files changed, 31 insertions(+)

-- 
2.11.0


