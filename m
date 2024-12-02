Return-Path: <netdev+bounces-148107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CEF9E076F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A35AB84B1B
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB77205AAA;
	Mon,  2 Dec 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSLjvPdR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC9205AD6;
	Mon,  2 Dec 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150189; cv=none; b=CsTP3wVZjndIATaKP6BLjud/TI2PacHxH8irKovR9HGhUEktUqlrT8+P0OnPy4W4sNYqIfyi3aVs5Sqo2aznEDtIVw+bD6Mhos0pLB1SEBnPD3o87MDKA5mHV2SJGGs49uSZZd5ZkLUSf96dybNgvvXCsu9W8DDOAEL18vUUIHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150189; c=relaxed/simple;
	bh=+awc5BsafdDhOHGstfAmJuHpZsgfQRSK20ev00XNOPQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=sMaOCbnkjkgjyJBSaLwSI7SWC4rxmLMZyIhEIlIeHe1YXsbBYK5gz5L63fQ3oANeGJkj7VBq/P3Pp/uIaPERhVPRrHuerdk/idY/uoHgYQSImRWwvvjRz7priCzHC8ppEtpY5fjfKxI58pKCwPZLtzbbY/y0EOsrPf7t+cHU/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSLjvPdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D1BC4CED6;
	Mon,  2 Dec 2024 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733150189;
	bh=+awc5BsafdDhOHGstfAmJuHpZsgfQRSK20ev00XNOPQ=;
	h=Date:From:To:Subject:From;
	b=gSLjvPdRE2YLuiCXMZIU+4R8HOfm0rA3TaZvTh8egYhPIU657saj1RQrE5V38BPkg
	 fu6sRvtlnlxoSh3XVyHG0i26yrbCqi9/54nxOWZX+AmZj/zjnD9eqBDbGF4EmU2Lsf
	 akBV9OrQ5ZwVIMfRO9hSGZQjQmAaZtrrilGDAHFczxK6Nn8gXZY+iir9sp8Br6yWyo
	 24GFxnMkNP2iDRslWCAFThwWQS7KbeeKLvdXyFRRV9NmyUWywbYNaLo9tCGTPdHdNL
	 am4XZan/7r4280ii5glSZW9j38vipQRYJ+/ILJ313evu4lvoM0rt4Rp5ZbbvR8tbP4
	 xc6sGstlhmG5A==
Date: Mon, 2 Dec 2024 06:36:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20241202063628.4d124d83@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus tagged v6.13-rc1 and net-next is accepting patches again.

