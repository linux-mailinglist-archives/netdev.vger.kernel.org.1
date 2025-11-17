Return-Path: <netdev+bounces-239184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C98C652A6
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6489A4F0A06
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DAA2D46B4;
	Mon, 17 Nov 2025 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VpMFfI/M"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD012D2499
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396804; cv=none; b=SrK0Yde9gYK8fxh0Fnp5lx75tW0MKaeQxp3GMrbQyDGms8mirelIkLErpUazJcx7Zvs+DN+35nxM0FwElBnou2/KzF8Jzu3yUcT4i/OOGuJcG7Sw8dx1Zj00mvA2oahyrgjtGLLM/TEZPPjO+eEwv5JrTM/1TjQU9oX3zTz1Ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396804; c=relaxed/simple;
	bh=pYa7b1QSb8XhTX63U1LGfCwsxEOsaiRO0Yi2eZ+bjTk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=NwPwZla5fDl8hD9OogEn7ae/VP63CocY3sN6HSgL7sQYV5/FDEPcjjCbJRX4LGArBTGNzq/lhNYVpDbHd0NMMJrbf9M+lM7x9xPpHIkJEz9iHRswUUcGYlztMMsCVBwNRoO6WsfMphCf+HBZM2gXYbmTLRkqL8/vEZlzPde6Mz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VpMFfI/M; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <938dbf1c-d2b5-42db-8ceb-0121e0cac698@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763396790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pYa7b1QSb8XhTX63U1LGfCwsxEOsaiRO0Yi2eZ+bjTk=;
	b=VpMFfI/MfTi38Ls1IHtb3yBrDf4yuKiHVrh8TpQu24Ioe/qYRajmeI+SYdOEukHqnVmguw
	dpKz/Cfny7p2dmO3k2QnOnBOHxuAaEwD/AEGgyESsTNJ/lOZqAlpyl+QYluPrMxQEqCDhk
	PnKFiZ3mLfy42MXazZVapOlyOcCx67U=
Date: Mon, 17 Nov 2025 08:26:20 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: bpf <bpf@vger.kernel.org>, netdev@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Announcement: BPF CI is down
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hello everyone,

BPF CI has been down since Friday, November 15, because GitHub appears
to have disabled the "GitHub Actions" feature for the kernel-patches
GitHub organization without any prior notice. We do not yet know the
reason for this.

Currently, the dashboard [1] shows the following message:

"GitHub Actions is currently disabled for this repository. Please
reach out to GitHub Support for assistance."

This means that no BPF CI jobs, including AI reviews, will run for an
unknown period of time.

In the meantime, please be patient with patch reviews, as maintainers
will need to run the selftests manually.

[1] https://github.com/kernel-patches/bpf/actions

