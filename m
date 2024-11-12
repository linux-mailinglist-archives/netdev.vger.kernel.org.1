Return-Path: <netdev+bounces-144145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB329C5D5E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068B1B425EE
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEE6200BBA;
	Tue, 12 Nov 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlUtcwUN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C2200121;
	Tue, 12 Nov 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425282; cv=none; b=ZCYosQuBoAmZcI7li3g3cLobrfY6DVdv55nVYPLhKoyX4BGc02J1pUttYMlhvOU9A8kUCqQXd/Fh9N2o0NATKWdegcE5zmIVvWlx2UnGGlFbAaZu2pf+RyLDx2iESCJqgcwiT+zj4Va4tetJnaXfwpONzdRMLuqzIpsBw94N+Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425282; c=relaxed/simple;
	bh=Z58vp2e2al0KWimVIPipVRG7YJpIir/MZaKzKbtQGVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYwlTIDNsXEK/uelo4ANKl1KFmqEtKhUUho20oF7gPahSrzaNjESdL62h3BcLyoe64qCbXHWc+upXuJElsiPGwoq5HwpLWYvviVGDUpFxcRNKjZJxaremQMcthd/Zkstqs36zHQdjqLJcfedfD5yCsLzEC4D3Kyuq+xsHIOSC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlUtcwUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FADAC4CED0;
	Tue, 12 Nov 2024 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731425281;
	bh=Z58vp2e2al0KWimVIPipVRG7YJpIir/MZaKzKbtQGVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BlUtcwUNpeuHsJZkJS8EgY/gkmNfn6KmGOr64KPfIEzpyq3a9TIqKZE0UzijvQMvC
	 lVV6hvjSP6tv0WvgumXZwniU9PGyVbQ66/eabqlQSB5BOt2IgNc94SKoRtjDHHenKb
	 Y3gf+x1tLS7I8Wjhj831VHASQe7u+XVlxSc/Pal2JDr542YXYvJPhjf+yXAUZqfQtv
	 esqWIDMXP4cw4U+BdRqDJnY/ClrH/MZtX86XfM4DXyEJKvyChmtfa6EoTqfFjhm2dz
	 yrzBAoM61/8DyYiTxpUugJe7Kk+3WNLxK8FI/w2JRHuZrVZoyvP3rt+VsitLcpdB7N
	 +ykMYaI3wU+cw==
Date: Tue, 12 Nov 2024 07:28:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tools: ynl: two patches to ease building with
 rpmbuild
Message-ID: <20241112072800.3a25cdbc@kernel.org>
In-Reply-To: <CAASaF6zsC59x-wCRKNmdPEB7NOwtqLf6=AgJ-UO1xFYxCG11gQ@mail.gmail.com>
References: <cover.1730976866.git.jstancek@redhat.com>
	<20241111155246.17aa0199@kernel.org>
	<CAASaF6zsC59x-wCRKNmdPEB7NOwtqLf6=AgJ-UO1xFYxCG11gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 09:16:07 +0100 Jan Stancek wrote:
> One thing I wasn't sure about (due to lacking install target) was whether
> you intend to run ynl always from linux tree.
> 
> If you're open to adding 'install' target, I think that should be something
> to look at as well. It would make packaging less fragile, as I'm currently
> handling all that on spec side.

Yes, definitely open to adding an install target.

Assume that whatever is missing or done strangely from packaging
perspective is due to incompetence rather than intentional design :)

