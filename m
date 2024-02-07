Return-Path: <netdev+bounces-69837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF5D84CCA7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDE81C2594C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6BF7CF02;
	Wed,  7 Feb 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJUoImtl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6D7E788;
	Wed,  7 Feb 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315942; cv=none; b=ATGpqmCsctNAZL9//hJzXn6R5pwVBiYSQpwvpQgCCfFGVi7nbyVWiqPcglq83i1F1gw9yFuUgFP2Gll5lpOpiyCzxrGOwkQX1j/X+LGN23dJEtlzizIWvNiCCa+rSdPjPq4OA3maABNOkvt7HZLZuebHV5B77GN33Lf8evUNY30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315942; c=relaxed/simple;
	bh=9gfeQFNW7jPaPrbXEOMaJtzp02EITBNOO4pB5b64vxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2ON4fuiws/Uvsb+Lp0vmWUYJHzAc2yOUJC/UytjW2RDjqtYmpNgSbZF09FrH14xwubTno3/bF+//4Qib/3L6vZ9rQOi4IuUhfku2wIWjrg3IQ+T5FMH6librtq5dzjDmndzdh7Uxkv09gj90ucXS6mBP5W9ZtKA2km0wULWETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJUoImtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F95FC433F1;
	Wed,  7 Feb 2024 14:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707315941;
	bh=9gfeQFNW7jPaPrbXEOMaJtzp02EITBNOO4pB5b64vxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BJUoImtl/FM4XOspOEcjl6y1WzH/8PBlj2SHCeiWsnOJOUuWksjZfsXsy6sBdzWd6
	 VIeEeTJk3cjRbz2028Fz9I9i7K38N1bf2GglHJEZPBDTi+JUlRIobwukXD6L5n01yw
	 u2rsZ3WRJ5gYRtAVd5IGvKyWhodzYoPVZrAHeaqndc/2RLoAA89/KWn4zp3xpCO6Gt
	 Dmj66QpWQTc769v4PlCp+lGrKogzcigj5BvDDiPsNlrSYqfrReNWixRmWG/yGiKnzz
	 bz9z8ME3WdQVGvT7ugUKTOHzumthsadgF3MMOJw8rBB/1c0iSHWzRh22TobOWbAHtp
	 w+VLGAC2RmO0g==
Date: Wed, 7 Feb 2024 06:25:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau
 <martineau@kernel.org>
Subject: Re: [TEST] The no-kvm CI instances going away
Message-ID: <20240207062540.5fe5563b@kernel.org>
In-Reply-To: <2d0eb4ef-dd07-4800-8fcf-637a924570fa@kernel.org>
References: <20240205174136.6056d596@kernel.org>
	<f6437533-b0c9-422b-af00-fb8a236b1956@kernel.org>
	<20240206174407.36ca59c4@kernel.org>
	<2d0eb4ef-dd07-4800-8fcf-637a924570fa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 10:44:14 +0100 Matthieu Baerts wrote:
> > Unfortunately I'm really behind on my "real job". I don't have a clear
> > plan. I think we should scale the timeout by 2x or so, but I haven't
> > looked how to do that.  
> 
> No hurry, I understand.
> 
> It is not clear to me how the patches you add on top of the ones from
> patchwork are managed. Then, I don't know if it can help, but on the
> debug instance, this command could be launched before starting the tests
> to double the timeout values in all the "net" selftests:
> 
>   $ find tools/testing/selftests/net -name settings -print0 | xargs -0 \
>        awk -i inplace -F '=' \
>            '{if ($1 == "timeout") { print $1 "=" $2*2 } else { print }}'

I'd rather not modify the tree. Poking around - this seems to work:

  export kselftest_override_timeout=1

Now it's just a matter of finding 15min to code it up :)

