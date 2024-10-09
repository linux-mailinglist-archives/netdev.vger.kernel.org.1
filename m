Return-Path: <netdev+bounces-133676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C7996AA8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2801F27A76
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F7219993A;
	Wed,  9 Oct 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkRg42mu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE519992B;
	Wed,  9 Oct 2024 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477899; cv=none; b=HFtfoWZa8lqjw+EbszOMAHQWJyTVFaF1pZYqQA5EzqoJxczYsWIi+lmD12UKUKCpSZtEfeJAOMHbjM9nai+VBcC7ndvG3Y5UWdpxLDwZWf6KudLdIzz3RJCq117Fco1cqlm0FbnOlFpOa8qIu+LdSaVyfnZtO+OXdmsWLEONdlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477899; c=relaxed/simple;
	bh=CAj1n8xaJN2sx8bGi75ma8Oormx2JMvDSfKrbm39mu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIIDXlQwkSLRj1YcuOtUR29FrRjWvMUBJyFZHlNuK2g0QRjDk4ZyyZ7EBE6CygRyOOKqWsFtqKPrdece5u3JBvZMzL/z4VXSpAl03nulx2py7HmXZCR1ZFDlm0UnhreT/W0N1hFSzkvkRPbKHgqQyh6TRhOAIkNqlcrss0WnO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkRg42mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACBDC4CED3;
	Wed,  9 Oct 2024 12:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728477898;
	bh=CAj1n8xaJN2sx8bGi75ma8Oormx2JMvDSfKrbm39mu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkRg42mu2PAho0QAXqoykGS92ghft2Cukcl5RCYUZxdoCX6YcNosrUQicxo55/qsK
	 15vlN61LNkgr3r/6Pmv70C4m1mT3SgpRYDiTv9Gahp5atDR6yPr+F+/9pZ5lPbMeW2
	 q4ygpxqgfiBD1ZMbVOK3oj8H/TvlFxCCovdAgCclbstjUUECNsGvjwSXQFIHWuLXbg
	 anz6G0pMosEyFfa6Osc1Z4RRmtYchJDinjNZC42Rds2hUILPLf8z1b4BTIc6gA3S1V
	 i/65qfkwhbubjaDSLZG+ytRD3Bcpaj0dadPefPINw/NPCsu6mwkWdmbehtdfrqDPHO
	 V3tyrOU2XQO5w==
Date: Wed, 9 Oct 2024 13:44:55 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Zubkov <green@qrator.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@treblig.org
Subject: Re: [PATCH net-next] Fix misspelling of "accept*" in net
Message-ID: <20241009124455.GT99782@kernel.org>
References: <20241008162756.22618-2-green@qrator.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008162756.22618-2-green@qrator.net>

On Tue, Oct 08, 2024 at 06:27:57PM +0200, Alexander Zubkov wrote:
> Several files have "accept*" misspelled as "accpet*" in the comments.
> Fix all such occurrences.
> 
> Signed-off-by: Alexander Zubkov <green@qrator.net>

Thanks, I agree this corrects the spelling of accept in these files.

Reviewed-by: Simon Horman <horms@kernel.org>

