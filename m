Return-Path: <netdev+bounces-18559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E50757A0C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD29A1C20C53
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A2CC2D5;
	Tue, 18 Jul 2023 11:07:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA01C152
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:07:58 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F391310EF
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 04:07:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so33201601fa.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 04:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689678475; x=1692270475;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhj3PiKMKBo2rj4GQa0g6ssdckgN6WqVltudoi3R9Dw=;
        b=GWQ34gLkK245it+cwSvu3Ac8nmFBe2xgCQaHMcS8RiAuRql1eerVgVcGo6a4vYwA4e
         +ZNXy8BgEU9hlTqinfpGscLovv5L0IEzg8hvMqh3Gix4GveJZzotAQFIZ/f+Z5F/SB6D
         7qdvCYd3F5ZMTJSxFP5rB8X3y/debR7h0SzqfIDRUp/fI8owYhSJUlKiPs33/kNXK8Nb
         MLc4xlaYyhMvkofWSDFA/EayKCwFmwGH/XoMDOiBGfbmC+crmgVGnYORes6b6hDMlxHc
         lGQswj3h9Aiz2qqiKghC3thNMQ1rkHL26Qh5R1TQxyH0dyfr/mps+8+OFUlPmbDBkXef
         X+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689678475; x=1692270475;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bhj3PiKMKBo2rj4GQa0g6ssdckgN6WqVltudoi3R9Dw=;
        b=QLbBpxEiXSzWc4pwmect6Ex1UzC0n0+6HOqAt61hsXHblpgnZaThbB6zIG8G72EDHf
         bBg5EniTelpauN6aamcJ5Sn6WxWqkQkCTEQv4Dou6FESQMLn9V+W5Ur7hIpeMxPM/E9M
         XParVWo7nqMP28aIt+hn7QGAZ+RIPrQxrpdilSM7UqrdumEm36pyaNr8tqsulTAGMoGB
         U6pXJlYD50a+sKtRDms5BF19USBIqJiotL+M3gWME7cTE0KPVUKCTp4fUn7I8dJU0GxX
         TSJGgr/dUy8XWf5hsdfIAZrZCc4JzzWxVMxbEktax0UM/1Hp5mF+FOgwcQKTcpiaWYzc
         ELsQ==
X-Gm-Message-State: ABy/qLbOJSJ8qpHz0ESdyCqja94Lxu4KYv54NbcZAze5hqrrCZsIYCjK
	CXY9Lxt4WrxZA2vfzUyFWiQ=
X-Google-Smtp-Source: APBJJlHSqwCqJQ7z2SS7mSIwUB16zJ2uJQ7aX7yFGLbJCoUQQB21Vh2OhQEO/byaSPyN3TUsuDDWdw==
X-Received: by 2002:a2e:b019:0:b0:2b9:20fe:4bcc with SMTP id y25-20020a2eb019000000b002b920fe4bccmr6508949ljk.21.1689678474893;
        Tue, 18 Jul 2023 04:07:54 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7315:d100:15fd:b3ca:86:923? (dynamic-2a01-0c22-7315-d100-15fd-b3ca-0086-0923.c22.pool.telefonica.de. [2a01:c22:7315:d100:15fd:b3ca:86:923])
        by smtp.googlemail.com with ESMTPSA id h5-20020a50ed85000000b00521a7864e13sm964956edr.90.2023.07.18.04.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 04:07:54 -0700 (PDT)
Message-ID: <ddadceae-19c9-81b8-47b5-a4ff85e2563a@gmail.com>
Date: Tue, 18 Jul 2023 13:07:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net 0/2] r8169: revert two changes that caused regressions
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This reverts two changes that caused regressions.

Heiner Kallweit (2):
  r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions now that
    ASPM is disabled during NAPI poll")
  Revert "r8169: disable ASPM during NAPI poll"

 drivers/net/ethernet/realtek/r8169_main.c | 38 ++++++++++++++++-------
 1 file changed, 27 insertions(+), 11 deletions(-)

-- 
2.41.0


