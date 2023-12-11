Return-Path: <netdev+bounces-56142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F780DF7D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C521C21488
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7345675D;
	Mon, 11 Dec 2023 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9wn2a/7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F256474;
	Mon, 11 Dec 2023 23:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ED1C433C8;
	Mon, 11 Dec 2023 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702337430;
	bh=UHEs2AqJSESH4k9T1jOhhUdl14jHJc+0zyYnOuWknr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M9wn2a/7Jv+gFkF348t+9B4VJ4g3EKPIo+t04vf9QYikPLkv3WsURy3x8O1pUYgJ4
	 +NOjoQ26aGtR/z70P7CWZiBPRzOX1wk8mrYSfPAvDP5GamAmMv8ASVwWOzwtkJPSYU
	 uv8Mhx1E2AfocSTwLgOd8yoPTYrzWv0PPGoVLgkdm/xNI+zJfW3bTjc4+NAB2P8xIp
	 pilQcwU1iROvxVTF4EtaVUuXnWS55c82k+HxblTuQ2ydDJAWik87oerbws7eSL5LN8
	 pWrj78OUY+CQ3IJ7STfd+axXj4ZeugSHNc2hFfd32sbrfZuBgttKSzoGosJ6dVCmpA
	 6U8MImyLiqozw==
Date: Mon, 11 Dec 2023 15:30:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 03/11] doc/netlink: Regenerate netlink .rst
 files if ynl-gen-rst changes
Message-ID: <20231211153029.4b861bff@kernel.org>
In-Reply-To: <20231211164039.83034-4-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211164039.83034-4-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 16:40:31 +0000 Donald Hunter wrote:
> Add ynl-gen-rst.py to the dependencies for the netlink .rst files in the
> doc Makefile so that the docs get regenerated if the ynl-gen-rst.py
> script is modified.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

