Return-Path: <netdev+bounces-199202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B0DADF633
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E120117EA35
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296A1A3167;
	Wed, 18 Jun 2025 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTc0h3rA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBBE3085B3
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272456; cv=none; b=DJ1GxCKklRUCXcYXTERzLU/mcM8Qx2HzFX+IGUm79J8/PPCvyiPibJrOPdoy0gI34uBxuF7ERNHMeDK4F8JsUoMNImWD52BTZo+v2r7CNS5TMDx6AIICp8lvG+J5SQNhyrHwqVW6NyE02NMCUAL+cO0mwYuA12QvBGlR2ld7o8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272456; c=relaxed/simple;
	bh=FyR+UvfwxWEdNAnzplUkLL3k4NbHwnAdaKieqxpQciM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGVQt3/BIicj1ODPwUMzJnlJlwFipnmzdNpHstKju5Lf21qTtkF3U3YIQdLMpP+utrv9rARoOxxvJ7UxLYg+2hbRIfUYjxKyY2S/2T3OTGbX9L3cwx4IpUea+RRlzcQbL5S0qD7uoEmu+jpt0+eUgD/+t2trEmuK7KUgy/iiLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTc0h3rA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0988CC4CEE7;
	Wed, 18 Jun 2025 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750272456;
	bh=FyR+UvfwxWEdNAnzplUkLL3k4NbHwnAdaKieqxpQciM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WTc0h3rAr+3TfjIFOZN/QUl7rQ6l12DKhuiv2vV2HJzQesP80cDBJy11CQ2ityO3v
	 6hL8wfICluxMLC6ze9n5xzgVaTxlPdPdyi0p6wyqXxwV37VpPgLJEsk/8vvWZaqg8p
	 f4Gv2VkXxRGZbHrHLXydmgyCrQVHedLeb05oCctnmEcBhJP3i4YwWpEHaurtcESRev
	 6OqDBUD6Lqc2lRv3wURGu9n38fxI19fIay5deazx0ObxWF2RYA8FN9bv9JQ1XEVspZ
	 9EnWQgUY1J0LRFG1xYWfzu/pNsghHOLIH3XKNIjaYC7R3PEpAQVXbLroyuhcEQ2xzj
	 VfDNbyzVC5r1g==
Date: Wed, 18 Jun 2025 11:47:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Cc: <Jason@zx2c4.com>, <wireguard@lists.zx2c4.com>, <netdev@vger.kernel.org>
Subject: Re: Issue with rtnl_lock in wg_pm_notification
Message-ID: <20250618114735.5472f2cd@kernel.org>
In-Reply-To: <2c5257a7-e330-4983-8447-3e217b616b2e@quicinc.com>
References: <2c5257a7-e330-4983-8447-3e217b616b2e@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 01:44:56 +0530 Sharath Chandra Vurukala wrote:
> I do not understand fully what wireguard functionality is, but
> considering that rtnl_lock is a global one, it does not seem to be a
> good design to have notification callback acquire this lock.

I'm not very familiar with the PM locks, but isn't the PM notification
lock also a global one? Again, not an expert but having PM lock outside
the rtnl_lock would be more intuitive to me.

