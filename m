Return-Path: <netdev+bounces-101163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6F28FD916
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BC71C23091
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA54016B755;
	Wed,  5 Jun 2024 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+rOxrfk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264F15F3E6;
	Wed,  5 Jun 2024 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623057; cv=none; b=ZARR32UT2tT1stIXYtSqgXlBVhAyGAFSejV/m1Zk+VEgLlJFr+g1y1v6+CSIdzwUPfA3XtHncecGgwIsUo6OAhwXZ0dIS+KEfz0QFaIZqA8ynzrGbXbp7zG48z65iKOtSWzwtV35zhjv/MS7qKNTiIk9MF4JDzTCiFfTfetLj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623057; c=relaxed/simple;
	bh=e/lzo4MsGVsUj+Rbv36tR6SnepX757j5ODjaRfZIDos=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=X45Rk/O8rZowi/SgOTrDSTpMp6jAhYLSxKBb0p3pzCyXMAvtAR7uoJJnOX6/LnUxKxgBhKKD3wJeeT7Bsmhgv07/H2VcM7ToIEIoPw53Uv0qpm69WBAwQEENDhlUasJ/WHHLp4FaD6ivUv9ylVk70RpIs04Fqscs9Br94I4mNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+rOxrfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B77C2BD11;
	Wed,  5 Jun 2024 21:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623057;
	bh=e/lzo4MsGVsUj+Rbv36tR6SnepX757j5ODjaRfZIDos=;
	h=Date:From:To:Cc:Subject:From;
	b=N+rOxrfkB08c7fvcstOfVLwSetRjPhoCAHYY9s1qTqSEQO61GK3UaIXLT/2v5Pf6e
	 FczIqfT9m5fSnvX1IxaFW96Yu/KF+TWBibKUZXxh56628abftWukAOjI5iuUszURm6
	 3PPJCECvcEoMy1htwObXRh2kILA49kfnq8xd+qwvEG3bvU5OEAUSMfK1uKZYil0kl6
	 joCt/ptljCNhPFAcU61L+OKp+EynFs2Tb+PNAWZUdMbTMMipft4AhzUhyYH/FaO0L3
	 apUaB7RYdkIhxF7OmZyClCZ45u5rlHWRAELiX7xXGJD8q/ZBvV2uTdfRNJLHjR3pav
	 8dDZ8T1wJ0GsA==
Date: Wed, 5 Jun 2024 14:30:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Cc: David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: [ANN] LPC 2024 - Networking Track CFP
Message-ID: <20240605143056.4a850c40@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

We are pleased to announce the Call for Proposals (CFP) for 
the Networking track at the 2024 edition of the Linux Plumbers 
Conference (LPC) which is taking place in Vienna, Austria, 
on September 18th - 20th, 2024.

LPC Networking track is an in-person (and virtual) manifestation 
of the netdev mailing list, bringing together developers, users 
and vendors to discuss topics related to Linux networking. 
Relevant topics span from proposals for kernel changes, through user
space tooling, to presenting interesting use cases, new protocols 
or new, interesting problems waiting for a solution.

The goal is to allow gathering early feedback on proposals, reach
consensus on long running mailing list discussions and raise awareness
of interesting work or use cases. We are seeking proposals of 30-45 min
in length (including Q&A discussion). Presenting in person is preferred,
however, exceptions could be given for remotely presenting if attending
in person is challenging.

Please submit your proposals through the official LPC website at:

 	https://lpc.events/event/18/abstracts/

Make sure to select "Networking Track" in the track pull-down menu.
After four years of co-locating BPF & Networking Tracks together this
year we separated the two, again. Please submit to the track which
feels suitable, the committee will transfer submissions between tracks
as it deems necessary.

The Networking track technical committee consists of:

  David S. Miller
  Andrew Lunn
  Eric Dumazet
  Jakub Kicinski
  Paolo Abeni
  Willem de Bruijn

Proposals must be submitted by August 4th; submitters will be notified
of acceptance by August 9th. Final slides (as PDF) are due on the first
day of the conference. 

We are very much looking forward to a great conference and seeing you all!

