Return-Path: <netdev+bounces-121201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5C895C28F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 02:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC041F21B73
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303CCBA46;
	Fri, 23 Aug 2024 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4wlnyL6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D048800
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724373801; cv=none; b=noWeoBIgpkYpy1vd1JtYVTz9qmuN9jvfr1jpcgSyTmL9UzvW/UeTtpVAtBCa0u1DX1J8L/rQESpYk1nz0q08dhCMXYwgJXUTbJOlDTlEcjZNRzn0DLzYDYV9UD+TWygg8ELcIkJ/qe1HwxstdUyPr9S5mkZt9/rs+Pe/PyfXjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724373801; c=relaxed/simple;
	bh=hFceXVbCvCS5A/JDtHlnjaw87XlG4qEAu/V/Ikwad3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXlJVcEEa24zZYCX27/LCgv0AcS6IMgv/dmtXi1eaW2PS9Qx8tLHlNGnNowYAJRuNJWZMri+4Iy+XPoiGCVOBUQ3pBvwP2Wa/HTLDAs4koRvXRS5A3Mda9p3AagF4iXIAW3OnAaOFONVJWzNrYv/RGNlMmpuNGEdYt/CUvyq4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4wlnyL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B09C32782;
	Fri, 23 Aug 2024 00:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724373800;
	bh=hFceXVbCvCS5A/JDtHlnjaw87XlG4qEAu/V/Ikwad3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s4wlnyL61+oref2LW71MNHmi6Xs8Py7gcMHIL1VJw9UrQVvt9YZeGSPO1ouaaGJtO
	 WY4jRpQW4/b7ZqaaAJ5sQWW5Vwy9tqv4JQH/n4aHye3721ZIDk4fuHjW5Dz37OdM4u
	 PlHazrcBp6fPyGdC61tHIucFmsIv7GNdJXeEEvZK1GDYx4rR2nVD8AP9GFHzFTxa+I
	 2zD3mTtwexk7MuacHIi8XW5tyvATMOMtzLae6L4+msHsCacv8om+F63M8BoyDOo1F0
	 5h3l26tXkNdZBxUrakfFf9Mfm7slTFBjoNmrOyP60QOoo4f8yGV0hxKFJILBJ7AnNn
	 xRz9T2dPaddcw==
Date: Thu, 22 Aug 2024 17:43:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v4 net-next 00/12] net: introduce TX H/W shaping API
Message-ID: <20240822174319.70dac4ff@kernel.org>
In-Reply-To: <cover.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 17:12:21 +0200 Paolo Abeni wrote:
> * Delegation
> 
> A containers wants to limit the aggregate B/W bandwidth of 2 of the 3
> queues it owns - the starting configuration is the one from the
> previous point:
> 
> SPEC=Documentation/netlink/specs/net_shaper.yaml
> ./tools/net/ynl/cli.py --spec $SPEC \
> 	--do group --json '{"ifindex":'$IFINDEX', 
> 			"leaves": [ 
> 			  {"handle": {"scope": "queue", "id":'$QID1' },
> 			   "weight": '$W1'}, 
> 			  {"handle": {"scope": "queue", "id":'$QID2' },
> 			   "weight": '$W2'}], 
> 			"root": { "handle": {"scope": "node"},
> 				  "parent": {"scope": "node", "id": 0},

In the delegation use case I was hoping "parent" would be automatic.

