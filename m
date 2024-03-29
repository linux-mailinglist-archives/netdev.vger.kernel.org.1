Return-Path: <netdev+bounces-83343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930C4891FC5
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A351C2918E
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9BD147C81;
	Fri, 29 Mar 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfnj00Ts"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA5014535D
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711721630; cv=none; b=tOPDGs2pCE9odcFT9XkL6fJE2Qq3/Bvxj5RzDNy7oEE97/HLQ5S0MNv/0T4rLfLDhJ+X6ZnYQ6URW0tzeq2JAE+hLRBrli0JCYiH4cYukqfmrThyaw9TDH6ni+1iFpLHpmUCkGV3QIqmT5fkA5IMmR5UKV6z1jMaf/eAWpG4khY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711721630; c=relaxed/simple;
	bh=KqYInpFxaiH1gBxE4xDgYOE4C0BCJdOsdBC+9JiEXsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwDP6f3aIkhD7AyQj284bd+6LCbHqB0hQ48hDZCJxbtWgFipbh/OJ8mfStDKrPeZD0A6EfyBSGGzyjqrXQRxjLjhmUmPB5TfZuurORLklFAtlumIw2UTa2iTvVgtOp610X+nvqDn3yWQjv7rdgs/m7mVUpwAExiAG2tW2x8nALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfnj00Ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D084DC433B1;
	Fri, 29 Mar 2024 14:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711721630;
	bh=KqYInpFxaiH1gBxE4xDgYOE4C0BCJdOsdBC+9JiEXsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yfnj00TsV2y3DKjZb4W2wtsQroeVXV3YB2XIGZyl0LZbKdmuOM2SNOuthuwgckD0V
	 jUbZspLmMSuKN79p+bqUXvW+8xumjuDHOz3rcADN4u64EpSNACmKna+DxzL8KATJkX
	 hg99azjs0KvmpmJOpor+9gk6xWfPAVc1aq1MuVEeaEIaldBQnu3zcmZxy9e5TLpay2
	 csFPxmiZedrHLQ2GLPyULTqpgyRZuvYCJ/EfjH/ADtI+RxlyfWRqyHMzQYChE6EwY4
	 NIyaTbKoCHPXXIyYRAUtaI9XqWZOJK/2vhAAdyxZiPSofgOHNqddNlnvKqhZVnpOZa
	 XVYJsqFXEo71g==
Date: Fri, 29 Mar 2024 07:13:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv2 net-next 1/2] ynl: rename array-nest to indexed-array
Message-ID: <20240329071348.7d18ec1f@kernel.org>
In-Reply-To: <20240329065423.1736120-2-liuhangbin@gmail.com>
References: <20240329065423.1736120-1-liuhangbin@gmail.com>
	<20240329065423.1736120-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 14:54:22 +0800 Hangbin Liu wrote:
> Some implementations, like bonding, has nest array with same attr type.
> To support all kinds of entries under one nest array. As disscussed[1],
> let's rename array-nest to indexed-array, and assuming the value is
> a nest by passing the type via sub-type.
> 
> [1] https://lore.kernel.org/netdev/20240312100105.16a59086@kernel.org/

> diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
> index 70a77387f6c4..1ee1647d0ee8 100644
> --- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
> +++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
> @@ -46,10 +46,16 @@ For reference the ``multi-attr`` array may look like this::
>  
>  where ``ARRAY-ATTR`` is the array entry type.
>  
> -array-nest
> +indexed-array
>  ~~~~~~~~~~

Documentation/userspace-api/netlink/genetlink-legacy.rst:50: WARNING: Title underline too short.

indexed-array
~~~~~~~~~~
-- 
pw-bot: cr

