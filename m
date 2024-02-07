Return-Path: <netdev+bounces-69668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F59F84C1D6
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FF0B218F1
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB43C53A0;
	Wed,  7 Feb 2024 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrS8ukBX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B90EEC6
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268903; cv=none; b=u19CiwGecRcowBll8cY/BW9lWvu1RmpEtZVcaXyuMXr3nPxWIP3Wyfji8w+DOREH4Tgm1UTx4ji/6mT0q59L63UxvVPmo906UVKdLQ9ciAa25KSqtzMKYe6NNN6zaYXZXEqVAadoWJ6xOyOtwdwpZjzjB6QQdntBoMUGNBkAghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268903; c=relaxed/simple;
	bh=0Uc3XWmg6lyO/G4kdfVbohxQ5FnWLm6CPm1og03DkR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbZDorAczJF+oALk/+GeDhfz5XRE9VgxtPfPortcXypClh7XhWWw6mrGvAqABNYMhzBCn7ck1yQjgp338c82xPV9gdsU+3o9n8//HoeA/+vpuBk26p15zXkPvsNHNhEepuwrZTYKiUCavQz6ryZlQB6/TqkyY8hZZIC3OtzSH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrS8ukBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C195FC433C7;
	Wed,  7 Feb 2024 01:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707268903;
	bh=0Uc3XWmg6lyO/G4kdfVbohxQ5FnWLm6CPm1og03DkR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JrS8ukBX6T1IxUapCv6Dgq+4iF7fZcRiwmW7Z+uVJVDWjMHIu55iZww/DkWzF2ypg
	 XzpPLezW/Ux1TvW/sVZ4vQpt7VYcTbc4fNyuYrQNHrh00K7w8I2/yzj90wcRRbjsL6
	 4DxBQI9DwVLUGfPUGUCq2WvC5YvquiF5Zz/HxbGc+9hTnTsAqy/ZjTAxXY0t5SDXT+
	 B5DncQYSzkpRtsoho+v7jAx5+xsZ/Me9hT2V65FKlmEbqAj79CkulHKGaK35RqvcUw
	 MvMvl8ml0CpwqFCxh4GcpI6ANdonMmGBe4T6cuHilPCyqQTaPQ5evlszE3WDAQ/Jmp
	 XLwv7+Qq2j6pg==
Date: Tue, 6 Feb 2024 17:21:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, Jay Vosburgh
 <j.vosburgh@gmail.com>, "David S . Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Liang Li
 <liali@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net] selftests: bonding: fix macvlan2's namespace name
Message-ID: <20240206172141.640b91d9@kernel.org>
In-Reply-To: <20240206153515.GE1104779@kernel.org>
References: <20240204083828.1511334-1-liuhangbin@gmail.com>
	<20240206153515.GE1104779@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 15:35:15 +0000 Simon Horman wrote:
> On Sun, Feb 04, 2024 at 04:38:28PM +0800, Hangbin Liu wrote:
> > The m2's ns name should be m2-xxxxxx, not m1.
> > 
> > Fixes: 246af950b940 ("selftests: bonding: add macvlan over bond testing")
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>  
> 
> Hi Hangbin Liu,
> 
> I agree this is a nice change.
> But it is not clear to me that this is fixing a bug.

Agreed, very unlikely mktemp would give us a collision.
Please resend for net-next with no fixes tag.

