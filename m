Return-Path: <netdev+bounces-19025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E7075962B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1A51C20FDA
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473F814AA3;
	Wed, 19 Jul 2023 13:05:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3781814A95
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:05:24 +0000 (UTC)
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 06:05:19 PDT
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC11E1711
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:05:19 -0700 (PDT)
Received: from ziongate (localhost [127.0.0.1])
	by ziongate (OpenSMTPD) with ESMTP id 52d853d3;
	Wed, 19 Jul 2023 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=
	message-id:date:mime-version:to:from:subject:cc:content-type
	:content-transfer-encoding; s=default; bh=g65oZ3V85PpPnPP1ajr+Vn
	kX6Jo=; b=kNxfhuYECfAsoflX3bUAgFWRWVnEfcQyFZI+UzUDu4qeoio16q/BN/
	SRFvMc3TsQrG+s0Gbf7KXOxtMcCU5y1xfniturc32F7jaC0b/YBrpUBryTfI6lbl
	iaUIc1tAZ9fn5WTSqJrcYNfrs4iGBP6mcWmoxQ4pGQlMG6tM7f++g=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=
	message-id:date:mime-version:to:from:subject:cc:content-type
	:content-transfer-encoding; q=dns; s=default; b=M/r2FqfdGE6K1du2
	zOU0vYgiHG4PwJjq3W1U/vmlB2aqj5dUTMBEog6DLp6GBtslDlhNe6qNLv1S4T5e
	GIjhiaWUSw6Ro4tPB33Xk2MUfnSAIq81NosUpSDgldBD0U0X+CH/sL0AitTSJUcp
	9yKn199Qc0FmsJBOn+gQmNpQ5Ck=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=20190913; t=1689771517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d1GeZToQPtZ+ZrlIv8WzQTBfjEEslUayBxVsZqpaYlc=;
	b=l7cRGpDPhzy7nw9zPFMcCaRLXsHjQ108UfGyl/fTxf6ETxNr0mMZi2HDFLM+LJCY8H9Yi/
	YlehaXyXE8SgWjpCa2wviBs0iIdMvSh6La1EGKLUxxcKzNCpFJDSnu+/rN0KhbpQDWSOPe
	sdQ02wCE7VqIdz6jQUIZDvf4Qsboq6Y=
Received: from [192.168.0.2] (host-80-182-57-72.pool80182.interbusiness.it [80.182.57.72])
	by ziongate (OpenSMTPD) with ESMTPSA id 86a64b19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Jul 2023 12:58:37 +0000 (UTC)
Message-ID: <dfd93459-c007-ef05-9706-4eb1ee34cf63@kernel-space.org>
Date: Wed, 19 Jul 2023 14:58:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Content-Language: en-US
To: netdev@vger.kernel.org
From: Angelo Dureghello <angelo@kernel-space.org>
Subject: dsa: mv88e6xxx rstp convergence test
Cc: olteanv@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear all,

i am testing three switches connected together, the switches are
linux-based using mv88e6xxx dsa driver on kernel 5.4.70. rstp is active 
as a daemon at userspace level.


    SW A  ---- Host
    /    \
SW B --- SW C


A host connected to A sends 1000 arp requests per secs
to SW B, while i disconnect the root path, to test convergence.

Convergence happens sometimes < 50 msec, sometimes near 100.

Do you think i can get a constant convergence time < 50 msec
in some other way ?

Thanks a lot,
angelo

