Return-Path: <netdev+bounces-77326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0660871455
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 04:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE301C203F3
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 03:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1096E376E6;
	Tue,  5 Mar 2024 03:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILLd+Vie"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF512F44
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609729; cv=none; b=AozyYbrzXnSyNqqvjpE7QD655BqwooEJs9msT+IWQ/VmANZWcdrdHhSN/LacAE0Z+8UjhK3h6jWyVAfhuRgfy3sfLXcnXW+93HaKn+7uAzEx8kvTD7LNVAXBW+EbwWl9IE228q1xGPEGiewwBxBTbWABmNUIbinb3berxvj1OqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609729; c=relaxed/simple;
	bh=zZHekIqHtxy9dF3Cfkpb6Ll2S+QrL7GBUTKgt/C6P8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaCl55xySgnKRwmX7S/ONXk3nGva+bA8nNe9TMgClwowehjuZjy1FUMD0DpkuFRgWa+dAz7ewGPTCBJ57EjcH5xdk8obYbQs919jTF81CBkliZFADb15hOzBQpQHUd4HgNZ30xRYw6m5Ty6sbRcbBnzikfvmZJcDrgyt+1eF5n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILLd+Vie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2584C433F1;
	Tue,  5 Mar 2024 03:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709609728;
	bh=zZHekIqHtxy9dF3Cfkpb6Ll2S+QrL7GBUTKgt/C6P8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ILLd+Vie75LndCUKeIG3+B3tLSOVQszlcYxsYR5/nsOX0k4iyDyoeEQcugZRfkwe9
	 5aCzAqtiV/6GZVUr2q8pJ+mZbMdzRmSwYAeMjvP3gVDMtz550cy6XI1vmKR35d4lOO
	 1SXSgiiMX1V55TlJHTEJJ3benVUC0ftP6JC8AzSB3r/Z1R2xqFHWMubpUg8zpFFP/f
	 +mr08iVYx3B0x6pU8B9Ql7q2YL4zvu5ZaYz8c0/DLtZX4yj4F5JOSsJ6SNelOqNTCc
	 VWDv9OEpaWjvXzFBUPFxafAUXhyvUqoa7lROaeDUGufA+gsEeA5rB5RCh5fs7eFjL+
	 Vhll/AFIqNErg==
Date: Mon, 4 Mar 2024 19:35:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jiri@resnulli.us, horms@kernel.org, przemyslaw.kitszel@intel.com,
 andrew@lunn.ch, victor.raj@intel.com, michal.wilczynski@intel.com,
 lukasz.czapnik@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 5/5] ice: Document
 tx_scheduling_layers parameter
Message-ID: <20240304193526.788ff854@kernel.org>
In-Reply-To: <20240228142054.474626-6-mateusz.polchlopek@intel.com>
References: <20240228142054.474626-1-mateusz.polchlopek@intel.com>
	<20240228142054.474626-6-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 09:20:54 -0500 Mateusz Polchlopek wrote:
> From: Michal Wilczynski <michal.wilczynski@intel.com>
> 
> New driver specific parameter 'tx_scheduling_layers' was introduced.
> Describe parameter in the documentation.
> 
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>

