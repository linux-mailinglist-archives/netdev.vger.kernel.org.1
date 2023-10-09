Return-Path: <netdev+bounces-39241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F7C7BE6A5
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845771C20A82
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D213ACF;
	Mon,  9 Oct 2023 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTDzFvnm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A738BB6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 16:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B489DC433C8;
	Mon,  9 Oct 2023 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696869477;
	bh=qlRswpJRFpIH5Iy48M5LSdwCmWTl90kKMCV2ExLF/EQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jTDzFvnmUfShJHJDdWz4lW8h8tANOLQ6wB1tT/XTuNQdahE8Wo2p1rZtdVII1Czr0
	 oGGza2C7Y8cka2FZhZZKl7Epeg7kvxcIZfNZz0UhRwfy44uW0hEKDT809cB0saglQ0
	 UEa+8uoS4rTd5IqpriPgWvDkY2gbluW5/DOOkUT+hQ4lN6Vj4Gk7Wu/7EArtRu8C7t
	 0BBRa3K8Ywy08/RWW8nsjFOQrLCe5jexNiliCE8GozheWa/SvTi/vJuNjWzi9HGLLW
	 q2oL83ME5NYAc1bztvpFAOyceh4kbXBu1ykYc1rv7e+J8rCyVysAngspljKq563x5F
	 z6RCwUChQBjgg==
Date: Mon, 9 Oct 2023 09:37:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, corbet@lwn.net, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, vladimir.oltean@nxp.com, andrew@lunn.ch,
 horms@kernel.org, mkubecek@suse.cz, Wojciech Drewek
 <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v2 2/6] ice: fix ICE_AQ_VSI_Q_OPT_RSS_*
 register values
Message-ID: <20231009093755.19f9ec9c@kernel.org>
In-Reply-To: <20231006224726.443836-3-ahmed.zaki@intel.com>
References: <20231006224726.443836-1-ahmed.zaki@intel.com>
	<20231006224726.443836-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Oct 2023 16:47:22 -0600 Ahmed Zaki wrote:
> Fixes: 7bd527aa174f ("ice: Adjust naming for inner VLAN operations")

If there is v3 please drop the Fixes tag.

If the mistake doesn't result in a triggerable bug there's no need 
to backport this and therefore no need to annotate the source of 
the problem. It will just confuse people into thinking it's a real
issue.

