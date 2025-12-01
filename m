Return-Path: <netdev+bounces-243051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB4AC98E3A
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 20:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559E73A45BB
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 19:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308B23C39A;
	Mon,  1 Dec 2025 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNQo27Z2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2ED21ABBB;
	Mon,  1 Dec 2025 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618027; cv=none; b=VYt7vphckqJTq0OLMtgoufl/0HH8MPgE6O0i0brnFyqsQqHBaR2NpvhFmbZCJJjpZGEXxbOK+l4zdnmlaGkxtjUFr8A31hFeOlp+/fkzErIT895hniAOQaikYHhYtRbe5HsFUBITXuJjsHqytn47VFjWRY/R1J6BJ5y7KqgKkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618027; c=relaxed/simple;
	bh=zVz95mtlTf+lnr2HHQD8EEzZ+lP+6BtM3gXhZ0qSk10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTAMFjcvc6KL6BTQAWY2Ty/+MyFqVzoTvaVttyDFwPo+rQA9conSuJFbSTU6BA55gK9nAVPD7rpJuXxrghK+BMmu7LQBG067/a/US5u6mh2YNCOo0veAtbUDtVNX2dV1scZiiIo4QIXC9LuFdxVvpud+rOsSlPv8sXjtgl8hZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNQo27Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD6BC4CEF1;
	Mon,  1 Dec 2025 19:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764618026;
	bh=zVz95mtlTf+lnr2HHQD8EEzZ+lP+6BtM3gXhZ0qSk10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sNQo27Z2mLyYmqj5PbDxQNcbqwFqpaidIE8Y+gI81zXHuccIRS0QBriMtDMBhV3rN
	 zS5PsFawiJgrXi6kMy7NU1sJs8EpmOaTkELvKalVG3Wj42AnbZH/D9tRdtXYhNbtfF
	 Iq2c2LM+KbecTAq+sdr77tgaKFHGScjPPxVRWo/nLIXy89bhdMWKxLcle4R7f2UQec
	 j4FQeb73fo698YHGFp/4tvWT535zAyyzE25+LeJrkclbAAhX7YfbcDsTAhNE2TV/7T
	 CVcw20lJOD3mjKTOWoXrJXNt2IRtUnmackTaAYSB5Ql1DPl7zRddhh0zVtAHhes4bQ
	 FPd1T2iWe1FBQ==
Date: Mon, 1 Dec 2025 11:40:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Clara Engler <cve@cve.cx>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] ipv4: Fix log message for martian source
Message-ID: <20251201114025.1e6aa795@kernel.org>
In-Reply-To: <aS3kX7DApnSfJtT9@3f40c99ffb840b3b>
References: <aSd4Xj8rHrh-krjy@4944566b5c925f79>
	<20251127181743.2bdf214b@kernel.org>
	<aSnSJZpC8ddH7ZN0@c83cfd0f4f41d48a>
	<20251128104712.28f8fa7c@kernel.org>
	<aS3kX7DApnSfJtT9@3f40c99ffb840b3b>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Dec 2025 19:54:23 +0100 Clara Engler wrote:
> On Fri, Nov 28, 2025 at 10:47:12AM -0800, Jakub Kicinski wrote:
> > Could you explain how you discovered the issue?  (it should ideally be
> > part of the commit msg TBH)  
> 
> In the past few days, I toyed around with TUN interfaces and using them
> as a tunnel (receiving packets via a TUN and sending them over a TCP
> stream; receiving packets from a TCP stream and writing them to a
> TUN).[^1]
> 
> When these IP addresses contained local IPs (i.e. 10.0.0.0/8 in source
> and destination), everything worked fine.  However, sending them to a
> real routeable IP address on the internet led to them being treated as a
> martian packet, obviously.  I was able to fix this with some sysctl's
> and iptables settings, but while debugging I found the log message
> rather confusing, as I was unsure on whether the packet that gets
> dropped was the packet originating from me, or the response from the
> endpoint, as "martian source <ROUTEABLE IP>" could also be falsely
> interpreted as the response packet being martian, due to the word
> "source" followed by the routeable IP address, implying the source
> address of that packet is set to this IP.
> 
> [^1]: https://backreference.org/2010/03/26/tuntap-interface-tutorial

I see. Sounds legit, we can adjust the error msg per you suggestion.
Unfortunately, we just entered a merge window and then there will be 
an end-of-year shutdown period so you'll need to post v2 in around a
month :(

