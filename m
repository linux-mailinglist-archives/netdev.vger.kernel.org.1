Return-Path: <netdev+bounces-21664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E8A764297
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 01:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D4D281E82
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C4A952;
	Wed, 26 Jul 2023 23:33:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570DBA93A
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87722C433C7;
	Wed, 26 Jul 2023 23:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690414398;
	bh=e1U82WhWdvKsAPCG6KUWjoeQie5eyuVRhL9c9uDS0+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aegaGsntjuyp8Jf4oAtFolVtURjqy9E2h0RtoCp8VsAmGb2/xBVm1sfMP5lp4wFnL
	 kiEaoRWJr6b2eHW0yq/NVK99+Nu+CNoWvFp6rWqEskVYbIPga8Z6V0/GtMvjmXrq5h
	 uNwqZRS8SSWkX9ZBLTEEBkPbH+17F93vr9+Hnu5VtUwq3S6X12OttNES8HFN/l1zU/
	 /pws3VQk+Endcmt1QBxenbFP2wC0QO7fWjlVXmVkMtvFSt/9G44pCHa1wgdGwL8PIg
	 zvdmpy89LZJWxKJN2d4NQGX/LBnSvjdjCvMrO6wmHJCdSCXLgMHrX1w52g7ET7sf3t
	 tvrQ0GfDkzSpw==
Date: Wed, 26 Jul 2023 16:33:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 2/4] ynl: mark max/mask as private for kdoc
Message-ID: <20230726163317.6f120200@kernel.org>
In-Reply-To: <20230725233517.2614868-3-sdf@google.com>
References: <20230725233517.2614868-1-sdf@google.com>
	<20230725233517.2614868-3-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 16:35:15 -0700 Stanislav Fomichev wrote:
> +                cw.p('/* private: */')
>                  cw.nl()

I was about to apply but I keep having doubts whether there should 
be a new line after the private marker. I know - a very important
question :D

Quick grep of

$ git grep -A1 '\* private:'

shows that all(?) current uses have something immediately following
the comment.

