Return-Path: <netdev+bounces-205992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18E1B0107C
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEB4545E8A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302FC200A3;
	Fri, 11 Jul 2025 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNdL6OGt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6EE182D0
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195444; cv=none; b=p2XGuBuSU3FeQwjiCQAQKr8ty57912f9ls+6eUm/A7U4OvyHhbxzL3gNwCs0vvmIOKhRC0FiMg/M6cT7+U2U2FNsMNnn6adg2KyTTbnw9IUHXqNhoLkzSuqNaz3tE7e1v7CbJ8haGW93CY/K/TadslJMvkB3J79FOzzY8VOspl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195444; c=relaxed/simple;
	bh=73Um8rt5b92zEh+6wyIHllIzRzTIqJmsmCOhTtI2aj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhNV1126g/dtzEJMiOjmJunJJvHOBZ16aDd1dTED4B6wtS0O+zzd9wjIuNNIh0NvgZY7Iv1ud/MjsC+k5kJ4YloxBpk9L0R7jALhbt1m1XvjjgxpMziTvo0fVQ1lcKEyM611YAn0WvvvgcbuWFD7yoa+y71qwyvlLcgts6EoZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNdL6OGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A18EC4CEE3;
	Fri, 11 Jul 2025 00:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752195443;
	bh=73Um8rt5b92zEh+6wyIHllIzRzTIqJmsmCOhTtI2aj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FNdL6OGtwhhZaU4nHDQYlpwCSykJ0UtozM4EQGjSLrKu4fB2CzUfhizWk1hQ470fW
	 T5f2u47hx+7DctOZgYGyIDvVQQS9i6yUv7t18f6x60WK6STRvWXGpAm8HL5R8HE8Th
	 LFLzppzc6SbqN66C9tsXo2hLvOaMZ3vWURLMEKfgBomxMgMI4FciyntlBCw/xJ1lE3
	 j78DN5vIexBv4RIKyBJoWF7pFNvuOh8dS+0CG5PoCe+jhNvo0dd5EITKX/8/wt5jf3
	 W++j0PTyQTsGRpbIT4+7YgqiGLQUruV1cTc7QYJLpFkUQHtCcXNhPga3RMDAbkXcoz
	 N+xrsz35lgZuA==
Date: Thu, 10 Jul 2025 17:57:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 0/8] net: maintain netif vs dev prefix
 semantics
Message-ID: <20250710175722.3ae03953@kernel.org>
In-Reply-To: <20250708213829.875226-1-sdf@fomichev.me>
References: <20250708213829.875226-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 14:38:21 -0700 Stanislav Fomichev wrote:
> Commit cc34acd577f1 ("docs: net: document new locking reality")
> introduced netif_ vs dev_ function semantics: the former expects locked
> netdev, the latter takes care of the locking. We don't strictly
> follow this semantics on either side, but there are more dev_xxx handlers
> now that don't fit. Rename them to netif_xxx where appropriate. We care only
> about driver-visible APIs, don't touch stack-internal routines.

LGTM, thanks for cleaning this up.
I'm not gonna send review tags, cause I'd have to strip them if I end
up applying these..

