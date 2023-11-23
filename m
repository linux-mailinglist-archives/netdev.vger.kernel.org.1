Return-Path: <netdev+bounces-50420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB187F5BB4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D12E1C20AC3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B0D22069;
	Thu, 23 Nov 2023 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXNbjR2I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D28D53
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 01:53:27 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9fa2714e828so82675566b.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 01:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700733206; x=1701338006; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5PTUYNfjDRM6hFUG0kEFnuiLCZkCTK1/4z2ebtULOs=;
        b=YXNbjR2IBskCzzYNi+xkP3xf7oKBX87ebs91q5OzyBWQpnDV0/wD7VFtJ8RN9GypRV
         n7XWqPU0kouTQXa0GYmEuTWiTyvOmt48S6ojFVI8IxsreI5uTSgq+gt2h9w5J41ASFjL
         DhzQdS5wLZ50k04F6GWrKKU2mTAAAoCLCooLSV/xCLuxNOsI49T6+4mXUa7RE9FQDPpB
         nqWxm/jlmvlfNVHgZzGML5jc+TcfSjwBcP2bOaLPJ0RSniAkmGDpaAEqGti7XXZaWqbA
         A9U76T/qdynbpQBUcSnEGYPkMFhcti7V6Rt8JhiG+F0lhMT2SNJXy7Thk2tcw6hYIbOq
         QH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700733206; x=1701338006;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5PTUYNfjDRM6hFUG0kEFnuiLCZkCTK1/4z2ebtULOs=;
        b=J8VGmB6UkAe5uzTJLeZvIiJKo+nVtACJlHnX6Z8qaI/zj7vfxRl0If11HKZ05GXcj/
         CTcpQ/f+ZWCLZzDyGoHX+E6GCdlX3CaquoSJ3a+CijPO+LncmXkR21wAkj75i7kok3aP
         PDXTO+8YstmNuK0JWAUuvxdmqtz0a/7vfTfxXh/4CDsolPUOKfZiPFxyaBY0ThVBLoZ0
         kCE3ij0FBhgvJHonj5ob/lbfumgY6h9FQC2Fd8DBBbxCq0Pq9rdGv5gGXzOyPadcVUSv
         RLbPLWaVKdYAgLVbug8/etslux256NFIW/a9u8zCeyrddOYkFDl0vbOxRtAilVcHnw1v
         Oe7w==
X-Gm-Message-State: AOJu0YzM36kDjSkHC/DQDFi0kxi791F3309mHaklTi4elQfSoSco/P7W
	2Mb/US0iYCPwve3Es53zHCg=
X-Google-Smtp-Source: AGHT+IHvBHwGWu5xxqqOj3XJAChIytowlTq6Yqzpg1jVsczq5D1qXd8o9vOvnjctULIuOHDMPd2ekA==
X-Received: by 2002:a17:907:7e8f:b0:9fd:a5da:cff7 with SMTP id qb15-20020a1709077e8f00b009fda5dacff7mr4139049ejc.29.1700733205688;
        Thu, 23 Nov 2023 01:53:25 -0800 (PST)
Received: from ?IPV6:2a01:c23:c0f2:3200:59ae:788f:5985:cbec? (dynamic-2a01-0c23-c0f2-3200-59ae-788f-5985-cbec.c23.pool.telefonica.de. [2a01:c23:c0f2:3200:59ae:788f:5985:cbec])
        by smtp.googlemail.com with ESMTPSA id f11-20020a17090624cb00b009fc3f347109sm555339ejb.156.2023.11.23.01.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 01:53:25 -0800 (PST)
Message-ID: <52f09685-47ba-4cfe-8933-bf641c3d1b1d@gmail.com>
Date: Thu, 23 Nov 2023 10:53:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: remove not needed check in
 rtl_fw_write_firmware
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This check can never be true for a firmware file with a correct format.
Existing checks in rtl_fw_data_ok() are sufficient, no problems with
invalid firmware files are known.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_firmware.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_firmware.c b/drivers/net/ethernet/realtek/r8169_firmware.c
index cbc6b846d..ed6e721b1 100644
--- a/drivers/net/ethernet/realtek/r8169_firmware.c
+++ b/drivers/net/ethernet/realtek/r8169_firmware.c
@@ -151,9 +151,6 @@ void rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
 		u32 regno = (action & 0x0fff0000) >> 16;
 		enum rtl_fw_opcode opcode = action >> 28;
 
-		if (!action)
-			break;
-
 		switch (opcode) {
 		case PHY_READ:
 			predata = fw_read(tp, regno);
-- 
2.43.0


