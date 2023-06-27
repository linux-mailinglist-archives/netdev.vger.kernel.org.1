Return-Path: <netdev+bounces-14151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E255B73F447
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 08:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D697280FDE
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 06:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01A1FBF;
	Tue, 27 Jun 2023 06:13:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4321FBA
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:13:48 +0000 (UTC)
Received: from ultron (136.red-2-136-200.staticip.rima-tde.net [2.136.200.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C87FF10DA;
	Mon, 26 Jun 2023 23:13:46 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ultron (Postfix) with ESMTP id F0BC51AC21D7;
	Tue, 27 Jun 2023 08:13:44 +0200 (CEST)
From: carlos.fernandez@technica-engineering.de
To: carlos.fernandez@technica-engineering.de,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES = 0
Date: Tue, 27 Jun 2023 08:13:44 +0200
Message-Id: <20230627061344.25078-1-carlos.fernandez@technica-engineering.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ZJW87b0ijjBytbqB@hog>
References: <ZJW87b0ijjBytbqB@hog>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
	HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,SPF_FAIL,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


Hi Sabrina, 

Your proposal seems good and fills all the possible alternatives. 
We'll prepare a new patch following your recomendations and send it again.

Thanks
--
Carlos

