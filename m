Return-Path: <netdev+bounces-22532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403CD767ECE
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C77C1C20AA0
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2170514AB3;
	Sat, 29 Jul 2023 11:45:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543C3C20
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 11:45:44 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669D51A4;
	Sat, 29 Jul 2023 04:45:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so5226793e87.1;
        Sat, 29 Jul 2023 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690631141; x=1691235941;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTdjEAe71b0Sk07G41NM9kDWo3D+urjxVcYP9X65Ar0=;
        b=qWf/cMdNQbJBbhcE+oqfUd9x9O06ioP77uX9/y0QYHkY18AqbcIp8MYq8khu4qAOKF
         DyDxL/clZ+NDPQ63i6KetnFhZLauDHI7l4+WWSZ12H+VrtRSYNky0yrjNXDgvxgPYV4k
         SrXvyYXBiEA0iKnU0e34S3J/o1SVHQcuOnfs/OqdJeXBc3i4mjuh48nLu23PGbEyAoJQ
         O8/80DDOt7KrkwVbrCpU7d6ZK3NzuXoGLGeAwO453xCGdIK6vuo9km5SQfMw0D0efPwS
         qQ2vBjvYzr+IMe2shf4hCWOtW6lTWcCuOQz7m30SR0Bw8QoWqlTMQakwUD/56uczRQaO
         oAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690631141; x=1691235941;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JTdjEAe71b0Sk07G41NM9kDWo3D+urjxVcYP9X65Ar0=;
        b=GrGZPrFJEj9L+ItV2x7LCEfpJRfljKe70dOrMm6cqMw2bGtsNQHmNZCQeikAuyeD6e
         RdjlRa2Ic+q/zO1rdvC+wLcopAMnVyGoJiqwZn1Z8w+ij3wM2KL2uz59QlIvbDlLUG/G
         x2qDQNyMZbtQ7k5Gm9GBxbGbunISaO/fKCp7LmNizv1nBZ2VQfjGym1KO5Z4uAc6h+KR
         4qvqPHN6JUU8u5dbKEOz7vu2I4SVo9ogS0TkFV0hFXYmVlS5wXy5XosMP0nccV81+Uix
         nt8vP7Pv+mF2jlsJml5y1Z27q13p7ZReAdOxxja6ePsbZfPLtkXwHBsFSUYsBAd6r0Ms
         qTAQ==
X-Gm-Message-State: ABy/qLbU/qHksPpbBO2okBuvsJWltigXSxssoYG29ciMJqPZf/UQCYbV
	AbLlG9AGSCCj9xRJWoTCYcQ=
X-Google-Smtp-Source: APBJJlG5pD/pDB2nRa75Z5e/lowSCoQHTY9YWpEMCI2NangfuzIZVkFVC3q39LjL9P6fu9vW8zTH2A==
X-Received: by 2002:ac2:5f48:0:b0:4fb:8938:48ab with SMTP id 8-20020ac25f48000000b004fb893848abmr1798657lfz.16.1690631141361;
        Sat, 29 Jul 2023 04:45:41 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id q25-20020ac25299000000b004fbb1f7352csm1190079lfm.72.2023.07.29.04.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 04:45:41 -0700 (PDT)
Message-ID: <2a4da319-a78a-7cb1-6f18-f59180de779f@gmail.com>
Date: Sat, 29 Jul 2023 13:45:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Network Development <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-mips@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: MediaTek Frame Engine Ethernet: does it need any resets?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I'm trying to understand MediaTek's Ethernet controller resets.

I noticed there is sth fishy when checking dts files. See following
errors:

arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: resets: [[2, 6], [2, 23]] is too short
         From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: reset-names:1: 'gmac' was expected
         From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: reset-names: ['fe', 'eth'] is too short
         From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: Unevaluated properties are not allowed ('reset-names', 'resets' were unexpected)
         From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml


1. Binding mediatek,net.yaml
It says that when present, there must be 3 resets: fe, gmac, ppe

2. mt7621.dtsi
It specifies 2 resets: fe, eth

3. mt7622.dtsi
It doesn't specify any resets

4. mt7629.dtsi
It doesn't specify any resets

5. drivers/net/ethernet/mediatek/
I don't see any reset_control_* code at all


Can someone help me what's the actual case with resets? Are they needed?
Are they used?

