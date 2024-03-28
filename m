Return-Path: <netdev+bounces-82942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09A89046F
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBAB1F2543B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C6130AF5;
	Thu, 28 Mar 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg8OSPNL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048185C51
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641741; cv=none; b=X4DnrzPI9spJe04bjEEA5+/2hv8gUFsTHSrvL2CTFv/8II68PamJTsEF+irNKPxXBFyjCvxI6RSkWO60RELVnfnGfOPMIuOy1jL+rxdMBgh9JQrodE+hTEhdvRZh2un/Qbne2B5UxsAJKoqe6OwSNzIgZIbI/qnLsKUIVMh8xSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641741; c=relaxed/simple;
	bh=cFB7+60j1G8ByR1TMqXmy0CmTGoln42FGZD7jOF0uAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlvjIpiKaa0Nm+8h6tA765LQhpTS7kHnJ+q6Qhw8gG/bvTghn3ViN7d9+wIno3y+3CjdrLXFpYvNEXGP9k91gZhbjdCaPWVCttehNaKWRzR6txytU19/vnpXKFgNADZ65YDwFcZJWS0RdZxGQ6rVRyqAkDMpjQh7eEDq9r4AuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg8OSPNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B89C433F1;
	Thu, 28 Mar 2024 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711641741;
	bh=cFB7+60j1G8ByR1TMqXmy0CmTGoln42FGZD7jOF0uAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dg8OSPNLOdNN+HIMHLfGJL10U7gq536BMjLu7eXwx4Tk3/8eiHNB5hq1cWhBQN1qI
	 G+JFifL109xJCt/t7HicGzX3g1ZMVL15uHj9KLa6XzHpbJMQpOCf6koSlBVlskL6dG
	 UaZJ/sfkCJVquDYz+Cf+LrsxOOsZjqJ8zTjAf1Zqg/kNN0WH30xjp2TT/EsC9It5FF
	 9VmMpjdLyAIXB7D3DkP42QAPSnNtFg9pb4JlhQ0GuMv/kowL2uS9mwcCz0tfXzQG6w
	 BF3brsB+sgWjVpfSD2f1n9PeNOns3M5xhhrToTFjlJB40w5hmGF4vll21HmxeNh9Re
	 KmRhfshCFctww==
Date: Thu, 28 Mar 2024 09:02:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next 1/2] ynl: rename array-nest to indexed-array
Message-ID: <20240328090220.458c98c2@kernel.org>
In-Reply-To: <ZgUhS8_Yno2dAyie@Laptop-X1>
References: <20240326063728.2369353-1-liuhangbin@gmail.com>
	<20240326063728.2369353-2-liuhangbin@gmail.com>
	<20240326204610.1cb1715b@kernel.org>
	<ZgUhS8_Yno2dAyie@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 15:50:35 +0800 Hangbin Liu wrote:
> I agree we need raise exception when only support nest sub-type. But
> what about after adding other sub-types in patch 2/2. e.g.
> 
> 	if attr_spec["sub-type"] == 'nest':
> 		decoded = self._decode_array_nest(attr, attr_spec)
> 	else:
> 		decoded = self._decode_index_array(attr, attr_spec)
> 
> Should we remove the exception in patch 2?

Looking a bit closer you should probably have:

-            elif attr_spec["type"] == 'array-nest':
-                decoded = self._decode_array_nest(attr, attr_spec)
+            elif attr_spec["type"] == 'indexed-array':
+                decoded = self._decode_array_attr(attr, attr_spec)
             elif attr_spec["type"] == 'bitfield32':

and do the sub-type handling inside (now renamed) _decode_array_attr()
Throw the exception there appropriately.

