Return-Path: <netdev+bounces-21695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B33A7644FA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0689A1C214D4
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 04:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2CE1C13;
	Thu, 27 Jul 2023 04:38:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31F1864;
	Thu, 27 Jul 2023 04:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E687C433C8;
	Thu, 27 Jul 2023 04:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690432733;
	bh=e8pUQtokD6kW5HRTRg2jX2BFd4xeKBBveF1wi1LpfFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OGPVMyR+OoRwzjhzAqXsVMdnkCHb+4WrYmW0W8qOYvDu1LwFPcez983qngW+7FOmK
	 zgxtio5KpielQwJn9gpmq5eOSZ4KmdBjewdBIEnlPCnfTF+dM3VtBv5LgnUZzaryBl
	 LnGlN6WaByAvWlne/yQVn6AhhDuNMem6jBUjHtQ+Rc+ayZjRDkO1vqZYEH2H8VpfvN
	 eZjTrxgetzpNveRUOtoCiYvdxg95yIcosmGYu7taXwcUQKgUTmc+7nsiP3tOdg1S6p
	 t6R6HxYSyuYgzdlenZzDGUmlQX8wH23bHMWhylyEk7r2LxKoCkI/yFzWji66DqA1gG
	 ua54QYjA6Dvjg==
Date: Wed, 26 Jul 2023 21:38:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Subject: Re: [PATCH net-next v2 3/7] net/handshake: Add API for sending TLS
 Closure alerts
Message-ID: <20230726213852.1191273d@kernel.org>
In-Reply-To: <169031739483.15386.5911126621395017786.stgit@oracle-102.nfsv4bat.org>
References: <169031700320.15386.6923217931442885226.stgit@oracle-102.nfsv4bat.org>
	<169031739483.15386.5911126621395017786.stgit@oracle-102.nfsv4bat.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 16:36:44 -0400 Chuck Lever wrote:
> +#include <net/sock.h>
> +#include <net/handshake.h>
> +#include <net/genetlink.h>

nit: genetlink? copy&paste from somewhere?

> +/**
> + * tls_handshake_close - send a Closure alert
> + * @sock: an open socket
> + *
> + */

nit: the empty comment line is on purpose?

