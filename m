Return-Path: <netdev+bounces-16551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0975B74DCC0
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E751C20A53
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370A14278;
	Mon, 10 Jul 2023 17:48:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF613AF9
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 17:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B97C433C7
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 17:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689011307;
	bh=u6uiJEPt/dpTUKEOGFtK4+283ZMqK2Hmm+nOFLYEGA4=;
	h=Date:From:To:Subject:From;
	b=SVJW4EqZ8ZXF0QAvTiSoRUDE2RaXKIJK35FbCtxYoTM93tZcW2+8lCPNZlSiz1zb+
	 0tpWdAzXAw98cFezmbxMbjcdJg8J/IfFf7hfiF5QpPzCLlxjHtyGZDOvje8tQCF/F6
	 hKt55/pHXuOK2knzjmaLsSeC3n7sz80j3a2/wIj1+WMGuHM3nvNUow7F392RBew3A0
	 6bgpyLFsN8Pxx1AXFiGkiblZQWPqPAjY49UtVgbxueimTuu9m7cWNqmkl/izMiVO9Z
	 Bjpzy1XO/hWUjEjjpnq86tWacxL/jwc/WQ82/Z3j8k45xdVbr7GoPBACf2epE9uDXl
	 zxb5/QHSdbgCw==
Date: Mon, 10 Jul 2023 10:48:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [ANN] net-next is OPEN
Message-ID: <20230710104826.578760e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

net-next is open again, and accepting changes for v6.6.

FYI we changed the location of the "status" page to:
https://patchwork.hopto.org/net-next.html
hoping it will be easier to keep it up to date in the new location.

