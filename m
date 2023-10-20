Return-Path: <netdev+bounces-43142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F457D18D4
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BCF281BBD
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 22:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0567632C83;
	Fri, 20 Oct 2023 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaavavBn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D3321AD;
	Fri, 20 Oct 2023 22:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09317C433C7;
	Fri, 20 Oct 2023 22:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697839558;
	bh=y2bK7Rld1GZZCtSFjbtlqtGNkpjPpl8o4DNjguzr4B8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YaavavBncXq7wevwgeAJO1GhimQe1EOmyLMvmZScW1QA2GQyHN+n/1pkf4mE84i1o
	 9Fv6s/3hw2c8RLw47ICeptfdTSDA5V7AFgnITJioLkqIF+zZZV21qBKxmAtXBOI5nS
	 JDGlTWVwqIw+mgbEoDbqVeD8W7DE3ua0BCERMVWY9ZSPLI/yiQs1etNZoSm2jj50Hs
	 N92SUW/52jRHQw3F4ly4TzLlRli14Ol6Ege3OVLgp0qaVMdgd6ykx/uL3KNSdm5skJ
	 mYr1h2kleZt+f0Iu0edLEUIQtk+8x8/dSjXg4v9tF4LzaHrowO9fZ/mlDCgI7XtwL5
	 IAs7Aqcolu7CQ==
Date: Fri, 20 Oct 2023 15:05:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>,
 <oe-kbuild-all@lists.linux.dev>
Cc: kernel test robot <lkp@intel.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <20231020150557.00af950d@kernel.org>
In-Reply-To: <b499663e-1982-4043-9242-39a661009c71@intel.com>
References: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>
	<202310190900.9Dzgkbev-lkp@intel.com>
	<b499663e-1982-4043-9242-39a661009c71@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 13:26:38 -0700 Nambiar, Amritha wrote:
> > WARNING:SPACING: space prohibited between function name and open parenthesis '('
> > #547: FILE: tools/net/ynl/generated/netdev-user.h:181:
> > +	struct netdev_queue_get_rsp obj __attribute__ ((aligned (8)));
> 
> Looks like the series is in "Changes Requested" state following these 
> warnings. Is there any recommendation for warnings on generated code? I 
> see similar issues on existing code in the generated file.

Yes, ignore this one. I'll post a change to the codegen.
The warning on patch 3 is legit, right?

kernel test bot folks, please be careful with the checkpatch warnings.
Some of them are bogus. TBH I'm not sure how much value running
checkpatch in the bot adds. It's really trivial to run for the
maintainers when applying patches.

