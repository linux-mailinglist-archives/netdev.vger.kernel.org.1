Return-Path: <netdev+bounces-161947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49590A24C48
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 01:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3724188413A
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 00:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEB8524F;
	Sun,  2 Feb 2025 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suUfPr3G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5BC29A0
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738456747; cv=none; b=EiY3trHusaIuIXqCA58MLaFKyCmiZvYkuIGjxfKx799wPGrb0V4zR2QA71Fn3H4CbjVPAbFavDcQvkdoYLhISUQJFTB09knjdfZbHYkge66gwy8KS8o36nXK8zmROGiKNBJgCxwZ3gLrYkH9lrhlgcCjyb+Hy1JfuhspTTvKkyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738456747; c=relaxed/simple;
	bh=G08zdSJOe5pHeia23N0VLNZ5NmYXXQj7tURT6Rk3hT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=go5Day2D+ErZlkr2UniarNHAQoNei56XxLBK8eISO//XfB3DoTkJwHPHqU6eirC0RKO5qIF1aA+0UWQxMDQmHeCJ2664ovUJGhxR/T2z9t/a79NmEWReb1HI7G16hRzbwLBMw1uidfoctkz/+JoOxnlI89etNy8VVJqZ5IjBnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suUfPr3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8DFC4CED3;
	Sun,  2 Feb 2025 00:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738456746;
	bh=G08zdSJOe5pHeia23N0VLNZ5NmYXXQj7tURT6Rk3hT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=suUfPr3G+M+5WoIxknA3jH9cwpUCQWMfz1ilnJMfrLJla/1Fdx/UePxiSAWGHO5fE
	 FXi/NoJyNlnYMAAx11SpJDl0hr8bqUvlaN81JFBOJDs5qumb6ikWMGRcBcgkz2Az8e
	 btPXu7U/yxAm8oyETXUhzidcAn4oO2RmuTQ7CoXu5bfWSJWhlZmd5YxXHFadw9sX3Y
	 bv6Ja3+1dDX9gmUs7VdJZQKnDyd4vHHm/WpicS6CyhCQfkGpNCLQtAR1U3bjf05lxh
	 G4x3Cn9BpFQAqavR7flmP3qeQ2gXnA5/IY0j10kpPL/jux/FeYNB8EvF5sfp62eElk
	 6eOBo0nUOmUmA==
Date: Sat, 1 Feb 2025 16:39:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [PATCH netnext] net: tc: improve qdisc error messages
Message-ID: <20250201163905.1741de75@kernel.org>
In-Reply-To: <CAM0EoM=nO52XBrcbMvDbe-OiyK7dBd0aVY=oN=3FsW6wQ9P14g@mail.gmail.com>
References: <20250116195642.2794-1-ouster@cs.stanford.edu>
	<CAM0EoMkkk-dT5kQH6OoVp-zs9bhg8ZLW2w+Dp4SYAZnFfw=CTA@mail.gmail.com>
	<CAGXJAmyxX0Ofkb-bzK=gXHJtjiVFczYcsvwAg9+JfS0qLjhqnA@mail.gmail.com>
	<CAM0EoM=nO52XBrcbMvDbe-OiyK7dBd0aVY=oN=3FsW6wQ9P14g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jan 2025 08:49:31 -0500 Jamal Hadi Salim wrote:
> Re-submit when net-next opens with --subject-prefix="PATCH net-next"
> --subject="net: sched: improve qdisc error messages"

Sorry for the confusion, the pw-bot didn't reply and someone
manually marked this as changes requested in patchwork :(

The patch has in fact already been applied. It is commmit 
f16312b0b9c0 ("net: tc: improve qdisc error messages"),
and already in Linus's tree.

