Return-Path: <netdev+bounces-42463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F567CECC1
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 02:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952671C20B2A
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 00:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661617E;
	Thu, 19 Oct 2023 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKdfe0Of"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D6361;
	Thu, 19 Oct 2023 00:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBB4C433C7;
	Thu, 19 Oct 2023 00:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697675268;
	bh=jHDQqSS8ZaH9Uy7TQHB6qJm6Cs7OcqGT8rO524V8Zow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eKdfe0Ofzge00ZDfDlnuCMUEScoQywz09l4jkmlclhCPRw0u00shfEbaLaa8zMx9E
	 lQ7iLz39Y53gPcWphz9okx9ykrt/I3WPsmXrRaNlfA+Ex5sFWXvUo3jIJNJKXtQO7r
	 bMe1uwejICnTXHwHyhN8fS19yvRR/Aac0wubmU4FeNI4nYTZGOz0P2OaWXUn2gsNyu
	 Rn7qpjcfpBwBXDOSzmO7g0UB4cm9obwYPAUcmeEP0Jb4pSRxhsgRyTRaLZpWwVTPdX
	 VMcQ9/07YBtVuFo26rtQdLIC0AHRV8cmvwKiJMmIH35Xu81SqGaTzjHdoMiLTZHyfG
	 8KgCl4U7k2gNw==
Date: Wed, 18 Oct 2023 17:27:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Alexander Potapenko <glider@google.com>, Eric
 Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Simon Horman
 <simon.horman@corigine.com>, netdev@vger.kernel.org,
 linux-btrfs@vger.kernel.org, dm-devel@redhat.com, ntfs3@lists.linux.dev,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] ip_tunnel: convert __be16 tunnel flags to
 bitmaps
Message-ID: <20231018172747.305c65bd@kernel.org>
In-Reply-To: <20231016165247.14212-12-aleksander.lobakin@intel.com>
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
	<20231016165247.14212-12-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 18:52:45 +0200 Alexander Lobakin wrote:
>  40 files changed, 715 insertions(+), 415 deletions(-)

This already has at least two conflicts with networking if I'm looking
right. Please let the pre-req's go in via Yury's tree and then send
this for net-next in the next release cycle.

