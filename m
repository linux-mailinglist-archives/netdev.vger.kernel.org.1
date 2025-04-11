Return-Path: <netdev+bounces-181844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73105A8691F
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB0B17BC5E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CB129DB60;
	Fri, 11 Apr 2025 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6rl8irm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE1A224888
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413821; cv=none; b=uY+jJ0l0oVILTxFnxRFhvUJbeSG7hE9r1Lvm3j367R8CaS5+663iFOWFLstvWy78HNoqJqqEUJslO7NucPCr6tBufiFo40moFXWfYLtz0Kxco6W9a+CIp+/jMsejsKG/G8vVnunLRSs/mZeFmxsH8X5jD5ch8C60DhbsBu8LrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413821; c=relaxed/simple;
	bh=DCbRMoG7I3MQvImQ/UAP0S2t9FYAGD6KqSQG0c4oLWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMdC9UnxKnFW5VarGyz+9EqJ8WECfkiRf8XOBQGeTPVe4SreiDbraqDLxLz2zcjCgkH0wYHGqLKcTN/q8DzGblu+JAnDaV6uSAJupxiP75n+pXnncvKU44+8qAIm6y37Fti0av6OiBgxxwLEduupi0UQHyLXILPcoAojt3r2G+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6rl8irm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46321C4CEE2;
	Fri, 11 Apr 2025 23:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744413820;
	bh=DCbRMoG7I3MQvImQ/UAP0S2t9FYAGD6KqSQG0c4oLWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m6rl8irmrTupdYOLtsltfNyr/NHHBJwODCVUhEIxGCrckcslkFBHg46jYD0MDf1qo
	 JKyZL6MlJhG/0gq18TE2aHvB60LK+dOWvkeoFcicBQcqrIFERt1yIycrCfmQIMixJw
	 pr1Cp8fW82K8Jym/ScYWXAukY5TrG3lZXFPXE2cy5i1wmtyZ5Vgj8R4UJAecPbdaJM
	 rs2EHSFIH/RObkCLKIELAje1YI7jPLnUNMT1aQci1TKGVlMdMUNErfFZyp4sj1FQRR
	 cmDMlYa1NqV1u+E2TPmzXX7cWsTxqVcHzKpl8jWpjTFoqVY0acZVs/sQdchGvhakxY
	 MK1E/g4iw/eVg==
Date: Fri, 11 Apr 2025 16:23:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2] net: txgbe: Update module description
Message-ID: <20250411162339.452e78c6@kernel.org>
In-Reply-To: <20250411024205.332613-1-jiawenwu@trustnetic.com>
References: <20250411024205.332613-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 10:42:05 +0800 Jiawen Wu wrote:
> Because of the addition of support for 25G/40G devices, update the module
> description.
> 
> Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")

Post for net-next == it's not a fix == no Fixes tag should be present
-- 
pw-bot: cr

