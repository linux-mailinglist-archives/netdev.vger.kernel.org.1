Return-Path: <netdev+bounces-224182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03FAB81D83
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFCE1C23ED5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480B629B8FE;
	Wed, 17 Sep 2025 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7UGXXJy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F71B3923
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142650; cv=none; b=Ymcu/DnItI2yxZTS08fTKw5dBdJpBVnTKuj5fs4AUnxSajCSLQoLbbr7dueGcJjm5m4vDIq0oCxS5HUnnQ63Zr0lO/LkLDQyngshV3tok7AxP/ZqnZPJ4VrAAy5JMB/8fQ4XI/zYcrl4YPQL15XZgjXVi3k+8kCYcRDMJOigq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142650; c=relaxed/simple;
	bh=Y8AptMqRkTUXzDRSEreOdpzqVFVDHOStu1dTdOrC1aM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPwXEtxLmLemrBn4cZOcTHkwdqKFTyYW0AVR57Fcmhbw35Yw4LB8c529M8cAEC6kKyABAglqQUFUXK/ZpeioSGVnMbMQQuriafwvRVzaGY8oXMxiwWaZgHwQN6h29pbOJXecMAEAJxLO3ltXTaTdYpnDu78j1qtDhzL+dJh5bcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7UGXXJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3193DC4CEE7;
	Wed, 17 Sep 2025 20:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758142649;
	bh=Y8AptMqRkTUXzDRSEreOdpzqVFVDHOStu1dTdOrC1aM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o7UGXXJySJQCRk84qJBAVJz+aiE3FJCJo1SzmD/uxjKY2l2raJ//SQz5fH4zdWCG3
	 UQlNsb73iqXgVyYGMtrGgkgQJrgaw7V7Iwd9BqxKujd7VdmJik8m85VUNt8c7gmV6R
	 dmHJ652SqxEtJa8B++iXpxcUvtHM5eqXAHXBD5r7DWTABp8Mf3gDGoLsBZyXwFEA7g
	 TemdvxeoNVVNAxoDnVT8YI3711VsyCsOkyr+3bX1YoQ0glJmoDQ7rZL5+I+gx6g3NO
	 gtIJZv23Gt+tCK/KLy1BhOrQ3Vx99MeuFvzKvG/BiAWZSDd877xAKhI60RW4v1WJIv
	 E1Xb4EcUTxzpg==
Date: Wed, 17 Sep 2025 13:57:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Sterba <dsterba@suse.cz>, kirjanov@gmail.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dkirjanov@suse.de
Subject: Re: [PATCH net 1/2] Revert "eth: remove the DLink/Sundance (ST201)
 driver"
Message-ID: <20250917135728.26172d1b@kernel.org>
In-Reply-To: <20250917173548.GG5333@suse.cz>
References: <20250901210818.1025316-1-kuba@kernel.org>
	<20250917173548.GG5333@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 19:35:48 +0200 David Sterba wrote:
> > +SUNDANCE NETWORK DRIVER
> > +M:	Denis Kirjanov <dkirjanov@suse.de>  
> 
> FWIW this email address does not exist anymore, you may want to replace
> it with kirjanov@gmail.com (found in archives and added to CC).

Denis, could you send a patch?

