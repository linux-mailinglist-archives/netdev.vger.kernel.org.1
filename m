Return-Path: <netdev+bounces-226122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A966CB9C739
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5FA1B25D6D
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 23:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2180F28488A;
	Wed, 24 Sep 2025 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/SIQTGT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38A2557A;
	Wed, 24 Sep 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755579; cv=none; b=kFlVJGvB1heCtf57JpGJUxBkkEDL23Flb8L8nsWzP9QC3Y7ezI18raR2Py+xHZFtFFqxnH53dz8Vkq0MZwG3RC76yvx7YfCQUZtc/F/MX0kbWOaefhqq6r4oOZmM/ylUjQvOl8dgjppP8y0CyKIEM+nSjbtzW4AhJhC/TDUliIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755579; c=relaxed/simple;
	bh=bU2JaXJ0gag8ImpiVJ9FCE+dISTxRRljn4fr36rMYaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RH6K8vIFmwutHgRsoD7u0aAuZeoXwfu7WEos3ImDWYPevwCSIiobl3JwaRaxHHaOz4p140fKKeJmEG0l5S25R1514Z18tjiHi55JR7WKmpg4wP2QVUiadZ9DaxeVl/MkkKpRiFTVA84N2qPj/8qCE829ZNVE7e1s4zHwFNxpG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/SIQTGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1E7C4CEE7;
	Wed, 24 Sep 2025 23:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758755578;
	bh=bU2JaXJ0gag8ImpiVJ9FCE+dISTxRRljn4fr36rMYaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T/SIQTGTcF/maFQ9OjtOjf/gWEtjT/NQj9pFqtC/l2/HMsIMMyDKxSl1KuT4+9VuV
	 jZg0B+ZF5r+OJWHNKczotb8iwAPnRfrS7y6AlLIwS+hVIHKvtSRAp3Kvo1qDYpM5nt
	 2+5hfvFnkBHeeQvSzg7e/Mlqq2RYEnKfR025EafgZ6HFn+fgNFMvrDFsft4oK8eluC
	 n5b9ur6WSjXnfrV64Di5/7tVSaBPlZePvdjLOXFzvmCy0sqkORG3gYJXl91ipwUC2R
	 j40NTykQw9YcvJyPN+rM2CLdQIkcxHYfJM1qdsLlsH3HsF4VAWH2J1C3KSPiSGBwrl
	 KvKhYI6163BdA==
Date: Wed, 24 Sep 2025 16:12:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Yeounsu Moon" <yyyynoom@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Andrew Lunn" <andrew@lunn.ch>
Subject: Re: [PATCH net v3 1/2] net: dlink: fix whitespace around function
 call
Message-ID: <20250924161257.348fcd71@kernel.org>
In-Reply-To: <DD16FJFQ33HG.7IJCUH79LHN8@gmail.com>
References: <20250916183305.2808-1-yyyynoom@gmail.com>
	<20250916183305.2808-2-yyyynoom@gmail.com>
	<20250917160642.2d21b529@kernel.org>
	<DD16FJFQ33HG.7IJCUH79LHN8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 01:38:34 +0900 Yeounsu Moon wrote:
> You and Andrew seems to share a similar point of view, and both are
> quite reasonable. What do you think about this approach?

Send the fix first, wait for it to reach net-next.
Then send the cleanup.

