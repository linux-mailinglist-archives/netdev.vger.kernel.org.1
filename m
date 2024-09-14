Return-Path: <netdev+bounces-128304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD75978F05
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 10:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA91B2341D
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52478143723;
	Sat, 14 Sep 2024 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWNIKpLd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EEA13DDA7;
	Sat, 14 Sep 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301602; cv=none; b=OktnKh/vSsPQoScWYhNFmSaorxC8oo4+pbT5Z9jCgBixHo0Uep9qq5iIGKvkZfOGIWSUOLFpv5Adk/JQSsPRJQxKCqYzbRCKEbt/INMBJnvyKNfhZIwJ+CKbjMTc7SrgDJ24P0LxjoqXcyAH7AYlwdzQX52h5TlrJ7zi0C2+qi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301602; c=relaxed/simple;
	bh=M+Zf4JY7aU+gdS50S+1fYY8bKADB2nX5JxUksO+lNZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzEWpQAllIpOqnCWzX9JjvgNogzLGYkNgvUnBnj+TYUIkTy+/cUiWWgkqEALnHzRv4V7OnGLAIuIAEc6b+ixRfplJo2xFLCsZn78kSjr1vBiLp/lgM4PyKRzBYczF1cDyVA1T/1SZdJvUXjK0fwlOt0xmPo1jKDnO9Gdfh+cQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWNIKpLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D346C4CEC0;
	Sat, 14 Sep 2024 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726301601;
	bh=M+Zf4JY7aU+gdS50S+1fYY8bKADB2nX5JxUksO+lNZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWNIKpLdmAOW117JnXlk6GSbuLqlPp7A4RSyI0+XWJ05EynYG/hr+qXCMZPNd8Iqn
	 IR7Z0hlN74RxImblVHRjeJALmXsd/cG37sXQvfPBnunVX7NL96SqFOpTobsmJ+FTkF
	 KhojZ+Ap3PbarALR5gs+mjyBmqsmV35HKGU14CJ7PpiidDYvPJ0hM+QAYvtaYMW3Q+
	 1Nl7yaA74ujRWXn5PvQvhI5TPipHd8Fvlsp2BbTf6/zXvF2exl2uz81DpnLFKlhJtA
	 Geei6zdImqlLXNjIUvd/KpfQUSE8VfaUof+V0rT2lO4ZFRdU3PZtleSeIVLEp/oJqH
	 4lpPKWTgUeQxQ==
Date: Sat, 14 Sep 2024 09:13:17 +0100
From: Simon Horman <horms@kernel.org>
To: Linu Cherian <lcherian@marvell.com>
Cc: davem@davemloft.net, sgoutham@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gakula@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2 net-next 1/2] octeontx2-af: Knobs for NPC default rule
 counters
Message-ID: <20240914081317.GA8319@kernel.org>
References: <20240912161450.164402-1-lcherian@marvell.com>
 <20240912161450.164402-2-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912161450.164402-2-lcherian@marvell.com>

On Thu, Sep 12, 2024 at 09:44:49PM +0530, Linu Cherian wrote:
> Add devlink knobs to enable/disable counters on NPC
> default rule entries.
> 
> Introduce lowlevel variant of rvu_mcam_remove/add_counter_from/to_rule
> for better code reuse, which assumes necessary locks are taken at
> higher level.
> 
> Sample command to enable default rule counters:
> devlink dev param set <dev> name npc_def_rule_cntr value true cmode runtime
> 
> Sample command to read the counter:
> cat /sys/kernel/debug/cn10k/npc/mcam_rules
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v1:
> Removed wrong mutex_unlock invocations.

Hi Linu,

This patch seems to be doing two things:

1) Refactoring some functions to have locking and non-locking variants.
   By LoC this is appears the bulk of the code changed in this patch.
   It also appears to be straightforward.

2) Adding devlink knobs

   As this is a user-facing change it probably requires a deeper review
   than 1)

I would suggest, that for review, it would be very nice to split
1) and 2) into separate patches. Maybe including a note in the patch
for 1) that the refactor will be used in the following patch for 2).

As for the code changes themselves, I did look over them,
and I didn't see any problems.


