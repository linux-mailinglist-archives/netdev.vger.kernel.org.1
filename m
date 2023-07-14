Return-Path: <netdev+bounces-18023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC275434D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 21:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC88282278
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD0A1F92F;
	Fri, 14 Jul 2023 19:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D90313715
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 19:38:37 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19B212D
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 12:38:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666eb03457cso1637620b3a.1
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689363516; x=1691955516;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaDLRcQ8+R3VJUflG/aHCwu2Dwn4hB8uTW67Q9s5wEw=;
        b=OwHudDHlsWZdd0ao1TIp5IJKJOG0ngy8rBaKBidc0sHf+BktexSmnw+rwFLFNxKCdU
         QFJo0OxAPdmnjxKbMUkZ7Fyqr07KYV+9ktpuwxx705a6YpCfHqgu90TBo26YJACafdsH
         DLM9MbDAgYwMj8chk8qWZiZsAgNxNXN4xpC5rfP5XunWsCi2tWM2xS16KilIpK07o9WT
         nhBWb8bhiaXn9LL3KrVqKL2aPNf1/UQ7I5JAjnTTEMOyFDjoTJx50/ZukQLMD/MLxbg1
         BKJjAdHnm71oWoR8u8b/4WjG/IALpj5eY3JrYgl0cbcTopofUQ7IgW6uNwUb2sSdzQuN
         mhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689363516; x=1691955516;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oaDLRcQ8+R3VJUflG/aHCwu2Dwn4hB8uTW67Q9s5wEw=;
        b=F6NUXekfrR8GITTAaKQnWmZBWfNMzzG/MYBRVR0QqAj7zmE6UEt3DmPwKxJBOoCvg2
         KLU1sikBeoUstVEt5U1rrhITBK2T+nS7C2g7N7heSe7D2mucsa5GXhCpaB3MmuG6ynoz
         DgRMcDKnh336CIur4PlDKEF+XwYaPkMGMBBS5P2DOL6iuLadTYNb7CC/YAX5h5Qk9Y20
         U8htpcmCsoWbh1vB4mODBgm9FgoRLEYGzaq7RfbC0vaCgh8jbngo4Qv25BJQBYsD9eIp
         Lc78/X6ZhnkvjsXOHvnL55D3sPrP7JXmbmd+UXSuemnw1Kd5/HrxI6CKFWEeo2qB1/Dg
         OspA==
X-Gm-Message-State: ABy/qLaVmicyojTpQB1cW17XK5ddsivDrCQfdyUjYrf/NfmkGSiYy4qW
	WjZ6N/ulu4vrN2BC7diTIn9+V21V3rg=
X-Google-Smtp-Source: APBJJlHIKFHzGvhdfQJbHCCBS4FkIWghnK2B+cwo2OzaA4n6hSPJVIvCJCvfoT+XNYKkIIDGPYOfdg==
X-Received: by 2002:aa7:8891:0:b0:681:3ed2:b493 with SMTP id z17-20020aa78891000000b006813ed2b493mr4937214pfe.26.1689363515950;
        Fri, 14 Jul 2023 12:38:35 -0700 (PDT)
Received: from smtpclient.apple ([2600:381:7001:e003:9559:2e9c:7f30:1736])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78e13000000b00682b2fbd20fsm7561981pfr.31.2023.07.14.12.38.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 12:38:35 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: SIMON BABY <simonkbaby@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 14 Jul 2023 12:38:24 -0700
Subject: Query on acpi support for dsa driver
Message-Id: <5D6DFE0F-940B-4AAD-AD39-B8780389B67E@gmail.com>
To: netdev@vger.kernel.org
X-Mailer: iPhone Mail (20F75)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Team ,
I am new to this group . I have a query on adding a switch device ( microchi=
p EVB-KSZ9897) to my Intel based x86 board which uses ACPI instead of device=
 tree. The Intel x86 is running Linux Ubuntu 5.15 kernel .=20

Do I need any changes in the drive code to get the acpi table and invoke the=
 functions ? When I looked the code drivers/net/dsa/microchip/ksz9477_i2c.c i=
t has support only for DSA.=20

Please provide your inputs .

Regards
Simon



