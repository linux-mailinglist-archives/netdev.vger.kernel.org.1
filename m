Return-Path: <netdev+bounces-217382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DA9B38810
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26891893ED7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367072C3278;
	Wed, 27 Aug 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QceY4Oaz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121632C3242
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313681; cv=none; b=GtXEIZ6QIy/X1ZQjXADWYkhCIGMSPD6IOPfsjHiL9au+bHIxWA0TOJ4LuvzoQ+9PCRNGRlej20ASyf3DFwCHJCw5AO4aQxKYaEgkedJI1GSUpUztJjX2zdAtoA/J0Ta4LTMIRlOtyNuVYMUzSs2e8iaqF2KWU/z34zslds5DDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313681; c=relaxed/simple;
	bh=rXlMAjFdIq2DJMwnZLvnLhSwnH5z6NctSYnJ/75y7tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpZkioDBJJRIKxL6Kg5ZENmnXjIyEp2CBVzVNahza5jlcWqDga9c5TgAPSncx4Sipsu+MhXq7nfXD2/VHNG3lt5Yrh+khVOr5UbR9A4RZm9fwUcTooSV7b+IpbsHf4gShR2V4yKGXIgCQq8s0BxTUJLhn0BBi8zX5Lww1+E6Yvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QceY4Oaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88211C4CEEB;
	Wed, 27 Aug 2025 16:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313680;
	bh=rXlMAjFdIq2DJMwnZLvnLhSwnH5z6NctSYnJ/75y7tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QceY4OazOgjqsGAiSmDqzRqh04xrHLIvrAtgPMhoZut5urwTzgsjG0Y2rEJ9Eb5U7
	 GCwhK/nISSQczozHT8XWDq0Y7qRZuiCgPUpC6xCiL+bzMvm79E/+qmx8U/i8rMsRr2
	 zmAQ3Sdv9fxySc+RlKOIQGRwOnDsywPAprU5PNxz6t7HA8oQ5SzfI9SWhDPkYqlr3d
	 6jQGLS8DC8v9cubr8jPSINlgo1pwDRfMHiq1jXxzGd5pdYZTFtLasERJqHewotZLHU
	 JRoZL5uvQPlc1ZW5qmO5gpMTU89sr20aA+Jhtjl3wW61bd0ExVTsne8seGkAFAa7zO
	 yWbVYDEB4nRRw==
Date: Wed, 27 Aug 2025 17:54:36 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 05/13] macsec: use NLA_POLICY_MAX_LEN for
 MACSEC_SA_ATTR_KEY
Message-ID: <20250827165436.GG10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <192227ca0047b643d6530ece0a3679998b010fac.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <192227ca0047b643d6530ece0a3679998b010fac.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:23PM +0200, Sabrina Dubroca wrote:
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


