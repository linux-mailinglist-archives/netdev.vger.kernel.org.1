Return-Path: <netdev+bounces-243118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DFEC99ADE
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 01:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029AE3A22AC
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 00:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320319A2A3;
	Tue,  2 Dec 2025 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khgpbfO1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD7817DFE7
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 00:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764636819; cv=none; b=kidrfSc3k+pfWWrqQZo2W7JkEdLdm06sZA8GlySLx9/R0T/M3lMnJKu7BRXxuaMHMrGVYrGF+5uTn243GxoMsmR3vP1lCeu8xwTzYEuSYf1IUD6l6YpPkt5L10TxLoeG2xQNl9AIuiKf8TBu9otP6/GK89fUlQTmmNNDZL7rk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764636819; c=relaxed/simple;
	bh=zIrCqiOxp+GNYPXoSgtf9LRSllxeva23FOnOckQGaN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPW95IT7nhmiwjn9OKg74tSrHIVnKOWFyM35EUsae3f0nRbSQGcV+ewJG7GRAZ+VCQZFOiOIS2+kP/Zppmo/4RaPIaG3R/FIYjAkCxoj0UvjcMrtx4foVlhkZLEq/LzWoonl9IhIws13v/n6jDMmc0ODh0G2/fPD15AgnvjWmzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khgpbfO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44EDC4CEF1;
	Tue,  2 Dec 2025 00:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764636818;
	bh=zIrCqiOxp+GNYPXoSgtf9LRSllxeva23FOnOckQGaN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=khgpbfO1uGAdERAlF+VricqGng8eHsVZKmQohwV4oDefmPZ/MC2vNgF74bcZgGbTA
	 WKLne5V13LsYSBgqG7EgA6X1iFaUezZQDN226REj5p9y4dBExYYi0vYqkmRrpysCzN
	 RBCiMjvRkmOTuu/az6kpQZVer4M8Vx9oB6SjScL3A0o0lQTLTv/IDSZYN279EHlMnn
	 wFkrz2ysfU84bD7XCaQgbSRBZSVa6I57YST5BEW3j1+YY2WrNLAE8ApMXvm/zPvgFz
	 /UysMW7TRLNXB8X4YCjRqvuH8Zrq0aLMWf/7Us5HJ1n3gywEERp3fT7dfkMlPa5vpI
	 pYnI8IsvEgfMg==
Date: Mon, 1 Dec 2025 16:53:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 14/15] Documentation: net: dsa: mention
 availability of RedBox
Message-ID: <20251201165337.538d88d1@kernel.org>
In-Reply-To: <20251130131657.65080-15-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
	<20251130131657.65080-15-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Nov 2025 15:16:56 +0200 Vladimir Oltean wrote:
> -A driver which is able of offloading certain functions of a DANP or DANH should
> -declare the corresponding netdev features as indicated by the documentation at
> +A driver which is able of offloading certain functions of should declare the
                                                            ^
AI code review points out there's an object missing between "of" and
"should". I removed the "of" when applying, given the context it should
be somewhat obvious we're talking about functions of the ``hsr`` driver.
But please follow up if you prefer to add an explicit object to that
clause.

> +corresponding netdev features as indicated by the documentation at
>  ``Documentation/networking/netdev-features.rst``. Additionally, the following
>  methods must be implemented:

