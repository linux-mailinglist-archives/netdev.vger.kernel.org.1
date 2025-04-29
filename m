Return-Path: <netdev+bounces-186886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E1EAA3C1A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BFB188F861
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6B2BE0E7;
	Tue, 29 Apr 2025 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNDWABjU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1AE26F44C;
	Tue, 29 Apr 2025 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969285; cv=none; b=tQGab5D5hPL4WzaMTBWqeZAsWZyLaJvZ8EgT/1ta5rIvPxOPJEPEMc8hn9z7XbXi9xSvpZgHnxF1zln6FQrrkDo9NXLwH86P6tLdwJGrMp8izVo53JEBMkcF9bcsSQu8SC2Qw/3wOdCThdgKJjpE8ARnrCIb2F3BkjufLsLn6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969285; c=relaxed/simple;
	bh=fAlX+Lt5V+LaI4Cx7JCgzZ4OfSfzgUpstMeIReZB04I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOFetZDFt5o9TDR2JBkBXQ72zGaK0bgtazHiuLpbs0tD8k0wDqjPNF7E0Sz4i28vvr8/u9TMMsBGXG1Ec/djf/cF2wVkY42N/xamkYQdfgpH6bjCJqdQA+/3EXKG4PP2s8Rjqjr8DlqqlnIcWBeO3IDpjvCd3cDAtDHz+n5xeo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNDWABjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64247C4CEE3;
	Tue, 29 Apr 2025 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745969284;
	bh=fAlX+Lt5V+LaI4Cx7JCgzZ4OfSfzgUpstMeIReZB04I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HNDWABjUCuxF00cC9YWvNiQ8OU5jvdWg7bBD0p3gIf9J642Uy2Xim02rHkhS9VZ55
	 q+1jSQoOhuKJftYcrZKtOSRXeaEKhl6VF6o011qWYpTnu6fZqDL+fBNu55L08bPL6s
	 m49lLVHGUd7VCHkZ/e2AwphSTC6dhHGpCwxmo0Zvt1DN4kcNmG8k6S/3KCmdRP/2aR
	 PTOvyNbPaSr2Oo7IKUBGmF2iLhwoIBs3FWWuh+7wy5qx+nEzyooPzsq/aiT1Se0tYJ
	 bjNcm0koXh2cRD0BaZpsgReR2g4kDY9uKuTDrld0C+7ca3NphgWr436tLmK4bOqPh0
	 jSxjiNEpPgJoQ==
Date: Tue, 29 Apr 2025 16:28:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v5 06/10] ref_tracker: automatically register a file in
 debugfs for a ref_tracker_dir
Message-ID: <20250429162802.1cfc3965@kernel.org>
In-Reply-To: <20250428-reftrack-dbgfs-v5-6-1cbbdf2038bd@kernel.org>
References: <20250428-reftrack-dbgfs-v5-0-1cbbdf2038bd@kernel.org>
	<20250428-reftrack-dbgfs-v5-6-1cbbdf2038bd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 11:26:29 -0700 Jeff Layton wrote:
> +/**
> + * ref_tracker_dir_debugfs - create debugfs file for ref_tracker_dir
> + * @dir: ref_tracker_dir to be associated with debugfs file
> + * @fmt: format string for filename
> + * @...: arguments for the format string
> + *
> + * Call this function to create a debugfs file for your ref_tracker_dir that
> + * displays the current refcounts for the object. It will be automatically
> + * removed when the ref_tracker_dir exits. The filename must be unique. If
> + * the creation fails then the pr_warn will be emitted.
> + */
> +void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)

lib/ref_tracker.c:374: warning: Excess function parameter 'fmt' description in 'ref_tracker_dir_debugfs'
lib/ref_tracker.c:374: warning: Excess function parameter '...' description in 'ref_tracker_dir_debugfs'

