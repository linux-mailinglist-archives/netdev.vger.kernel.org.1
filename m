Return-Path: <netdev+bounces-189853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1229AB3ED4
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF131887165
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32A8296D31;
	Mon, 12 May 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtK2bR71"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9492951B1
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070291; cv=none; b=Q9bI59R+xgEiBsbUYq32JGOXxUe7Vzt/NraZ6NBvZlwaIly76NMuSiInZjPXBIkjL17hY/0xyjWgdRTSIdcweACPd8sVrgP0GYpoIhEhDB59030zuKP9Zs4s5JHiTC4McIEa+oDbOqZ9EcWET+YNwOHPb2X2DL582vUIcxNAmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070291; c=relaxed/simple;
	bh=x5kBLEMiuhJd1dBI5NK8qWHIs4wHKgRm86alD4jd9JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWMDKFYNxjQ7Xq/UHy+lrH8Cu3c5+1P0HUBwv/SHVog1gNtwTVFn+blYiF4/OC5KQk5+7SRsr8OxOWPHr5wvEdmClons+QVrremtCmy4U8DuiglALn6G1PKtTB45I8BEImrDuh6G+QmNP8ovcVW8r6BBEfKselKTr4eM2ZxdH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtK2bR71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FC0C4CEE7;
	Mon, 12 May 2025 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747070291;
	bh=x5kBLEMiuhJd1dBI5NK8qWHIs4wHKgRm86alD4jd9JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtK2bR71cQoWMQCEd64hvQv3APJovdhVnciwp/ALn4qqKMe0EFd1kObrzRs6exNte
	 sgzKi0U6TbO+bwA+lH148Ia/tAm80DUlE1DQ5iJGaxojCkzmYCl8BVxzpgNPWgxZ+i
	 BDOJUCcea9WjITXIsZ2ef1+D14MrPp2QOrGBBGbNNqGEIsWfU2Tyk002hibbcfl35M
	 apm3fEGXlZAmqYdkWA8hPKw3tr4vkgiICjhGtz0RQlX19YHxzlyZ72inpcPZJMMheA
	 tyiGtDVRpjS67GzPuWifpHPZrQ1l0rOxuierxN42NRwlBXUZuLzCFAVQZ3aFPgNHAB
	 UKc1zQ1GkqlMg==
Date: Mon, 12 May 2025 18:18:07 +0100
From: Simon Horman <horms@kernel.org>
To: Eelco Chaudron <echaudro@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
	i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2] openvswitch: Stricter validation for the
 userspace action
Message-ID: <20250512171807.GU3339421@horms.kernel.org>
References: <67eb414e2d250e8408bb8afeb982deca2ff2b10b.1747037304.git.echaudro@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67eb414e2d250e8408bb8afeb982deca2ff2b10b.1747037304.git.echaudro@redhat.com>

On Mon, May 12, 2025 at 10:08:24AM +0200, Eelco Chaudron wrote:
> This change enhances the robustness of validate_userspace() by ensuring
> that all Netlink attributes are fully contained within the parent
> attribute. The previous use of nla_parse_nested_deprecated() could
> silently skip trailing or malformed attributes, as it stops parsing at
> the first invalid entry.
> 
> By switching to nla_parse_deprecated_strict(), we make sure only fully
> validated attributes are copied for later use.
> 
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> ---
> v2: Changed commit message based on Ilya's feedback.

Reviewed-by: Simon Horman <horms@kernel.org>


