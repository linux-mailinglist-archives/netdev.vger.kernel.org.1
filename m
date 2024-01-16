Return-Path: <netdev+bounces-63747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75382F258
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 17:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C731F22461
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA591C6A3;
	Tue, 16 Jan 2024 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlqUdssO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C51C290;
	Tue, 16 Jan 2024 16:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E58FC433C7;
	Tue, 16 Jan 2024 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705422238;
	bh=EcdnWKz4VyFqWAHSR9mnOwkDjWab90sdecpYlpsvTy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UlqUdssOpy6aP5+1nc1yArvtsb3jBfIgPe1esSGRGct10/BL3b8Goa4RO705AH1rW
	 FibVJsc+Lww0whtANW9pwa8ZPV7Uj/g+1P+Uk11MC+OgxOJbPmEU/k3/055P+21HAi
	 X62Z0a4zZTRe0FQ0yeqlD57ch+wS3nFprMoFd8fkZuoDs05XxGxO5Zm180XZ7yfyqx
	 6hrKZnzwzEUheeP6i+zUSAxZFq5/jW/FLj25tbl85Fxy1U3qHQ45RW0Bs5LpZzlmOT
	 5jBxvutIPWh4QaC9ICFFv9UJqNsCd0RBytFCHd3/Qji9ozVdRTRgqeH2hB2lR+cfto
	 nW/RbkWPdUr8Q==
Date: Tue, 16 Jan 2024 08:23:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Lamprecht <t.lamprecht@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: vxlan: how to expose opt-in RFC conformity with unprocessed
 header flags
Message-ID: <20240116082357.22daf549@kernel.org>
In-Reply-To: <db8b9e19-ad75-44d3-bfb2-46590d426ff5@proxmox.com>
References: <db8b9e19-ad75-44d3-bfb2-46590d426ff5@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 16:13:22 +0100 Thomas Lamprecht wrote:
> What would be the accepted way to add a switch of making this RFC conform in
> an opt-in way? A module parameter? A sysfs entry? Through netlink?

Thru netlink. My intuition would be to try to add a "ignore
bits" mask, rather than "RFC compliance knob" because RFCs
may have shorter lifespan than kernel's uAPI guarantees..

