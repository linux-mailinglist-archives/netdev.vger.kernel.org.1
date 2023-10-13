Return-Path: <netdev+bounces-40563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7C77C7AC6
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 02:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FB91C20DA5
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AAA36A;
	Fri, 13 Oct 2023 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJxTjZAo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735E360
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 00:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E499C433C7;
	Fri, 13 Oct 2023 00:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697156133;
	bh=ryPle/1x3mswxx4PaZa3d1IXrtB5t2o1gtURUuXFgfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cJxTjZAowKMrUFCc8h317HW+yYN3hAEuMAxjaMjcaotq4wwk9XY3f+p8lX863qTjM
	 OwZBj4HQ/ZRIVnBpdDNqLcwDtci2+0NkQEvE8762a17d2ik3WaVVR5k9T8PbF685p+
	 nE9WrKzGsGlfh+ox50233Eey3sPYTKuxkoP8G0ASBgIS0ovdkZTGUvcXX+O5mJj5jT
	 e0QCxItjIwzwRvHptMQ+ddj0BP+KiN8tCYoIGbmpubL3m4SddA/RN7wKN6+onlXjDD
	 V53bybodMfV7FFP2JggBSqPV2NIGbBGVOQiQ1yIs2pWiXOJtI8oxyCNzvr7HhslAx7
	 e3WKlAEU6rJDw==
Date: Thu, 12 Oct 2023 17:15:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <johannes@sipsolutions.net>
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Message-ID: <20231012171532.35515553@kernel.org>
In-Reply-To: <b8705217-c26e-454d-a7f7-d24a4d8cbd0d@intel.com>
References: <20231010110828.200709-1-jiri@resnulli.us>
	<20231010110828.200709-3-jiri@resnulli.us>
	<20231010115804.761486f1@kernel.org>
	<ZSY7kHSLKMgXk9Ao@nanopsycho>
	<20231011095236.5fdca6e2@kernel.org>
	<ZSbVqhM2AXNtG5xV@nanopsycho>
	<20231011112537.2962c8be@kernel.org>
	<ZSe8SGY3QeaJsYfg@nanopsycho>
	<b8705217-c26e-454d-a7f7-d24a4d8cbd0d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 14:06:57 -0700 Jacob Keller wrote:
> >> - it doesn't support "by name" operations so ethtool didn't use it  
> > 
> > It follows the original Netlink rule: "all uapi should be well defined in
> > enums/defines".
> 
> What's the "by name" operation?

Instead of sending the full bit mask sending the list of bits and what
state we want them in. And that list can either have bit numbers or
names. Looking at ethnl_parse_bit() could be helpful.

