Return-Path: <netdev+bounces-175765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA76A676C6
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA1A3B82B5
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A253FC3;
	Tue, 18 Mar 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzbucQmF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF7207A3E;
	Tue, 18 Mar 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309302; cv=none; b=LdBGPbWeUD1xy85tVQr++cgyaa9fMQSDqp0ZWUjMJb1z897O0TjdsxA0Wes9yhhNlLchgeRknE50RveAm2N3jaA/mrAT9Plw5EEOKdIe0/Ah40x6EQwINUg07gBQQwik/k9XZHJm20W7Zghz6g6oq1qPFmJzfZqWQLYEiHt2FuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309302; c=relaxed/simple;
	bh=/FEdHl3jk0n6rO675cBSNPnQPnOs8f+H3LcY5yHGvgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2EFer53JvmPnVOHvnSHjVguRIcCgDsInXjKtA6rG3JBoAJKqBjC7uaqBEuVtqlnDOA5HxtRjONMtzkHuDsWAX6TytYngOJCzllULiuI8fUfgquiPwu8mYC4jBAuU0ZkApHOgMeaTI510TmIrztQ/vm2cgEBSpw8X92FFndM1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzbucQmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B06C4CEDD;
	Tue, 18 Mar 2025 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742309301;
	bh=/FEdHl3jk0n6rO675cBSNPnQPnOs8f+H3LcY5yHGvgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzbucQmF9/xPVwzzXVdmF680I5od/ArclBuhZcObN9lUb7bnfAFYmhKNXzJtFTuWU
	 bxV1EVqZQtqnKg62I1U+4Zwkgr98Onr3ltLTTHRHDbsYv5qJqYprbTW/cOzPVD+Bim
	 vdgcGCLGS1CSZdbN7oG9w0Yl9qyBD51Sm6LGz+oQWbdE2lNCK2DpQ49en5HCeNySJi
	 i87pDgQZzl6dZhz/Sb3F94WYo2UWCRkmFEjkTQ6bJBbBETOXl2jXgEIUUkh5i8ThK+
	 ly9xAQ5dA9FQHJzzWn/0w9AKeGNSAQdxwVGy6YVoEEN5MC4Y53PL90ZZyeW5X8rz/B
	 ntmlOponQjgNA==
Date: Tue, 18 Mar 2025 14:48:18 +0000
From: Simon Horman <horms@kernel.org>
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	edumazet@google.com, kuba@kernel.org,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next] igc: enable HW vlan tag insertion/stripping by
 default
Message-ID: <20250318144818.GB688833@kernel.org>
References: <20250313093615.8037-1-rsalvaterra@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313093615.8037-1-rsalvaterra@gmail.com>

On Thu, Mar 13, 2025 at 09:35:22AM +0000, Rui Salvaterra wrote:
> This is enabled by default in other Intel drivers I've checked (e1000, e1000e,
> iavf, igb and ice). Fixes an out-of-the-box performance issue when running
> OpenWrt on typical mini-PCs with igc-supported Ethernet controllers and 802.1Q
> VLAN configurations, as ethtool isn't part of the default packages and sane
> defaults are expected.
> 
> In my specific case, with an Intel N100-based machine with four I226-V Ethernet
> controllers, my upload performance increased from under 30 Mb/s to the expected
> ~1 Gb/s.
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks,

this seems entirely reasonable to me.

Reviewed-by: Simon Horman <horms@kernel.org>

Link to v1 for reference:
https://lore.kernel.org/all/20250307110339.13788-1-rsalvaterra@gmail.com/

