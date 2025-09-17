Return-Path: <netdev+bounces-224114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAA6B80EB2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D09E7AA4C6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC882FC03D;
	Wed, 17 Sep 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh29n+I8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC02FC01E
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125338; cv=none; b=ot03XR/7k8zurUOK67gjxXnS1+RuylVHCuYg+0GdXbSetPv9ZRq4yLX4/LhEnQVTaGGulIDyGh3DVF+g/k3Yo8KQGZaIS2eVqHnpPT9BxllmXOFAs3PrVojx5Zrl9tokdcCkoTteyegr1Nax+ESgtTAvRsJygb6MW+Uw4U3o97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125338; c=relaxed/simple;
	bh=9UDyF0g6k69+3/w3lCmA28GHF2D+/BSivUsnjrslRmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAAni7Yjwz+PPmiho+YA9OVvE+AbE+fNryUJDgKRP+v2/dh/ApUcidD1onRLMJ1kOJPcm/X/+r41M9A1a4MsPDo/+FkogzfUNwVRrIQe18V0se7AfK5BSnzBgEqRLqD+uiHK62pV2iF+Mozyy/sJk717xmI8L6hizOwAZdYFEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh29n+I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A401C4CEF7;
	Wed, 17 Sep 2025 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758125337;
	bh=9UDyF0g6k69+3/w3lCmA28GHF2D+/BSivUsnjrslRmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hh29n+I8PwsCfKcmzkD0XKzVienJM3LUw2Y6M8OxinQxnG8kNAvQjlR2aytUY3DGk
	 qi82Q/X8LNYDDCZSPtAKvc3CDin6FW/XOLqNN6MpKdV2OM0nJ5fXoACZNlT6uQZsor
	 ZmxPEwZgaNrx3jrIMLQuCzUchWA66ysT/2rKR4lbtencjjiWHz7bIkUWEdzNK2jWsu
	 ABOL69qNU+irEB/WrgPw2sQuWiOzMKKejBhGXWkmCMhgKXOdkgAJquoz+1PuAnRw1V
	 /rm+YPswKScR66CIpr8QLQ44bRlJBJUjXrzj/iYqfwFx5tvQQKXSoITpwu0QJW2uou
	 GMvBcKrH2luxg==
Date: Wed, 17 Sep 2025 17:08:54 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	lee@trager.us
Subject: Re: [PATCH net-next v3 8/9] eth: fbnic: report FW uptime in health
 diagnose
Message-ID: <20250917160854.GP394836@horms.kernel.org>
References: <20250916231420.1693955-1-kuba@kernel.org>
 <20250916231420.1693955-9-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916231420.1693955-9-kuba@kernel.org>

On Tue, Sep 16, 2025 at 04:14:19PM -0700, Jakub Kicinski wrote:
> FW crashes are detected based on uptime going back, expose the uptime
> via devlink health diagnose.
> 
>  $ devlink -j health diagnose pci/0000:01:00.0 reporter fw
>  {"last_heartbeat":{"fw_uptime":{"sec":201,"msec":76}}}
>  $ devlink -j health diagnose pci/0000:01:00.0 reporter fw
>  last_heartbeat:
>     fw_uptime:
>       sec: 201 msec: 76
> 
> Reviewed-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


