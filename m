Return-Path: <netdev+bounces-69630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE37684BE63
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 21:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42E3288BDE
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319D17588;
	Tue,  6 Feb 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3+3ybpp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A117741
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707249785; cv=none; b=SV4dfXaE4IALXoSSFoh+BGVZCBVIJNBDHX2bMKd6Acn2EDKnKSRMJyWR7uwEAT8EqEPdmjfT8HsaicQIR9QVQSBKLqTJDikX+fO5ExNCHBbXzr9VtAbLjRUzRJU6G2U1IPoZZrzrb0kZnQu31pL+L2BKrFNF3wPPF4MGVe0FD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707249785; c=relaxed/simple;
	bh=4Dd5Wi9bGR8FWGHP5XEo3Dl84oIpNLPmsNrGy3fOJIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZG6hFK2WdmVJQabQCspu2n9OMcSOuY/3oGLQFamnGgj/uOTPTtHK4Z8CR5vFHjo+ahpCBA4GGGDa403VE8f62w1oa6Uq7DTosPMJtR2Gt3Q2uFbsSr5tffDpYXk+ywduUUKmVCYVbMMKO8QMNls68GL/GUtBiNJaZpaPWwDdkCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3+3ybpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91561C433F1;
	Tue,  6 Feb 2024 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707249784;
	bh=4Dd5Wi9bGR8FWGHP5XEo3Dl84oIpNLPmsNrGy3fOJIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S3+3ybpps768PVi4j5h2lcij3vHute1WC8cUt3k8N5/n98vWK1WiS3P0yhtfo2FOY
	 D5VjYTbrr+aLOK7cumjlsudQFxIIrh+8BAjGYPgF8xbg9nD5UvAm7NECqqyxEIOCYZ
	 AC2adBFFDCmqKLpGnzOpIQzVuS7XNBKOTIv6mlpnhExew4jsWhxLs63qGKzk21heKu
	 T1UE+AKrTgSqnYNj5wZV71DC/j0iSzQLF9kvdQ+86GbOuQh+ZJcKxTJoklZbud/76N
	 s5WvPVTYJAApivwPFN+iC00iTmwxmr1xR0YZIGo/C6iwQ/fUKNGPC32eGrQPgebBoP
	 1OTBiZE/o+VBQ==
Date: Tue, 6 Feb 2024 12:03:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alan Brady <alan.brady@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <willemdebruijn.kernel@gmail.com>, <przemyslaw.kitszel@intel.com>,
 <igor.bagnucki@intel.com>, <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v4 00/10 iwl-next] idpf: refactor virtchnl messages
Message-ID: <20240206120303.0fd22238@kernel.org>
In-Reply-To: <d93d8608-be23-401a-b163-da7ce4dc476f@intel.com>
References: <20240206033804.1198416-1-alan.brady@intel.com>
	<20240206105737.50149937@kernel.org>
	<d93d8608-be23-401a-b163-da7ce4dc476f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 11:18:48 -0800 Alan Brady wrote:
> We did run coccinelle check and see the min suggestions. It's triggering 
> on these statements I added:
> 
> return reply_sz < 0 ? reply_sz : 0;
> 
> A min here would change it to:
> 
> return min(reply_sz, 0);
> 
> I didn't really like that because it's misleading as though we're 
> returning the size of the reply and might accidentally encourage someone 
> to change it to a max. Here reply_sz will be negative if an error was 
> returned from message sending. But this function we only want to return 
> 0 or negative. By being explicit in what we want to do, it seems clearer 
> to me what the intention is but I could be wrong.
> 
> We can definitely change it however if that's preferred here.

Hm, okay, that does sound like making it worse.
I'll disable the minmax coccicheck for now, it seems noisy.

