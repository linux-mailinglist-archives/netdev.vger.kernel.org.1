Return-Path: <netdev+bounces-65639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3154983B3EB
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF41E1F21022
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D71350FE;
	Wed, 24 Jan 2024 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3jms9n8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5012BE96;
	Wed, 24 Jan 2024 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131808; cv=none; b=ptM1enFccQJGiwW6j5ewYdsVrIdqsMSWn0GWmwjsARCwl/i1KUMpMrHSAeq1VQamU9hkWnGjTqtohid8VPOOSyoLZq3IyNzw9zP1yseSICkpU3fbuoDER2PDWq6/yvz7HNwnfUe8t2AZeouKQF5V+TLBgWVUf/8W3HtZLoP+F/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131808; c=relaxed/simple;
	bh=1ZwCh/u+J+L77BnFSFFWJSMxVLku6vhyCI+ViJDOP8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU45H0Eo4L6lE8xWNo+adLBc6ZeugGS5bU4Ibxs09gVjAT4N1oqVraCf3fdnc0u2GTbvtq1XpJ0e3NCHWKvF6p862oHewfo/zicCJQeVaphXt7E8+kG+spldJfpYdHPyg7FRWCrtzhhPIGj0PDPm3W5KTFQjeq2J2CWecTq2RHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3jms9n8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F950C433C7;
	Wed, 24 Jan 2024 21:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706131808;
	bh=1ZwCh/u+J+L77BnFSFFWJSMxVLku6vhyCI+ViJDOP8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3jms9n8rbmKkCEV/1APHIVLd4zeoJiOzZFGg5viDipfeyX7nNV8n+1WumP19Z1EF
	 zaEj2cS7lgTOFb8wqjJ+G6d147u5qdm/ze+OSNcsy6XpFvDg/vEnEQAHjTikO3QKU0
	 SWZWqP7x/3dxGzkt78msgz2hWoLdxP1Q2c2xNxQuSuBXO/0yTKgkoWQU6WPAL9Pkyi
	 1dzxV47fOu4QM1WhilfZsKKzloCMvpDUfPbTLwv4tpURDvnONoazhaRkKFHbRf3oe1
	 hEiMMeJjl5hkon3hk4qJKmBbfz2aFNQld2fRG4Hg0h7+ka9+b3HPZj4NMXHsf5cgOr
	 cAQyJluUsZXtQ==
Date: Wed, 24 Jan 2024 21:30:03 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, patches@lists.linux.dev,
	Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH resend] tipc: node: remove Excess struct member
 kernel-doc warnings
Message-ID: <20240124213003.GA349089@kernel.org>
References: <20240123051152.23684-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123051152.23684-1-rdunlap@infradead.org>

On Mon, Jan 22, 2024 at 09:11:52PM -0800, Randy Dunlap wrote:
> Remove 2 kernel-doc descriptions to squelch warnings:
> 
> node.c:150: warning: Excess struct member 'inputq' description in 'tipc_node'
> node.c:150: warning: Excess struct member 'namedq' description in 'tipc_node'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>


