Return-Path: <netdev+bounces-128464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B622E979A35
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 05:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8341F229E5
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 03:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE112B8B;
	Mon, 16 Sep 2024 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nO0eOJO5"
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0017C69
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726459057; cv=none; b=sFcaDaowLVx9WoNjbvJBvh4xSGhvPa6q5lR3JWNe4OFzCIn1pdBik0B/yCzsErfMytf6Os2j3rHFGaYV4PLrAPCREfwIZb5yGIlZ4+PfLqa/JhMQnXsZmEb0JmgqNB4BZBZ+3MVYv/VVi7vcYq0lvy11p6agNx0WI2lvZaJGCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726459057; c=relaxed/simple;
	bh=uQeCiuqofbp7VBgWJBHIBiFbeaUu9Qm1y9Nz4rNP4v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hf8/WBl5DMjyCf0drWkYLobUUW+BcVi6hRhd99tVyDc/ps0jGt3q2GVUwYusByDRVj66E+zI3qR1rqkVVspAwSD4Qk9c7fyuWsIrk7x41oDKkET0Bom8BYK4NCRVdK/zA7p1MqxOOkzybCvm++2Nw9xtjU4xiCv1RQMLTja0+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nO0eOJO5; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726458990;
	bh=uQeCiuqofbp7VBgWJBHIBiFbeaUu9Qm1y9Nz4rNP4v0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=nO0eOJO5KWXwyCVueVDt4D9I5KPTJD0sKVmtao8eRjcHWafxPvmzooU09JaV93uwX
	 eX3f93sxxtk7dxw/1a5h3q3dH+tcpn/UaF6T2fT/KIhX1LTPGnTNLh59HtdSkvwtk4
	 A8mnxB2KsRJ+93TfcjmFHPqctyrVKSQzPwa3QicA=
X-QQ-mid: bizesmtpip2t1726458973t9xfue2
X-QQ-Originating-IP: 4+X9rNC0rfWCVm+jTaZrmC9K3XSZNEdwwr0L1XVgKWM=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Sep 2024 11:56:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14186944467596871158
From: WangYuli <wangyuli@uniontech.com>
To: christophe.jaillet@wanadoo.fr
Cc: aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	conor.dooley@microchip.com,
	devicetree@vger.kernel.org,
	emil.renner.berthing@canonical.com,
	gregkh@linuxfoundation.org,
	hal.feng@starfivetech.com,
	kernel@esmil.dk,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	robh@kernel.org,
	sashal@kernel.org,
	stable@vger.kernel.org,
	walker.chen@starfivetech.com,
	wangyuli@uniontech.com,
	william.qiu@starfivetech.com,
	xingyu.wu@starfivetech.com
Subject: Re: [PATCH 6.6 v2 1/4] riscv: dts: starfive: add assigned-clock* to limit frquency
Date: Mon, 16 Sep 2024 11:56:10 +0800
Message-ID: <87764635B0614447+20240916035610.64002-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e2d7ed77-827b-4b7c-800c-9c8f3bcb6b5a@wanadoo.fr>
References: <e2d7ed77-827b-4b7c-800c-9c8f3bcb6b5a@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Since this commit is already in 'linux/master', changing its title for the backport might just make things more confusing.

Thanks,
--
WangYuli

