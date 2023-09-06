Return-Path: <netdev+bounces-32217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D2B7938EF
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBCE281395
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B48A46B9;
	Wed,  6 Sep 2023 09:52:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2846AD
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 09:52:33 +0000 (UTC)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5240B171C;
	Wed,  6 Sep 2023 02:52:30 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-794d98181f0so144132539f.2;
        Wed, 06 Sep 2023 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693993949; x=1694598749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfcT1TUG3JFbje5YkAW/OMHaDMFlJNMAHeJBaOqjF0k=;
        b=GcP/TQ+/Wl2zoQbq5VEgivPYY0OcHjkr91eGbsUtSTbuGV8DNbKJz30IU6xt/4uBgj
         +Z1ZsgFBaKkWJ3MV91xZWWj2nJxVpSJG8NnlMaO6JYdwbnsEXCpJbz+1rVhWWiIPgcID
         z9WAUSbdShYwSH8lPF0lEMx0vKEzY3+mDKPZ5kr6Hsu1iedmW0eqQw0i0dQim8lyura0
         InhKTDnr5kN5WA+Zaq4Yv1gLNG9G14B/iO8TqZ53O1HeTvaxoUzYABPxQpYx7Dq3c9aP
         7/HJvnrJAjyfKbYsSTeSdUR+B8G1fTqa3iln+1rJq8HYxaqo8QhNf5iim6wjJk+A+4cj
         Vdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693993949; x=1694598749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfcT1TUG3JFbje5YkAW/OMHaDMFlJNMAHeJBaOqjF0k=;
        b=XQa4IXsJSczm1r0vfzXIytblg+I+kYkaEOonOEQrlcFqll81oez+14xWSAiVptDkyH
         HXNEOjcL4boTPDTim7exXFcZmqUkMZn7kaJMvgI+rDuNmC8gzaevn0g6Q6uMNtqxUgS7
         TIgf4u/ZkF489KkdB4vR0KM9XpuCo4KN5TlfMYHhcr5GYECEfDqVeGA5df1NsxaAhsKP
         YTHT1LjfpNt3TRnLRLouihkcZnsW8rV9RXkwBwZ1/TUAUuy0tAkHuCrt8mJhMkkBKu9B
         Ts28IUpB9BvuoSD5n6txRdVv16gmx1y8rHQcYrveXUP0olnBuDuaqVLi+B3QdXZmLwGL
         /xUQ==
X-Gm-Message-State: AOJu0YzP6nGzp57QC5KVtHKyqeFJ/w9PBaPSNX+Z9ZlhPT3BAB1KdSSU
	77jmTXi0T+6otDU2TMZB1SbSQt4PPis=
X-Google-Smtp-Source: AGHT+IGQP29U72+M4hbjUqHN51HiNG/Oo980jxDNWg3+4uFCpInhCkpe/PcSiQ5hfZ/rZeAGc7si4g==
X-Received: by 2002:a5e:c705:0:b0:790:a905:5fbf with SMTP id f5-20020a5ec705000000b00790a9055fbfmr17284053iop.11.1693993949302;
        Wed, 06 Sep 2023 02:52:29 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:b68d:99e6:78c9:f0e6])
        by smtp.gmail.com with ESMTPSA id i23-20020a5d9e57000000b007836a9ca101sm4794744ioi.22.2023.09.06.02.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:52:28 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-omap@vger.kernel.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 2/2] arm: dts: am3517: Configure ethernet alias
Date: Wed,  6 Sep 2023 04:51:43 -0500
Message-Id: <20230906095143.99806-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230906095143.99806-1-aford173@gmail.com>
References: <20230906095143.99806-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The AM3517 has one ethernet controller called davinci_emac.
Configuring the alias allows the MAC address to be passed
from the bootloader to Linux.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/ti/omap/am3517.dtsi b/arch/arm/boot/dts/ti/omap/am3517.dtsi
index fbfc956f4e4d..77e58e686fb1 100644
--- a/arch/arm/boot/dts/ti/omap/am3517.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am3517.dtsi
@@ -15,6 +15,7 @@ / {
 	aliases {
 		serial3 = &uart4;
 		can = &hecc;
+		ethernet = &davinci_emac;
 	};
 
 	cpus {
-- 
2.39.2


