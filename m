Return-Path: <netdev+bounces-172553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510ECA55689
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A015175FEF
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F70426B957;
	Thu,  6 Mar 2025 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4/21jk6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BEB4F5E0;
	Thu,  6 Mar 2025 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289124; cv=none; b=bqNFQx0Ulvhg8CbvySNwspMav4PphcX/Vlh1XXLiVJhVrh9yrdNK3yCfRxzG6QAjCMCWZtnzB7adOPUJGDpJ+5EiQXy3wge0SB7MmzLpiWRXQvtp8Xg+aFXQM5yGHhndxZQYWq4sFSuv5415G2IFFdbHChdjrs+BZL5aRRXOaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289124; c=relaxed/simple;
	bh=/3gn/UXYXUGp9YQTjxRCxyTc/Q0sgDTCWT4tloBrK9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZXF4LfbnfjwPM4sSxj3VrxBLMEQ186JBMxzcYaqztJgtHEcpfPY1a2DMijWYj8rs9sWO0kQfG+8lCFPGR+iQDSoGdQIyZzooCZ2L6uh4ELDc7rjZnKEB7aWjovgVgoNrta92ZIARmVjztg333Gfc/50HXOTZtSgZkflTBMN950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4/21jk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365FEC4CEE0;
	Thu,  6 Mar 2025 19:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741289123;
	bh=/3gn/UXYXUGp9YQTjxRCxyTc/Q0sgDTCWT4tloBrK9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N4/21jk6z4jkL3C7VJkFUUHLtAcNeePr+FbJHQpGuHMSEJwgDh1/mM2DOCDb4CQFZ
	 GQ4dhvcUb5iM7Hqe1sfxM7nWyg7qinVIV+7URtm96dWZMAjeaEc46IdgPw89zGkYhN
	 D3ZR+4hO2OinBasXN8wE7UwJ++i5BU0kpTEJTJyuAM3eAad638JuahI560emXEJYXg
	 ipBTAHA5CbmjRn79jg5/HYCK7l8u7K6TbOz10sWje7qa6YsiCPJxYrrOxfapizb94Q
	 owfqfoFOoiWDd6oPfeIHb47zOgToP+S3vyubRYj6lrGkaCJM0RhoqcSkockhMdrMYN
	 5CYKUXF1pNfog==
Date: Thu, 6 Mar 2025 11:25:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: netdev: add a note on selftest posting
Message-ID: <20250306112522.0a2b38b6@kernel.org>
In-Reply-To: <ba1afa07-ea24-4ae5-8f65-fc2fc24f1a22@kernel.org>
References: <20250306180533.1864075-1-kuba@kernel.org>
	<ba1afa07-ea24-4ae5-8f65-fc2fc24f1a22@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 19:22:49 +0100 Matthieu Baerts wrote:
> > +Co-posting selftests
> > +--------------------
> > +
> > +Selftests should be part of the same series as the code changes.
> > +Specifically for fixes both code change and related test should go into
> > +the same tree (the tests may lack a Fixes tag, which is expected).  
> 
> Regarding the Fixes tag in the tests, could we eventually suggest using
> the same one as for the code change?
> 
> Sometimes, I do that to get the corresponding test backported as well,
> if there are no conflicts. That's good to have an easy way to check if
> something has been correctly fixed on stable versions as well.

Hm, that's probably up to the stable team to decide. My intuition
is to reserve Fixes tags for fixes, and add another tag if necessary.
The mention of the Fixes tag was primarily because of NIPA checks...
A bit of a wink and a nod since we try not to speak about NIPA checks.

> The only thing is with the selftests written in Python or Bash: it is
> easy to get a situation where there are no conflicts, but the
> modification doesn't work, e.g. some functions or variables are not
> available, etc. The stable team will then not notice that during their
> build tests. Not sure if my suggestion is safe to recommend then.

Good point..

