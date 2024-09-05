Return-Path: <netdev+bounces-125359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AFC96CE35
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 06:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445341C223BE
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 04:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F50148302;
	Thu,  5 Sep 2024 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b="L/zEMPUa"
X-Original-To: netdev@vger.kernel.org
Received: from mod.modforum.org (mod.modforum.org [192.254.136.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9976379DC
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.136.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725511825; cv=none; b=K/rY39O0CEvW2w3hpQStA9eJsE7xbgkwQNm4ybLelDte8Ep2X6LW0c4AfPATmrHGzBjuzsKCIB6xWRdQCYxy6WdiY0ONnTKh4pNmy5uVdBK+ws7VAj0Hapf5wp5XAz4Ndd4KY2GBtC2dsodTcMLoqEtWCmwiYw2lv/ekpC1W5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725511825; c=relaxed/simple;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MqS1LZhPMgm+ySt11XZZjgU1bY7yVubALQO67nvpdZslovGIjbXRNBTJnsYdOlRqn4HNbV0ra2IlXQUOEpYWK5dQABpOODgXg6rxcynqNyqOQWxWxyZdzPK/9ushNsxDUqQd5i02W618FFuFnaoYmtnfaXYvU9ACsA7Ox1vb0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com; spf=pass smtp.mailfrom=basantfashion.com; dkim=pass (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b=L/zEMPUa; arc=none smtp.client-ip=192.254.136.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=basantfashion.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=basantfashion.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=; b=L/zEMPUaeXBL+8CSmbNT0TgbOA
	K74No7cRhhylXtaEWRVufto/8iBhWzMB4KXIpTKINl/+CcW4bYBRapihYP662eQCNxzw3jsDojXEk
	Ybglpk8H2dQnD8nJEtrrQWuWGLzgJTqemrQCNJwcZZn0+ngIxnbqY4WAEJ7QWxCwaAjz0zIs5kTKd
	uP3GtUGPeSvHXMOhCQcNmZBERGlYx788duasAv5hVJ5bJrI5ykYEmT/P8hmHIykOnjbQ6OdmtSkPt
	HDqifeOeKdS2E1+NADys2BwQPliBfDHf2txtriJ91TVO+td+bvuziTVQsrlHEUEI3Crho0UiJSLjP
	0zlrMNZQ==;
Received: from [162.244.210.121] (port=62478)
	by mod.modforum.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <kuljeet@basantfashion.com>)
	id 1sm4Qv-0000vU-Ka
	for netdev@vger.kernel.org; Wed, 04 Sep 2024 23:49:25 -0500
Reply-To: procurement@mercuira.com
From: MERCURIA  <kuljeet@basantfashion.com>
To: netdev@vger.kernel.org
Subject: Request for Quote and Meeting Availability
Date: 4 Sep 2024 21:50:21 -0700
Message-ID: <20240904215021.E5F40842C7036DF8@basantfashion.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mod.modforum.org
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - basantfashion.com
X-Get-Message-Sender-Via: mod.modforum.org: authenticated_id: kuljeet@basantfashion.com
X-Authenticated-Sender: mod.modforum.org: kuljeet@basantfashion.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Greetings,

I hope you are doing great.

We have reviewed your products on your website, and several items=20
have caught our interest. We would like to request a quote the=20
following

Can you ship to the United States?

What are your best prices?

What support do you provide?

We are also interested in your services for this project.

Could you let us know your availability for a virtual meeting on=20
Zoom to discuss this project further?

Please advise us on these matters so that we can prepare a=20
meeting notice for our company executives to effectively engage=20
with you.

Thank you for your attention to this inquiry. We look forward to=20
your prompt response.

Best regards,

Nina Petrova
Procurement Manager
Email: procurement@mercuira.com
12 Marina View, Asia Square Tower 2, #26-01, Singapore, 018961
Phone: +65 641 1080

