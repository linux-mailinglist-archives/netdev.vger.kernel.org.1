Return-Path: <netdev+bounces-202939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE37AEFC2D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9B74A1AA5
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0782027703E;
	Tue,  1 Jul 2025 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXP8RvBM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02EC2749E7;
	Tue,  1 Jul 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379448; cv=none; b=KftVN4oUL091aU17wxuBwLJx9IoQ53RJ/Kfmvc3yRSVRmKkn0rMMx8l1gaHCmssH459z5I75sSsNpvl+dMtvfpq4zzNjEqDXGq0R4hB3XdWyjPL72mSeMzSG7pFfIsD4DBEXlcDmz0vbrO1aYodPs3RwX74ETiutGPTdmWiw074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379448; c=relaxed/simple;
	bh=BttQAyY0m+6Nv7XnK/wTCKqgjQoLM5UX6l1sTpWOt1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5Bs3N1By21BvivG0N+QlX71y2Hm1MtN23BhSM51BJrHfFtH6Hd1KkditYaP6EnPf3sqAUABFV6kfhWbq74oIAG/22K5iRrNP5corNrECJZ6m9ak/GjopasEAOavf5pNo9wJqP3ba8oR6JbtyNretontuce1WADTU7I0nJIqezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXP8RvBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1EBC4CEED;
	Tue,  1 Jul 2025 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751379448;
	bh=BttQAyY0m+6Nv7XnK/wTCKqgjQoLM5UX6l1sTpWOt1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uXP8RvBM1eDkYlyyDayEvFmUsyLuo/9VhGNbGMtWmDP9CHMSrAmG9305055rJ8Yiq
	 4i+IWl/hmavaAb153/GZiFn1VTeo33CrmRUScF31rgCnOiDtqd20OZ6b1gB/JxiY0x
	 n0xOi8PbRscpyDiPqRGvJpBcNkyi71nShzOsec8TpRvNEF3oNLDx64e4JppdKHM9Wv
	 cJUCIWn9lvHvvBZhsjcoPBo4wMpigQ6ZMQbDu1frVGZAnsdY3r8AwQzuBkvmFsi6Hh
	 1PkMVYEmWyTesFoehexT9KraPszJZNVIkQ2CXV9NyqVc7EioZxiZoMhCuwEpEqmyAw
	 FRaS9rHXB2kpg==
Date: Tue, 1 Jul 2025 15:17:24 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: Re: [PATCH net-next 5/5] net: ip-sysctl: Add link to SCTP IPv4
 scoping draft
Message-ID: <20250701141724.GX41770@horms.kernel.org>
References: <20250701031300.19088-1-bagasdotme@gmail.com>
 <20250701031300.19088-6-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701031300.19088-6-bagasdotme@gmail.com>

On Tue, Jul 01, 2025 at 10:13:00AM +0700, Bagas Sanjaya wrote:
> addr_scope_policy description contains pointer to SCTP IPv4 scoping
> draft but not its IETF Datatracker link. Add it.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


