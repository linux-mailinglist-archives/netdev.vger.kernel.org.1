Return-Path: <netdev+bounces-237781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2FC502EC
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189363AE034
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4423A21A457;
	Wed, 12 Nov 2025 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfj0GrFe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44F155757;
	Wed, 12 Nov 2025 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762910024; cv=none; b=Rann5wqhSl617wWq8z2PBzOIj9kCLzuEJcuA7ZFalk5VeyLOyibBON3Tv321rWKq1T4FP2hv+AgrcCAL4SYI6K9mKdVS97YPDw4a77mm541N6k1qYD+/ZMkiNE9HWa7B2oIoxY0mr8sQ1mB00Gb2t9r+LPFC2Ykm6uxtDBmNKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762910024; c=relaxed/simple;
	bh=oDl1WfrAghq+RE9pFio7UD5bjLDfO6Rlsgm4KgrcWl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0Mu6Z5vcFsZ+A4idLS5yCIh6ArAXwiOll5ZvnZlm1I+6zD9ukfq+TWMaMrw3DIl7xGliRpW6Tj15ngjGCRw2nX+k7NEDQIn/6QgVdDifFy7VORiUcCLB8LLDQfrZZ8s2nqtv8Zy5PIpVsKbl04tMNaiFUzjchufkrDeRnVGmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfj0GrFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B04C4CEF5;
	Wed, 12 Nov 2025 01:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762910023;
	bh=oDl1WfrAghq+RE9pFio7UD5bjLDfO6Rlsgm4KgrcWl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rfj0GrFe/hv7wIbYG9qd9byNFSuj7ayLnIGNwAkNADVc7oNrOLtZrrnz/hoQ6ODGI
	 phdKmiLSry0/IkvyCxN7WyY8eQS+TAIJxP2P4gx1nXVGwCm46CvCdyEHBkABEy37SY
	 NbvKyrNAz1yonoh1SCJcTm00ccmjeiuKKFb2K686WJ/rPnqD2fSZDo121GFoNKZDC3
	 OLmIuaB1MNlBBKNdhoq9DcK3uRhQNHvtFwLkOEQWrZFmdTOuzkHaHldrwJ1ku6Iii8
	 l4uzpXbhRtOgKEivbZye67n5ky4YBZ1TSY7SZyqdfmxO12VoSTllOxRvgKuzIIVvQ2
	 aSqTD8/vkRZNw==
Date: Tue, 11 Nov 2025 17:13:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Subject: Re: [PATCH net] team: Move team device type change at the end of
 team_port_add
Message-ID: <20251111171341.4c6d69be@kernel.org>
In-Reply-To: <20251112003444.2465-1-zlatistiv@gmail.com>
References: <20251112003444.2465-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 02:34:44 +0200 Nikola Z. Ivanov wrote:
> Attempting to add a port device that is already up will expectedly fail,
> but not before modifying the team device header_ops.
> 
> In the case of the syzbot reproducer the gre0 device is
> already in state UP when it attempts to add it as a
> port device of team0, this fails but before that
> header_ops->create of team0 is changed from eth_header to ipgre_header
> in the call to team_dev_type_check_change.
> 
> Later when we end up in ipgre_header() struct *ip_tunnel points to nonsense
> as the private data of the device still holds a struct team.
> 
> Move team_dev_type_check_change down where all other checks have passed
> as it changes the dev type with no way to restore it in case
> one of the checks that follow it fail.

Since this is a bug fix it must have a Fixes tag pointing to first
commit where the issue could be reproduced.

Please make sure to have a quick read of (at least the tl;dr of)
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
before reposting.
-- 
pw-bot: cr

