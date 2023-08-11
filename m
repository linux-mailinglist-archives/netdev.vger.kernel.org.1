Return-Path: <netdev+bounces-26961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25D7779AB5
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD92A1C20B77
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABDC34CCA;
	Fri, 11 Aug 2023 22:26:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA18833
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 22:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490CAC433C8;
	Fri, 11 Aug 2023 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691792795;
	bh=uoDHaxNPOW0Fa1jjS9dAgVpjupxR10NJvSv1QRGTocU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fk6lC2QIuJGe+JLCJzmT1erXDMWJtg/dMlaxrr7m5Kcn/v+gsjW+yK1z1pMEX16mM
	 Qk/SMhsGc470EtoqejSb80Z98S8XfDHmwXQ3+o7wNwOh8ZvLH/ENKB5572C3zann+a
	 6tEdIaxcJ2H/IjO+ugH95mU3d03opsavD9MQwN7burGIXIDdBDk11J9UBXVsO6J+K5
	 uI66J9UqGEC8s3nbVoXaNsCOZig2DCq6lcZpN85ceDBHvKTRQOLIMPfGGzgcFNlQAd
	 0uqaTnQS42e6X9+wSv7S/4zlwdLf63lF4UxeO5sDC7ueSWyfamlckm9YXZnz62dZpI
	 U4YGanMdxW6cQ==
Date: Fri, 11 Aug 2023 15:26:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, rdunlap@infradead.org, void@manifault.com,
 jani.nikula@intel.com, horms@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] docs: net: add netlink attrs best practices
Message-ID: <20230811152634.271608c5@kernel.org>
In-Reply-To: <20230811031549.2011622-1-linma@zju.edu.cn>
References: <20230811031549.2011622-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 11:15:49 +0800 Lin Ma wrote:
> Provide some suggestions that who deal with Netlink code could follow
> (of course using the word "best-practices" may sound somewhat
> exaggerate).

I truly appreciate the effort, but I'm worried this will only confuse
developers. This document does not reflect the reality of writing new
netlink families at all. It's more of a historic perspective.

