Return-Path: <netdev+bounces-111578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CAA931965
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F391C21BF8
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BDD548E0;
	Mon, 15 Jul 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se/BHO5h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E354724
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064775; cv=none; b=U66Ez37PMUjgiaFFbHRQ+/mcGubpA6sS2XxdoH8etrIRrBVX/UHpjShZabB8YWBPAeEHSfRs/1eRYhEEVRMr7FHtBi6p1YC8QHR1jPz+lxg7YPzc26dYLg8xgyZ8phvz/fKqBDY5Q/PBhOwSc5aLgND2Nt4kmrU4fdPWACCQffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064775; c=relaxed/simple;
	bh=WWjx8FrSCfz5UmKtqnvyCIp73UDTfFLnbJ28YFs42vg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b311mDoMqVahpghfkzZQ2cs763nNT5RiZLHJNH9GRQJqaCZ0hQsQZxCdkxh6R4Ytbfy1iXJ7XtrmWwZEirxcnL0rKyABelypOi9O3zmNF8jXOMZ7U7bvrNpp6dqSzLeZ5UNF1fBPM5WCIowrynJawVVxhiwLsuiYYSGdQqhPZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se/BHO5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75690C32782;
	Mon, 15 Jul 2024 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064774;
	bh=WWjx8FrSCfz5UmKtqnvyCIp73UDTfFLnbJ28YFs42vg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Se/BHO5hSBlfkomsRA8Z1QiIex7IBu58R9REx8jpGLTwJoAQztPID3XSA44kxyukA
	 O38wFZG9uc5oPWueWT5KKZrcVL0W0/aCUxnij39p4rbGiIJL5O6Bt+GPq+altNiyW2
	 DrXhka2yvQeMYx0O8Kps5DZWlLCq9KBB/nAbQDxxvVKcSLjaEmF1ofZXx2povT2zik
	 nBknLMvwWiPQ8uxSgnbd59xnv0WLJofM2yUyAiead7JSpBDl/hEECNEHEDRf+MvF64
	 G/C+ZYD51OfJd+Mpm7QNNCvP+Ln2zUa4YXes0XH+5IMNpxVn7AEIwCuBfi2nvLlY4U
	 P/bzFRhQlP+eA==
Date: Mon, 15 Jul 2024 12:32:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: Re: [PATCH net-next 5/9] bnxt_en: Remove BNXT_FLAG_USING_MSIX flag
Message-ID: <20240715173252.GA435752@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-6-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:35PM -0700, Michael Chan wrote:
> Now that we only support MSIX, the BNXT_FLAG_USING_MSIX is always true.
> Remove it and any if conditions checking for it.  Remove the INTX
> handler and associated logic.

The cover letter says new firmware (the revision isn't mentioned)
doesn't support INTx.  I guess it's OK if the new driver without INTx
support runs on adapters with old firmware that still supports INTx?
So the INTx support was never a real benefit?  I assume this driver
change won't force a simultaneous firmware update?  The old driver
might work in a "pci=nomsi" situation, but the new one probably won't?
Just checking to be sure these are all acceptable consequences.

