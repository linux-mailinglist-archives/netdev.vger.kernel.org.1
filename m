Return-Path: <netdev+bounces-140172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA79B567C
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E15B21D44
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD320B1F7;
	Tue, 29 Oct 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1EEFZ3O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B020A5FA;
	Tue, 29 Oct 2024 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243219; cv=none; b=KEwoPvc9sqlXZSfIFwClpT7weReF+DIqM+ph9EGw6N2VUkBgBh1DQ9dhZgVsDYgrBqBzaJlKR0kNaWjb/aAVqiKRS2RlTkFFCfi337eicyY28QcvOnM3qOe6rvke/TrSL2WDPZLxsx3zuKwge/Xh+JEkOVCN+SMCe4Mq+t/Mo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243219; c=relaxed/simple;
	bh=GNALf1PTTHAUpeZX/17m1kSxP1m3t/rIPFZU42PzlXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yr+tSQpYqt/njwVlEEbZVDvO88lFObWHrPdgKj1IqbieMUEYrR9/ItKwa1P7TVD+lUxtUPN2BgDHTp4PjKUv83E/dEaJsEhF5fDPgTK2zlWvAaPbw9O6S80GEaYJoStwvJfYq1at9P3JzjT6m2PYaCj39HeKTKFLba7JEQw5vyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1EEFZ3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFFEC4CECD;
	Tue, 29 Oct 2024 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730243218;
	bh=GNALf1PTTHAUpeZX/17m1kSxP1m3t/rIPFZU42PzlXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e1EEFZ3O78RO4W0UqLNJ1fsE5Xx/wN/fQsoP8T9A5UuMGoWmwi1E4zGVE93nfbFQs
	 MCazQRKLWrJznjhs+gCuH/TvaId/SGRPfG9poxK2FaqMe6Sv/eWQ0iEqkzs7oRSHHf
	 qmxHiN5J1jOyzvHJKPYzGpuMXBw9U2wCU2kOsRhgJzxk1UvgXXC5GI2variImqcchD
	 do+yGbBpiag5EbdmPD8bPjgO2cO/velWmhEpvYHF3y0lEWAk6YunItHzlILk58K12S
	 2aFTUXrDgEQHyi99u38kuBVGMgnw0z91enzhv/6HRDbPjvwFzkUF/Cv3TriFJPgFJ8
	 q3BV7lUKfYvQQ==
Date: Tue, 29 Oct 2024 16:06:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <lcherian@marvell.com>,
 <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
 <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v2 4/6] octeontx2-pf: CN20K mbox REQ/ACK
 implementation for NIC PF
Message-ID: <20241029160657.2a0a2c91@kernel.org>
In-Reply-To: <20241022185410.4036100-5-saikrishnag@marvell.com>
References: <20241022185410.4036100-1-saikrishnag@marvell.com>
	<20241022185410.4036100-5-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 00:24:08 +0530 Sai Krishna wrote:
> +/**
> + * CN20k RVU PF MBOX Interrupt Vector Enumeration
> + *
> + * Vectors 0 - 3 are compatible with pre cn20k and hence
> + * existing macros are being reused.
> + */

Please don't use /** unless the comment is in kernel-doc format.
It causes warnings for documentation extractors:

 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h:12: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  * CN20k RVU PF MBOX Interrupt Vector Enumeration
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h:12: warning: missing initial short description on line:
  * CN20k RVU PF MBOX Interrupt Vector Enumeration
-- 
pw-bot: cr

