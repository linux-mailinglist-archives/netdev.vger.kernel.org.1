Return-Path: <netdev+bounces-242494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1DC90B33
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 04:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2AFC4E062C
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EE427E7F0;
	Fri, 28 Nov 2025 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi1b5NB+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD8199252;
	Fri, 28 Nov 2025 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764299337; cv=none; b=MGCDav7rDaMBR42C+PMEJC1oUZexWEjQvrvrWSYTKcIu6Q0hOv0wXd92MyVcsJBbZxpGkZHx9cHgN5LAmWF15XTwrg91s1XQP0SKf+NL77pzi/tQym1Yu8n6aNfElLL8fmbhm8MSqUCutdbTDCuhYZguXvBpkUvjk4fp56as4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764299337; c=relaxed/simple;
	bh=tW9Y/FfY5NtJPp61Anf/+/y5X5M3jkvLwLMgTwPtd6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDh+6siu9Z+yKJziGg/jgdu8jLFFZz4aa8eH4x32ImKo+xWmGcefn8EURpsdqhh8g/WtNLuxlNyYLhAirwk7xI44BU1c8Ui6F9LdsXUl+fWi/RCh1iC6hVWPFJ9p+9svM/LyrvZ2k/uhr2UiUSvgHij6vubTh/Zsn0QR7imJJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi1b5NB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557C7C4CEF8;
	Fri, 28 Nov 2025 03:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764299337;
	bh=tW9Y/FfY5NtJPp61Anf/+/y5X5M3jkvLwLMgTwPtd6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oi1b5NB+XF7Uq1vJmv8zicUeTPxt1px5U1L2s3n2aRPhdGSDP4SpJ5aE8ivEe5nSD
	 te4IKqxXu8kxAqOppv8w6zLE3o8kXY3R94UOx05/B0gerZNWy2IIyZjZeBdmZn9WhD
	 WDYDMNlsNQh9KN2L4LuS8ralaJUlD/CaA/bFbwnOlO6buL4pSMLN7E+jwgxwHfDOje
	 GKZVEScRz4Y1RW9tS3W/IEIRGQepLxGdEX0TDCFDb7WCgly9HePN0J9kfgxj8+LR3A
	 YzyKrNl8fImEYnfKpdHqDdZVNOhrIM2riMdZqg38kTZcwX3BA3lZQ6ApgNaoRLK8h4
	 NgQhdgGkjkHjw==
Date: Thu, 27 Nov 2025 19:08:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [v3, net-next 01/12] bng_en: Query PHY and report link status
Message-ID: <20251127190855.69779791@kernel.org>
In-Reply-To: <20251126194931.455830-2-bhargava.marreddy@broadcom.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
	<20251126194931.455830-2-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 01:19:20 +0530 Bhargava Marreddy wrote:
> +	struct mutex		link_lock;

missing mutex_init() for this lock?
-- 
pw-bot: cr

