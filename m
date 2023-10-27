Return-Path: <netdev+bounces-44812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C46C7D9EFB
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD82E1C20F5B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFA23AC25;
	Fri, 27 Oct 2023 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ips5XnKi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D41946F
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55411C433C8;
	Fri, 27 Oct 2023 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698428470;
	bh=+Dw/R9rxeB34Ys1RgDRJPOsBdBTjXEHYnmLpZHr0qFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ips5XnKid8mLLgmTNkAwhj35i7/oH6gg5CKZbWdzoM4CQVsiH3sRV5ASY02T05hG2
	 YiLiBygmHRXmsD7Y09eVBzkdRJMYP9+/qdjDZ7e732ooyzuDjWenSz3I/YjefSEm64
	 4uymylzt+GikYXH2fNXw7nobV97YVHtfWEfMAahiHUtYciBEn04LTD5th7EWCAi7de
	 lZszTL8QntLpDJk9lnjycJUaPd9MABbTpzUJNrg+gdtWtkUWTsFrEo66SZAx7DfguB
	 G6J2MOnPQpJf+fBq3oI8J3luFogh+V8xxAwPMtq4PTBSbjEEt4ta58tKAwwTAbsB/d
	 wZWYudGye4pFA==
Date: Fri, 27 Oct 2023 10:41:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/9] Intel Wired LAN Driver Updates for
 2023-10-23 (iavf)
Message-ID: <20231027104109.4f536f51@kernel.org>
In-Reply-To: <fbd68251-9fa1-4668-a551-b4aaebeb0340@intel.com>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
	<fbd68251-9fa1-4668-a551-b4aaebeb0340@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 09:58:38 -0700 Jacob Keller wrote:
> Since we pulled the fix out into net, I assume I should resend a rebased
> v2 of this series?

Yes, please

