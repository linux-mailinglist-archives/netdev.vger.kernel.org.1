Return-Path: <netdev+bounces-209369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B91B0F677
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C882189BFDC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF982FE315;
	Wed, 23 Jul 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUH0ZBxf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09282FEE0B;
	Wed, 23 Jul 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282489; cv=none; b=eW0x8Q1lZX4L61HDtzohvfQX/PFo+cZj9K33ubUpQRlO2lnxpmoef85meSG2Kna1IcI5R+gMYI9DHGDkKQa497s3oLK1dFm27B2P1UidV7KEEvTgOINY0OrNwy1Nqu8RMsoNmIpRy5fkR1xoqmbHItwyp1Tt4rdvtpwwop9TGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282489; c=relaxed/simple;
	bh=wg95t8hBDt/FDMW2+0cxFLlTUvurj/1FbB2YpA2HE8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUCtsLzUbUzQ8exqUrZpG1NkpvMgANGYJGqJpEGrfSdyIzwgepAj6sY0ZTTmH2xREOOruXtLF5Hsrpxn6zUjiG//ycig/pOyl1LLCgVKA3QG8DaIBLaWtcHMjs9yStLHts4RKyYY7Wr1GFlmoe25MUi9lNsd1r5H0r55Gey3R9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUH0ZBxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F58C4CEFF;
	Wed, 23 Jul 2025 14:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282485;
	bh=wg95t8hBDt/FDMW2+0cxFLlTUvurj/1FbB2YpA2HE8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUH0ZBxfq1OpItC+5DMY/XBZo11tqnHPmoUJqzjXRt2bKWb3qNaDI5vJttiFKcxNM
	 pJfqhMKHNqAs0rPyKNGbCkYQxBDlyrp4L5VOFZ6LEnSaS+JUSMtjBShiYQbZZsSkce
	 jXS+fT7kt7NwZ01gF4riO5Ko29uc6IWtwG0XQR2XTfjiE1BrGE1kRNTgig8hT6nEHg
	 wdtIVICZgQguIQFpebCkUDJfl0XV86vY068W1fnyuthQDoxFA/ucLOY1kCNMGXmtFC
	 3dWqqIbD5ebADA2dyTfZ5xo01y5dy5NXQcFkKfxlUmFTwbz8CPZ4xC2NDvLAQP8j2m
	 zMbbwDInOjyfA==
Date: Wed, 23 Jul 2025 15:54:41 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 1/5] netpoll: Remove unused fields from
 inet_addr union
Message-ID: <20250723145441.GD1036606@horms.kernel.org>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
 <20250721-netconsole_ref-v2-1-b42f1833565a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-netconsole_ref-v2-1-b42f1833565a@debian.org>

On Mon, Jul 21, 2025 at 06:02:01AM -0700, Breno Leitao wrote:
> Clean up the inet_addr union by removing unused fields that are
> redundant with existing members:
> 
> This simplifies the union structure while maintaining all necessary
> functionality for both IPv4 and IPv6 address handling.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


