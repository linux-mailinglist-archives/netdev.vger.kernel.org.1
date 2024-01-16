Return-Path: <netdev+bounces-63613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F26682E7CD
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 02:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBAD3B2237B
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 01:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFBC13AF1;
	Tue, 16 Jan 2024 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YagaN3zH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85513AE6;
	Tue, 16 Jan 2024 01:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7428DC433F1;
	Tue, 16 Jan 2024 01:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705370081;
	bh=c9Goi8sG4G3JYMmyUMf1Gt30HfsoqC6ta1hoRjrOL+Y=;
	h=Date:From:To:Subject:From;
	b=YagaN3zH86NQ6wHstZGlgNm6lhspyOdtMWrOoAWvJK4OayccEAHdgQXmvc48B+Ije
	 qC/Id2xewcdFsO+/eWVcmzflf0xSbFqjIYgr1GuAQEs8GHeqDEfVdk6+dRNTbYv20C
	 5bypVq4cmy1Eg7afafEsnQv1PCS76PRigBLwK4qd0zo+zVHr7EA7nOj5BeTuvYbLXC
	 PepZ6VTmh1Y05Xta6tsaSs1xRp0FbVjvIeyP/BmYY1CkKSpi78u4ePBLcHIPVMs4rL
	 2Dy7G4trMH5lN3wXA2zfY1Gpc9yuyGP6fMfeydQLNNapN+lRwwa57CCXscMNW7n7FA
	 zv8onWNyQSuGg==
Date: Mon, 15 Jan 2024 17:54:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Jan 16th
Message-ID: <20240115175440.09839b84@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).

There's a minor CI update. Please suggest other topics.

