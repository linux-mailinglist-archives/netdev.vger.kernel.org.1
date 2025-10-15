Return-Path: <netdev+bounces-229628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB5BBDF024
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 043A64E34D0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD5126561D;
	Wed, 15 Oct 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsAAZeU9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CEE25C6FF;
	Wed, 15 Oct 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538349; cv=none; b=ki5HKKy9cv6x93gNAXFJWD/DL/Q7N3VfFe5cPdQf/NyjcEbAoNYnMDAZhhicUzbSaejuZ4utioMtKMz/P69XnsK0aCp9I84pO0FU+KcZfXzr6s0ExJXIXWtQ71t0F0h+MRFRgIBeRsmlNQU3RmmuHEmuakvkinNnWyeJVzpHEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538349; c=relaxed/simple;
	bh=1DJ2jDZn0JtNLiEK+YMnEGzt8g3y1oCm2JZDj+y4kzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOxMVC3UTSUSXa/ESCs2e8qQNgTVrsETzlgN/4jksHDXLqvWr4607GGgO/EfhVXet2npq8C83NXmm5UX78B7Qwat9nBJo1wsag9jLnmX8FrIURZ2kqrSWqsQHoDunNuv2FA7XQw3LjMpYIPdq47h5Ohv3E+ONhMLlVtNVP5Jsb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsAAZeU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9A9C4CEF8;
	Wed, 15 Oct 2025 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760538349;
	bh=1DJ2jDZn0JtNLiEK+YMnEGzt8g3y1oCm2JZDj+y4kzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tsAAZeU9GQTp3gS3GOeuyryKLn6uUX07CRbE+8PhMxm73fVWFxn+IxbBk1ZR/7AvL
	 pyw0quPh5NGsptlAMCHNO2+Eg6kWQ4ogBfJT6XRGrj13JI3XghDzhyO5tK17kqkV9r
	 +NskYQqnPFk2fM7WXxXT8JB5WjBHx3khy5s/toy2jNni1+fQP+9MS2XoEeymP04HOz
	 gQnwhVck98sF22bSTwvon2JglEc2/yloUbizUmyyR3W7xQTJJxhfXfFZH1omrxIAJE
	 xmlF4ZRwZpfJBgNpR6nXLRPquI/te46cAapo2+wa2G9/6eKgmuLu9xJ4v3Pbmgqwdc
	 s5KndYKMkclvQ==
Date: Wed, 15 Oct 2025 07:25:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Frank Li <Frank.Li@nxp.com>, Andrew
 Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <20251015072547.40c38a2f@kernel.org>
In-Reply-To: <CAL_Jsq+SSiMCbGvbYcrS1mGUJOakqZF=gZOJ4iC=Y5LbcfTAUQ@mail.gmail.com>
References: <20251010183418.2179063-1-Frank.Li@nxp.com>
	<20251014-flattop-limping-46220a9eda46@spud>
	<20251014-projector-immovably-59a2a48857cc@spud>
	<20251014120213.002308f2@kernel.org>
	<20251014-unclothed-outsource-d0438fbf1b23@spud>
	<20251014204807.GA1075103-robh@kernel.org>
	<20251014181302.44537f00@kernel.org>
	<CAL_Jsq+SSiMCbGvbYcrS1mGUJOakqZF=gZOJ4iC=Y5LbcfTAUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 06:53:01 -0500 Rob Herring wrote:
> > > And the issue is that both PW projects might get updated and both don't
> > > necessarily want the same state (like this case). So we need to
> > > distinguish. Perhaps like one of the following:
> > >
> > > dt-pw-bot: <state>
> > >
> > > or
> > >
> > > pw-bot: <project> <state>  
> >
> > We crossed replies, do you mind
> >
> >   pw-bot: xyz [project]
> >
> > ? I like the optional param after required, and the brackets may help
> > us disambiguate between optional params if there are more in the future.  
> 
> That's fine. Though it will be optional for you, but not us? We have
> to ignore tags without the project if tags intended for netdev are
> continued without the project. Or does no project mean I want to
> update every project?

Fair :( I imagine your workflow is that patches land in your pw, and
once a DT maintainer reviewed them you don't care about them any more?
So perhaps a better bot on your end would be a bot which listens to
Ack/Review tags from DT maintainers. When tag is received the patch
gets dropped from PW as "Handled Elsewhere", and patch id (or whatever 
that patch hash thing is called) gets recorded to automatically discard
pure reposts.

Would that work?

