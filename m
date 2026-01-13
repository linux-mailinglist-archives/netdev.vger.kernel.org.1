Return-Path: <netdev+bounces-249517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2E0D1A5F2
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 951A2300FEF0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2583346AE7;
	Tue, 13 Jan 2026 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMoOAO8K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C6346AE5;
	Tue, 13 Jan 2026 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322766; cv=none; b=FlW8Jvzoa1Yw459kmap30B8SelR0fvweYppXkrmY96j1vXY3ibkwr39+qzCq0JzLPglPHUswzVag5VMt2dFj6XtJAManKXVSDDYV6XeaYp+oeAt8DnQbFAZNha2RNxOXB9aJmGTNF3X3YEkfV/FwYNN+k0tG6Za9kC2PhMdJ2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322766; c=relaxed/simple;
	bh=q2585gFcpikHapWddJU4lnHYNTpNABRMp+5eyxVNt5s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=hOKwpIYn+5l3rd1lZ/HuxdhJbj7is3ZA22TuHKAt1usIAExplAcP//HKmVr5DEWS2kQgcyqIxKH6Ra1r0FwiMLUnBd+fgp8xylr1Iz0eu20SGM8jq6bVDllM994bbJdMbfgCX+3CxThH41YktGh5e5ja2FRpDrVhsUVlqn7tfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMoOAO8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F1AC19422;
	Tue, 13 Jan 2026 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768322766;
	bh=q2585gFcpikHapWddJU4lnHYNTpNABRMp+5eyxVNt5s=;
	h=Date:From:To:Subject:From;
	b=rMoOAO8KNXYUYRt/iTy7uBcjFo5anez7kOYpR1yPKDb3PqHhK+a6/chY7mA8tl+Uy
	 oi7bGLYVnm8mNgg1Z/2FNuZ+f56HBd0sHfB4khZLJFR/iK65Yeimn1IWTzLAh3AVhZ
	 2rf9ctTXKuOzK2jjo/8a0BjEOAijvUQxzs5lpDy3EPYJ0t7rWxxEgEsmxhteWjqZ7i
	 39X/Xl8NPIeRbAf+jQAuieOMutU8FHOJXfn4ZvSs+WNYh15ohNAraU/cniRfurVQll
	 3csyckXWKbu0OdoaFEuIrR+TTgOEyMZzJ6xknrFTV8g+mq7F3DvmYHls+wOF3zEq2v
	 tok15yZgJutfA==
Date: Tue, 13 Jan 2026 08:46:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Jan 13th
Message-ID: <20260113084605.60d0fc56@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Present: Andrew, Jakub, Johannes, Kuniyuki, Simon, Willem, Paolo

PHY Testing SoW Update
 - Approved by board; processing contract in conjunction with LF

Lab update
 - 3 machines in production (control, build, virt/ksft)
   - Have capacity to host Wireless NIPA
 - HW testing - 1 of 2 stage 2 machines received, other is on back order
   - ETA 2 weeks but keeps getting pushed out weekly
   - 2 NICs per machine

Finance Estimates
 - Estimating $200k+ EoY=E2=80=9926 balance
 - Looking for ways to effectively use these funds
 - Netconf funding was one avenue
 - Patchwork extensions are still in the works

NIPA maintenance help
 - Either a separate SoW for significant chunks of work or time commitment
   - Prefer time commitment due to lower management overhead
 - 1 day/week with possibility to extend periodically to more as task pile =
up
   - need upper bound for budgeting

AI Review Discussion
 - Delay has been implemented to discourage reposting too quickly
 - Tool is being used to limited but good effect by some maintainers
   and developers

