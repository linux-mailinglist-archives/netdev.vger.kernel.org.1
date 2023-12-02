Return-Path: <netdev+bounces-53184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1938019C3
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96D51F2102A
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDDC17EF;
	Sat,  2 Dec 2023 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIWtHHGK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4F15A3;
	Sat,  2 Dec 2023 02:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418B6C433C8;
	Sat,  2 Dec 2023 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701482430;
	bh=g4fLarvWt35knPqUTLJUQTT5kUKnq7ZBMmQCiHnQ7m4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EIWtHHGKdMBvEVeCOw/DX25xsLcNTbZLEooPtlLQ6MtO6tTeMO7c3TUjYNrgjmUmm
	 E3SIYxD9hxD8APnGA5k3mqoGg8X5DTjuzTrYIt9DtX1IqOjj4v+J004rT4bS9smt62
	 CrbOUdxCDwWHn2i7tLlR+ixLkTP3vzEa3zlNjLwz7jhiim2leZlrigOngTXkNbWDyj
	 gj+mp3uBxLo3vy9k8cHcrJ0OCZU2W2pIDHZKBhF/hmWBbt4VDen8bZVaWcYwY7Qs5x
	 uK/HQn5aKnsBGA+AhjEFXfDxwkQBLz1HFf4ODIeYUE2PMXSNwaT5odmjfpM7+HngPf
	 a4q1Mpt2xfd7Q==
Date: Fri, 1 Dec 2023 18:00:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 3/6] tools/net/ynl: Add 'sub-message'
 attribute decoding to ynl
Message-ID: <20231201180029.45acfc2c@kernel.org>
In-Reply-To: <20231130214959.27377-4-donald.hunter@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-4-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 21:49:55 +0000 Donald Hunter wrote:
> @@ -510,7 +561,7 @@ class SpecFamily(SpecElement):
>        """
>        for op in self.yaml['operations']['list']:
>          if name == op['name']:
> -          return op
> +            return op
>        return None
>  
>      def resolve(self):

Looks unrelated, plus the 'for' vs 'if' are still indented by 2.

