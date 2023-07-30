Return-Path: <netdev+bounces-22648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 202D27686BB
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 19:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF866281698
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04823134C8;
	Sun, 30 Jul 2023 17:27:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A861A3D78
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 17:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA480C433C7;
	Sun, 30 Jul 2023 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690738054;
	bh=pSLYxgMjwsGIgcCwKb7HOuT3xdHzNFwyOhdX3x7XHrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmb6tDcQrmRFhG2MRo3nSOVrKjYAy0oUromdbic6c3fB95B9NxNxgQrGQ+bowdvlp
	 wbPVBtojvNmMTTxyckdNsM16gHjkqoaA8Poqn1tsKvPC0PB/N137NguOJWmwwt8AW/
	 x+HDVMje5A9mf5tXxc+P0GfaCSiM/SFw3+ouGseao0qNtDjnYMfFOWdizNQ1miYT+Z
	 ANm7h8d6whgmOavC080lhiBVojelsK0ApUdDJx1CU/N5+gEKBxv/ETT5ZD7FBiTGG4
	 QfCVyGycae+EzVJMll/IuuhRdvIznbxMzYKAXiKIqpXyYv08b/XoceShfhxf/DSVdJ
	 fRKoFsf7JkRIg==
Date: Sun, 30 Jul 2023 19:27:29 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
	sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] vsock: Remove unused function declarations
Message-ID: <ZMadgRSXLJXbrbu5@kernel.org>
References: <20230729122036.32988-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729122036.32988-1-yuehaibing@huawei.com>

On Sat, Jul 29, 2023 at 08:20:36PM +0800, Yue Haibing wrote:
> These are never implemented since introduction in
> commit d021c344051a ("VSOCK: Introduce VM Sockets")
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


