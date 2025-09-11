Return-Path: <netdev+bounces-222221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D62B5399B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3845E16E41D
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B44327A21;
	Thu, 11 Sep 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALOHvfFJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC91DD525;
	Thu, 11 Sep 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609360; cv=none; b=sWXla2OBLiwDQuCJbrtK2YuYueDnupblkiOdS65iA++onOkYUjrtfVmGt0YRZqUz/2egdLZB5A4Ez8GVxI4jGiDi4GCKrHdqkvIvrysNgbO29RRyhuaqxOby/ndpjnRzKxgeUKH46GwYh+YU2jR51XpYa/8/I0Gc6MbXvgemYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609360; c=relaxed/simple;
	bh=vBrh4Eg/9AalFgG+VFvxFaFUOMBAIQlV1yro0Ua4Tco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omtCW1FYUzppBym+24gL20UryJ3qBoC8JYVEANGp3uY+0YwjgkFXmcIbiv3m46qCEZvmmvhPBGLMv7h5+6+Ja8mkdCkRxHXFLuozTtUeJ/RVp9Q5J0xZZx90ysva9dVd2WEoKSZbDBY0NJEUiM01qM3Kny7eUfqbwn3piFvnC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALOHvfFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89750C4CEF0;
	Thu, 11 Sep 2025 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757609358;
	bh=vBrh4Eg/9AalFgG+VFvxFaFUOMBAIQlV1yro0Ua4Tco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALOHvfFJ9RID0dPrP2fyFaJa0+AxLMq18gqFvC0utl2WdbcNxJwK/OQjCNGxW0I3D
	 NO+7tEtB/teomxUItqMMX88U1liPg6Bou86ZlNFIzSzjBQFuzqM///WMoUDNoUmgab
	 m37gtqQwaXbij3ntVOReWAcS+utiFJFsD2E4y5dfTfALk84ocXeR2IsCqaCKUUMgAN
	 7CaeesvT2XEq6ZJ0+Y8YagG1u57GIvR+JhIQXJosEcSQHLt1z7UbUODoeKGDD3Ks8a
	 uRa1WrVryRNy85NLl6r2SXqlFnqabT5Zi8/9D82c4q01dctXlFqhN5/QPpnhycm/Ar
	 g649Qu2DIc4KA==
Date: Thu, 11 Sep 2025 17:49:15 +0100
From: Simon Horman <horms@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: Replace sleep with slowwait
Message-ID: <20250911164915.GN30363@horms.kernel.org>
References: <20250910025828.38900-1-dsahern@kernel.org>
 <20250910025828.38900-2-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910025828.38900-2-dsahern@kernel.org>

On Tue, Sep 09, 2025 at 08:58:28PM -0600, David Ahern wrote:
> Replace the sleep in kill_procs with slowwait.
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


