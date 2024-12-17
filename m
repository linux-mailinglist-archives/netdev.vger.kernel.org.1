Return-Path: <netdev+bounces-152466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578809F4068
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32FA188E607
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775ED54738;
	Tue, 17 Dec 2024 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbqoqfAI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3F43AB9
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401448; cv=none; b=JjuK3znWJ6IqJG9e8YPFdXm+f96WMEy0YPwQznpm/3Iv/R/Xf+/KTbXOHN9WM6lXNSmjvuMAPIjsxM6DtJEPfFAlc0TftD7dIaMBE/1EQP9t7avilieXG5+Qq8AI8qdRYP/oa8ak6Zs/akj1V/WtAXzyhjl5qcTRU0+X1EpJ+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401448; c=relaxed/simple;
	bh=4T5ROK0FMeg9QOqI9w8ox+G7YRoCBnLYWiKNP5sJ7TE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dg67cAv0bP2r3F9PNKsgQ4QbAZ3cFNxO/TE/9xiL5OLd5YX7HPUvcw55u9Nwl4TGc+VFw7LE6+2BQhCqoUrBfrEEdFQJ/E81MpVNIer1RTj9lqjqEMAFTObziedQyn2thE31DPDpi7qETJ0j/8dt6YM8zLeZjEiwTL0zcbhd1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbqoqfAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B44C4CED0;
	Tue, 17 Dec 2024 02:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734401448;
	bh=4T5ROK0FMeg9QOqI9w8ox+G7YRoCBnLYWiKNP5sJ7TE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZbqoqfAISbZkDk+wN/4XMDphSmAnL1l2HPwBpkGMKGuZTu06tWZ2Gumt9L3S+/YfK
	 cmOrBfZIJ36atpMd56Zs2/QyQSLdmaYxoGNqleuOM2VwiWlbvT0hcPQ1jnAbl0FEJC
	 1dEBUoahNaPEucMshCESnxnVtlGt1Fer+jEviNkbmui5nJZxnZcND7Uac0v+mvnzed
	 PDsJIgcAk7Ol0UEn7kdbP+57afBAkjBsOwkwwsgNuKtA9kA1OXHzmiur6TI8oW/7yr
	 GVgRMi1qazew2PFCydKQ9WlIfYO8H2ZaKq9lTmaYKZ+ZR4RpMa71H2tjDEs0NgAiFY
	 a14VZvY3471lg==
Date: Mon, 16 Dec 2024 18:10:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Khang Nguyen <khangng@os.amperecomputing.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1] netlink: specs: add phys-binding attr to
 rt_link spec
Message-ID: <20241216181047.33dd336c@kernel.org>
In-Reply-To: <20241213112551.33557-1-donald.hunter@gmail.com>
References: <20241213112551.33557-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 11:25:50 +0000 Donald Hunter wrote:
> Note that enum mctp_phys_binding is not currently uapi, but perhaps it
> should be?

FWIW I think the values are defined by a DMTF standard,
but we could list them. No strong preference.

