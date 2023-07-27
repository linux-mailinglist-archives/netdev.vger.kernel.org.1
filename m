Return-Path: <netdev+bounces-21822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41DB764E56
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD13D1C21501
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD276D53A;
	Thu, 27 Jul 2023 08:57:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFEC2C2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:57:35 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A3997;
	Thu, 27 Jul 2023 01:57:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so235643e87.3;
        Thu, 27 Jul 2023 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690448253; x=1691053053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=njYhEt4+eOi8+Tslvkgq6U+0tcgEtLytzTelQXXGBtg=;
        b=YLXps7D1mm5p8Mds8Qd9tHivV7E5PhSHgjV7yiKRqK7yjA1yNHHCa3yn4AqV3h2Pw9
         K02oJQrQ5YuH1iTOT91bXSWJMxTwL5t0F9QqdlYfda49ptyD9vRMBVS9JSfwPPhF8C4A
         QcIvCZtwVrDYofn5bpF0GiBPHUTYrMXECux23hYD/wwq/S3W+fMsJd3mnjFzEkV9hArf
         mOUocXGo1vVaTUeI7s8amquV54vjm/c29Q+Xl+dTthBv9zx03vYh17KlGocQ8O2Tz92a
         rCgogmVKD+FC1WgJAtEERMtqQA8/A44U40iyve/oSawA7uqcQJ/qMCZ2pzZvOF7dKNzZ
         sPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448253; x=1691053053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njYhEt4+eOi8+Tslvkgq6U+0tcgEtLytzTelQXXGBtg=;
        b=PnptCon87+GlSF1SZNH9URMDqNP9zgTQagE9+5ERM1s+fWwqM8EN7AOGzLw0fcS9QI
         U986B0gSWnSJJAytdQHY40NKBIbArQr9cZEoSpgx8BHw3qp2yADr4E0QvAonfzYldBtk
         cwolFokMWC8hBfy5c4WiV9ki4M1YeLZsypXvQ14woVlFwerIxmbrsMePep6fQMCluUJ7
         a8reL0hf0mVFg6cFDMOYPheE2WUCguu2jUoWcV3G6MIkO70TxnbjIOcntf20QgtU9Xcp
         mKu48EP1MN8Y+D9024fJmLlGn2kPumZkiQtBraN3MOBR+iRa/yW392uyBk941sFCk4JI
         d+3w==
X-Gm-Message-State: ABy/qLZJ/CXBDG43slms3xKyz/w/cPnnXJIde054cyhFd5+go85pYDH4
	dwo1yRNFfDjCpmnKZovJPdPBRn0q8yb4UnrTmb8=
X-Google-Smtp-Source: APBJJlGeD8o/CYv0QiyFLveOX/fqvIsAPDYKhOXXj6lHQrF5n5d+nHfejRKsDreaqLfM/r5FId7O4sjsBt/3scufObw=
X-Received: by 2002:a05:6512:3e29:b0:4fb:896d:bd70 with SMTP id
 i41-20020a0565123e2900b004fb896dbd70mr1616733lfv.46.1690448252498; Thu, 27
 Jul 2023 01:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725173728.13816-1-dg573847474@gmail.com> <20230726214613.7fee0d7b@kernel.org>
In-Reply-To: <20230726214613.7fee0d7b@kernel.org>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Thu, 27 Jul 2023 16:57:21 +0800
Message-ID: <CAAo+4rWvCsYmQbzb8mFDw_LPFXx9tLky8gA-R68Kc3te79=7kw@mail.gmail.com>
Subject: Re: [PATCH] mISDN: hfcpci: Fix potential deadlock on &hc->lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: isdn@linux-pingi.de, alexanderduyck@fb.com, duoming@zju.edu.cn, 
	yangyingliang@huawei.com, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks. v2 patch is just sent to address the problem.

Best Regards,
Chengfeng

