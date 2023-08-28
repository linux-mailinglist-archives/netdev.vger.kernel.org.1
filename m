Return-Path: <netdev+bounces-30959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F5978A3A6
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 02:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D014280E07
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 00:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EED360;
	Mon, 28 Aug 2023 00:23:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75F62A
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 00:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9DCC433C7
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 00:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693182205;
	bh=Qzlno7W3dduqCj724ScncVezzdXsNZdQEpWsx4i+MVM=;
	h=Date:From:To:Subject:From;
	b=NdyNz4gbd9qbi8Z7vAiChqX+4DgiCnhbBodC1qMzarGJYZT4U+PTno0UBcxI0dE/O
	 ox3FYOxoOwAukMk2XcCUIu15RY1ccuB3HQK1AXYZXmeIPETUnaqvlOrczoLFf6d/QI
	 FIeXgKJgFFNKenKI36ImZnwfbu9aPpfe4Mq/bcieZt7OhZobqrVcl4otpS3jr52AWl
	 PS0lfZ4HWQBrGLpV1Leyl8XnzgK3OkmsN4T4PwOSV5AYPbusX7wHKyY7J5ZeSDCKNK
	 zQYhrJVfJULkQGh1/xcFgOVkZbCh3ybthunik8rJgZF2nGt16ztsiEwyDRke1/267m
	 vNDdL2cpMqu8g==
Date: Sun, 27 Aug 2023 17:23:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [ANN] net-next is closed
Message-ID: <20230827172323.1c988b58@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

v6.5 has been released and so the v6.6 merge window begins.
We'll make a call on outstanding patches on Monday, please
refrain from posting non-fixes unless explicitly asked to.

